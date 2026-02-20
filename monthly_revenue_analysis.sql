DROP TABLE IF EXISTS online_sales;

CREATE TABLE online_sales (
    index_col INTEGER,
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description TEXT,
    Quantity INTEGER,
    InvoiceDate TIMESTAMP,
    UnitPrice NUMERIC(10,2),
    CustomerID NUMERIC,
    Country VARCHAR(50)
);

SET datestyle = 'ISO, MDY';

\copy online_sales(index_col, invoiceno, stockcode, description, quantity, invoicedate, unitprice, customerid, country) 
FROM 'C:/Users/Admin/Downloads/archive (2)/online_retail.csv' 
WITH (FORMAT csv, HEADER, DELIMITER ',');

SELECT 
    EXTRACT(YEAR FROM InvoiceDate) AS year,
    EXTRACT(MONTH FROM InvoiceDate) AS month,
    TO_CHAR(InvoiceDate, 'YYYY-MM') AS year_month,
    SUM(Quantity * UnitPrice) AS total_revenue,
    COUNT(DISTINCT InvoiceNo) AS order_volume
FROM online_sales
WHERE Quantity > 0 
  AND UnitPrice > 0 
  AND CustomerID IS NOT NULL
GROUP BY year, month, year_month
ORDER BY year, month;

SELECT 
    TO_CHAR(InvoiceDate, 'YYYY-MM') AS year_month,
    SUM(Quantity * UnitPrice) AS total_revenue,
    COUNT(DISTINCT InvoiceNo) AS order_volume
FROM online_sales
WHERE Quantity > 0 AND UnitPrice > 0
GROUP BY year_month
ORDER BY total_revenue DESC
LIMIT 3;
