--select *
--from [Online Sales Data]



--Total units sold
----select sum(units_sold) as Total_units_sold
----from [Online Sales Data]

--Total revenue
----Select sum(Total_Revenue) as Total_Revenue
----from [Online Sales Data]

--Total revenue per product category
----select Product_Category, sum(Total_revenue) as Total_revenue_by_Product_Category
----from [Online Sales Data]
----group by Product_Category
----order by Total_revenue_by_Product_Category desc

----Total Revenue per region
----select Region, sum(Total_revenue) as Total_Revenue_per_Region
----from [Online Sales Data]
----group by Region
----order by Total_Revenue_per_Region

----Most_Purchased_ProductCategory_In_Asia
----select  product_category, count(product_category) as Most_Purchased_ProductCategory_In_Asia
----from [Online Sales Data]
----where Region like 'Asia'
----group by product_category

----Most_Purchased_ProductCategory_In_Europe
----select  product_category, count(product_category) as Most_Purchased_ProductCategory_In_Europe
----from [Online Sales Data]
----where Region like 'Europe'
----group by product_category

----Most_Purchased_ProductCategory_In_NorthAmerica
----select  product_category, count(product_category) as Most_Purchased_ProductCategory_In_NorthAmerica
----from [Online Sales Data]
----where Region like 'Asia'
----group by product_category

--Most used payment method
----select Payment_Method, count(Payment_Method) as Most_Used_Payment_Method
----from [Online Sales Data]
----group by Payment_Method

--select Payment_Method, sum(Total_Revenue) as Total_Revenue_per_Payment_method
--from [Online Sales Data]
--group by Payment_Method
--order by Total_Revenue_per_Payment_method desc
