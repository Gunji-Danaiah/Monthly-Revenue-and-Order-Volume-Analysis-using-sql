# Monthly Revenue and Order Volume Analysis

## Objective
Analyze monthly revenue and order volume from an online retail dataset.

## Tools Used
- SQL (PostgreSQL syntax)
- Online SQL environments: SQLFiddle, DB-Fiddle, or PostgreSQL locally

## Dataset
Source: UCI Online Retail Dataset
Records: 541,909 transactions
Period: December 2010 - December 2011

## Analysis Steps
1. Data cleaning (removing cancelled orders, NULL customers)
2. Revenue calculation per transaction
3. Monthly aggregation
4. Order volume calculation
5. Trend analysis

## Key Findings
- December 2010 had the highest revenue (£734,582.71)
- Order volume peaks during holiday seasons
- Average order value remains consistent around £450

## SQL Query Highlights
```sql
-- Core monthly aggregation
SELECT 
    EXTRACT(YEAR FROM InvoiceDate) AS year,
    EXTRACT(MONTH FROM InvoiceDate) AS month,
    SUM(Quantity * UnitPrice) AS total_revenue,
    COUNT(DISTINCT InvoiceNo) AS order_volume
FROM online_sales
WHERE Quantity > 0
GROUP BY year, month
ORDER BY year, month;
