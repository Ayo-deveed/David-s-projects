## 1 Select customer name together with each order the customer made
select c.customer_Name, o.order_id
from customers as c
JOIN  orders as o on c.customer_id = o.customerid;

## 2 Select order id together with name of employee who handled the order.
SELECT order_id, first_name, last_name
FROM  orders as o
JOIN employees as e on o.employeeid = e.employee_id;

## 3. Select customers who did not placed any order yet.
select c.customer_Name, o.order_id
from customers as c
left JOIN  orders as o on c.customer_id = o.customerid
Where o.order_id is null;

## 4. Select order id together with the name of products.
SELECT od.orderid, p.product_name
FROM order_details as od
join products as p on od.productid = p.product_id;

## 5.	Select products that no one bought. 
SELECT p.product_id, p.product_name
FRom products as p
inner join order_details as od on p.product_id = od.productid
where od.orderid is null;

SELECT p.product_id, p.product_name
FRom products as p
where p.product_id not in(
select productid
from order_details);

## 6. Select customer together with the products that he bought.
SELECT c.customer_Name, p.product_Name
from customers as c
join orders as o on c.customer_id = o.customerid
join order_details as od on o.order_id = od.orderid
join products as p on c.customer_Name = p.product_name;

# 7. Select product names together with the name of corresponding category.
SELECT p.product_name, c.category_name
FROM products as p
join categories as c on p.categoryid = c.category_id;

# 8. Select orders together with the name of the shipping company
SELECT o.order_id, s.shipper_name
FROM orders AS o
JOIN shippers as s on shipperid = shipper_id;

# 9. Select customers with id greater than 50 together with each order they made.
SELECT c.customer_id, o.order_id
FROM customers as c
JOIN orders as o on c.customer_id = o.customerid
where customer_id > 50;

# 10. Select employees together with orders with order id greater than 10400.
SELECT e.employee_id,order_id
FROM employees as e
join orders as o on e.employee_id = o.employeeid
where order_id > 10400;

# 11. Select the most expensive product.
SELECT product_name, price
from products
order by price desc
limit 1;

# 12. Select the second most expensive product.
SELECT product_name, price
from products
order by price desc
limit 1 offset 1;

# 13. Select name and price of each product, sort the result by price in decreasing order
select product_name, price
from products
order by price desc;

# 14. Select 5 most expensive products.
SELECT product_name, price
from products
order by price desc
limit 5;

# 15. Select 5 most expensive products without the most expensive (in final 4 products)
SELECT product_name, price
from products
order by price desc
limit 5 offset 1 ;

# 16. Select name of the cheapest product (only name) without using LIMIT and OFFSET
SELECT product_name
FROM products
where price = (select min(price) from products);

# 17. Select name of the cheapest product (only name) using subquery.
SELECT product_name
FROM products
where price = (select min(price) from products);

# 18. Select number of employees with LastName that starts with 'D'
SELECT employee_id
from employees
where last_name = 'D%';

# 19.Select customer name together with the number of orders made by the corresponding customer, sort the result by number of orders in decreasing order 
SELECT c.customer_Name, count(O.order_id)
from customers as c
JOIN orders AS O ON c.customer_id = O.customerid
GROUP BY c.customer_Name
order by count(O.order_id) desc;

# 20.Add up the price of all products.
SELECT sum(price)
from products;

# 21. Select orderID together with the total price of that Order, order the result by total price of order in increasing order.
SELECT od.orderid, sum(p.price) 'Total Order Price'
from order_details as od
join products as p on od.productid = p.product_id
GROUP BY od.orderid
order by sum(p.price) asc;

# 22. Select customer who spend the most money.
select c.customer_Name, count(o.order_id) as 'Most Ordered Cust.'
from customers as c
JOIN orders AS o on c.customer_id = o.customerid
group by c.customer_Name
order by count(o.order_id) desc
limit 1; 

# 23. Select customer who spend the most money and lives in Canada.
select c.customer_Name, count(o.order_id)
from customers as c
JOIN orders AS o on c.customer_id = o.customerid
where country like 'canada'
group by c.customer_Name
order by count(o.order_id) desc
limit 1; 

# 24. Select customer who spend the second most money.
select c.customer_Name, count(o.order_id) as '2nd Most Ordered Cust.'
from customers as c
JOIN orders AS o on c.customer_id = o.customerid
group by c.customer_Name
order by count(o.order_id) desc
limit 1 offset 1; 

# 25. Select shipper together with the total price of proceed orders.
SELECT s.shipper_name, sum(p.price) as 'Total Price of Orders'
from shippers as s
JOIN products as p on s.shipper_id = p.supplierid
group by s.shipper_name
order by sum(p.price);


## B. EXPLORATORY DATA ANALYSIS
# 1. Total number of products sold so far.
select count(productid) as 'Total Product'
from order_details;

# 2. Total Revenue So far
SELECT sum(price*quantity) AS 'Total Revenue'
from products
join order_details on product_id = productid;

# 3. Total Unique Products sold based on category
SELECT count(distinct category_id) as 'Total Unique Products Sold off Category'
 from categories
 join products on categoryid = category_id;

# 4. Total Number of Purchase Transactions from customers.
SELECT count(customerid) as 'Total Purchase'
from orders;

# 5. Compare Orders made between 2021 – 2022
SELECT year(orderdate)as 'Order Year',count(order_id) as 'Total Order'
from orders
where orderdate between '2022-01-01' and '2023-12-31'
group by year(orderdate);

# 6. What is total number of customers? Compare those that have made transaction and those that haven’t at all.
select count(customer_id) as 'Total Customers'
from customers;

# 7. Who are the Top 5 customers with the highest purchase value?
select c.customer_name as 'Top 5 customers',  (price * quantity) as 'Purchase Value'
from products as p
join order_details as o on o.productid = p.product_id
join customers as c on c.customer_id = o.order_details_id
order by (price * quantity) desc
limit 5;

# 8. Top 5 best-selling products.
SELECT p.product_name,  count(od.productid) as 'Top 5 Selling Products'
from products as p
join order_details as od on p.product_id = od.productid
group by p.product_name
order by count(od.productid) desc
limit 5;

# 9. What is the Transaction value per month?
select monthname(orderdate) as 'Month',sum(Price * quantity) as 'Transaction Value'
from orders as o
join order_details as od on od.orderid = o.order_id
join products as p on p.product_id = od.productid
group by monthname(orderdate)
order by sum(Price * quantity) desc ;

# 10. Best Selling Product Category?
 select c.category_name, c.category_id, count(p.categoryid)
 from products as p
join categories as c on p.categoryid = c.category_id
group by c.category_id
order by count(c.category_id) desc
limit 1;

# 11. Buyers who have Transacted more than two times.
 select c.customer_id, c.customer_Name, count(o.customerid) as "Customer's Transactions"
from customers as c
 join orders as o on c.customer_id = o.customerid
 group by c.customer_id
having count(o.customerid) > 2
order by count(order_id) desc;

# 12. Most Successful Employee.*
select e.first_name, e.last_name, o.employeeid, count(e.employee_id) as 'Most Successful Employee'
from employees as e
join orders as o on e.employee_id = o.employeeid
 group by o.employeeid
order by count(o.employeeid) desc
limit 1;

## 13. Most used Shipper.
select shipper_name,shipper_id,count(shipperid)as 'Most Used Shipper'
from shippers
join orders on shipper_id = shipperid
group by shipper_id
order by count(shipperid) desc
limit 1;

## 14 Most used Supplier
SELECT supplier_id,supplier_name,count(supplierid) as 'Most Used Supplier'
from suppliers
join products on supplier_id = supplierid
group by supplier_id
order by count(supplierid) DESC
limit 5;