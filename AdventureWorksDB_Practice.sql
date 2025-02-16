--AdventureWork Database Practice

--7)

Select * from Sales.SalesOrderHeader
Select CustomerID, SUM(Freight) total_freight from Sales.SalesOrderHeader
group by CustomerID 
order by CustomerID

--08)
Select CustomerID,SalesPersonID, AVG(SubTotal) avg_subtotal, SUM(SubTotal) sum_subtotal from Sales.SalesOrderHeader
group by CustomerID,SalesPersonID
order by CustomerID desc

--09)

select ProductID,sum(Quantity) total_quantity
from Production.ProductInventory
where Shelf in ('A','C','H')
group by ProductID
having sum(quantity) > 500
order by ProductID 

--10)
SELECT SUM(quantity) AS total_quantity
FROM production.productinventory
GROUP BY (locationid * 10);

--11) From the following tables write a query in SQL to find the persons whose last name starts with letter 'L'. Return BusinessEntityID, FirstName, LastName, and PhoneNumber. Sort the result on lastname and firstname.
--Sample table: Person.PersonPhone
SELECT PH.BusinessEntityID,PhoneNumber,FirstName,LastName
FROM Person.PersonPhone PH INNER JOIN  Person.Person P
ON PH.BusinessEntityID=P.BusinessEntityID
WHERE LastName LIKE 'l' 
ORDER BY LastName,FirstName

--12) From the following table write a query in SQL to find the sum of subtotal column. Group the sum on distinct salespersonid and customerid. Rolls up the results into subtotal and running total. Return salespersonid, customerid and sum of subtotal column i.e. sum_subtotal

SELECT SalesPersonID,CustomerID, SUM(SubTotal)  sum_subtotal FROM Sales.SalesOrderHeader
GROUP BY  ROLLUP (SalesPersonID,CustomerID )

SELECT coalesce(CAST(SalesPersonID AS VARCHAR),'TOTAL')
,coalesce(CAST(CustomerID AS VARCHAR),'TOTAL SALES BY SALES PERSON - '+CAST(SalesPersonID AS VARCHAR))
,SUM(SubTotal) sum_subtotal 
FROM Sales.SalesOrderHeader
GROUP BY  ROLLUP (SalesPersonID,CustomerID )

-----------------------------------------------------------------------------------------------------------------------------------

--13)From the following table write a query in SQL to find the sum of the quantity with subtotal for each locationid. Group the results for all combination of distinct locationid and shelf column. Rolls up the results into subtotal and running total. Return locationid, shelf and sum of quantity as TotalQuantity.
--Sample table: production.productinventory

SELECT * FROM production.productinventory
SELECT 
COALESCE(CAST(LOCATIONID AS VARCHAR),'GRAND_TOTAL') LOCATIONID
,COALESCE(CAST(Shelf AS VARCHAR),'SUB_TOTAL') SHELF
,SUM(Quantity) SUM_QUANTITY
FROM production.productinventory
GROUP BY GROUPING SETS ( ROLLUP (locationid, shelf), CUBE (locationid, shelf) );


--14)From the following table write a query in SQL to find the total quantity for each locationid and calculate the grand-total for all locations. Return locationid and total quantity. Group the results on locationid.
--Sample table: production.productinventory

SELECT 
COALESCE(CAST(LOCATIONID AS VARCHAR),'GRAND_TOTAL') LOCATIONID
,SUM(Quantity) SUM_QUANTITY
FROM production.productinventory
GROUP BY ROLLUP(LocationID)

--15) From the following table write a query in SQL to retrieve the number of employees for each City. Return city and number of employees. Sort the result in ascending order on city.
--Sample table: Person.BusinessEntityAddress
SELECT * FROM Person.Address

SELECT COUNT(BA.AddressID),CITY FROM Person.BusinessEntityAddress BA
INNER JOIN Person.Address PA ON BA.AddressID = PA.AddressID
GROUP BY City ORDER BY City ASC
