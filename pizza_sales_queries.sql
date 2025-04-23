USE [pizza DB];
select * from pizza_sales
-- A. KPI’s
--1. Total Revenue:
select round(sum(total_price),2) as Total_Revenue from pizza_sales

--2. Average Order Value
select round(sum(total_price)/COUNT(distinct order_id),2) as Avg_order_value from pizza_sales

--3. Total Pizzas Sold
select sum(quantity) as Total_pizza_sold from pizza_sales

--4. Total Orders
select COUNT(distinct order_id)as Total_orders from pizza_sales

--5. Average Pizzas Per Order
select CAST(CAST(sum(quantity) as decimal(10,2))/CAST(count(distinct order_id)as decimal(10,2))as decimal(10,2))
as Avg_Pizzas_per_order from pizza_sales

--B. Daily Trend for Total Orders
SELECT DATENAME(DW,order_date) AS order_day,COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales GROUP BY DATENAME (DW, order_date)

--C. Monthly Trend for Orders
SELECT DATENAME(MONTH,order_date) AS order_day,COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales GROUP BY DATENAME (MONTH, order_date) ORDER BY Total_orders DESC

--D. % of Sales by Pizza Category
SELECT pizza_category,SUM(total_price)AS Total_sales,ROUND(SUM(total_price)*100/
(SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date)=1),2)
AS Percentage FROM pizza_sales
WHERE MONTH(order_date)=1 
GROUP BY pizza_category

--E. % of Sales by Pizza Size
SELECT pizza_size,CAST(SUM(total_price)AS DECIMAL(10,2))AS Total_sales,ROUND(SUM(total_price)*100/
(SELECT SUM(total_price) FROM pizza_sales),2)
AS Percentage FROM pizza_sales
GROUP BY pizza_size
ORDER BY Percentage DESC

--F. Total Pizzas Sold by Pizza Category
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC


--G. Top 5 Pizzas by Revenue
SELECT Top 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC

--H. Bottom 5 Pizzas by Revenue
SELECT Top 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC

--I. Top 5 Pizzas by Quantity
SELECT Top 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC

--J. Bottom 5 Pizzas by Quantity
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC

--K. Top 5 Pizzas by Total Orders
SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC

--L. Bottom 5 Pizzas by Total Orders
SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC


