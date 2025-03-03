--************************************************LIKE OPERATOR*******************************************************

--18] From the following table write a query in SQL to find the contacts who are designated as a manager in various departments. Returns ContactTypeID, name. Sort the result set in descending order.
--Sample table: Person.ContactType

SELECT ContactTypeID,Name FROM Person.ContactType
WHERE Name LIKE '%MANAGER%'
ORDER BY Name DESC

--19]20. From the following tables write a query in SQL to make a list of contacts who are designated as 'Purchasing Manager'. Return BusinessEntityID, LastName, and FirstName columns. Sort the result set in ascending order of LastName, and FirstName.
SELECT * FROM Person.BusinessEntityContact
SELECT * FROM Person.ContactType
SELECT * FROM Person.Person

SELECT P.BusinessEntityID,FirstName,LastName FROM Person.BusinessEntityContact PC
INNER JOIN Person.ContactType PT ON PC.ContactTypeID = PT.ContactTypeID
INNER JOIN Person.Person P ON P.BusinessEntityID = PC.PersonID
WHERE PT.Name = 'Purchasing Manager'
ORDER BY LastName,FirstName

SELECT pp.BusinessEntityID, LastName, FirstName
    -- Retrieving BusinessEntityID, LastName, and FirstName columns
    FROM Person.BusinessEntityContact AS PC 
        -- Joining Person.BusinessEntityContact with Person.ContactType based on ContactTypeID
        INNER JOIN Person.ContactType AS PT
            ON pc.ContactTypeID = PT.ContactTypeID
        -- Joining Person.BusinessEntityContact with Person.Person based on BusinessEntityID
        INNER JOIN Person.Person AS pp
            ON pp.BusinessEntityID = PC.PersonID
    -- Filtering the results to include only records where the ContactType Name is 'Purchasing Manager'
    WHERE pT.Name = 'Purchasing Manager'
    -- Sorting the results by LastName and FirstName
    ORDER BY LastName, FirstName;

--20)From the following tables write a query in SQL to retrieve the salesperson for each PostalCode who belongs to a territory and SalesYTD is not zero. Return row numbers of each group of PostalCode, last name, salesytd, postalcode column. Sort the salesytd of each postalcode group in descending order. Shorts the postalcode in ascending order.

select * from Sales.SalesPerson
select * from Person.Person
select * from Person.Address

select ROW_NUMBER() OVER (PARTITION BY pa.PostalCode ORDER BY sp.SalesYTD DESC) AS 'Row Number',
pa.postalCode, lastName, salesytd
from Sales.SalesPerson sp join Person.Person p
on sp.BusinessEntityID = p.BusinessEntityID
join Person.Address pa on pa.AddressID = p.BusinessEntityID
where sp.TerritoryID is not null and sp.SalesYTD !=0
order by pa.PostalCode 

--21) From the following table write a query in SQL to count the number of contacts for combination of each type and name. Filter the output for those who have 100 or more contacts. Return ContactTypeID and ContactTypeName and BusinessEntityContact. Sort the result set in descending order on number of contacts
SELECT * from Person.BusinessEntityContact
SELECT * from Person.ContactType

Select COUNT(be.PersonID) noofcontact, pc.ContactTypeID,Name from Person.ContactType pc
join Person.BusinessEntityContact be
on pc.ContactTypeID = be.ContactTypeID
group by pc.ContactTypeID,Name
order by noofcontact desc

-- 22) From the following table write a query in SQL to retrieve the RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees. In the output the RateChangeDate should appears in date format. Sort the output in ascending order on NameInFull.

--Select * from HumanResources.EmployeePayHistory
--select * from Person.Person

Select CAST(EH.RateChangeDate as VARCHAR(10)) AS  RateChangeDate,FirstName +' '+MiddleName +' '+LastName AS FULL_NAME,(Rate*40) weekly_salary  
from HumanResources.EmployeePayHistory EH
JOIN Person.Person P ON EH.BusinessEntityID = P.BusinessEntityID
ORDER BY FULL_NAME ASC

--23) From the following table write a query in SQL to find the sum, average, count, minimum, and maximum order quentity for those orders whose id are 43659 and 43664. Return SalesOrderID, ProductID, OrderQty, sum, average, count, max, and min order quantity.

SELECT SalesOrderID,ProductID,OrderQty, SUM(OrderQty) OVER (PARTITION BY SalesOrderID) SU_M,AVG(OrderQty) OVER (PARTITION BY SalesOrderID) AV_G,COUNT(OrderQty) OVER (PARTITION BY SalesOrderID) CNT,MIN(OrderQty) OVER (PARTITION BY SalesOrderID) MN,MAX(OrderQty) OVER (PARTITION BY SalesOrderID)  MX FROM Sales.SalesOrderDetail 
WHERE SalesOrderID IN (43659,43664)


--24) From the following table write a query in SQL to find the sum, average, and number of order quantity for those orders whose ids are 43659 and 43664 and product id starting with '71'. Return SalesOrderID, OrderNumber,ProductID, OrderQty, sum, average, and number of order quantity.

SELECT SalesOrderID, ProductID, OrderQty,
SUM(OrderQty) OVER (PARTITION BY SalesOrderID,ProductID) SU_M,
AVG(OrderQty) OVER (PARTITION BY SalesOrderID,ProductID) AV_G,
COUNT(OrderQty) OVER (PARTITION BY SalesOrderID,ProductID) QNT
FROM Sales.SalesOrderDetail 
WHERE SalesOrderID IN (43659,43664) AND ProductID LIKE('71%')
