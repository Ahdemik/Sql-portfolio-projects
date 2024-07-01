--insert into EmployeeDemographics
--values (NULL, 'Adedeji', NULL, NULL, NULL)

--Select *
--from EmployeeDemographics
--order by EmployeeID ASC

--Select*
--from dbo.EmployeeDemographics

--Select *
--from dbo.EmployeeSalary


--Joining tables

--Select *
--from dbo.EmployeeDemographics
--full outer join dbo.EmployeeSalary
--on EmployeeDemographics.EmployeeID=EmployeeSalary.EmployeeID

--Using Case statement to clean data

-- select FirstName, Lastname,Age,
-- case
--when Age = 30 then 'old'
--	when Age between 25 and 30 then 'Adult'
--	when age > 30 then 'Agba'
--	else 'Young' 
-- end AS Status
-- from EmployeeDemographics
-- where Age is not null
-- order by age
 
-- Using Case statement for calculations

-- Select FirstName,LastName,JobTitle,Salary,
-- Case	
--	when Jobtitle = 'Nurse' Then Salary + (Salary * .20)
--	when Jobtitle= 'Salesman' then salary + (Salary * .15)
--	when JOBTITLE= 'Doctor' then salary + (salary * .30)
--	else salary + (Salary * .005)
--End AS New_Salary
--from dbo.EmployeeDemographics
--join dbo.EmployeeSalary
--on EmployeeDemographics.EmployeeID=EmployeeSalary.EmployeeID
-- order by New_Salary

--Select *
--from dbo.EmployeeDemographics
--order by EmployeeID

-- Using the update statement

--update .dbo.EmployeeDemographics
--set Gender= 'Male'
--where EmployeeID= 1011

--Aliasing (Joining columns into one)

--Select FirstName + ' ' + LastName as Full_Name
--from EmployeeDemographics

--select demo.EmployeeID, sal.Salary
--from EmployeeDemographics as Demo
--join EmployeeSalary as sal
--on demo.EmployeeID=sal.EmployeeID

--Partition

--select FirstName, LastName,Salary,Gender, count(Gender) over (partition by Gender) as Total_gender
--from EmployeeDemographics demo
--join EmployeeSalary sal
--on demo.EmployeeID=sal.EmployeeID

--Creating temp table

--create table #temp_Employee_Salary 
--(EmployeeID int,
--JobTitle varchar(100),
--Salary int,
--)

--Select *
--from #temp_Employee_Salary

--inserting into temp table

--insert into #temp_Employee_Salary values
--(1001, 'Programmer', 10000)

--Inserting data from another table into a temp table

--insert into #temp_Employee_Salary 
--select *
--from EmployeeSalary

--update #temp_Employee_Salary
--set EmployeeID= 1010
--where JobTitle = 'Programmer'

--Dropping an existing temp table and creating a new one

--drop table if exists #temp_EmployeeSalary2
--create table #temp_EmployeeSalary2
--(JobTitle varchar(50),
--Employee_Per_Job int,
--Salary int,
--)

--inserting data from 2 tables into temp table
--insert into #temp_EmployeeSalary2
--select JobTitle, count(JobTitle), Avg(Salary)
--from EmployeeDemographics as Demo
--join EmployeeSalary as Sal
--on Demo.EmployeeID=Sal.EmployeeID
--group by JobTitle

--select *
--from #temp_EmployeeSalary2

--using the drop table 

--drop table if exists employeeErrors
--CREATE TABLE EmployeeErrors (
--EmployeeID varchar(50)
--,FirstName varchar(50)
--,LastName varchar(50)
--)

--Insert into EmployeeErrors Values 
--('1001  ', 'Jimbo', 'Halbert')
--,('  1002', 'Pamela', 'Beasely')
--,('1005', 'TOby', 'Flenderson - Fired')

--Using Trim, LTrim, RTrim

--select EmployeeID, Trim(employeeID) as TrimId
--from EmployeeErrors

--USING REPLACE

--select LastName, Replace(LastName, '- fired', '') as lastnamefixed
--from EmployeeErrors

--using subquries (in the select, from, and where statement)



--subquery in select

--select EmployeeID, Salary, (select avg(salary) from EmployeeSalary) as AvgSalary
--from EmployeeSalary

----subquery in where

--select EmployeeID,JobTitle, Salary
--from EmployeeSalary
--where EmployeeID in (
--					select EmployeeID
--					from EmployeeDemographics
--					where Age > 30)

--Upper and Lower case

--Select FirstName, lower(FirstName)
--from EmployeeDemographics

--Store Procedure

--Create Procedure Temp_Employee2
--as
--create table #Temp_Employee
--(JobTitle varchar(50),
--Employee_Per_Job int,
--Salary int,
--)

--insert into #Temp_Employee
--select JobTitle, count(JobTitle), Avg(Salary)
--from EmployeeDemographics as Demo
--join EmployeeSalary as Sal
--on Demo.EmployeeID=Sal.EmployeeID
--group by JobTitle

--select *
--from #Temp_Employee

--Exec Temp_Employee2