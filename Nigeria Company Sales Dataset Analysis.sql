select *
from company_sales_data_nigeria

--Query 1 Find total sales revenue for each region.

select Region,
		sum(TotalAmount) as total_revenue
from company_sales_data_nigeria
group by Region
order by total_revenue Desc

--Query 2 Find the number of orders placed by each customer.

select CustomerName,
		CustomerID,
		count(OrderID) as number_of_orders
from company_sales_data_nigeria
group by CustomerID, CustomerName
order by number_of_orders Desc

--Query 3 Calculate the average unit price of products in each category.

select ProductCategory,
		round(avg(PricePerUnit), 2) average_unit_price
from company_sales_data_nigeria
group by ProductCategory
order by average_unit_price desc


--Query 4 List all the orders where the quantity purchased is greater than 5.

Select *
from company_sales_data_nigeria
where Quantity > 5
order by Quantity desc

--Query 5 Find the total sales for each sales representative.

Select top 5 
		SalesRepName,
		SalesRepID, 
	sum(TotalAmount) total_sales
from company_sales_data_nigeria
group by SalesRepID, SalesRepName
order by total_sales desc


--Query 6 List all orders placed between '2024-01-01' and '2024-06-30'.

Select * 
from company_sales_data_nigeria
where OrderDate between '2024-01-01' and '2024-06-30'
order by OrderDate

-- Query 7 Find the top 5 customers by total purchase value.

Select top 5 CustomerName,
		CustomerID,
		sum(TotalAmount) as total_purchase_value
from company_sales_data_nigeria
group by CustomerName,
		CustomerID 
order by total_purchase_value desc


-- Query 8 Determine the number of orders pending for each region.

Select Region,
		count(DeliveryStatus) as number_of_orders_pending
from company_sales_data_nigeria
where DeliveryStatus = 'Pending'
group by Region
order by number_of_orders_pending desc

-- Query 9 Calculate the total quantity of products sold for each product category.

Select ProductCategory,
		count(Quantity) as quantity_sold
from company_sales_data_nigeria
group by ProductCategory
order by quantity_sold desc

-- Query 10 List all orders where the payment method is 'Bank Transfer' and the delivery status is 'Delivered'.

Select *
from company_sales_data_nigeria
where PaymentMethod = 'Bank Transfer' 
and		DeliveryStatus = 'Delivered'

--Query 11 Find total sales revenue in Ibadan, Ilorin, Lagos, Abekouta in February, 2024

Select Region,
		sum(TotalAmount) as total_sales_revenue
from company_sales_data_nigeria
where OrderDate between '2024-02-01' and '2024-02-28'
and Region in ('Ibadan', 'Ilorin', 'Lagos', 'Abeokuta')
group by Region