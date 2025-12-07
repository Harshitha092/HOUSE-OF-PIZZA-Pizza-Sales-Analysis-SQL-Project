-- kPI's     

-- Total number of orders placed.
select count(order_id) as Total_orders from orders;

-- Total revenue generated from pizza sales.
select round(sum(p.price * o.quantity), 2) as Total_revenue
from pizzas p join  order_details o 
on p.pizza_id = o.pizza_id;

-- Average order value (AOV):
select round(avg(Revenue),2) as AvgOrderValue
from (select od.order_id, sum(od.quantity * p.price) as Revenue
		from order_details od join pizzas p 
        on od.pizza_id = p.pizza_id
		group by od.order_id) as revenue_data;

-- Highest-priced pizza.
select pt.name, pt.category, p.size, p.price
from pizzas p join pizza_types pt 
on p.pizza_type_id = pt.pizza_type_id
order by p.price desc
limit 1;

-- Most common pizza size ordered.
select p.size, sum(od.quantity) as TotalQty
from order_details od join pizzas p 
on od.pizza_id = p.pizza_id
group by p.size
order by TotalQty desc
limit 1;
	
-- Business Questions
-- Top Performing Pizzas
-- List the top 5 most ordered pizza types along with their quantities.
select pt.name, sum(od.quantity) as Total_quantity
from order_details od join pizzas p
on p.pizza_id = od.pizza_id
join pizza_types pt
on p.pizza_type_id=pt.pizza_type_id
group by pt.name
order by Total_quantity desc
limit 5;

-- Find the top 3 pizza categories that generate the highest revenue.
select pt.category, round(sum(od.quantity * p.price), 2) as TotalRevenue
from order_details od join pizzas p
on od.pizza_id = p.pizza_id
join pizza_types pt
on p.pizza_type_id = pt.pizza_type_id
group by pt.category
order by TotalRevenue desc
limit 3;

-- Time-based insights
-- Revenue by day of week:
select dayname(o.order_date) as DayOfWeek, round(sum(od.quantity * p.price), 2) as Revenue
from orders o join order_details od
on o.order_id = od.order_id
join pizzas p
on od.pizza_id = p.pizza_id
group by dayname(o.order_date)
order by Revenue desc;

-- Monthly revenue trend:
select monthname(o.order_date) as MonthName, round(sum(od.quantity * p.price), 2) as Revenue 
from orders o join order_details od
on o.order_id = od.order_id
join pizzas p on od.pizza_id = p.pizza_id
group by MonthName
order by Revenue desc;

-- Determine the distribution of orders by hour of the day.
select hour(order_time) as Hours, count(order_id) as Ordercount
from orders
group by Hours
order by Hours asc;

-- Average number of orders per day.
select round(avg(DailyOrderCount), 0) as AvgOrderPerDay
from (select order_date, count(order_id) as DailyOrderCount
		from orders
		group by order_date) as daywiseOrders;
        
-- Group the orders by date and calculate the average number of pizzas ordered per day.
select round(avg(daily_pizza_quantity), 0) as AvgPizzasPerDay
from (select o.order_date, sum(od.quantity) as daily_pizza_quantity
from orders o join order_details od
on o.order_id = od.order_id
group by order_date) as tot_qty;

--         
-- Analyze the cumulative revenue generated over time.
select o.order_date, round(sum(od.quantity * p.price), 2) as DailyRevenue, 
		sum(round(sum(od.quantity * p.price), 2)) over (order by o.order_date) as cumm_revenue
from order_details od join orders o
on od.order_id = o.order_id
join pizzas p
on od.pizza_id = p.pizza_id
group by o.order_date;

-- Join the necessary tables to find the total quantity of each pizza category ordered.
select pt.category, sum(od.quantity) as Total_Quantity
from order_details od join pizzas p
on od.pizza_id = p.pizza_id
join pizza_types pt
on p.pizza_type_id = pt.pizza_type_id
group by pt.category
order by Total_Quantity desc;

-- Determine the top 3 most ordered pizza types based on revenue.
select pt.name, sum(p.price * od.quantity) as Total_revenue
from order_details od join pizzas p
on od.pizza_id = p.pizza_id
join pizza_types pt on p.pizza_type_id = pt.pizza_type_id
group by pt.name
order by Total_revenue desc
limit 3;
        
-- Calculate the percentage contribution of each pizza type to total revenue.
with cte_getTotalRev as (
	select sum(od.quantity * p.price) as TotalRevenue 
    from order_details od join pizzas p
	on od.pizza_id = p.pizza_id
	),
	cte_getDailyRevOnType as (
		select pt.pizza_type_id, pt.name, sum(od.quantity * p.price) as DailyRevenue
		from order_details od join pizzas p
		on od.pizza_id = p.pizza_id
		join pizza_types pt
		on pt.pizza_type_id = p.pizza_type_id
		group by pt.pizza_type_id, pt.name
    )
select trt.pizza_type_id, trt.name, round(DailyRevenue, 2) as Revenue,
		round((trt.DailyRevenue/tr.TotalRevenue) * 100, 2) as revenue_pct
from cte_getTotalRev tr cross join cte_getDailyRevOnType trt
order by revenue_pct desc;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
with cte_RevenueByType as (
	select pt.category, pt.name, sum(od.quantity * p.price) as Revenue, 
		rank() over (partition by pt.category order by sum(od.quantity * p.price) desc) as rank_no
	from order_details od join pizzas p
	on od.pizza_id = p.pizza_id
	join pizza_types pt
	on p.pizza_type_id = pt.pizza_type_id
	group by pt.category, pt.name
)
select category, name, round(Revenue, 2)as Revenue from cte_RevenueByType where rank_no < 4;
