-- 1. View All Online Sales Data
SELECT * 
FROM [Online Sales Data];

-- 2. Total Units Sold
SELECT SUM(units_sold) AS Total_Units_Sold 
FROM [Online Sales Data];

-- 3. Total Revenue
SELECT SUM(Total_Revenue) AS Total_Revenue 
FROM [Online Sales Data];

-- 4. Total Revenue by Product Category
SELECT Product_Category, 
       SUM(Total_Revenue) AS Total_Revenue_by_Product_Category
FROM [Online Sales Data]
GROUP BY Product_Category
ORDER BY Total_Revenue_by_Product_Category DESC;

-- 5. Total Revenue by Region
SELECT Region, 
       SUM(Total_Revenue) AS Total_Revenue_per_Region
FROM [Online Sales Data]
GROUP BY Region
ORDER BY Total_Revenue_per_Region DESC;

-- 6. Most Purchased Product Category in Asia
SELECT Product_Category, 
       COUNT(Product_Category) AS Most_Purchased_Product_Category_In_Asia
FROM [Online Sales Data]
WHERE Region LIKE 'Asia'
GROUP BY Product_Category
ORDER BY Most_Purchased_Product_Category_In_Asia DESC;

-- 7. Most Purchased Product Category in Europe
SELECT Product_Category, 
       COUNT(Product_Category) AS Most_Purchased_Product_Category_In_Europe
FROM [Online Sales Data]
WHERE Region LIKE 'Europe'
GROUP BY Product_Category
ORDER BY Most_Purchased_Product_Category_In_Europe DESC;

-- 8. Most Purchased Product Category in North America
SELECT Product_Category, 
       COUNT(Product_Category) AS Most_Purchased_Product_Category_In_North_America
FROM [Online Sales Data]
WHERE Region LIKE 'North America'
GROUP BY Product_Category
ORDER BY Most_Purchased_Product_Category_In_North_America DESC;

-- 9. Most Used Payment Method
SELECT Payment_Method, 
       COUNT(Payment_Method) AS Most_Used_Payment_Method
FROM [Online Sales Data]
GROUP BY Payment_Method
ORDER BY Most_Used_Payment_Method DESC;

-- 10. Total Revenue by Payment Method
SELECT Payment_Method, 
       SUM(Total_Revenue) AS Total_Revenue_per_Payment_Method
FROM [Online Sales Data]
GROUP BY Payment_Method
ORDER BY Total_Revenue_per_Payment_Method DESC;
