SELECT LastName
FROM Person.Person

SELECT FirstName, LastName
FROM Person.Person

SELECT FirstName, MiddleName, LastName
FROM Person.Person

SELECT TOP 500 FirstName, MiddleName, LastName
FROM Person.Person

SELECT TOP 10 PERCENT FirstName, MiddleName, LastName
FROM Person.Person

SELECT TOP 100 *
FROM Production.Product

SELECT TOP 100 FirstName AS "Customer First Names", LastName
FROM Person.Person

SELECT *
FROM HumanResources.vEmployee

SELECT *
FROM HumanResources.Employee

SELECT FirstName, LastName, EmailAddress, PhoneNumber
FROM Sales.vIndividualCustomer

SELECT *
FROM Production.Product
WHERE ListPrice > 10

SELECT *
FROM HumanResources.vEmployee
WHERE FirstName = 'Chris'

SELECT *
FROM HumanResources.Employee
WHERE BirthDate >= '1-1-1980'


SELECT *
FROM HumanResources.Employee
WHERE BirthDate >= '1-1-1980' AND Gender = 'F'

SELECT *
FROM HumanResources.Employee
WHERE MaritalStatus = 'S' OR Gender = 'M'

SELECT *
FROM HumanResources.Employee
WHERE MaritalStatus = 'S' AND (Gender = 'M' OR OrganizationLevel = 4)

SELECT *
FROM Production.Product
WHERE (ListPrice > 100 AND Color = 'Red') OR StandardCost > 30

SELECT *
FROM HumanResources.vEmployeeDepartment
WHERE Department = 'Research and Development' OR (StartDate < '1/1/2005' 
	AND Department = 'Executive')

SELECT *
FROM Sales.vStoreWithDemographics
WHERE (AnnualSales > 1000000 AND BusinessType = 'OS') OR
	( YearOpened < 1990 AND SquareFeet > 40000 AND NumberEmployees > 10)

SELECT *
FROM HumanResources.vEmployee
WHERE FirstName IN ('Chris', 'Steve', 'Michael', 'Thomas')
	
SELECT *
FROM Sales.vStoreWithDemographics
WHERE AnnualSales BETWEEN 1000000 AND 2000000

SELECT *
FROM HumanResources.vEmployee
WHERE FirstName LIKE 'Mi%'

SELECT *
FROM HumanResources.vEmployee
WHERE FirstName LIKE 'Mi_'

SELECT *
FROM HumanResources.vEmployee
WHERE FirstName LIKE '%s'

SELECT *
FROM HumanResources.vEmployee
WHERE FirstName LIKE '%h%'

SELECT *
FROM HumanResources.vEmployee
WHERE FirstName LIKE 'D[a,o]n'

SELECT *
FROM Person.Person
WHERE MiddleName IS NULL

SELECT *
FROM Person.Person
WHERE MiddleName IS NOT NULL

SELECT *
FROM HumanResources.vEmployee
WHERE MiddleName IS NOT NULL AND PhoneNumberType = 'Cell'

SELECT FirstName, LastName
FROM Sales.vIndividualCustomer
ORDER BY FirstName

SELECT FirstName, LastName
FROM Sales.vIndividualCustomer
ORDER BY FirstName DESC

SELECT FirstName, LastName
FROM Sales.vIndividualCustomer
ORDER BY 2

/*>>>>>Sequencia de escrita 
SELECT
FROM
WHERE
GROUP BY
HAVING
ORDER BY

>>>>>Sequencia de leitura e evolucao do codigo
FROM
WHERE
GROUP BY
HAVING
SELECT
ORDER BY*/

SELECT LastName, FirstName, SalesQuota
FROM Sales.vSalesPerson
ORDER BY SalesQuota DESC, LastName ASC 

SELECT LastName, FirstName, SalesQuota AS SQ
FROM Sales.vSalesPerson
WHERE SalesQuota >= 250000
ORDER BY SQ DESC, LastName ASC 

SELECT P.Name, P.ProductNumber, PS.Name AS [ProductSubcategory Name]
FROM Production.Product P
INNER JOIN Production.ProductSubcategory PS
ON P.ProductSubcategoryID = PS.ProductSubcategoryID

SELECT *
FROM Production.ProductSubcategory

SELECT PS.Name AS ProductSubcategoryName,
	   PC.Name AS ProductCategoryName
FROM Production.ProductSubcategory PS
INNER JOIN Production.ProductCategory PC
ON PS.ProductCategoryID = PC.ProductCategoryID

SELECT P.FirstName, P.LastName, E.EmailAddress, PP.PhoneNumber
FROM Person.Person P
INNER JOIN Person.EmailAddress E
ON P.BusinessEntityID = E.BusinessEntityID
INNER JOIN Person.PersonPhone PP
ON PP.BusinessEntityID = P.BusinessEntityID

SELECT P.Name, P.ProductNumber, PS.Name AS ProductSubCategoryName
FROM Production.Product P
LEFT OUTER JOIN Production.ProductSubcategory PS
ON PS.ProductSubcategoryID = P.ProductSubcategoryID

SELECT P.Name, P.ProductNumber, PS.Name AS ProductSubCategoryName
FROM Production.ProductSubcategory PS 
RIGHT OUTER JOIN Production.Product P
ON P.ProductSubcategoryID = PS.ProductSubcategoryID

SELECT P.FirstName, P.LastName, SOH.SalesOrderNumber, SOH.TotalDue AS SalesAmount, T.Name AS TerritoryName
FROM Sales.SalesOrderHeader SOH
LEFT OUTER JOIN Sales.SalesPerson SP
ON SP.BusinessEntityID = SOH.SalesPersonID
LEFT OUTER JOIN HumanResources.Employee E
ON E.BusinessEntityID = SP.BusinessEntityID
LEFT OUTER JOIN Person.Person P
ON P.BusinessEntityID = E.BusinessEntityID
LEFT OUTER JOIN Sales.SalesTerritory T
ON T.TerritoryID = SOH.TerritoryID
WHERE T.Name = 'Northwest'
ORDER BY SOH.TotalDue DESC

SELECT MAX(TotalDue)
FROM Sales.SalesOrderHeader

SELECT MIN(TotalDue)
FROM Sales.SalesOrderHeader

SELECT TotalDue
FROM Sales.SalesOrderHeader
ORDER BY TotalDue DESC

SELECT COUNT(*)
FROM Sales.SalesOrderHeader

SELECT COUNT(SalesPersonID)
FROM Sales.SalesOrderHeader

SELECT COUNT(SalesPersonID)
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL

SELECT COUNT(FirstName)
FROM Person.Person

SELECT COUNT(DISTINCT FirstName)
FROM Person.Person

SELECT AVG(TotalDue)
FROM Sales.SalesOrderHeader

SELECT SUM(TotalDue)
FROM Sales.SalesOrderHeader

SELECT *
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '1/1/2006' AND '12/31/2006'

SELECT SUM(TotalDue)
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '1/1/2006' AND '12/31/2006'

SELECT SalesPersonID, SUM(TotalDue) AS Total_Sales
FROM Sales.SalesOrderHeader
GROUP BY SalesPersonID

SELECT ProductID, SUM(Quantity) AS [Total in Stock], COUNT(*) AS [Total Locations]
FROM Production.ProductInventory
GROUP BY ProductID

SELECT TerritoryID, SalesPersonID, SUM(TotalDue) AS [Total Sales]
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '1/1/2006' AND '12/31/2006'
GROUP BY TerritoryID, SalesPersonID
ORDER BY 1, 2

SELECT ST.Name AS[Territory Name], P.FirstName + ' ' + P.LastName AS SalesPersonName, SUM(TotalDue) AS [Total Sales]
FROM Sales.SalesOrderHeader SOH
INNER JOIN Sales.SalesPerson SP
ON SP.BusinessEntityID = SOH.SalesPersonID
INNER JOIN Person.Person P
ON P.BusinessEntityID = SP.BusinessEntityID
INNER JOIN Sales.SalesTerritory ST
ON ST.TerritoryID = SOH.TerritoryID
WHERE OrderDate BETWEEN '1/1/2006' AND '12/31/2006'
GROUP BY ST.Name, P.FirstName + ' ' + P.LastName
ORDER BY 1, 2

SELECT ST.Name AS [Territory Name], SUM(TotalDue) AS [Total Sales  - 2006]
FROM Sales.SalesOrderHeader SOH
INNER JOIN Sales.SalesTerritory ST
ON ST.TerritoryID = SOH.TerritoryID
WHERE OrderDate BETWEEN '1/1/2006' AND '12/31/2006'
GROUP BY ST.Name
HAVING SUM(TotalDue) > 4000000
ORDER BY 1

SELECT PS.Name AS [SubCategory Name], COUNT(*) AS [Product Count]
FROM Production.Product P
INNER JOIN Production.ProductSubcategory PS
ON PS.ProductSubcategoryID = P.ProductSubcategoryID
GROUP BY PS.Name
HAVING COUNT(*) >= 15
ORDER BY 1

SELECT SalesPersonID, SUM(TotalDue) AS [Total Sales Amount], COUNT(*) AS [Total Sales Count]
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '1/1/2006' AND '12/31/2006' AND SalesPersonID IS NOT NULL
GROUP BY SalesPersonID
HAVING SUM(TotalDue) > 2000000 AND COUNT(*) >= 75
ORDER BY [Total Sales Amount] DESC