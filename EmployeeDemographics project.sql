-- ===================================
-- INSERTING DATA INTO A TABLE
-- ===================================
INSERT INTO EmployeeDemographics
VALUES (NULL, 'Adedeji', NULL, NULL, NULL);

-- ===================================
-- SELECTING DATA FROM TABLES
-- ===================================
-- Select all records from EmployeeDemographics
SELECT *
FROM EmployeeDemographics
ORDER BY EmployeeID ASC;

-- Select all records from EmployeeDemographics using dbo schema
SELECT *
FROM dbo.EmployeeDemographics;

-- Select all records from EmployeeSalary
SELECT *
FROM dbo.EmployeeSalary;

-- ===================================
-- JOINING TABLES
-- ===================================
-- Full Outer Join between EmployeeDemographics and EmployeeSalary
SELECT *
FROM dbo.EmployeeDemographics
FULL OUTER JOIN dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;

-- ===================================
-- USING CASE STATEMENTS
-- ===================================
-- Cleaning Data with CASE Statements
SELECT FirstName, LastName, Age,
    CASE
        WHEN Age = 30 THEN 'Old'
        WHEN Age BETWEEN 25 AND 30 THEN 'Adult'
        WHEN Age > 30 THEN 'Senior'
        ELSE 'Young'
    END AS Status
FROM EmployeeDemographics
WHERE Age IS NOT NULL
ORDER BY Age;

-- Calculations with CASE Statements
SELECT FirstName, LastName, JobTitle, Salary,
    CASE
        WHEN JobTitle = 'Nurse' THEN Salary + (Salary * 0.20)
        WHEN JobTitle = 'Salesman' THEN Salary + (Salary * 0.15)
        WHEN JobTitle = 'Doctor' THEN Salary + (Salary * 0.30)
        ELSE Salary + (Salary * 0.005)
    END AS New_Salary
FROM dbo.EmployeeDemographics
JOIN dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
ORDER BY New_Salary;

-- ===================================
-- UPDATING DATA
-- ===================================
-- Update Gender for a specific EmployeeID
UPDATE dbo.EmployeeDemographics
SET Gender = 'Male'
WHERE EmployeeID = 1011;

-- ===================================
-- ALIASING COLUMNS
-- ===================================
-- Combine FirstName and LastName into Full_Name
SELECT FirstName + ' ' + LastName AS Full_Name
FROM EmployeeDemographics;

-- Aliasing tables for simplicity
SELECT demo.EmployeeID, sal.Salary
FROM EmployeeDemographics AS Demo
JOIN EmployeeSalary AS Sal
ON Demo.EmployeeID = Sal.EmployeeID;

-- ===================================
-- PARTITIONING DATA
-- ===================================
-- Count of Gender using PARTITION BY
SELECT FirstName, LastName, Salary, Gender,
    COUNT(Gender) OVER (PARTITION BY Gender) AS Total_Gender
FROM EmployeeDemographics Demo
JOIN EmployeeSalary Sal
ON Demo.EmployeeID = Sal.EmployeeID;

-- ===================================
-- TEMPORARY TABLES
-- ===================================
-- Create a temporary table
CREATE TABLE #temp_Employee_Salary (
    EmployeeID INT,
    JobTitle VARCHAR(100),
    Salary INT
);

-- Insert data into the temporary table
INSERT INTO #temp_Employee_Salary
VALUES (1001, 'Programmer', 10000);

-- Insert data from EmployeeSalary table into the temporary table
INSERT INTO #temp_Employee_Salary
SELECT *
FROM EmployeeSalary;

-- Update the temporary table
UPDATE #temp_Employee_Salary
SET EmployeeID = 1010
WHERE JobTitle = 'Programmer';

-- Drop and recreate another temporary table
DROP TABLE IF EXISTS #temp_EmployeeSalary2;
CREATE TABLE #temp_EmployeeSalary2 (
    JobTitle VARCHAR(50),
    Employee_Per_Job INT,
    Salary INT
);

-- Insert aggregated data into the temporary table
INSERT INTO #temp_EmployeeSalary2
SELECT JobTitle, COUNT(JobTitle), AVG(Salary)
FROM EmployeeDemographics AS Demo
JOIN EmployeeSalary AS Sal
ON Demo.EmployeeID = Sal.EmployeeID
GROUP BY JobTitle;

-- Select data from the temporary table
SELECT *
FROM #temp_EmployeeSalary2;

-- ===================================
-- CLEANING DATA WITH FUNCTIONS
-- ===================================
-- Trim unnecessary spaces
SELECT EmployeeID, TRIM(EmployeeID) AS TrimID
FROM EmployeeErrors;

-- Replace unwanted text in LastName
SELECT LastName, REPLACE(LastName, '- Fired', '') AS LastNameFixed
FROM EmployeeErrors;

-- ===================================
-- SUBQUERIES
-- ===================================
-- Subquery in SELECT statement
SELECT EmployeeID, Salary,
    (SELECT AVG(Salary) FROM EmployeeSalary) AS AvgSalary
FROM EmployeeSalary;

-- Subquery in WHERE statement
SELECT EmployeeID, JobTitle, Salary
FROM EmployeeSalary
WHERE EmployeeID IN (
    SELECT EmployeeID
    FROM EmployeeDemographics
    WHERE Age > 30
);

-- ===================================
-- STRING FUNCTIONS
-- ===================================
-- Convert names to lowercase
SELECT FirstName, LOWER(FirstName)
FROM EmployeeDemographics;

-- ===================================
-- STORED PROCEDURES
-- ===================================
-- Create and execute a stored procedure for a temporary table
CREATE PROCEDURE Temp_Employee2 AS
BEGIN
    CREATE TABLE #Temp_Employee (
        JobTitle VARCHAR(50),
        Employee_Per_Job INT,
        Salary INT
    );

    INSERT INTO #Temp_Employee
    SELECT JobTitle, COUNT(JobTitle), AVG(Salary)
    FROM EmployeeDemographics AS Demo
    JOIN EmployeeSalary AS Sal
    ON Demo.EmployeeID = Sal.EmployeeID
    GROUP BY JobTitle;

    SELECT *
    FROM #Temp_Employee;
END;

EXEC Temp_Employee2;
