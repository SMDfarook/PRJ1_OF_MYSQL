
-- DATA EXPLORATION & CLEANING 
-- Null Value Check: Check for any null values in the dataset and delete records with missing data. 
select  * from sales
where transaction_id is null or sale_date is null or sale_time is null or
 customer_id is null or gender is null or age is null or category is null or
 quantity is null or price_per_unit is null or cogs is null or total_sale is null ;
 
 -- Delete null values from sales tables now we can check..
 Delete from sales
 where transaction_id is null or sale_date is null or sale_time is null or
 customer_id is null or gender is null or age is null or category is null or
 quantity is null or price_per_unit is null or cogs is null or total_sale is null ;
 
 --  Nulls values detele we chck the once sales data..
 select * from sales;
 
 -- Record Count: Determine the total number of records in the dataset.
 select count(*) from sales;

 -- Customer Count: Find out how many unique customers are in the dataset.
 select count(distinct customer_id) from users;
 
 -- Category Count: Identify all unique product categories in the dataset. 
 select distinct category from sales;
 
 
 
 --  DATA ANALYSIS & FINDINGS...
  --  1.Write a SQL query to retrieve all columns for sales made on '2023-01-01':
  select * from sales
  where sale_date=  '2023-01-01';
 
 --  2. Write a SQL query to retrieve all transactions where the category is 'Clothing' 
 --     and the quantity sold is more than 2 in the month of dec-2022:
select * from sales
where category = 'Clothing' 
and date_format(sale_date , '%Y-%m')  =  '2022-12'
and quantity >=2;


-- 3.Write a SQL query to calculate the total sales (total_sale) for each category.:
select  category,
sum(total_sale) as total_saless
from sales
group by category ;

-- 4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
select  
round(avg(age) ,2) as avg_ages
from sales
where category= 'beauty'; 

-- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.:
select * from sales
where total_sale > 1000;

-- 6.Write a SQL query to find the total number of transactions (transaction_id) made
--   by each gender in each category.: 
select gender,category,
count(transaction_id) as transcation
from sales
group  by gender,category 
order  by transcation asc;


-- 7 Write a SQL query to find the top 5 customers based on the highest total sales **:
select customer_id, gender,
sum(total_sale) as  highest_sales 
from sales
group by customer_id ,gender
order by highest_sales desc
limit 5;

-- 8 Write a SQL query to find the number of unique customers who purchased items from each category (Electronics ,clothing)and only male person.:
select sale_date,sale_time,category,gender,age,
count(distinct customer_id) as cust_uniq
from sales 
where  gender = 'male' and  category in ('Electronics' ,'Clothing')
group  by  sale_date,sale_time,category,gender,age ;

-- 9 . Write a SQL query to calculate the average sale for each month. Find out best selling month in each year: alter
select 
    Year,
    Month,
    avg_sales
    from
(select 
extract(Year  from sale_date) as Year,
extract(Year  from sale_date)as Month,
avg(total_sale) as avg_sales,
rank() over(partition by extract(Year  from sale_date),extract(Year  from sale_date)  order by avg(total_sale) desc) as rankss
from sales
group by extract(Year  from sale_date),
         extract(Year  from sale_date)
) as subs
where rankss = 1;

-- 10 . Write a SQL query to create each shift and number of orders (Example Morning 
--      <12, Afternoon Between 12 & 17, Evening >17):WITH hourly_sale
-- SUBSQUERY 
select 
shift,
count(*) as  total_orders
from
(select *,
      case
      when Hour(sale_time) <12 Then 'morning'
      when Hour(sale_time) between 12 and 17 then 'afternoon'
      else 'evening'
      end as shift
      from sales) as subs
GROUP BY shift 
ORDER BY total_orders DESC;

-- CTE QUERY
with monthly as 

(select *,
      case
      when Hour(sale_time) <12 Then 'morning'
      when Hour(sale_time) between 12 and 17 then 'afternoon'
      else 'evening'
      end as shift
      from sales)
select  shift,
count(*)as total_orders
from monthly
group by shift
order by total_orders desc;


-- END OF PROJECT 1 