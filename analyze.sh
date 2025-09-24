#!/bin/bash

# Interactive Retail Sales Analysis Script
echo "🛒 Retail Sales Analysis - Interactive Mode"
echo "=========================================="

DATABASE="retail_analysis.db"

# Check if database exists
if [ ! -f "$DATABASE" ]; then
    echo "❌ Database not found. Please run ./run_project.sh first"
    exit 1
fi

echo "📊 Database Summary:"
sqlite3 $DATABASE "SELECT 'Total Records: ' || COUNT(*) FROM retail_sales;"
sqlite3 $DATABASE "SELECT 'Date Range: ' || MIN(sale_date) || ' to ' || MAX(sale_date) FROM retail_sales;"
echo ""

echo "🔍 Choose an analysis to run:"
echo "1. Sales by Category"
echo "2. Top 5 Customers by Sales"
echo "3. Sales by Time Shift (Morning/Afternoon/Evening)"
echo "4. Average Age by Category"
echo "5. High-Value Transactions (>1000)"
echo "6. Run All Analyses"
echo "7. Open Interactive SQL Mode"
echo "0. Exit"

read -p "Enter your choice (0-7): " choice

case $choice in
    1)
        echo "📈 Sales by Category:"
        sqlite3 -header -column $DATABASE "SELECT category, ROUND(SUM(total_sale),2) as total_sales, COUNT(*) as transactions FROM retail_sales GROUP BY category ORDER BY total_sales DESC;"
        ;;
    2)
        echo "🏆 Top 5 Customers by Sales:"
        sqlite3 -header -column $DATABASE "SELECT customer_id, ROUND(SUM(total_sale),2) as total_sales FROM retail_sales GROUP BY customer_id ORDER BY total_sales DESC LIMIT 5;"
        ;;
    3)
        echo "🕐 Sales by Time Shift:"
        sqlite3 -header -column $DATABASE "
        WITH hourly_sale AS (
            SELECT *,
                CASE
                    WHEN CAST(substr(sale_time,1,2) AS INTEGER) < 12 THEN 'Morning'
                    WHEN CAST(substr(sale_time,1,2) AS INTEGER) BETWEEN 12 AND 17 THEN 'Afternoon'
                    ELSE 'Evening'
                END as shift
            FROM retail_sales
        )
        SELECT shift, COUNT(*) as total_orders, ROUND(SUM(total_sale),2) as total_sales
        FROM hourly_sale
        GROUP BY shift
        ORDER BY total_sales DESC;"
        ;;
    4)
        echo "👥 Average Age by Category:"
        sqlite3 -header -column $DATABASE "SELECT category, ROUND(AVG(age),1) as avg_age FROM retail_sales GROUP BY category;"
        ;;
    5)
        echo "💰 High-Value Transactions (>1000):"
        sqlite3 -header -column $DATABASE "SELECT COUNT(*) as high_value_transactions, ROUND(SUM(total_sale),2) as total_value FROM retail_sales WHERE total_sale > 1000;"
        ;;
    6)
        echo "📊 Complete Analysis Report:"
        echo "============================"
        echo ""
        echo "1. Sales by Category:"
        sqlite3 -header -column $DATABASE "SELECT category, ROUND(SUM(total_sale),2) as total_sales, COUNT(*) as transactions FROM retail_sales GROUP BY category ORDER BY total_sales DESC;"
        echo ""
        echo "2. Customer Demographics:"
        sqlite3 -header -column $DATABASE "SELECT category, ROUND(AVG(age),1) as avg_age, COUNT(DISTINCT customer_id) as unique_customers FROM retail_sales GROUP BY category;"
        echo ""
        echo "3. Sales Performance:"
        sqlite3 -header -column $DATABASE "SELECT COUNT(*) as total_transactions, ROUND(AVG(total_sale),2) as avg_sale, ROUND(MAX(total_sale),2) as max_sale FROM retail_sales;"
        ;;
    7)
        echo "🔧 Starting Interactive SQL Mode..."
        echo "Type .help for SQLite commands, .exit to quit"
        sqlite3 $DATABASE
        ;;
    0)
        echo "👋 Goodbye!"
        exit 0
        ;;
    *)
        echo "❌ Invalid choice. Please run the script again."
        ;;
esac
