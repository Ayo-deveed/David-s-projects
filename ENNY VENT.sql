-- CREATING A DATABASE
CREATE DATABASE enny_vent;

-- SELECTING A DATABASE
USE enny_vent;

## creating TABLES##
-- CREATING customer table
CREATE TABLE customers(
    customerid int auto_increment primary key,
    first_name varchar(150) not null,
    last_name varchar(150) not null,
    gender enum("Male","Female"),
    email varchar(200) unique default null,
    address text
);

-- creating orders table
CREATE TABLE orders(
      order_id int auto_increment primary key,
      order_date date not null,
      customer_id int not null,
      
      foreign key(customer_id) references customers(customerid)
);
      
-- creating product table--
CREATE TABLE products(
      product_id int auto_increment primary key,
      name varchar(200) not null,
      description text,
      price float (10,2) not null,
      stock_quantity int
);

-- creating order details
CREATE TABLE order_details(
       order_details_id int auto_increment primary key,
       quantity int not null,
       order_id int not null,
       productid int not null,
       
       constraint order_fk foreign key(order_id) references orders(order_id)
);

-- DML COMMANDS: DATA MANIPULATION LANGUAGE

-- Altering a table
ALTER TABLE order_details
ADD constraint product_fk foreign key(productid) references products(product_id);

## INSERTing sample table data into our tables

-- INSERTING DATA INTO CUSTOMER TABLE
INSERT INTO customers(first_name ,last_name,gender,email,address)
VALUES ("John","kennedy","Male","johnk@gmail.com","Ikeja,Lagos"),
('Mary','Ayo','Female','maryayo@gmail.com','Owerri,Imo'),
('Dele', 'Sayo','Female','delesayo@gmail.com','Iwo,Osun'),
('Titi','Layo','Male','titilayo@gmail.com','Ibadan,Oyo'),
('Abu','Bakar','Male','abubarkar@yahoo.com','Plateau,Jos');

SELECT *
from customers;

-- Inserting data into products table
INSERT INTO products(name,description,price,stock_quantity)
VALUES ('Samsung TV','50 inches','500.50','5'),
('Casio Watch','New Model','1500.00','30'),
('Polo Shirt','Fairly used','650.00','23'),
('Hp Laptop','UK Used','13000.50','10'),
('Hp Printer','Deskjet','2500.00','23'),
('ox fan','30 inches','1400.00','12');

select *
from products;

-- Inserting data into ORDERS table
INSERT INTO orders(order_date,customer_id)
VALUES ('2024-02-25','1'),
('2024-02-26','1'),
('2024-03-20','2'),
('2024-03-21','2'),
('2024-03-22','3'),
('2024-03-24','4'),
('2024-10-02','2'),
('2024-04-10','3'),
('2024-04-11','5'),
('2024-02-09','1');

SELECT *
from orders;

-- Inserting data into ORDERS DETAILS table
INSERT INTO order_details(quantity,order_id,productid)
VALUES ('2','1','1'),
('2','2','4'),
('3','3','3'),
('2','4','2'),
('2','1','1'),
('1','5','2'),
('3','6','3'),
('1','7','6'),
('1','8','5'),
('1','9','1');

SELECT *
FROM order_details;

-- To empty a table
TRUNCATE TABLE order_details;

-- update INFORMATION IN OUR table with a new row of value
INSERT INTO customers(first_name,last_name,gender,email,address)
VALUE ('Jonah','Elliot','Male','jelliot@gmail.com','Utako,Abuja');

-- Add a new column after tabke created
ALTER TABLE customers
ADD COLUMN phone int default null;

-- deleting a table
ALTER TABLE customers
DROP column phone;

-- deleting a table
drop table customers;

-- DElete an entire row of data
delete  from order_details
where order_details_id = 2;

-- update an existing info
update customers
set address = "Enugu, Enugu"
where customerid = 1;

-- update multiple info
update customers
set first_name = 'Dayo',gender = 'Female', email = 'dola@gmail.com'
where customerid =3; 