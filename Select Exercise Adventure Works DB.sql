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

--18)From the following table write a query in SQL to retrieve the total sales for each year. Filter the result set for 
--those orders where order year is on or before 2016. Return the year part of orderdate and total due amount. Sort 
--the result in ascending order on year part of order date

Select SUM(TotalDue) as order_Amount,datepart(YEAR,OrderDate) as year 
from Sales.SalesOrderHeader
where datepart(YEAR,OrderDate) <= '2016'
group by datepart(YEAR,OrderDate)
order by datepart(YEAR,OrderDate)

--19. From the following table write a query in SQL to find the contacts who are designated as a manager in various departments.
--Returns ContactTypeID, name. Sort the result set in descending order.

Select ContactTypeID,Name 
from Person.ContactType
where Name like '%Manager%'
order by Name desc

--20. From the following tables write a query in SQL to make a list of contacts who are designated as 'Purchasing Manager'. Return BusinessEntityID, LastName, and FirstName columns. Sort the result set in ascending order of LastName, and FirstName.

Select pp.BusinessEntityID,pp.FirstName,pp.LastName from 
Person.BusinessEntityContact bp inner join Person.ContactType pc 
on bp.ContactTypeID = pc.ContactTypeID
right join Person.Person pp on bp.BusinessEntityID = pp.BusinessEntityID
order by pp.FirstName,pp.LastName

--21) From the following tables write a query in SQL to retrieve the salesperson for each PostalCode who belongs to a territory and SalesYTD is not zero. Return row numbers of each group of PostalCode, last name, salesytd, postalcode column. Sort the salesytd of each postalcode group in descending order. Shorts the postalcode in ascending order.

Select LastName,SalesYTD,PostalCode, ROW_NUMBER() OVER (PARTITION BY PostalCode ORDER BY SalesYTD DESC) AS "Row Number"
from Sales.SalesPerson sp inner join person.Person pp 
 on sp.BusinessEntityID = pp.BusinessEntityID inner join  person.Address pa 
 on sp.BusinessEntityID = pa.AddressID
 and SalesYTD <> 0 and TerritoryID is not null
 order by PostalCode asc
 
 --22) From the following table write a query in SQL to count the number of contacts for combination of each type and name. Filter the output for those who have 100 or more contacts. Return ContactTypeID and ContactTypeName and BusinessEntityContact. Sort the result set in descending order on number of contacts.
 Select * from Person.BusinessEntityContact
 Select * from Person.ContactType
 
 Select bc.ContactTypeID,Name, COUNT(pc.ContactTypeID) as noofcontact from Person.BusinessEntityContact bc
 inner join Person.ContactType pc
 on bc.ContactTypeID = pc.ContactTypeID
 group by bc.ContactTypeID,Name
 having COUNT(pc.ContactTypeID) > 100
 
 
 --23. From the following table write a query in SQL to retrieve the RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees. In the output the RateChangeDate should appears in date format. Sort the output in ascending order on NameInFull.
 
 --select * from HumanResources.EmployeePayHistory
--select * from Person.Person
 
Select convert(varchar(10),RateChangeDate,103) RateChangeDate,FirstName +' '+ MiddleName +' '+LastName FullName, (Rate*40) as weeklySalary 
from HumanResources. EmployeePayHistory EPH
inner join Person.Person pp 
ON EPH.BusinessEntityID = pp.BusinessEntityID
order by FullName asc

--24. From the following tables write a query in SQL to calculate and display the latest weekly salary of each employee. Return RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees Sort the output in ascending order on NameInFull.

--select * from HumanResources.EmployeePayHistory where BusinessEntityID=4
--select * from Person.Person
 
Select PP.BusinessEntityID,convert(varchar(10),RateChangeDate,103) RateChangeDate,FirstName +' '+ MiddleName +' '+LastName FullName, (Rate*40) as weeklySalary 
from HumanResources. EmployeePayHistory EPH
inner join Person.Person pp 
ON EPH.BusinessEntityID = pp.BusinessEntityID
WHERE EPH.RateChangeDate IN (SELECT MAX(RateChangeDate) FROM HumanResources.EmployeePayHistory EP WHERE BusinessEntityID =  EPH.BusinessEntityID )
order by FullName asc

--25. From the following table write a query in SQL to find the sum, average, count, minimum, and maximum order quentity for those orders whose id are 43659 and 43664. Return SalesOrderID, ProductID, OrderQty, sum, average, count, max, and min order quantity.

Select * from Sales.SalesOrderDetail

Select SalesOrderID,ProductID,OrderQty, SUM(OrderQty) as TotalQut,
AVG(OrderQty) AverageQty,
COUNT(OrderQty) NoOfOrders,
MAX(OrderQty) MaximunQty,
MIN(OrderQty)MinimunQty
from Sales.SalesOrderDetail
where SalesOrderID in (43659,43664)
group by SalesOrderID,ProductID,OrderQty