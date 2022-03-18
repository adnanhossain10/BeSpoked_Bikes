CREATE DATABASE BeSpoked_Bikes;
USE BeSpoked_Bikes;

--Ideally I should have written a JavaScript code to allow the client to only extract values 
--and keep the data in protected mode but due to the time constraint I just decided to use a single SQL File
--so I'm missing the client aspect in this project

--Since the question stated that at a minimum I need the following components, 
--after taking care of those componensts, I took the liberty to add some identifiers to
--help make distinction easier 
--Date input format YYYY-MM-DD


CREATE table Products(
Name VARCHAR(50),
PID INT Primary Key, 
Manufacturer VARCHAR(50),
Style VARCHAR(50),
Purchase_Price Real,
Sale_Price Real,
Qty_on_Hand INT,
Commission_Percentage Decimal(2,2) --Percentage will always be a decimal between 0 and 1
);

CREATE table Salesperson(
FName VARCHAR(20),
LName VARCHAR(20),
SID INT Primary Key,
Address VARCHAR(50),
Phone VARCHAR(50),
Start_Date Date,
Termination_Date Date 
);

CREATE table Customer(
FName VARCHAR(20),
LName VARCHAR(20),
CID INT Primary Key,
Address VARCHAR(50),
Phone VARCHAR(50),
Start_Date Date 
);

CREATE table Sales(
PID INT,
SID INT,
CID INT,
Sales_Date Date 
);

CREATE table Discount(
Product VARCHAR(50),
PID INT,
Begin_Date Date,
End_Date Date, 
Discount_Percentage Decimal(2,2) --Percentage will always be a decimal between 0 and 1
);

INSERT INTO Products 
VALUES
    ("Swagtron EB7", 1031, "Swagtron", "Foldable", 399.99, 599.99, 21, 0.05),
    ("ZIP EBike", 1076, "SWFT", "Electrical", 999.99, 1499.99, 6, 0.1);   
INSERT INTO Salesperson 
VALUES
    ("Kalp", "Patel", 46, "303 Brumbaugh Hall, Penn State","8149923728", "2022-03-17", "2022-03-18", "Muskan Rathi"),
    ("Aneesh", "Nadgouda", 78, "127 East Hamilton, State College","8144419768", "2011-03-17", "2038-03-27", "Sufian FNU");
INSERT INTO Customer
VALUES
    ("Aly", "Ghallab", 5161, "301, The Here", "717636572", "2018-06-19")
    ("Karim", "Degheady", 7598, "Woodruff, Atlanta", "570636572", "2017-07-21");
INSERT INTO Sales
VALUES  
    (1031, 46, 5161, "2019-03-11");
INSERT INTO Discount
VALUES 
    ("Zip EBike", 1076, "2021-06-21", "2021-07-21",0.4);

--Based on Client Actions

SELECT * from Salesperson;
Update Salesperson 
SET Address = "8th Street, Georgia Tech", Phone = "7693284332"
WHERE SID = 46;
SELECT * from Products;
Update Salesperson 
SET Qty_on_Hand = 16, Commission_Percentage = 0.2
WHERE PID = 1076;
SELECT p.Product as 'Product', c.Customer as 'Customer', s.Sales_Date as 'Sales_Date', 
p.Sale_Price as 'Sale Price', (sp.FName, sp.LName) as 'Salesperson', p.Commission_Percentage from Products p, 
Salesperson sp, Customer c, Sales s WHERE s.PID = p.PID, s.SID = sp.SID, s.CID = c.CID ORDER BY s.Sales_Date;
INSERT INTO Sales
VALUES
    ( 1076, 78, 7598, "2020-04-20");
-- Couldn't configure the last query properly due to some discrepancies in the data layer.
SELECT (sp.FName, sp.LName) as 'Salesperson', SUM(p.Commission_Percentage * p.Sale_Price) from Salesperson sp, Product p, Sales s where s.SID = sp.SID, p.PID = s.PID;

