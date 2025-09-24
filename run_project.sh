#!/bin/bash

# Retail Sales Analysis Project - Run Script
echo "🚀 Setting up Retail Sales Analysis Project..."

# Check if SQLite is available
if ! command -v sqlite3 &> /dev/null; then
    echo "❌ SQLite is not installed. Please install it first."
    exit 1
fi

# Create database and set up tables
echo "📊 Creating database and tables..."
sqlite3 retail_analysis.db < setup_database.sql

# Import CSV data
echo "📥 Importing CSV data..."
sqlite3 retail_analysis.db << EOF
.mode csv
.headers on
.import "SQL - Retail Sales Analysis_utf .csv" retail_sales
SELECT 'Data imported successfully! Total records: ' || COUNT(*) FROM retail_sales;
EOF

echo "✅ Database setup complete!"
echo "🔍 You can now run the analysis queries from sql_query_p1.sql"
echo ""
echo "To start analyzing:"
echo "1. Run: sqlite3 retail_analysis.db"
echo "2. Or run specific queries from the SQL file"
echo ""
echo "Example quick analysis:"
sqlite3 retail_analysis.db << EOF
SELECT 'Total Sales Records: ' || COUNT(*) FROM retail_sales;
SELECT 'Unique Customers: ' || COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT 'Product Categories: ' || GROUP_CONCAT(DISTINCT category) FROM retail_sales;
EOF
