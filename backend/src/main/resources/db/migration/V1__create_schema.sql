-- =====================================================
-- Flyway Migration Script: V1__create_schema.sql
-- Description: Initial database schema creation
-- Author: Database Team
-- Created: 2026-03-18
-- =====================================================

-- Drop tables if they exist (for clean installation)
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS wines;
DROP TABLE IF EXISTS wineries;
DROP TABLE IF EXISTS regions;
DROP TABLE IF EXISTS users;

-- =====================================================
-- Table: regions
-- Description: Wine growing regions master data
-- =====================================================
CREATE TABLE regions (
    region_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    climate VARCHAR(50),
    area_hectares DECIMAL(10,2),
    established_year INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uk_region_name_country (name, country)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- Table: wineries
-- Description: Winery information
-- =====================================================
CREATE TABLE wineries (
    winery_id INT AUTO_INCREMENT PRIMARY KEY,
    region_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    founded_year INT,
    annual_production INT,
    certification VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (region_id) REFERENCES regions(region_id),
    UNIQUE KEY uk_winery_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- Table: wines
-- Description: Wine products catalog
-- =====================================================
CREATE TABLE wines (
    wine_id INT AUTO_INCREMENT PRIMARY KEY,
    winery_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    varietal VARCHAR(50),
    vintage INT NOT NULL,
    alcohol_percentage DECIMAL(3,1),
    price DECIMAL(10,2),
    stock_quantity INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (winery_id) REFERENCES wineries(winery_id),
    INDEX idx_wine_vintage (vintage),
    INDEX idx_wine_varietal (varietal),
    UNIQUE KEY uk_wine_winery_vintage (winery_id, name, vintage)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- Table: users
-- Description: Application users
-- =====================================================
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('admin', 'user', 'critic') DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL,
    UNIQUE KEY uk_user_email (email),
    UNIQUE KEY uk_user_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create indexes for performance
CREATE INDEX idx_regions_country ON regions(country);
CREATE INDEX idx_wineries_region ON wineries(region_id);
CREATE INDEX idx_wines_winery ON wines(winery_id);
CREATE INDEX idx_wines_price ON wines(price);

-- =====================================================
-- End of Schema Creation
-- =====================================================
