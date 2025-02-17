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