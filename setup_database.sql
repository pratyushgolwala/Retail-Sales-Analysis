-- Setup script for Retail Sales Analysis Project
-- This script creates the table and prepares it for data import

-- Create the retail_sales table
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales (
    transactions_id INTEGER PRIMARY KEY,
    sale_date TEXT,
    sale_time TEXT,
    customer_id INTEGER,
    gender TEXT,
    age INTEGER,
    category TEXT,
    quantiy INTEGER,
    price_per_unit REAL,
    cogs REAL,
    total_sale REAL
);

-- Import data from CSV (you'll need to run this separately)
-- .mode csv
-- .headers on
-- .import "SQL - Retail Sales Analysis_utf .csv" retail_sales

-- Verify the import
-- SELECT COUNT(*) as total_records FROM retail_sales;
-- SELECT * FROM retail_sales LIMIT 5;
