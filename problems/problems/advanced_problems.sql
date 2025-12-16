-- Calculate the percentage contribution of each pizza category to total revenue.

select
pizza_types.category, round (sum(orders_details.quantity*pizzas.price) / (select sum(orders_details.quantity*pizzas.price) from orders_details join pizzas 
on orders_details.pizza_id=pizzas.pizza_id)*100,2) as revenue

from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join orders_details
on orders_details.pizza_id=pizzas.pizza_id
group by pizza_types.category order by revenue desc;


-- Analyze the cumulative revenue generated over time.

select order_date,
sum(revenue) over (order by order_date) as cum_revenue
from
(select orders.order_date, sum(orders_details.quantity*pizzas.price) as revenue
from orders join orders_details
on orders.order_id=orders_details.order_id
join pizzas
on orders_details.pizza_id=pizzas.pizza_id
group by orders.order_date) as sales;
