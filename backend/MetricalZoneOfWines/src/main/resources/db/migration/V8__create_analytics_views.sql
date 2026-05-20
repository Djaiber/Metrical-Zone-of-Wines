-- ============================================================
-- Metrical Zone of Wines — V8
-- Descripción: Creación de Vistas Analíticas y Forenses (Reportes)
-- Motor: MySQL 8.0
-- ============================================================

-- ------------------------------------------------------------
-- VISTA 1: vw_analytics_top_premium_wines
-- Objetivo: Ranking de los 3 mejores vinos de alta gama por región.
-- Detalles Técnicos:
-- 1. Utiliza una CTE (Common Table Expression) llamada 'RankedWines' para organizar la consulta.
-- 2. Emplea la función de ventana DENSE_RANK() particionada por región (r.id)
--    para asignar un puesto basado en el puntaje, sin saltar números en caso de empate.
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_analytics_top_premium_wines AS
WITH RankedWines AS (
    SELECT
        r.name AS region_name,
        w.name AS wine_name,
        w.price_range AS pricing_tier,
        wm.avg_score AS performance_score,
        DENSE_RANK() OVER (
            PARTITION BY r.id
            ORDER BY wm.avg_score DESC
        ) AS internal_rank
    FROM wines w
    INNER JOIN vineyards v ON w.vineyard_id = v.id
    INNER JOIN regions r ON v.region_id = r.id
    INNER JOIN wine_metrics wm ON wm.wine_id = w.id
    WHERE w.price_range IN ('Premium', 'Luxury')
)
SELECT
    region_name,
    wine_name,
    pricing_tier,
    performance_score
FROM RankedWines
WHERE internal_rank <= 3;


-- ------------------------------------------------------------
-- VISTA 2: vw_analytics_production_by_segment
-- Objetivo: Análisis de rendimiento y volumen por tipo de vino y segmento de mercado.
-- Detalles Técnicos:
-- 1. Agrupa los datos por tipo de vino y rango de precio.
-- 2. Filtra los resultados a nivel de servidor utilizando HAVING para excluir
--    nichos de producción menores a 5000 botellas, optimizando la respuesta.
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_analytics_production_by_segment AS
SELECT
    w.wine_type AS catalog_type,
    w.price_range AS market_segment,
    COUNT(w.id) AS total_labels,
    SUM(w.production_bottles) AS total_bottles_manufactured,
    ROUND(AVG(wm.avg_score), 2) AS aggregate_score_avg
FROM wines w
         INNER JOIN wine_metrics wm ON w.id = wm.wine_id
GROUP BY w.wine_type, w.price_range
HAVING total_bottles_manufactured >= 5000;


-- ------------------------------------------------------------
-- VISTA 3: vw_audit_forensic_deleted_records
-- Objetivo: Extracción forense de registros eliminados analizando el log inmutable.
-- Detalles Técnicos:
-- 1. Explota las capacidades de MySQL 8.0 para manejar tipos nativos JSON.
-- 2. JSON_EXTRACT busca la llave 'name' dentro del payload estructurado.
-- 3. JSON_UNQUOTE limpia el resultado eliminando las comillas literales del string JSON.
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_audit_forensic_deleted_records AS
SELECT
    log_id AS audit_ticket,
    table_name AS target_table,
    record_id AS original_primary_key,
    action_type AS dml_operation,
    logged_at AS execution_timestamp,
    logged_by_user AS system_operator,
    JSON_UNQUOTE(JSON_EXTRACT(payload, '$.name')) AS extracted_entity_name
FROM audit_master_log
WHERE action_type IN ('DELETE', 'DELETE_FORMULA');


-- ------------------------------------------------------------
-- VISTA 4: vw_analytics_dominant_grapes_per_vineyard
-- Objetivo: Mapeo de viñedos con cepas dominantes (mayor o igual al 50% en ensambles).
-- Detalles Técnicos:
-- 1. Rompe la relación muchos a muchos entre vinos y uvas agrupando por viñedo y uva.
-- 2. Calcula el promedio exacto de participación del compuesto en la tabla pivote wine_grapes.
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_analytics_dominant_grapes_per_vineyard AS
SELECT
    v.name AS vineyard_source,
    gv.name AS grape_variety_name,
    gv.color AS grape_color,
    COUNT(w.id) AS single_varietal_wines_count,
    ROUND(AVG(wg.percentage), 2) AS exact_composition_average
FROM vineyards v
         INNER JOIN wines w ON v.id = w.vineyard_id
         INNER JOIN wine_grapes wg ON w.id = wg.wine_id
         INNER JOIN grape_varieties gv ON wg.grape_id = gv.id
GROUP BY v.id, gv.id
HAVING exact_composition_average >= 50.00;


-- ------------------------------------------------------------
-- VISTA 5: vw_analytics_score_evolution_deltas
-- Objetivo: Análisis de series de tiempo para evaluar la evolución de puntajes.
-- Detalles Técnicos:
-- 1. Emplea la función de ventana temporal LAG() para consultar el valor de la fila anterior.
-- 2. Calcula matemáticamente el delta (diferencia) de puntaje entre capturas históricas
--    sin necesidad de ejecutar consultas anidadas (SELF-JOIN).
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_analytics_score_evolution_deltas AS
SELECT
    entity_type,
    entity_id,
    snapshot_date,
    avg_score AS current_snapshot_score,
    LAG(avg_score, 1) OVER (
        PARTITION BY entity_type, entity_id
        ORDER BY snapshot_date ASC
    ) AS previous_snapshot_score,
    ROUND(avg_score - LAG(avg_score, 1) OVER (
        PARTITION BY entity_type, entity_id
        ORDER BY snapshot_date ASC
    ), 2) AS score_evolution_delta
FROM metrics_snapshot_history
WHERE entity_type = 'WINE';


-- ------------------------------------------------------------
-- VISTA 6: vw_analytics_climate_style_matrix
-- Objetivo: Matriz cruzada (Pivot Table) de estilos de vino frente a tipos de clima.
-- Detalles Técnicos:
-- 1. Emula un cubo OLAP bidimensional transformando filas en columnas.
-- 2. Utiliza agregación condicional (SUM + CASE WHEN) para contar ocurrencias
--    específicas del campo ENUM 'wine_style_profile' agrupadas por clima.
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_analytics_climate_style_matrix AS
SELECT
    climate_type AS regional_climate,
    SUM(CASE WHEN wine_style_profile = 'Bold reds' THEN 1 ELSE 0 END) AS bold_reds_count,
    SUM(CASE WHEN wine_style_profile = 'Crisp whites' THEN 1 ELSE 0 END) AS crisp_whites_count,
    SUM(CASE WHEN wine_style_profile = 'Elegant reds' THEN 1 ELSE 0 END) AS elegant_reds_count,
    SUM(CASE WHEN wine_style_profile = 'Sparkling' THEN 1 ELSE 0 END) AS sparkling_count,
    COUNT(id) AS total_regions_evaluated
FROM regions
GROUP BY climate_type;


-- ------------------------------------------------------------
-- VISTA 7: vw_analytics_price_outliers
-- Objetivo: Detección estadística de anomalías de precio (sobrevaloración extrema).
-- Detalles Técnicos:
-- 1. Calcula dinámicamente la media y la desviación estándar (STDDEV) regional en una subconsulta.
-- 2. Filtra los vinos cuyo precio supera en 1.5 desviaciones estándar el promedio
--    de su propia región, identificando verdaderos outliers del mercado.
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_analytics_price_outliers AS
SELECT
    v.name AS vineyard_name,
    w.name AS wine_label,
    w.avg_price_usd AS current_price,
    sub.regional_price_avg AS regional_average,
    sub.price_std_deviation AS regional_deviation,
    ROUND(w.avg_price_usd - sub.regional_price_avg, 2) AS difference_usd
FROM wines w
         INNER JOIN vineyards v ON w.vineyard_id = v.id
         INNER JOIN (
    SELECT
        v2.region_id,
        AVG(w2.avg_price_usd) AS regional_price_avg,
        STDDEV(w2.avg_price_usd) AS price_std_deviation
    FROM wines w2
             INNER JOIN vineyards v2 ON w2.vineyard_id = v2.id
    GROUP BY v2.region_id
) sub ON v.region_id = sub.region_id
WHERE w.avg_price_usd > (sub.regional_price_avg + (1.5 * sub.price_std_deviation));


-- ------------------------------------------------------------
-- VISTA 8: vw_analytics_acclaimed_gastronomy_guide
-- Objetivo: Consolidación sintética de sugerencias de maridaje para vinos top.
-- Detalles Técnicos:
-- 1. Utiliza GROUP_CONCAT para fusionar múltiples filas de texto en una sola cadena.
-- 2. Implementa DISTINCT dentro del concatenador para evitar sugerencias duplicadas
--    y define un separador visualizado personalizado (' | ').
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_analytics_acclaimed_gastronomy_guide AS
SELECT
    w.wine_type AS catalog_type,
    wm.prestige_index AS tier,
    COUNT(w.id) AS total_wines_matched,
    GROUP_CONCAT(DISTINCT w.food_pairing SEPARATOR ' | ') AS consolidated_gastronomy_guide
FROM wines w
         INNER JOIN wine_metrics wm ON w.id = wm.wine_id
WHERE wm.prestige_index IN ('Acclaimed', 'Legendary')
GROUP BY w.wine_type, wm.prestige_index;


-- ------------------------------------------------------------
-- VISTA 9: vw_audit_storage_efficiency
-- Objetivo: Análisis de carga operativa comparando logs activos vs almacenamiento en frío.
-- Detalles Técnicos:
-- 1. Cruza dos subconsultas agregadas utilizando LEFT JOIN.
-- 2. Implementa la función COALESCE() para manejar los valores NULL de los operadores
--    que aún no tienen registros en el archivo histórico, asegurando una aritmética correcta.
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_audit_storage_efficiency AS
SELECT
    active.logged_by_user AS operator_account,
    active.active_logs_count,
    COALESCE(archived.archived_logs_count, 0) AS cold_storage_logs_count,
    (active.active_logs_count + COALESCE(archived.archived_logs_count, 0)) AS cumulative_total_operations
FROM (
         SELECT logged_by_user, COUNT(log_id) AS active_logs_count
         FROM audit_master_log
         GROUP BY logged_by_user
     ) active
         LEFT JOIN (
    SELECT logged_by_user, COUNT(archive_id) AS archived_logs_count
    FROM audit_archive_log
    GROUP BY logged_by_user
) archived ON active.logged_by_user = archived.logged_by_user;


-- ------------------------------------------------------------
-- VISTA 10: vw_analytics_high_altitude_premium
-- Objetivo: Análisis del impacto del 'terroir' de altitud en los precios comerciales.
-- Detalles Técnicos:
-- 1. Contrasta un macro-indicador nacional (promedio de altitud del país) calculado
--    mediante una subconsulta, contra el micro-indicador (altitud específica del viñedo).
-- 2. Filtra y consolida exclusivamente aquellos viñedos por encima del umbral nacional.
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_analytics_high_altitude_premium AS
SELECT
    c.name AS country_name,
    v.name AS high_altitude_vineyard,
    v.altitude_avg_m AS vineyard_altitude,
    ROUND(sub_avg.national_altitude_avg, 2) AS national_baseline_altitude,
    COUNT(w.id) AS premium_wines_produced,
    ROUND(AVG(w.avg_price_usd), 2) AS average_wine_price_usd
FROM vineyards v
         INNER JOIN wines w ON v.id = w.vineyard_id
         INNER JOIN regions r ON v.region_id = r.id
         INNER JOIN countries c ON r.country_id = c.id
         INNER JOIN (
    SELECT r2.country_id, AVG(v2.altitude_avg_m) AS national_altitude_avg
    FROM vineyards v2
             INNER JOIN regions r2 ON v2.region_id = r2.id
    GROUP BY r2.country_id
) sub_avg ON c.id = sub_avg.country_id
WHERE v.altitude_avg_m > sub_avg.national_altitude_avg
GROUP BY v.id;