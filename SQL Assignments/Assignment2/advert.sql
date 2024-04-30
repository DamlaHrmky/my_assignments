CREATE DATABASE Advertisement;

CREATE TABLE Products(
 product_id INT IDENTITY PRIMARY KEY,
 product_name VARCHAR(255) NOT NULL 
);

CREATE TABLE Customers(
 customer_id INT IDENTITY PRIMARY KEY,
 first_name VARCHAR(50) NOT NULL,
 last_name VARCHAR(50) NOT NULL
);

CREATE TABLE Sales(
 sale_id INT IDENTITY PRIMARY KEY,
 product_id INT NOT NULL,
 customer_id INT NOT NULL
 FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE,
 FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE    
);

INSERT INTO Products(product_name) VALUES
('2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD'),
('Polk Audio - 50 W Woofer - Black');

SET IDENTITY_INSERT Customers ON 

INSERT INTO Customers(customer_id,first_name, last_name) VALUES
(17,'Rima', 'Miller'),
(18,'Parthenia', 'Lawrence'),
(31,'Glory', 'Russell');

SET IDENTITY_INSERT Customers OFF

INSERT INTO Sales(product_id, customer_id) VALUES
(1, 17),
(1, 18),
(1, 31);


---1. Product Sales Report

SELECT Cu.customer_id, Cu.first_name, Cu.last_name, 
	CASE Sales.product_id
        WHEN 2 THEN 'YES'
        ELSE 'No'
	END AS Other_Product

FROM Customers as Cu
INNER JOIN Sales on Sales.customer_id = Cu.customer_id
 
---2. return the conversion rate for each Advertisement type

CREATE TABLE Actions(
 Visitor_ID INT IDENTITY PRIMARY KEY,
 Adv_Type VARCHAR(2) NOT NULL,
 Action NVARCHAR(50) NOT NULL
);

INSERT INTO Actions(Adv_Type, Action) VALUES
('A', 'Left'),
('A', 'Order'),
('B', 'Left'),
('A', 'Order'),
('A', 'Review'),
('A', 'Left'),
('B', 'Left'),
('B', 'Order'),
('B', 'Review'),
('A', 'Review')
;


SELECT 
    Adv_Type, 
    CAST(ROUND(COUNT(CASE WHEN Action = 'Order' THEN 1 END)*1.0 / COUNT(Action), 2) AS DECIMAL(10,2)) AS Conversion_Rate
FROM 
    Actions
GROUP BY 
    Adv_Type;