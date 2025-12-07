CREATE DATABASE houseofpizza;
USE houseofpizza;

create table orders (
	order_id int not null,
    order_date date not null,
    order_time time not null,
    primary key(order_id)
    );

create table order_details(
	order_details_id int not null,
    order_id int not null,
    pizza_id text not null,
    quantity int not null,
    primary key(order_details_id)
);

SELECT * FROM pizzas;
SELECT * FROM pizza_types;
SELECT * FROM orders;
SELECT * FROM order_details;

-- pizzas
-- Total entries:
SELECT count(*) FROM pizzas;

-- Check if theres any null values:
select * from pizzas where pizza_id is null or pizza_type_id is null or size is null or price is null;

-- Check if there's any price that is negative or 0
select * from pizzas where price <= 0;

-- Distinct sizes:
select distinct size from pizzas;

-- Prize range:
select min(price) from pizzas;
select max(price) from pizzas;

-- pizzatypes
-- Total entries:
SELECT count(*) FROM pizza_types;

-- Check if any null values present:
select * from pizza_types where pizza_type_id is null or name is null or category is null;

-- Distinct category:
select distinct category from pizza_types;

-- Orders
-- Total entries:
SELECT count(*) FROM orders;

-- check if any null values present:
select * from orders where order_id is null or order_date is null or order_time is null;

-- check if any orders without order details present:
Select * from order_details od 
left join orders o
on o.order_id=od.order_id
WHERE o.order_id IS NULL;

-- Order details
-- Total entries:
SELECT count(*) FROM order_details;

-- check if any null values present:
select * from order_details where order_details_id is null or order_id is null or pizza_id is null or quantity is null;

-- check if any qty is negative or 0:
select * from order_details where quantity <=0;

-- Min & Max quantity ordered: 
select min(quantity) from order_details;
select max(quantity) from order_details;