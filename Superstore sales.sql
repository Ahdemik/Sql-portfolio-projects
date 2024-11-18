-- ========================================
-- City with the Highest Profits
-- ========================================
SELECT City, SUM(CAST(Profit AS INT)) AS Profit
FROM [Sample - Superstore]
GROUP BY City
ORDER BY Profit DESC;

-- ========================================
-- Product Category with Highest Profits
-- ========================================
SELECT Category, SUM(CAST(Profit AS INT)) AS Profit
FROM [Sample - Superstore]
GROUP BY Category
ORDER BY Profit DESC;

-- ========================================
-- Product Category with the Highest Sales
-- ========================================
SELECT Category, SUM(Sales) AS HighestSale
FROM [Sample - Superstore]
GROUP BY Category
ORDER BY HighestSale DESC;

-- ========================================
-- Sales per City
-- ========================================
SELECT City, COUNT(Sales) AS HighestSale
FROM [Sample - Superstore]
GROUP BY City;

-- ========================================
-- Most Used Ship Mode
-- ========================================
SELECT Ship_Mode, COUNT(Ship_Mode) AS MostUsedShipMode
FROM [Sample - Superstore]
GROUP BY Ship_Mode
ORDER BY MostUsedShipMode DESC;

-- ========================================
-- State with the Highest Sales
-- ========================================
SELECT State, SUM(Sales) AS HighestSale
FROM [Sample - Superstore]
GROUP BY State
ORDER BY HighestSale DESC;

-- ========================================
-- Sales per Region
-- ========================================
SELECT Region, SUM(Sales) AS HighestSale
FROM [Sample - Superstore]
GROUP BY Region
ORDER BY HighestSale DESC;

-- ========================================
-- Sales by Segment
-- ========================================
SELECT Segment, SUM(Sales) AS HighestSale
FROM [Sample - Superstore]
GROUP BY Segment
ORDER BY HighestSale DESC;

-- ========================================
-- Sales per Product Category in Concord City
-- ========================================
SELECT Category, COUNT(Category) AS SalesInConcord
FROM [Sample - Superstore]
WHERE City LIKE 'Concord'
GROUP BY Category
ORDER BY SalesInConcord;

-- ========================================
-- Orders by Customer: Claire Gute
-- ========================================
SELECT City, Category, Sub_Category, Quantity, Order_Date, Order_ID, Product_Name
FROM [Sample - Superstore]
WHERE Customer_Name LIKE 'Claire Gute'
ORDER BY Order_Date;
