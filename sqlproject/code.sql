-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;
--retrieve all books in the "fiction" genre;
select * from Books
where genre ='Fiction';

-- find books published after the year 1950;
select * from Books
where published_year >1950;
-- list all the customers from the caneda
select * from Customers
where country = 'Canada';
-- show orders placed in november 2023;
select * from Orders
where order_date between '2023-11-01' and '2023-11-30';

-- retrieve the total stock of books available;
select  sum(stock) as total_stock from books;

--find the details of the most expensive book;
select * from books
order by price desc
limit 1;
-- show all customers who ordered more than 1 quanitity os a book

select * from Orders
where quantity >1;

-- retrieve all order where the total amount exceeds $20
select * from orders
where total_amount >20;

--list all the genre available in the books table
select  genre from books;
select  distinct genre from books;

-- find the book with lowest stock
select * from books
order by stock
limit 5;

-- calculate the total revenue generated from all orders
select sum(total_amount) as total_revenue from orders;

--advance 
-- retrieve the total number of books sold from each genre
select b.genre,sum(o.quantity) as total_books_sold
from orders o
join books b on o.book_id = b.book_id
group by b.genre;

--find the average price of book in the fantasy genre
select * from books;
select avg(price)as average_price from books
where genre = 'Fantasy';

--list customers who have palced atleat 2 orders
select * from orders;

select o.customer_id , c.name,count(o.order_id)as count_order  
from orders o
join customers c on o.customer_id = c.customer_id
group by o.customer_id, c.name
having count(order_id)>=2;


-- find the most frequently ordered book
select o.book_id , b.title ,count(o.order_id)as order_count
from orders o
join books  b on b.book_id = o.book_id
group by o.book_id , b.title
order by  order_count desc limit 1;


-- show the 3 most expensive books of 'Fantasy ' genre
select * from books
where genre = 'Fantasy'
 order by price desc
 limit 3;

 --retrieve the total quantity of books sold by each author;
 select * from books;
  select * from orders;

 select b.author, sum(o.quantity)as  total_quantity
 from orders o
 join books b on b.book_id = o.book_id
 group by b.author;

 --list the city where cutomers who spent over $30 are located


 select distinct c.city , o.total_amount
 from orders o
 join customers c on c.customer_id = o.customer_id
 where o.total_amount > 30;
 -- find the customer who spent most

  select  c.name , sum(o.total_amount)as total_spent
 from orders o
 join customers c on c.customer_id = o.customer_id
 group by c.name
 order by total_spent desc
 limit 1;

 --calculate the stock remaining after fulfilling all orders
 select b.book_id,b.title,b.stock, coalesce(sum(o.quantity),0) as order_quantity,
 b.stock - coalesce(sum(o.quantity),0) as remaining_quantity
 from books b
 left join orders o on b.book_id = o.book_id
 group by b.book_id;
 

 
 
 
 















