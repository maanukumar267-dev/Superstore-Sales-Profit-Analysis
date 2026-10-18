/*
========================================================
PROJECT: Superstore Sales & Profit Analysis
SECTION 1: EXECUTIVE KPI ANALYSIS
AUTHOR: Mantu Kumar
DATABASE: SuperstoreDB
TABLE: dbo.Superstore
========================================================

BUSINESS QUESTION:
What are the overall sales, total profit, and number
of unique orders for the Superstore business?

OBJECTIVE:
Measure overall business performance using three
Key Performance Indicators (KPIs).
*/

-- Q1. Calculate the overall business performance KPIs.

SELECT
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    COUNT(DISTINCT Order_ID) AS Total_Orders
FROM dbo.Superstore;

/*
SECTION 2: SALES AND PROFIT ANALYSIS BY CATEGORY

BUSINESS QUESTION:
Which product category generates the highest sales
and profit?

OBJECTIVE:
Compare total sales and profit across product
categories to identify business performance.
*/

-- Q2. Analyze total sales and profit by category.

SELECT
    Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM dbo.Superstore
GROUP BY Category
ORDER BY Total_Sales DESC;

/*
SECTION 3: REGIONAL SALES AND PROFIT ANALYSIS

BUSINESS QUESTION:
Which region generates the highest sales and profit?

OBJECTIVE:
Compare regional sales and profit to identify
strong-performing regions and business opportunities.
*/

-- Q3. Analyze total sales and profit by region.

SELECT
    Region,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM dbo.Superstore
GROUP BY Region
ORDER BY Total_Profit DESC;

/*
SECTION 4: MONTHLY SALES AND PROFIT ANALYSIS

BUSINESS QUESTION:
How do sales and profit change from month to month?

OBJECTIVE:
Analyze monthly sales and profit to identify trends
and fluctuations in business performance.
*/

-- Q4. Analyze monthly sales and profit.

SELECT
    YEAR(Order_Date) AS Order_Year,
    MONTH(Order_Date) AS Order_Month,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM dbo.Superstore
GROUP BY
    YEAR(Order_Date),
    MONTH(Order_Date)
ORDER BY
    Order_Year,
    Order_Month;

    /*
SECTION 5: TOP 10 PRODUCTS BY SALES

BUSINESS QUESTION:
Which 10 products generate the highest total sales?

OBJECTIVE:
Identify the products contributing the most revenue
to help the business understand product performance.
*/

-- Q5. Find the top 10 products by total sales.

SELECT TOP 10
    Product_Name,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM dbo.Superstore
GROUP BY Product_Name
ORDER BY Total_Sales DESC;

/*
SECTION 6: LOSS-MAKING PRODUCT ANALYSIS

BUSINESS QUESTION:
Which products generate a negative total profit?

OBJECTIVE:
Identify products with overall losses and help
the business investigate pricing, discounts, and costs.
*/

-- Q6. Find products with negative total profit.

SELECT
    Product_Name,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM dbo.Superstore
GROUP BY Product_Name
HAVING SUM(Profit) < 0
ORDER BY Total_Profit ASC;

/*
SECTION 7: CUSTOMER SEGMENT ANALYSIS

BUSINESS QUESTION:
Which customer segment generates the highest sales
and profit?

OBJECTIVE:
Compare sales and profit across customer segments
to identify the most valuable customer group.
*/

-- Q7. Analyze sales and profit by customer segment.

SELECT
    Segment,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM dbo.Superstore
GROUP BY Segment
ORDER BY Total_Sales DESC;

/*
SECTION 8: DISCOUNT ANALYSIS

BUSINESS QUESTION:
How do discounts relate to sales and profit
across product categories?

OBJECTIVE:
Compare average discounts, sales, and profit
to identify opportunities to improve profitability.
*/

-- Q8. Analyze average discount and profit by category.

SELECT
    Category,
    AVG(Discount) AS Average_Discount,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM dbo.Superstore
GROUP BY Category
ORDER BY Average_Discount DESC;

/*
========================================================
SECTION 9: PROFIT MARGIN ANALYSIS
========================================================

BUSINESS QUESTION:
Which product category has the highest profit margin?

OBJECTIVE:
Compare profit relative to sales across categories
to understand which category is more profitable.
*/

-- Q9. Calculate profit margin by category.

SELECT
    Category,
    CAST(SUM(Sales) AS DECIMAL(12,2)) AS Total_Sales,
    CAST(SUM(Profit) AS DECIMAL(12,2)) AS Total_Profit,
    CAST(
        100.0 * SUM(Profit) / NULLIF(SUM(Sales), 0)
        AS DECIMAL(5,2)
    ) AS Profit_Margin_Percent
FROM dbo.Superstore
GROUP BY Category
ORDER BY Profit_Margin_Percent DESC;

/*
========================================================
SECTION 10: TOP 10 MOST PROFITABLE PRODUCTS
========================================================

BUSINESS QUESTION:
Which 10 products generate the highest total profit?

OBJECTIVE:
Identify the products that contribute the most
to overall business profitability.
*/

-- Q10. Find the top 10 products by total profit.

SELECT TOP 10
    Product_Name,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM dbo.Superstore
GROUP BY Product_Name
ORDER BY Total_Profit DESC;

/*
========================================================
SECTION 11: BOTTOM 10 PRODUCTS BY PROFIT
========================================================

BUSINESS QUESTION:
Which 10 products have the lowest total profit?

OBJECTIVE:
Identify the least profitable products and areas
that may need business improvement.
*/

-- Q11. Find the bottom 10 products by total profit.

SELECT TOP 10
    Product_Name,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM dbo.Superstore
GROUP BY Product_Name
ORDER BY Total_Profit ASC;

/*
========================================================
SECTION 12: LOSS-MAKING ORDER ANALYSIS
========================================================

BUSINESS QUESTION:
Which individual order records have negative profit?

OBJECTIVE:
Identify loss-making records and investigate
possible reasons for negative profit.
*/

-- Q12. Find order records with negative profit.

SELECT
    Order_ID,
    Order_Date,
    Customer_Name,
    Product_Name,
    Sales,
    Profit
FROM dbo.Superstore
WHERE Profit < 0
ORDER BY Profit ASC;

/*
========================================================
SECTION 13: CUSTOMER PROFITABILITY ANALYSIS
========================================================

BUSINESS QUESTION:
Which customers generate the highest and lowest profit?

OBJECTIVE:
Identify the most and least profitable customers to
understand customer profitability and support business
decisions.

*/

-- Q13. Find total profit generated by each customer.

SELECT
    Customer_ID,
    Customer_Name,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM dbo.Superstore
GROUP BY
    Customer_ID,
    Customer_Name
ORDER BY Total_Profit DESC;

/*
========================================================
SECTION 14: SHIPPING MODE PERFORMANCE ANALYSIS
========================================================

BUSINESS QUESTION:
Which shipping mode generates the highest sales and profit?

OBJECTIVE:
Compare sales and profit across different shipping modes
to understand their business performance.
*/

-- Q14. Analyze sales and profit by shipping mode.

SELECT
    Ship_Mode,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    COUNT(DISTINCT Order_ID) AS Total_Orders
FROM dbo.Superstore
GROUP BY Ship_Mode
ORDER BY Total_Profit DESC;

/*
========================================================
SECTION 15: SUB-CATEGORY PROFITABILITY ANALYSIS
========================================================

BUSINESS QUESTION:
Which product sub-categories generate the highest
profit, and which have low profitability?

OBJECTIVE:
Compare sales, profit, and profit margin across
sub-categories to identify profitable products
and areas that need improvement.
*/

-- Q15. Analyze sales and profitability by sub-category.

SELECT
    Sub_Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    CAST(
        100.0 * SUM(Profit) / NULLIF(SUM(Sales), 0)
        AS DECIMAL(10,2)
    ) AS Profit_Margin_Percent
FROM dbo.Superstore
GROUP BY Sub_Category
ORDER BY Total_Profit DESC;

/*
========================================================
SECTION 16: REGIONAL SALES CONTRIBUTION ANALYSIS
========================================================

BUSINESS QUESTION:
What percentage of total sales comes from each region?

OBJECTIVE:
Measure each region's contribution to overall sales
to understand regional business performance.
*/

-- Q16. Calculate each region's percentage contribution to total sales.

SELECT
    Region,
    SUM(Sales) AS Total_Sales,
    CAST(
        100.0 * SUM(Sales) /
        SUM(SUM(Sales)) OVER ()
        AS DECIMAL(10,2)
    ) AS Sales_Contribution_Percent
FROM dbo.Superstore
GROUP BY Region
ORDER BY Total_Sales DESC;

/*
========================================================
SECTION 17: DISCOUNT IMPACT ON PROFITABILITY
========================================================

BUSINESS QUESTION:
How do different discount levels affect sales and profit?

OBJECTIVE:
Compare sales, profit, and profit margin across
discount ranges to identify potential profitability issues.
*/

-- Q17. Analyze business performance by discount range.

SELECT
    CASE
        WHEN Discount = 0 THEN '0% - No Discount'
        WHEN Discount <= 0.10 THEN '1% - 10% Discount'
        WHEN Discount <= 0.20 THEN '11% - 20% Discount'
        WHEN Discount <= 0.30 THEN '21% - 30% Discount'
        ELSE 'Above 30% Discount'
    END AS Discount_Range,

    COUNT(*) AS Total_Records,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,

    CAST(
        100.0 * SUM(Profit) / NULLIF(SUM(Sales), 0)
        AS DECIMAL(10,2)
    ) AS Profit_Margin_Percent

FROM dbo.Superstore

GROUP BY
    CASE
        WHEN Discount = 0 THEN '0% - No Discount'
        WHEN Discount <= 0.10 THEN '1% - 10% Discount'
        WHEN Discount <= 0.20 THEN '11% - 20% Discount'
        WHEN Discount <= 0.30 THEN '21% - 30% Discount'
        ELSE 'Above 30% Discount'
    END

ORDER BY MIN(Discount);

/*
========================================================
SECTION 18: YEAR-OVER-YEAR SALES GROWTH ANALYSIS
========================================================

BUSINESS QUESTION:
How did annual sales change compared with the previous year?

OBJECTIVE:
Calculate annual sales and year-over-year growth
to evaluate business performance over time.
*/

-- Q18. Calculate annual sales and year-over-year growth.

WITH Annual_Sales AS
(
    SELECT
        YEAR(Order_Date) AS Order_Year,
        SUM(Sales) AS Total_Sales
    FROM dbo.Superstore
    GROUP BY YEAR(Order_Date)
),
Sales_Comparison AS
(
    SELECT
        Order_Year,
        Total_Sales,
        LAG(Total_Sales) OVER (
            ORDER BY Order_Year
        ) AS Previous_Year_Sales
    FROM Annual_Sales
)
SELECT
    Order_Year,
    Total_Sales,
    Previous_Year_Sales,
    CAST(
        100.0 * (Total_Sales - Previous_Year_Sales)
        / NULLIF(Previous_Year_Sales, 0)
        AS DECIMAL(10,2)
    ) AS YoY_Growth_Percent
FROM Sales_Comparison
ORDER BY Order_Year;

/*
========================================================
SECTION 18: YEAR-OVER-YEAR SALES GROWTH ANALYSIS
========================================================

BUSINESS QUESTION:
How did annual sales change compared with the previous year?

OBJECTIVE:
Calculate annual sales and year-over-year growth
to evaluate business performance over time.
*/

-- Q18. Calculate annual sales and year-over-year growth.

WITH Annual_Sales AS
(
    SELECT
        YEAR(Order_Date) AS Order_Year,
        SUM(Sales) AS Total_Sales
    FROM dbo.Superstore
    GROUP BY YEAR(Order_Date)
),
Sales_Comparison AS
(
    SELECT
        Order_Year,
        Total_Sales,
        LAG(Total_Sales) OVER (
            ORDER BY Order_Year
        ) AS Previous_Year_Sales
    FROM Annual_Sales
)
SELECT
    Order_Year,
    Total_Sales,
    Previous_Year_Sales,
    CAST(
        100.0 * (Total_Sales - Previous_Year_Sales)
        / NULLIF(Previous_Year_Sales, 0)
        AS DECIMAL(10,2)
    ) AS YoY_Growth_Percent
FROM Sales_Comparison
ORDER BY Order_Year;