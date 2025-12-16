-- Retrieve the total number of orders placed.
select count(order_id) as total_orders from orders;

-- Calculate the total revenue generated from pizza sales.
	select
	round(sum(orders_details.quantity * pizzas.price),2) as total_sales
	from orders_details join pizzas
	on pizzas.pizza_id = orders_details.pizza_id;
    
-- Identify the highest-priced pizza.
select
pizza_types.name,pizzas.price
from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
order by pizzas.price desc limit 1;

-- Identify the most common pizza size ordered.
select
pizzas.size,count(orders_details.order_details_id) as order_count
from pizzas join orders_details
on pizzas.pizza_id=orders_details.pizza_id
group by pizzas.size order by order_count desc limit 1;

-- List the top 5 most ordered pizza types along with their quantities.
	select
    pizza_types.name,sum(orders_details.quantity) as total_quantity
    from pizza_types join pizzas
    on pizza_types.pizza_type_id=pizzas.pizza_type_id
    join orders_details
    on orders_details.pizza_id=pizzas.pizza_id
    group by pizza_types.name order by total_quantity desc limit 5;