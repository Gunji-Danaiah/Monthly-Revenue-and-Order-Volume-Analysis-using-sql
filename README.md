# Monthly Revenue and Order Volume Analysis

## Objective
Analyze monthly revenue and order volume from an online retail dataset using SQL.

## Tools Used
- PostgreSQL 16
- psql command‑line tool
- GitHub

## Dataset
Source: UCI Online Retail Dataset (`online_retail.csv`)  
Rows: 541,909  
Period: December 2010 – December 2011

## Methodology
1. Imported CSV into PostgreSQL using `\copy`.
2. Cleaned data by filtering out:
   - Cancelled orders (`Quantity <= 0`)
   - Zero/negative prices
   - Missing CustomerID
3. Calculated revenue per line item (`Quantity * UnitPrice`).
4. Aggregated by year‑month using `GROUP BY`.
5. Computed total revenue and distinct order count per month.

## SQL Query (Main Analysis)
```sql
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
