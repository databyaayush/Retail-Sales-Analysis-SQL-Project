retail_sales-- SQL retail sales analysis project --
CREATE DATABASE retail_sales_dataset;

-- Create table --
DROP TABLE IF EXISTS Retail_sales;
CREATE TABLE Retail_sales(
	transaction_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
	total_sale FLOAT
);

-- Finding NULL Values --

SELECT * FROM retail_sales
WHERE transaction_id IS NULL
	or
	sale_date IS NULL
    or
    sale_time IS NULL
    or
    customer_id IS NULL
    OR
    gender IS NULL
    OR
    age IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    price_per_unit IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

-- Deleting the NULL values --

DELETE FROM retail_sales
WHERE transaction_id IS NULL
	or
	sale_date IS NULL
    or
    sale_time IS NULL
    or
    customer_id IS NULL
    OR
    gender IS NULL
    OR
    age IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    price_per_unit IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- Data Exploration --
 
-- How many sales we have --
SELECT  COUNT(*) AS Total_sales FROM retail_sales;

-- How many customers we have --
SELECT COUNT(DISTINCT customer_id) AS Total_Customer FROM retail_sales;

-- How many categorys we have --
SELECT COUNT(DISTINCT category) AS Total_Category FROM retail_sales;

--  Bussiness Analysis --

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05 -- 
SELECT * 
FROM retail_sales
WHERE sale_date = "2022-11-05"; 

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and in the month of Nov-2022
SELECT *
FROM retail_sales
WHERE category = 'clothing'
  AND sale_date >='2022-09-01'
  AND sale_date <'2022-10-01';
  
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category,sum(total_sale)
FROM  retail_sales
GROUP BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT avg(age) AS AVG_AGE
FROM retail_sales
WHERE category = "Beauty";

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT *
FROM retail_sales
WHERE total_sale>1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT count(transaction_id) AS Total_Number_Of_Transaction,gender,category 
FROM retail_sales
GROUP BY gender,category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
	extract(year from sale_date) AS YEAR,
    EXTRACT(MONTH from sale_date) AS MONTH,
    sum(total_sale)
FROM retail_sales
group by sale_date
order by SUM(total_sale) DESC;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT customer_id,sum(total_sale)
FROM retail_sales
GROUP BY customer_id
ORDER BY sum(total_sale) DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT category,COUNT(DISTINCT customer_id )AS unique_customer
FROM retail_sales
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
SELECT
CASE
	WHEN EXTRACT(HOUR from sale_time)<12 THEN 'MORNING'
    WHEN EXTRACT(HOUR from sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
    WHEN EXTRACT(HOUR FROM sale_time)>17 THEN 'Evening'
    END AS SHIFT,
    count(total_sale) AS total_sold
FROM retail_sales
GROUP BY SHIFT;
 