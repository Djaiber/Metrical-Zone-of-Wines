-- =====================================================
-- Flyway Migration Script: V3__stored_procedures.sql
-- Description: Stored procedures for business logic
-- Author: Database Team
-- Created: 2026-03-18
-- =====================================================

DELIMITER //

-- =====================================================
-- Procedure: GetWineAnalytics
-- Description: Calculates comprehensive wine analytics including
--              average rating, total reviews, and sales velocity
-- Parameters: p_wine_id - The wine ID to analyze
-- Returns: Wine metrics in result set
-- =====================================================
CREATE PROCEDURE GetWineAnalytics(IN p_wine_id INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;
    
    -- Get wine basic info
    SELECT 
        w.wine_id,
        w.name AS wine_name,
        win.name AS winery_name,
        w.vintage,
        w.price,
        w.stock_quantity
    FROM wines w
    JOIN wineries win ON w.winery_id = win.winery_id
    WHERE w.wine_id = p_wine_id;
    
    -- Note: This procedure would typically join with MongoDB data
    -- For now, we'll create a placeholder for review statistics
    SELECT 'MongoDB aggregation would return review metrics here' AS review_stats;
    
    COMMIT;
END//

-- =====================================================
-- Procedure: UpdateInventoryWithTransaction
-- Description: Updates wine inventory with transaction control
-- Parameters: 
--   p_wine_id - Wine identifier
--   p_quantity_change - Positive for restock, negative for sale
--   p_transaction_type - 'SALE' or 'RESTOCK'
-- =====================================================
CREATE PROCEDURE UpdateInventoryWithTransaction(
    IN p_wine_id INT,
    IN p_quantity_change INT,
    IN p_transaction_type VARCHAR(20)
)
BEGIN
    DECLARE current_stock INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error: Transaction rolled back' AS status;
    END;

    START TRANSACTION;
    
    -- Lock the row for update
    SELECT stock_quantity INTO current_stock
    FROM wines 
    WHERE wine_id = p_wine_id 
    FOR UPDATE;
    
    -- Validate based on transaction type
    IF p_transaction_type = 'SALE' THEN
        IF current_stock < ABS(p_quantity_change) THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Insufficient stock for sale';
        END IF;
        
        UPDATE wines 
        SET stock_quantity = stock_quantity - ABS(p_quantity_change)
        WHERE wine_id = p_wine_id;
        
    ELSEIF p_transaction_type = 'RESTOCK' THEN
        UPDATE wines 
        SET stock_quantity = stock_quantity + ABS(p_quantity_change)
        WHERE wine_id = p_wine_id;
    ELSE
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Invalid transaction type';
    END IF;
    
    -- Log the transaction
    INSERT INTO inventory_transactions (
        wine_id, 
        quantity_change, 
        transaction_type,
        transaction_date
    ) VALUES (
        p_wine_id,
        p_quantity_change,
        p_transaction_type,
        NOW()
    );
    
    COMMIT;
    SELECT 'Transaction completed successfully' AS status;
END//

-- =====================================================
-- Procedure: GetRegionalPerformance
-- Description: Aggregates performance metrics by region
-- Parameters: p_year - Filter by vintage year
-- =====================================================
CREATE PROCEDURE GetRegionalPerformance(IN p_year INT)
BEGIN
    SELECT 
        r.region_id,
        r.name AS region_name,
        r.country,
        COUNT(DISTINCT w.winery_id) AS winery_count,
        COUNT(DISTINCT wi.wine_id) AS wine_count,
        AVG(wi.price) AS avg_price,
        SUM(wi.stock_quantity) AS total_stock
    FROM regions r
    LEFT JOIN wineries w ON r.region_id = w.region_id
    LEFT JOIN wines wi ON w.winery_id = wi.winery_id 
        AND (p_year IS NULL OR wi.vintage = p_year)
    GROUP BY r.region_id, r.name, r.country
    ORDER BY wine_count DESC;
END//

DELIMITER ;

-- =====================================================
-- Create supporting table for inventory transactions
-- =====================================================
CREATE TABLE IF NOT EXISTS inventory_transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    wine_id INT NOT NULL,
    quantity_change INT NOT NULL,
    transaction_type VARCHAR(20) NOT NULL,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (wine_id) REFERENCES wines(wine_id),
    INDEX idx_transaction_date (transaction_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- End of Stored Procedures
-- =====================================================
