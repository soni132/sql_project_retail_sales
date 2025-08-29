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
select * from retail_sales;
select count(*) from retail_sales;
select * from retail_sales
order by transactions_id
limit 100;
select * from retail_sales
order by transactions_id 
limit 10;
select * from retail_sales
where transactions_id is null;
select * from retail_sales
where sale_date is null;
delete  from retail_sales
where age is null;

delete from retail_sales
where quantity is null;

select* from retail_sales;
--unique customer--
select count(distinct customer_id) from retail_sales
;
--total no of sales--
select count(*) from retail_sales;
--total no of category--
select count(distinct category)
from retail_sales;

--distinct category name--
select distinct category from retail_sales;

--find no of sales regarding category--
select category ,count(transactions_id) as total_sales
from retail_sales
group by category;

--type of genders--
select distinct gender from retail_sales;

--no of sales regarding gender--
select gender, count(transactions_id) as no_of_sales
from retail_sales
group by gender;

--which gender do most of sales--
select gender, count(transactions_id) as no_of_sales
from retail_sales
group by gender
order by 2 desc
limit 1;

--find diffrent age groups--
select distinct age 
from retail_sales;

--no of sales regarding age-group
select age ,count(transactions_id) as sales
from retail_sales
group by age
order by 2 desc;

--Write a SQL query to retrieve all columns for sales made on '2022-11-05:--
select * from retail_sales
where sale_date ='2022-11-05';

--no of sales on 2022-11-05--
select count(transactions_id) as no_of_sales
from retail_sales
where sale_date ='2022-11-05';

--Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
select * from retail_sales
where category='Clothing' and quantity>4
and to_char(sale_date,'yyyy-mm')='2022-11';

--Write a SQL query to calculate the total sales (total_sale) for each category.:--
select category,sum(total_sale)as total_sales
from retail_sales
group by category;

--Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

select category,avg(age) as avg_age
from retail_sales
group by category
having category='Beauty';

--alternate--
select avg(age)
from retail_sales
where category='Beauty';

-- Write a SQL query to find all transactions where the total_sale is greater than 1000.:
select * from retail_sales
where total_sale>1000;

-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
select category,gender
,count(transactions_id)
from retail_sales
group by category,gender
order by 3;

-- Write a SQL query to calculate the average sale for each month.Find out best selling month in each year:
select 
extract (year from sale_date) as year,
extract( month from sale_date )as month
,avg(total_sale) as sales,
rank() over(partition by extract (year from sale_date) order by avg(total_sale) desc) as rank
from retail_sales
group by 1,2;



select year,month from
(
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
)as ranked_moths
where rank=1
order by year;

-- **Write a SQL query to find the top 5 customers based on the highest total sales **:
select customer_id,sum(total_sale) as total_sale_by_customer
from retail_sales
group by customer_id
order by 2 desc
limit 5;

-- Write a SQL query to find the number of unique customers who purchased items from each category.:

select count(distinct customer_id)
from retail_sales
where category in ('Beauty','Clothing','Electronics');

-- customers who bought from all categories
select distinct customer_id
from retail_sales
group by customer_id
having 
count(distinct category)>=3;

-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
select 
case
when extract(hour from sale_time)<12 then 'Morning'
when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
else 'Evening'
end as Shift,
count(transactions_id)
from retail_sales
group by Shift;
--end of project--

