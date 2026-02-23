CREATE TABLE Books(
 Book_id INT PRIMARY KEY ,
 Title VARCHAR(100),
 Author VARCHAR(100),
 Genre VARCHAR(50),
 Published_year INT,
 Price NUMERIC(10,2),
 Stock INT
);
DROP TABLE IF EXISTs custommer;
CREATE TABLE Customers(
 Customers_id serial PRIMARY KEY,
 Name varchar(100),
 Email varchar (100),
 Phone varchar (100),
 City  varchar (100),
 Country  varchar(100)
);

CREATE TABLE Orders(
 Order_id serial primary key,
 Customer_id int references Customers (Customers_id),
 Book_id int references Books (Book_id),
 Order_Date Date,
 Quantity int,
 Total_Ammount NUMERIC(10,2)
);
SELECT * FROM  Orders;
SELECT * FROM  Books;
SELECT * FROM Customers;
-- Retrive All Book in the 'Fiction ' Gener
SELECT * from Books
where genre ='Fiction';
-- Finds Books published After the year 1950
Select * from Books
where published_year>1950;
-- List All The cusromer from the canada
Select * from Customers
where country='Canada';
-- Show Orders place in Novmber 2023
Select * from Orders
where order_date BEtween '2023-1-01' AND '2023-11-30';

-- Retrive The Total stock of Book avilable
SELECT  Sum (stock)  AS total_Stock from Books;

-- Find The details of the most expencive book
 SELECT * FROM Books ORDER BY price DESC;

 -- Shoe All the customer who order more than 1 quantity of Book
  SELECT *  FROM Orders
  WHERE quantity>'1';
--Retrive the all orders where the total ammount exceeds $20
 select * from orders
 WHERE total_ammount>'20';
-- List all genres Avilable in the Books title
Select  Distinct genre from Books;
-- Finds the Books of lowest Stock
SELECT * FROM Books  ORDER BY stock  ;

-- Calculate the total revenue genrated from all orders
SELECT SUM (total_ammount) AS Total_revenue FROM Orders  ;
-- Retrive the total number of books sold for each genre

-- Retrive The total number of sold for each genre
Select b.genre, sum(o.quantity) As Total_Book_sold
from orders o
join Books b on o.book_id= b.book_id
group by b.genre;

-- find the average price of books in the "fantasy" genre.
	Select AVG(price) As average_price
	from Books
	where genre='fantasy';
	-- list of customer who have placed at least  2 orders
	SELECT o.customer_id, 
       c.name, 
       COUNT(o.order_id) AS order_count
FROM orders o
JOIN customers c 
     ON o.customer_id = c.customers_id
GROUP BY o.customer_id, c.name
HAVING COUNT(o.order_id) >= 2;

-- find the most frequantly ordered  book
Select o.book_id,b.title ,count (order_id) As order_count
from orders o
join books b on o.book_id=b.book_id 
group by o.book_id, b.title
order by order_count desc limit 4;

-- Show the top 3 most expensive books of 'fannasy ' genre
select * from books 
where genre='Fantasy'
order by price desc limit 3;
 
-- Retrive the total quantity of books sold by each author
select b.author, sum(o.quantity) as total_book_sold
from orders o
join books b on b.book_id=o.book_id
group by b.author;
-- L:Ist the city where customer who spent over $30 are located 
select  distinct c.city, total_ammount
from orders o
join customers c on c.customers_id= o.customer_id
where o.total_ammount>30 limit 2;

-- Find the customer who spent the most on orders
select c.customers_id, c.name,sum (o.total_ammount) as total_spent
from orders o
join customers c on o.customer_id= c.customers_id
group by c.customers_id,c.name
order by total_spent DESC;

 -- Calculate The stock remaining after fulfilling all orders 

	 select b.book_id,b.title,b.stock, coalesce (sum(quantity),0) As order_quantity 
	 from books b
	 left join orders o on b.book_id=o.book_id
	 group by b.book_id;
