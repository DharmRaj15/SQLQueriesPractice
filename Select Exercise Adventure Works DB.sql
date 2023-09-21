Select * from HumanResources.Employee
order by JobTitle asc

Select * from Person.Person [person]
order by LastName asc

Select FirstName, LastName, businessentityid as Employee_id
from Person.Person
order by LastName asc

SELECT ProductID,ProductNumber,Name
FROM production.Product
where SellStartDate is not null and ProductLine = 'T'
order by Name desc

Select salesorderid, customerid, orderdate, subtotal,(taxamt*100)/subtotal AS Tax_percent
from sales.salesorderheader
order by SubTotal desc

--7)
Select distinct JobTitle 
from HumanResources.Employee
Order by JobTitle asc

--8)
Select CustomerID,sum(Freight) as TotalFreight 
from Sales.SalesOrderHeader
group by CustomerID
order by CustomerID

--9)
Select ProductID, SUM(Quantity) as TotalQuantity 
from Production.ProductInventory
group by ProductID
order by ProductID asc


--10)From the following table write a query in SQL to find the total quentity for a group of locationid multiplied by 10.
Select sum(quantity) as total_quantity  
from Production.ProductInventory
group by (LocationID*10)

--11)From the following tables write a query in SQL to find the persons whose last name starts with letter 'L'. 
-----Return BusinessEntityID, FirstName, LastName, and PhoneNumber. Sort the result on lastname and firstname.

Select ph.BusinessEntityID,FirstName,LastName,PhoneNumber
from Person.PersonPhone ph inner join Person.Person pp
on ph.BusinessEntityID = pp.BusinessEntityID
and LastName like 'L%'
order by LastName,FirstName

--12) From the following table write a query in SQL to find the sum of subtotal column. Group the sum on distinct 
------salespersonid and customerid. Rolls up the results into subtotal and running total. Return salespersonid,
------customerid and sum of subtotal column i.e. sum_subtotal

Select distinct SalesPersonID,CustomerID,SUM(SubTotal) sum_subtotal 
from Sales.SalesOrderHeader
--group by SalesPersonID,CustomerID
GROUP BY ROLLUP (salespersonid, customerid)

--13. From the following table write a query in SQL to find the sum of the quantity of all combination of group of distinct 
-----locationid and shelf column. Return locationid, shelf and sum of quantity as TotalQuantity.

Select LocationID,Shelf, SUM(Quantity) TotalQuantity
from Production.ProductInventory
group by cube( LocationID,Shelf)

--14)From the following table write a query in SQL to find the sum of the quantity with subtotal for each locationid. 
-----Group the results for all combination of distinct locationid and shelf column. Rolls up the results into subtotal 
-----and running total.Return locationid, shelf and sum of quantity as TotalQuantity.

Select LocationID,Shelf, SUM(quantity) as TotalQuantity 
from Production.ProductInventory
group by GROUPING sets (rollup(LocationID,Shelf), cube(LocationID,Shelf))

--Select * from Production.ProductInventory

--15. From the following table write a query in SQL to find the total quantity for each locationid and calculate the 
------grand-total for all locations. Return locationid and total quantity. Group the results on locationid.

Select LocationID, SUM(Quantity) TotalQuantity 
from Production.ProductInventory
--group by rollup(LocationID)
group by GROUPING SETS ( locationid, () );


--16. From the following table write a query in SQL to retrieve the number of employees for each City. Return city and 
------number of employees. Sort the result in ascending order on city.

Select COUNT(b.AddressID) NoOfEmp,p.city
from Person.BusinessEntityAddress b inner join Person.[Address] p
on b.BusinessEntityID = p.City
group by p.city
order by p.City

--Select * from Person.BusinessEntityAddress where cast(AddressID as varchar)='Ottawa'

--17. From the following table write a query in SQL to retrieve the total sales for each year.
------Return the year part of order date and total due amount. Sort the result in ascending order on year part of order date.

Select SUM(TotalDue) as order_Amount,datepart(YEAR,OrderDate) as year 
from Sales.SalesOrderHeader
group by datepart(YEAR,OrderDate)
order by datepart(YEAR,OrderDate)
