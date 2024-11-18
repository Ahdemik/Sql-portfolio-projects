-- # Smartphones Data Analysis Queries
-- This script contains various queries to analyze and manage data in the Smartphones table.

-- ## 1. Convert Price from INR to NGN
SELECT price, (price * 18.46) AS Price_in_ngn
FROM Smartphones;

-- ## 2. Add a "Price_in_ngn" Column to the Table
ALTER TABLE Smartphones
ADD Price_in_ngn NVARCHAR(255);

-- ## 3. Update the "Price_in_ngn" Column
UPDATE Smartphones
SET Price_in_ngn = (price * 18.46);

-- ## 4. Find Smartphones with the Highest Price
SELECT brand_name, model, MAX(price_in_ngn) AS Max_Price
FROM Smartphones
GROUP BY brand_name, model
ORDER BY Max_Price DESC;

-- ## 5. Find Smartphones with the Highest Rating
SELECT brand_name, model, MAX(rating) AS Max_Rating
FROM Smartphones
GROUP BY brand_name, model
ORDER BY Max_Rating DESC;

-- ## 6. Find Smartphones with the Highest Battery Capacity
-- Includes brand name, model, price in NGN, and rating
SELECT brand_name, model, price_in_ngn, rating, MAX(battery_capacity) AS Max_Battery_Capacity
FROM Smartphones
GROUP BY brand_name, model, price_in_ngn, rating
ORDER BY Max_Battery_Capacity DESC;

-- ## 7. List Smartphones with Snapdragon Processors
-- Includes only models with at least 8GB RAM and 64GB Internal Memory
SELECT brand_name, model, price_in_ngn, processor_brand, ram_capacity, internal_memory
FROM Smartphones
WHERE processor_brand LIKE 'snapdragon'
  AND ram_capacity >= 8
  AND internal_memory >= 64;

-- ## 8. List All Apple Smartphones
-- Includes their price, rating, battery capacity, RAM, and internal memory
SELECT brand_name, model, price_in_ngn, rating, battery_capacity, ram_capacity, internal_memory
FROM Smartphones
WHERE brand_name LIKE 'apple'
ORDER BY price_in_ngn DESC;
