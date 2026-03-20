# 🍷 Especificación de Requerimientos - Proyecto Winegrapp

## 1. Introducción
El presente documento detalla las necesidades funcionales y las restricciones técnicas para el desarrollo de la plataforma **Winegrapp**. El sistema se concibe como una solución integral para la comunidad "Winer’s", permitiendo la exploración de viñedos y productos vínicos a nivel global mediante una arquitectura híbrida (Relacional + NoSQL). El enfoque principal es la agilidad de consulta y la facilidad para compartir experiencias sin las barreras de un registro de usuario tradicional, operando bajo un entorno de despliegue en Linux.

---

## 2. Requerimientos Funcionales (RF)
Estos requerimientos describen las funciones que el sistema debe ejecutar para los usuarios finales.

* **RF01 - Consulta de Catálogo y Filtrado Geográfico:** El sistema debe permitir explorar el catálogo completo de vinos y viñedos, con filtros obligatorios por país y región.
* **RF02 - Jerarquía de Visualización:** La plataforma debe organizar la información de modo que los vinos solo sean visibles al ingresar a la sección específica de su respectivo viñedo.
* **RF03 - Sistema de Reseñas Abierto:** Se debe permitir a los usuarios publicar reseñas y calificaciones detalladas (1 a 5 estrellas) tanto para viñedos como para vinos sin necesidad de autenticación.
* **RF04 - Gestión de Datos Flexibles (Capa NoSQL):** El sistema debe mostrar notas de cata y detalles técnicos extraídos de **MongoDB**, permitiendo que la información técnica sea extensible.
* **RF05 - Dashboard de Analítica y Tendencias:** La interfaz principal debe presentar un resumen visual con los vinos "Top" y las zonas geográficas con mejores puntajes según la agregación de datos.
* **RF06 - Consulta de Calidad de Cosecha:** Los usuarios podrán consultar métricas de calidad de la uva por años específicos y zonas determinadas para informar su compra.
* **RF07 - Búsqueda Avanzada por Atributos:** El sistema debe permitir búsquedas cruzadas (ej: tipo de uva + bodega + rango de precio) integrando datos de las dos bases de datos.
* **RF08 - Galería Multimedia de Viñedos:** El sistema debe permitir la visualización de imágenes de las etiquetas de los vinos y mapas de ubicación de los viñedos almacenados en el servidor.

---

## 3. Requerimientos No Funcionales (RNF)
Definen las propiedades, restricciones y estándares de calidad técnica del sistema.

* **RNF01 - Arquitectura de Persistencia Híbrida:** Uso obligatorio de un motor relacional (**MySQL/PostgreSQL**) para datos maestros y **MongoDB** para el manejo de documentos y reseñas.
* **RNF02 - Integridad y Normalización Relacional:** La base de datos relacional debe contar con al menos ocho entidades y cumplir estrictamente con la **Tercera Forma Normal (3FN)**.
* **RNF03 - Lógica de Negocio en Capa de Datos:** Implementación obligatoria de procedimientos almacenados, funciones y triggers para la automatización de procesos internos de la DB.
* **RNF04 - Robustez Transaccional:** Todas las operaciones de escritura deben cumplir con las propiedades ACID, asegurando el uso de **COMMIT** y **ROLLBACK** para evitar datos huérfanos.
* **RNF05 - Entorno de Despliegue en VM:** El sistema debe ser desplegado en una distribución **Linux o Unix** dentro de una máquina virtual, con documentación para su reproducción.
* **RNF06 - Interoperabilidad del Backend:** La API (desarrollada en SpringBoot) debe garantizar la conexión simultánea y eficiente con la capa SQL y la capa NoSQL.
* **RNF07 - Gestión de Configuración (Git):** El código fuente y la documentación técnica deben gestionarse en un repositorio de **GitHub** con un historial de versiones actualizado.
* **RNF08 - Latencia de Consultas:** Las consultas que involucren agregaciones de datos entre el catálogo y las analíticas de usuarios no deben superar un tiempo de respuesta de 500ms.

---

## 4. Priorización y Matriz de Trazabilidad
Esta sección vincula los requerimientos con los objetivos estratégicos definidos en el Acta de Inicio.

| ID Req. | Prioridad | Origen / Objetivo | Entregable Relacionado |
| :--- | :--- | :--- | :--- |
| **RF01** | Alta | Consulta de catálogo global | Módulo de Búsqueda y Filtros |
| **RF02** | Alta | Estructura de viñedos | Modelo Relacional (8 entidades) |
| **RF03** | Alta | Sistema de reseñas sin registro | Implementación MongoDB |
| **RF04** | Media | Flexibilidad de datos técnicos | Capa de persistencia NoSQL |
| **RF05** | Media | Analítica para la comunidad | Dashboard de visualización |
| **RF07** | Alta | Búsqueda cruzada híbrida | Integración Backend - SQL/NoSQL |
| **RNF01** | Crítica | Arquitectura híbrida exigida | Esquema de persistencia políglota |
| **RNF02** | Crítica | Calidad y orden de datos | Diccionario de datos y Script SQL |
| **RNF05** | Alta | Infraestructura obligatoria | Máquina Virtual configurada |
| **RNF07** | Alta | Control de versiones | Repositorio GitHub de ACID'os |

---

## 5. Conclusión
La implementación de estos 16 requerimientos asegura que **Winegrapp** cumpla con los estándares académicos y técnicos exigidos por la Universidad El Bosque. El equilibrio entre la flexibilidad de NoSQL para las reseñas y el rigor de la normalización relacional para los datos maestros permitirá una plataforma robusta y escalable para la comunidad "Winer’s".