-- =====================================================
-- Flyway Migration Script: V2__seed_data.sql
-- Description: Initial seed data for development
-- Author: Database Team
-- Created: 2026-03-18
-- =====================================================

-- =====================================================
-- Seed Regions
-- =====================================================
INSERT INTO regions (name, country, climate, area_hectares, established_year) VALUES
('Bordeaux', 'France', 'Maritime', 120000, 1152),
('Napa Valley', 'USA', 'Mediterranean', 42500, 1861),
('Tuscany', 'Italy', 'Mediterranean', 65000, 1716),
('Mendoza', 'Argentina', 'Continental', 148000, 1561),
('Barossa Valley', 'Australia', 'Mediterranean', 13000, 1842);

-- =====================================================
-- Seed Wineries
-- =====================================================
INSERT INTO wineries (region_id, name, founded_year, annual_production, certification) VALUES
(1, 'Château Margaux', 1705, 300000, 'Organic'),
(1, 'Château Lafite Rothschild', 1868, 350000, 'Sustainable'),
(2, 'Robert Mondavi Winery', 1966, 500000, 'Organic'),
(3, 'Antinori', 1385, 400000, 'Sustainable'),
(4, 'Catena Zapata', 1902, 450000, 'Organic');

-- =====================================================
-- Seed Wines
-- =====================================================
INSERT INTO wines (winery_id, name, varietal, vintage, alcohol_percentage, price, stock_quantity) VALUES
(1, 'Château Margaux Grand Vin', 'Cabernet Sauvignon', 2019, 13.5, 850.00, 500),
(1, 'Pavillon Rouge', 'Cabernet Sauvignon', 2020, 13.0, 250.00, 1000),
(2, 'Carruades de Lafite', 'Cabernet Sauvignon', 2019, 13.0, 300.00, 750),
(3, 'Napa Valley Reserve', 'Cabernet Sauvignon', 2018, 14.5, 200.00, 1500),
(3, 'Fumé Blanc', 'Sauvignon Blanc', 2022, 13.5, 45.00, 2000),
(4, 'Tignanello', 'Sangiovese', 2019, 14.0, 150.00, 800),
(5, 'Nicolás Catena Zapata', 'Malbec', 2018, 14.0, 120.00, 1200);

-- =====================================================
-- Seed Users (passwords should be hashed in production)
-- =====================================================
INSERT INTO users (email, username, password_hash, role) VALUES
('admin@metricalzone.com', 'admin', '$2a$10$YourHashedPasswordHere', 'admin'),
('critic@wine.com', 'winecritic', '$2a$10$YourHashedPasswordHere', 'critic'),
('user@example.com', 'wineenthusiast', '$2a$10$YourHashedPasswordHere', 'user');

-- =====================================================
-- End of Seed Data
-- =====================================================
