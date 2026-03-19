-- =====================================================
-- Flyway Migration Script: V4__functions.sql
-- Description: User-defined functions for calculations
-- Author: Database Team
-- Created: 2026-03-18
-- =====================================================

DELIMITER //

-- =====================================================
-- Function: CalculateWineAge
-- Description: Calculates the age of a wine based on vintage
-- Parameters: p_vintage - The vintage year
-- Returns: Age in years as integer
-- =====================================================
CREATE FUNCTION CalculateWineAge(p_vintage INT) 
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE wine_age INT;
    SET wine_age = YEAR(CURDATE()) - p_vintage;
    RETURN wine_age;
END//

-- =====================================================
-- Function: GetWinePriceCategory
-- Description: Categorizes wine price into budget categories
-- Parameters: p_price - The wine price
-- Returns: Price category as string
-- =====================================================
CREATE FUNCTION GetWinePriceCategory(p_price DECIMAL(10,2)) 
RETURNS VARCHAR(20)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE category VARCHAR(20);
    
    IF p_price < 25 THEN
        SET category = 'Budget';
    ELSEIF p_price < 50 THEN
        SET category = 'Mid-Range';
    ELSEIF p_price < 100 THEN
        SET category = 'Premium';
    ELSE
        SET category = 'Luxury';
    END IF;
    
    RETURN category;
END//

-- =====================================================
-- Function: CalculateInventoryValue
-- Description: Calculates total inventory value for a wine
-- Parameters: p_wine_id - The wine ID
-- Returns: Total value as decimal
-- =====================================================
CREATE FUNCTION CalculateInventoryValue(p_wine_id INT) 
RETURNS DECIMAL(15,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total_value DECIMAL(15,2);
    
    SELECT price * stock_quantity INTO total_value
    FROM wines
    WHERE wine_id = p_wine_id;
    
    RETURN IFNULL(total_value, 0);
END//

-- =====================================================
-- Function: GetWineryAge
-- Description: Calculates winery age in years
-- Parameters: p_winery_id - The winery ID
-- Returns: Age in years as integer
-- =====================================================
CREATE FUNCTION GetWineryAge(p_winery_id INT) 
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE winery_age INT;
    DECLARE founded_year_val INT;
    
    SELECT founded_year INTO founded_year_val
    FROM wineries
    WHERE winery_id = p_winery_id;
    
    IF founded_year_val IS NULL THEN
        RETURN NULL;
    END IF;
    
    SET winery_age = YEAR(CURDATE()) - founded_year_val;
    RETURN winery_age;
END//

DELIMITER ;

-- =====================================================
-- End of Functions
-- =====================================================
