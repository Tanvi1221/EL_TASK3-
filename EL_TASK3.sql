create database adventureworks;
use adventureworks;
CREATE TABLE customers (
    CustomerKey INT PRIMARY KEY,
    Prefix VARCHAR(10),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    BirthDate DATE,
    MaritalStatus VARCHAR(10),
    Gender VARCHAR(10),
    EmailAddress VARCHAR(100),
    AnnualIncome DECIMAL(10, 2),
    TotalChildren INT,
    EducationalLevel VARCHAR(100),
    Occupation VARCHAR(100),
    HomeOwner VARCHAR(10)
);
SELECT * FROM customers LIMIT 10;

#basic select, where, order by 

select FirstName, LastName, Gender, AnnualIncome
from customers
where Gender = 'F'
order by AnnualIncome desc;
    
#join 
show tables;
DESCRIBE orders;
SELECT 
    c.customerName,
    o.orderNumber,
    o.orderDate,
    o.status
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
ORDER BY o.orderDate DESC;

#Aggregatefunctions=group by
SELECT status, COUNT(*) AS total_orders # number of orders per status
FROM orders
GROUP BY status;
SELECT c.customerName, COUNT(o.orderNumber) AS total_orders #number of orders per customer
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY c.customerName
ORDER BY total_orders DESC;

-- Count of customers grouped by marital status
SELECT MaritalStatus, COUNT(*) AS TotalCustomers
FROM customers
GROUP BY MaritalStatus;

-- Average annual income by gender
SELECT Gender, AVG(AnnualIncome) AS AverageIncome
FROM customers
GROUP BY Gender;


#subqueries 
-- Get customers whose income is above the average income
SELECT FirstName, LastName, AnnualIncome
FROM customers
WHERE AnnualIncome > (
    SELECT AVG(AnnualIncome) FROM customers
);


#create a view 
-- View for high-income customers (above 80,000)
CREATE VIEW HighIncomeCustomers AS
SELECT FirstName, LastName, EmailAddress, AnnualIncome
FROM customers
WHERE AnnualIncome > 80000;
-- Use the view
SELECT * FROM HighIncomeCustomers;

#create an index for faster searching 
-- Index on EmailAddress for quick lookup
CREATE INDEX idx_email ON customers (EmailAddress);

-- Index on AnnualIncome for income-based filters
CREATE INDEX idx_income ON customers (AnnualIncome);



