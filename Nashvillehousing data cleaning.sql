-- Cleaning data in sql queries

-- Standardize Date Format

--Select*
--from Nashvillehousing

--update Nashvillehousing
--set SaleDate= Convert(date,Saledate)

--Alter table Nashvillehousing
--Add SaleDateConverted Date;

--update Nashvillehousing
--set SaleDateConverted= Convert(date,Saledate)

-- To run update saledate
--Select SaleDateConverted
--from Nashvillehousing

-- Populate property address data

--Select*
--from Nashvillehousing
--where PropertyAddress is null
--order by ParcelID

--Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.propertyaddress,b.PropertyAddress) 
--from Nashvillehousing a
--join Nashvillehousing b
-- on a.ParcelID=b.ParcelID
-- and a.[UniqueID ]<>b.[UniqueID ]
-- where a.PropertyAddress is null

-- update a
-- set PropertyAddress= ISNULL(a.propertyaddress,b.PropertyAddress)
-- from Nashvillehousing a
--join Nashvillehousing b
-- on a.ParcelID=b.ParcelID
-- and a.[UniqueID ]<>b.[UniqueID ]
-- where a.PropertyAddress is null

-- Breaking out Property Address into Individual Columns (Address,City,State)

--FOR PROPERTYADDRESS
--Select PropertyAddress
--from Nashvillehousing

--Select
--PARSENAME(Replace(propertyaddress, ',', '.'), 2) as PropertyAddress
--,PARSENAME(Replace(propertyaddress, ',', '.'), 1) as PropertyAddress_City
--from Nashvillehousing

--Alter Table Nashvillehousing
--Add PropertyAddress_fix nvarchar(255);

--Update Nashvillehousing
--Set PropertyAddress_fix = PARSENAME(Replace(propertyaddress, ',', '.'), 2)


--Alter Table Nashvillehousing
--Add PropertyAddress_City nvarchar(255);

--Update Nashvillehousing
--Set PropertyAddress_City = PARSENAME(Replace(propertyaddress, ',', '.'), 1) 

-- Breaking out Owner Address into Individual Columns (Address,City,State)

--select *
--from Nashvillehousing

--select
--PARSENAME(Replace(OwnerAddress, ',', '.'),3) as Address
--,PARSENAME(Replace(OwnerAddress, ',', '.'),2) as City
--,PARSENAME(Replace(OwnerAddress, ',', '.'),1) as State
--from Nashvillehousing

--Drop Table if exists Owner_Address_Fix
--Alter Table Nashvillehousing
--Add Address nvarchar(255);

--Update Nashvillehousing
--set Address= PARSENAME(Replace(OwnerAddress, ',', '.'),3)

--Alter Table Nashvillehousing
--Add City nvarchar(255);

--Update Nashvillehousing
--set City= PARSENAME(Replace(OwnerAddress, ',', '.'),2)

--Alter Table Nashvillehousing
--Add State nvarchar(255);

--Update Nashvillehousing
--set State= PARSENAME(Replace(OwnerAddress, ',', '.'),1)


--Changing of Acronymns to full( Y and N to Yes and NO in 'Sold as Vacant' field

--select Distinct(SoldAsVacant), Count(soldasvacant)
--from Nashvillehousing
--group by SoldAsVacant

--Select SoldAsVacant,
--Case
--	when SoldAsVacant = 'Y' then 'Yes'
--	when SoldAsVacant = 'N' then 'NO'
--	Else SoldAsVacant
--	End
--from Nashvillehousing

--Update Nashvillehousing
--Set SoldAsVacant =
--Case
--	when SoldAsVacant = 'Y' then 'Yes'
--	when SoldAsVacant = 'N' then 'NO'
--	Else SoldAsVacant
--	End

-- DELETE UNUSED COLUMNS 

--SELECT*
--FROM Nashvillehousing

--Alter Table Nashvillehousing
--Drop column PropertyAddress, OwnerAddress

--RENAMING COLUMNS NAME

--sp_rename 'Nashvillehousing.SaleDateConverted', 'SaleDate'

--sp_rename 'Nashvillehousing.PropertyAddress_fix', 'PropertyAddress'
