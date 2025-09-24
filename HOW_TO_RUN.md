# How to Run the Retail Sales Analysis Project

## ✅ Project Setup Complete!

Your project is now ready to use. Here's how to run it:

## 🚀 Quick Start

### 1. Database is Already Set Up
- Database file: `retail_analysis.db`
- Data imported: 2000 sales records
- Date range: 2022-2023

### 2. Run Analysis (Choose One Method)

#### Method A: Interactive Analysis Menu
```bash
./analyze.sh
```
This gives you a menu with options:
1. Sales by Category
2. Top 5 Customers by Sales  
3. Sales by Time Shift (Morning/Afternoon/Evening)
4. Average Age by Category
5. High-Value Transactions (>1000)
6. Run All Analyses
7. Open Interactive SQL Mode

#### Method B: Direct SQL Commands
```bash
# View sample data
sqlite3 retail_analysis.db "SELECT * FROM retail_sales LIMIT 5;"

# Run specific queries
sqlite3 retail_analysis.db "SELECT category, SUM(total_sale) as total FROM retail_sales GROUP BY category;"
```

#### Method C: Interactive SQL Mode
```bash
sqlite3 retail_analysis.db
```
Then run any SQL commands from `sql_query_p1.sql`

## 📊 Key Findings from Your Data

- **Total Records**: 2,000 transactions
- **Unique Customers**: 155 customers  
- **Product Categories**: Electronics, Clothing, Beauty
- **Top Category by Sales**: Electronics ($313,810)
- **Date Range**: January 2022 - December 2023

## 📁 Project Files

- `retail_analysis.db` - SQLite database with your data
- `sql_query_p1.sql` - All analysis queries (10 business questions)
- `analyze.sh` - Interactive analysis script
- `run_project.sh` - Initial setup script
- `setup_database.sql` - Database schema

## 🔄 Need to Reset?

If you need to start over:
```bash
rm retail_analysis.db
./run_project.sh
```

## 💡 Next Steps

1. Try running `./analyze.sh` to explore the data
2. Open `sql_query_p1.sql` to see all the analysis queries
3. Modify queries to explore different aspects of the data
4. Add your own business questions and SQL queries

Happy analyzing! 🎉
