-- CLEANING DATA IN SQL QUERIES FOR NASHVILLE HOUSING DATA

-- 1. STANDARDIZE DATE FORMAT
-- Convert the SaleDate column to a standardized date format and add a new column
UPDATE Nashvillehousing
SET SaleDate = CONVERT(DATE, SaleDate);

ALTER TABLE Nashvillehousing
ADD SaleDateConverted DATE;

UPDATE Nashvillehousing
SET SaleDateConverted = CONVERT(DATE, SaleDate);

-- Verify the updated SaleDateConverted column
SELECT SaleDateConverted
FROM Nashvillehousing;

-- 2. POPULATE MISSING PROPERTY ADDRESS DATA
-- Check rows with missing PropertyAddress
SELECT *
FROM Nashvillehousing
WHERE PropertyAddress IS NULL
ORDER BY ParcelID;

-- Identify corresponding addresses from other rows with the same ParcelID
SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, 
       ISNULL(a.PropertyAddress, b.PropertyAddress) AS UpdatedAddress
FROM Nashvillehousing a
JOIN Nashvillehousing b
    ON a.ParcelID = b.ParcelID
    AND a.[UniqueID] <> b.[UniqueID]
WHERE a.PropertyAddress IS NULL;

-- Update missing PropertyAddress with corresponding values
UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM Nashvillehousing a
JOIN Nashvillehousing b
    ON a.ParcelID = b.ParcelID
    AND a.[UniqueID] <> b.[UniqueID]
WHERE a.PropertyAddress IS NULL;

-- 3. SPLIT PROPERTY ADDRESS INTO INDIVIDUAL COLUMNS (ADDRESS, CITY)
-- Break down the PropertyAddress column
SELECT PropertyAddress,
       PARSENAME(REPLACE(PropertyAddress, ',', '.'), 2) AS PropertyAddress,
       PARSENAME(REPLACE(PropertyAddress, ',', '.'), 1) AS PropertyAddress_City
FROM Nashvillehousing;

-- Add and populate the new columns for PropertyAddress breakdown
ALTER TABLE Nashvillehousing
ADD PropertyAddress_fix NVARCHAR(255);

UPDATE Nashvillehousing
SET PropertyAddress_fix = PARSENAME(REPLACE(PropertyAddress, ',', '.'), 2);

ALTER TABLE Nashvillehousing
ADD PropertyAddress_City NVARCHAR(255);

UPDATE Nashvillehousing
SET PropertyAddress_City = PARSENAME(REPLACE(PropertyAddress, ',', '.'), 1);

-- 4. SPLIT OWNER ADDRESS INTO INDIVIDUAL COLUMNS (ADDRESS, CITY, STATE)
-- Break down the OwnerAddress column
SELECT OwnerAddress,
       PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3) AS Address,
       PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2) AS City,
       PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1) AS State
FROM Nashvillehousing;

-- Add and populate the new columns for OwnerAddress breakdown
ALTER TABLE Nashvillehousing
ADD Address NVARCHAR(255);

UPDATE Nashvillehousing
SET Address = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3);

ALTER TABLE Nashvillehousing
ADD City NVARCHAR(255);

UPDATE Nashvillehousing
SET City = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2);

ALTER TABLE Nashvillehousing
ADD State NVARCHAR(255);

UPDATE Nashvillehousing
SET State = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1);

-- 5. UPDATE "SOLD AS VACANT" FIELD (Y/N TO YES/NO)
-- View distinct values in SoldAsVacant and their counts
SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM Nashvillehousing
GROUP BY SoldAsVacant;

-- Update "SoldAsVacant" field with descriptive values
UPDATE Nashvillehousing
SET SoldAsVacant = CASE
    WHEN SoldAsVacant = 'Y' THEN 'Yes'
    WHEN SoldAsVacant = 'N' THEN 'No'
    ELSE SoldAsVacant
END;

-- 6. DELETE UNUSED COLUMNS
-- Drop columns no longer needed
ALTER TABLE Nashvillehousing
DROP COLUMN PropertyAddress, OwnerAddress;

-- 7. RENAME COLUMNS
-- Rename columns for better clarity
EXEC sp_rename 'Nashvillehousing.SaleDateConverted', 'SaleDate';
EXEC sp_rename 'Nashvillehousing.PropertyAddress_fix', 'PropertyAddress';
