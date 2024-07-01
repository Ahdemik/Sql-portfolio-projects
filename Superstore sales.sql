
--select *
--from [Sample - Superstore]

----City with highest profits

--select City, sum(cast(Profit as int)) as Profit
--from [Sample - Superstore]
--group by City
--order by (Profit) Desc

----Product category with highest profits

--select Category, sum(cast(Profit as int)) as Profit
--from [Sample - Superstore]
--group by Category
--order by (Profit) Desc

----Product category with the highest sales

--select Category, sum(Sales) as HighestSale
--from [Sample - Superstore]
--group by Category
--order by (HighestSale) Desc

---- Sales per city

--select City, count(Sales) as HighestSale, 
--from [Sample - Superstore]
--group by City

---- Most used ship mode

--SELECT Ship_Mode, count(Ship_Mode) as MostUsedShipMode
--from [Sample - Superstore]
--group by Ship_Mode
--order by MostUsedShipMode desc

---- State with the highest sale

--select State, sum(Sales) as HighestSale
--from [Sample - Superstore]
--group by State
--order by (HighestSale) Desc

---- Sales per Region
--select Region, sum(Sales) as HighestSale
--from [Sample - Superstore]
--group by Region
--order by (HighestSale) Desc

---- Segment per segment
--select Segment, sum(Sales) as HighestSale
--from [Sample - Superstore]
--group by Segment
--order by (HighestSale) Desc

---- Sales per product category in concord city
--Select Category, count(category) as SalesInConcord
--from [Sample - Superstore]
--where City like 'Concord'
--group by Category
--order by SalesInConcord


--select City,Category,Sub_Category,Quantity,Order_Date,Order_ID,Product_Name
--from [Sample - Superstore]
--where Customer_Name like 'Claire Gute'
--order by Order_Date
