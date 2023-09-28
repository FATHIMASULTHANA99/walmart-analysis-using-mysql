use db; #	db is my database
-- Create table
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);

-- Data cleaning 

 -- There are no null values in our database as in creating the tables,
--  we set NOT NULL for each field, hence null values are filtered out.

-- ------------------------------------------------------------------------------------------------------
-- -------------------------------------Feature Engineering-----------------------------------------
-- ------------------------------------------------------------------------------------------------------
SELECT
	*
FROM sales;


-- Add the time_of_day column
SELECT
	time,
	(CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END) AS time_of_day
FROM sales;


ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

-- For this to work turn off safe mode for update
-- Edit > Preferences > SQL Edito > scroll down and toggle safe mode
-- Reconnect to MySQL: Query > Reconnect to server
UPDATE sales
SET time_of_day = (
	CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END
);


-- Add day_name column
SELECT
	date,
	DAYNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

UPDATE sales
SET day_name = DAYNAME(date);


-- Add month_name column
SELECT
	date,
	MONTHNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);

UPDATE sales
SET month_name = MONTHNAME(date);

-- --------------------------------------------------------------------------------------------------
-- ---------------------------- Generic questians----------------------------------------------------
-- --------------------------------------------------------------------------------------------------
-- How many unique cities does the data have?
SELECT 
	DISTINCT city
FROM sales;

-- In which city is each branch?
SELECT 
	DISTINCT city,
    branch
FROM sales;

-- --------------------------------------------------------------------
-- ---------------------------- Product -------------------------------
-- --------------------------------------------------------------------

-- How many unique product lines does the data have?
SELECT
	DISTINCT product_line
FROM sales;


-- What is the most selling product line
SELECT
	SUM(quantity) as qty,
    product_line
FROM sales
GROUP BY product_line
ORDER BY qty DESC;

-- What is the most selling product line
SELECT
	SUM(quantity) as qty,
    product_line
FROM sales
GROUP BY product_line
ORDER BY qty DESC;

-- What is the total revenue by month
SELECT
	month_name AS month,
	SUM(total) AS total_revenue
FROM sales
GROUP BY month_name 
ORDER BY total_revenue;


-- What month had the largest COGS?
SELECT
	month_name AS month,
	SUM(cogs) AS cogs
FROM sales
GROUP BY month_name 
ORDER BY cogs;


-- What product line had the largest revenue?
SELECT
	product_line,
	SUM(total) as total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- What is the city with the largest revenue?
SELECT
	branch,
	city,
	SUM(total) AS total_revenue
FROM sales
GROUP BY city, branch 
ORDER BY total_revenue;


-- What product line had the largest VAT?
SELECT
	product_line,
	AVG(vat) as avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax DESC;

-- -- Fetch each product line and add a column to those product 
-- line showing "Good", "Bad". Good if its greater than average sales



SELECT avg(total) from sales;

select product_line as pd, total,
       case
		   when total > (select avg(total) from sales)  then 'good'
		   else 'bad'
       end as good_bad_product
from sales;


-- which brand sold more product than avrg products sold?

select avg(quantity) as qty from sales;

select branch, sum(quantity) as qty
from sales
group by branch order by qty desc  ;

-- what is the most common product by gender?

SELECT gender,product_line,count(gender) as cn
FROM sales
GROUP BY gender,product_line order by cn desc ;


-- what is the average rating of each product_line?

select product_line , avg(rating) from sales GROUP BY product_line order by avg(rating) desc;

-- -------------------------------------------------------------------------------------------------------
-- ------------------------------------ Sales-------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------

-- number of sales made in each time of the day per weekday?

select dayname,time_of_day,sum(quantity)   from sales GROUP BY dayname,time_of_day ORDER BY sum(quantity) desc;

-- which of the customer types brings the most revenue?

select customer_type,sum(total) from sales GROUP BY customer_type order by sum(total) desc;

-- which city has the largest tax percent / VAT ( value added tax)?

select city,avg(vat) from sales GROUP BY city order by avg(vat) desc;


-- which customer_type pays the most in VAT?

select customer_type,avg(vat) from sales GROUP BY customer_type order by avg(vat) desc ;

-- -----------------------------------------------------------------------------------------------------
-- -----------------------------------------------Customer----------------------------------------------
-- -----------------------------------------------------------------------------------------------------
 
-- how many unique customer_types does the data have and its counts?

select distinct(customer_type) as customer_type, count(customer_type) as count from sales
 group by customer_type ORDER BY customer_type desc;
 
 -- how many unique payment methods does the data have?
 
 select distinct(payment_method)  from sales ;
 
 -- what is the most customer type?
 
 select DISTINCT(customer_type) as cus,count(customer_type) as count 
 from sales group by cus order by count;
 
 -- which customer type buys the most?
 
 -- select distinct(customer_type) as cs,sum(quantity ) as qt from sales group by cs order by qt desc;

select customer_type,count(*) 
 from sales group by customer_type order by count(*)  desc;
 
 -- what is the gender of the most of the customers?
 
 select gender,count(*) from sales group by gender order by count(*) desc; 
 
 -- what is the gender distribution per  branch?
 
 select branch,gender,count(*) from sales group by gender,branch order by branch;
 
 
-- what time of the day do customers give most ratings?

select time_of_day,count(rating) from sales group by time_of_day ; 

-- -- what time of the day do customers give most ratings?

select branch,time_of_day,count(rating) from sales 
group by branch,time_of_day order by branch,count(rating) desc; 


-- which day of the week has the best average ratings?

select dayname,avg(rating) from sales group by dayname order by avg(rating) desc; 
 
 
-- which day of the week has the best average ratings per branch?

select branch,dayname,avg(rating) from sales
 group by  branch,dayname order by branch,avg(rating) desc; 

