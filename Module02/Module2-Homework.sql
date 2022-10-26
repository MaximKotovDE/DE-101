select
city, 
count(distinct order_id) as number_order,
sum(sales) as revenue 
from public.orders o 
where category in ('Furniture', 'Technology')
and extract ('year' from order_date) = 2018 --извлекаем год из oder_date и фильтруем
group by 1
having sum(sales) > 10000
order by revenue desc;

/*select distinct 
category
from orders o;*/

select 
count(*),
count(distinct o.order_id)
from orders o 
left join "returns" r on r.order_id = o.order_id 

--9994 строки
-- inner 3226
-- left join 5009

select date_trunc('day', now())

--Total Sales
select state, city, sum(sales)
from orders o
group by state, city
order by sum(sales) desc

--Total Profit
select state, city, sum(profit)
from orders o
group by state, city
order by sum(profit) desc

--Profit Ratio
select extract ('year' from order_date) as year, extract ('month' from order_date) as month, avg(profit/sales) as profit_ratio
from orders o
group by extract ('year' from order_date), extract ('month' from order_date)
order by year, month

--Profit per Order
select distinct state, city, profit
from orders o 
group by distinct state, city, profit


--Sales per Customer
select distinct customer_name, sum(sales)
from orders o 
group by customer_name
order by sum(sales) desc

--Avg. Discount
select category, extract ('year' from order_date), avg(discount)
from orders o
group by category, extract ('year' from order_date)
order by category, extract ('year' from order_date)

--Monthly Sales by Segment ( табличка и график)

select segment, extract('year' from order_date), extract ('month' from order_date), sum(sales)
from orders o 
group by segment, extract('year' from order_date), extract ('month' from order_date)
order by segment, extract('year' from order_date), extract ('month' from order_date)

--Monthly Sales by Product Category (табличка и график)


select category, extract('year' from order_date), extract ('month' from order_date), sum(sales)
from orders o 
group by category, extract('year' from order_date), extract ('month' from order_date)
order by category, extract('year' from order_date), extract ('month' from order_date)

--Sales by Product Category over time (Продажи по категориям)
select category, count(distinct order_id) as "COUNT SALES", sum(sales) as "SUM SALES"
from orders o 
group by category 
order by sum(sales) DESC

--Sales and Profit by Customer

select distinct customer_name, sum(sales) as sales, sum(profit) as profit
from orders o 
group by customer_name
order by sum(sales) DESC

--Customer Ranking
select distinct customer_name, sum(sales) as sales, sum(profit) as profit
from orders o 
group by customer_name
order by sum(profit) DESC


--Sales per region

select region, sum(sales) as sales
from orders o
group by region
order by sum(sales) DESC 