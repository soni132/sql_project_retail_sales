# Retail Sales Analysis SQL Project

## 📊 Project Overview

**Project Title:** Retail Sales Analysis  
**Level:** Beginner  
**Database:** p1_retail_db  
**Main File:** `sql_project_p1.sql`

This project demonstrates essential SQL skills and techniques used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries.

## 🎯 Objectives

- **Database Setup:** Create and populate a retail sales database with comprehensive sales data
- **Data Cleaning:** Identify and remove records with missing or null values
- **Exploratory Data Analysis (EDA):** Perform basic analysis to understand dataset characteristics  
- **Business Analysis:** Answer specific business questions using SQL queries to derive actionable insights

## 🗄️ Database Schema

### Table: `retail_sales`

```sql
CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

**Column Descriptions:**
- `transactions_id`: Unique identifier for each transaction
- `sale_date`: Date of the sale
- `sale_time`: Time of the sale  
- `customer_id`: Unique customer identifier
- `gender`: Customer gender
- `age`: Customer age
- `category`: Product category (Beauty, Clothing, Electronics)
- `quantity`: Number of items sold
- `price_per_unit`: Price per individual item
- `cogs`: Cost of goods sold
- `total_sale`: Total transaction amount

## 🧹 Data Cleaning & Exploration

### Initial Data Exploration
```sql
-- Total record count
SELECT COUNT(*) FROM retail_sales;

-- Unique customers
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

-- Available categories
SELECT DISTINCT category FROM retail_sales;

-- Check for null values
SELECT * FROM retail_sales
WHERE sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
      gender IS NULL OR age IS NULL OR category IS NULL OR 
      quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### Data Cleaning
```sql
-- Remove records with null values
DELETE FROM retail_sales
WHERE age IS NULL;

DELETE FROM retail_sales
WHERE quantity IS NULL;
```

## 📊 Business Analysis Queries

### 1. **Daily Sales Retrieval**
```sql
-- All sales on a specific date
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';
```

### 2. **Category & Time-based Filtering**
```sql
-- Clothing sales with quantity > 4 in November 2022
SELECT * FROM retail_sales
WHERE category = 'Clothing' AND quantity > 4
AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';
```

### 3. **Sales Performance by Category**
```sql
-- Total sales per category
SELECT category, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY category;

-- Sales count by category
SELECT category, COUNT(transactions_id) AS total_sales
FROM retail_sales
GROUP BY category;
```

### 4. **Customer Demographics**
```sql
-- Average age by category
SELECT category, AVG(age) AS avg_age
FROM retail_sales
GROUP BY category
HAVING category = 'Beauty';

-- Gender distribution
SELECT gender, COUNT(transactions_id) AS no_of_sales
FROM retail_sales
GROUP BY gender
ORDER BY no_of_sales DESC;
```

### 5. **High-Value Transaction Analysis**
```sql
-- Transactions over $1000
SELECT * FROM retail_sales
WHERE total_sale > 1000;
```

### 6. **Gender & Category Cross-Analysis**
```sql
-- Transaction count by gender and category
SELECT category, gender, COUNT(transactions_id) AS total_trans
FROM retail_sales
GROUP BY category, gender
ORDER BY total_trans;
```

### 7. **Monthly Sales Trends**
```sql
-- Best selling month each year
SELECT year, month FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) 
                    ORDER BY AVG(total_sale) DESC) AS rank
    FROM retail_sales
    GROUP BY 1, 2
) AS ranked_months
WHERE rank = 1
ORDER BY year;
```

### 8. **Top Customer Analysis**
```sql
-- Top 5 customers by total sales
SELECT customer_id, SUM(total_sale) AS total_sale_by_customer
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sale_by_customer DESC
LIMIT 5;
```

### 9. **Customer Diversity Analysis**
```sql
-- Unique customers per category
SELECT COUNT(DISTINCT customer_id)
FROM retail_sales
WHERE category IN ('Beauty', 'Clothing', 'Electronics');

-- Multi-category customers
SELECT DISTINCT customer_id
FROM retail_sales
GROUP BY customer_id
HAVING COUNT(DISTINCT category) >= 3;
```

### 10. **Sales Shift Analysis**
```sql
-- Sales distribution by time of day
SELECT 
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS Shift,
    COUNT(transactions_id)
FROM retail_sales
GROUP BY Shift;
```

## 📋 Key Findings

### Customer Demographics
- Analysis reveals diverse age groups across different product categories
- Gender-based purchasing patterns identified across categories
- Beauty category customers show specific demographic characteristics

### Sales Patterns
- **High-Value Transactions:** Multiple transactions exceeded $1000, indicating premium purchase behavior
- **Seasonal Trends:** Monthly analysis reveals peak sales periods and seasonal variations
- **Time-of-Day Patterns:** Sales distribution varies significantly across Morning, Afternoon, and Evening shifts

### Category Performance
- Sales performance varies significantly across Beauty, Clothing, and Electronics categories
- Customer loyalty patterns differ by product category
- Cross-category purchasing behavior analyzed for customer segmentation

### Customer Insights
- Top-spending customers identified for targeted marketing strategies
- Customer diversity varies across product categories
- Multi-category customers represent valuable cross-selling opportunities

## 🛠️ Technologies Used

- **Database:** PostgreSQL/MySQL (adaptable)
- **Language:** SQL
- **Key Functions:** Aggregate functions, Window functions, Date/Time functions, Case statements

## 📁 Project Structure

```
retail-sales-analysis/
│
├── README.md                 # Project documentation
├── sql_project_p1.sql       # Main SQL queries and analysis
└── data/                     # Data files (if applicable)
```

## 🚀 Getting Started

1. **Setup Database:**
   ```sql
   CREATE DATABASE p1_retail_db;
   ```

2. **Create Table:**
   Execute the table creation script from `sql_project_p1.sql`

3. **Import Data:**
   Load your retail sales data into the `retail_sales` table

4. **Run Analysis:**
   Execute the queries in sequence to perform the complete analysis

## 📈 Business Impact

This analysis provides valuable insights for:
- **Inventory Management:** Understanding category performance and seasonal trends
- **Customer Segmentation:** Identifying high-value customers and demographic patterns
- **Operational Planning:** Optimizing staff scheduling based on sales shift patterns
- **Marketing Strategy:** Targeting specific customer segments and cross-selling opportunities

## 🤝 Contributing

This is a learning project designed for SQL skill development. Feel free to:
- Add additional business questions and corresponding SQL queries
- Extend the analysis with more complex scenarios
- Optimize existing queries for better performance
- Add data visualization components

## 📝 License

This project is available for educational and learning purposes.

---

**Note:** This project serves as a comprehensive introduction to SQL for data analysts, covering essential skills from basic database operations to complex business analysis queries.
