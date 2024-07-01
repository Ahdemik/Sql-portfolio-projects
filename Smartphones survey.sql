----Select*
----from Smartphones

----Convert price from INR to NGN

----Select price, (price)*18.46 as Price_in_ngn
----from Smartphones

----Adding Price in ngn column to the table

----Select*
----from Smartphones
----Alter Table Smartphones
----Add Price_in_ngn nvarchar(255);

----Updating the price in ngn

----Update  Smartphones
----Set Price_in_ngn = (price)*18.46

--SMARTPHONES WITH THE HIGHEST PRICE

--Select brand_name,model, max(price_in_ngn) as Max_Price
--from Smartphones
--group by brand_name, model
--order by Max_Price desc

--SMARTPHONES WITH THE HIGHEST RATING and Price

--Select brand_name,model, Max(rating) as max_rating
--from Smartphones
--group by brand_name,model
--order by max_rating desc

--SMARTPHONES WITH THE HIGHEST Battery capacity with price and rating

--Select brand_name,model, price_in_ngn,rating, Max(battery_capacity) as max_battery_capacity
--from Smartphones
--group by brand_name,model,price_in_ngn,rating
--order by max_battery_capacity desc

--List of smartphone where processor brand is snapdragon and proccessor is snapdragon

--select brand_name, model, price_in_ngn,processor_brand,ram_capacity, internal_memory
--from Smartphones
--where processor_brand like 'snapdragon'
--and ram_capacity >= '8'
--and internal_memory >= '64'

--select brand_name,Model,Price_in_ngn,rating,battery_capacity,ram_capacity,internal_memory
--from Smartphones
--where brand_name like 'apple'
--order by price_in_ngn desc


