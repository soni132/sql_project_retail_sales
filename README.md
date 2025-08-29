# Retail Sales Analysis SQL Project

## 📊 Project Overview

**Project Title:** Retail Sales Analysis  
**Level:** Beginner  
**Database:** p1_retail_db  

This project demonstrates essential SQL skills and techniques used by data analysts to explore, clean, and analyze retail sales data. It covers database setup, data cleaning, exploratory data analysis (EDA), and business-driven SQL queries to derive meaningful insights from sales data.

## 🎯 Objectives

- **Database Setup:** Create and populate a retail sales database with comprehensive sales data
- **Data Cleaning:** Identify and handle missing or null values to ensure data quality
- **Exploratory Data Analysis (EDA):** Perform basic analysis to understand dataset characteristics
- **Business Analysis:** Answer specific business questions using SQL queries to drive decision-making

## 🗄️ Database Schema

### Table Structure: `retail_sales`

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

## 🧹 Data Cleaning Process

### 1. Data Exploration
- **Record Count:** Total number of transactions in the dataset
- **Customer Analysis:** Number of unique customers
- **Category Analysis:** All unique product categories
- **Data Quality Check:** Identification of null values

```sql
-- Basic data exploration queries
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;
```

### 2. Null Value Handling
```sql
-- Check for null values
SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

-- Remove records with null values
DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

## 📈 Business Analysis & Key Queries

### 1. Daily Sales Analysis
```sql
-- Retrieve all sales for a specific date
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';
```

### 2. Category & Quantity Analysis
```sql
-- High-quantity clothing sales in November 2022
SELECT * FROM retail_sales
WHERE 
    category = 'Clothing'
    AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND quantity >= 4;
```

### 3. Sales Performance by Category
```sql
-- Total sales and order count by category
SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY category;
```

### 4. Customer Demographics
```sql
-- Average age of Beauty category customers
SELECT ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty';
```

### 5. High-Value Transactions
```sql
-- Transactions over $1000
SELECT * FROM retail_sales
WHERE total_sale > 1000;
```

### 6. Gender & Category Analysis
```sql
-- Transaction count by gender and category
SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP BY category, gender
ORDER BY category;
```

### 7. Monthly Sales Trends
```sql
-- Best selling month each year
SELECT year, month, avg_sale
FROM (    
    SELECT 
        EXTRACT(YEAR FROM sale_date) as year,
        EXTRACT(MONTH FROM sale_date) as month,
        AVG(total_sale) as avg_sale,
        RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
    FROM retail_sales
    GROUP BY 1, 2
) as t1
WHERE rank = 1;
```

### 8. Top Customer Analysis
```sql
-- Top 5 customers by total sales
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

### 9. Customer Diversity by Category
```sql
-- Unique customers per category
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as unique_customers
FROM retail_sales
GROUP BY category;
```

### 10. Sales Shift Analysis
```sql
-- Sales distribution by
