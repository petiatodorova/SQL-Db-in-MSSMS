USE SoftUni

--Write a query that selects:
--EmployeeId
--JobTitle
--AddressId
--AddressText
--Return the first 5 rows sorted by AddressId in ascending order.

SELECT TOP(5)
	e.EmployeeID, 
	e.JobTitle, 
	e.AddressID, 
	a.AddressText
FROM Employees e
JOIN Addresses a
ON e.AddressID = a.AddressID
ORDER BY e.AddressID

--FirstName
--LastName
--Town
--AddressText
--Sorted by FirstName in ascending order then by LastName. Select first 50 employees.

SELECT TOP(50)
	e.FirstName, 
	e.LastName, 
	t.[Name], 
	a.AddressText
FROM Employees e
JOIN Addresses a
ON e.AddressID = a.AddressID
JOIN Towns t
ON a.TownID = t.TownID
ORDER BY e.FirstName, e.LastName

--EmployeeID
--FirstName
--LastName
--DepartmentName
--Sorted by EmployeeID in ascending order. Select only employees from “Sales” department.

SELECT 
	e.EmployeeID,
	e.FirstName,
	e.LastName,
	d.[Name]
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE d.[Name] IN ('Sales')
ORDER BY e.EmployeeID

--EmployeeID
--FirstName
--Salary
--DepartmentName
--Filter only employees with salary higher than 15000. Return the first 5 rows sorted by DepartmentID in ascending order.

SELECT TOP(5)
	e.EmployeeID,
	e.FirstName,
	e.Salary,
	d.[Name]
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 15000
ORDER BY e.DepartmentID

--EmployeeID
--FirstName
--Filter only employees without a project. Return the first 3 rows sorted by EmployeeID in ascending order.



SELECT TOP(3) e.EmployeeID, e.FirstName
FROM Employees e
LEFT JOIN EmployeesProjects ep
ON e.EmployeeID = ep.EmployeeID
WHERE ep.ProjectID IS NULL
ORDER BY e.EmployeeID

--FirstName
--LastName
--HireDate
--DeptName
--Filter only employees hired after 1.1.1999 
--and are from either "Sales" or "Finance" departments, sorted by HireDate (ascending).

SELECT 
	e.FirstName,
	e.LastName,
	e.HireDate,
	d.[Name] AS DeptName
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE e.HireDate > '01-01-1999'
AND d.[Name] IN ('Sales', 'Finance')
ORDER BY e.HireDate

--EmployeeID
--FirstName
--ProjectName
--Filter only employees with a project which has started after 13.08.2002 and it is still ongoing (no end date). 
--Return the first 5 rows sorted by EmployeeID in ascending order.

SELECT TOP(5)
	e.EmployeeID, 
	e.FirstName, 
	p.[Name] AS ProjectName
FROM Employees e
JOIN EmployeesProjects ep
ON e.EmployeeID = ep.EmployeeID
JOIN Projects p
ON ep.ProjectID = p.ProjectID
WHERE p.StartDate > '2002-08-13'
AND p.EndDate IS NULL
ORDER BY e.EmployeeID

--EmployeeID
--FirstName
--ProjectName
--Filter all the projects of employee with Id 24. 
--If the project has started during or after 2005 the returned value should be NULL.

SELECT 
	e.EmployeeID, 
	e.FirstName, 
	CASE
		WHEN YEAR(P.StartDate) >= 2005 THEN NULL
		ELSE p.[Name]
	END AS ProjectName
FROM Employees e
JOIN EmployeesProjects ep
ON e.EmployeeID = ep.EmployeeID
JOIN Projects p
ON ep.ProjectID = p.ProjectID
WHERE e.EmployeeID IN (24)


--EmployeeID
--FirstName
--ManagerID
--ManagerName
--Filter all employees with a manager who has ID equals to 3 or 7. 
--Return all the rows, sorted by EmployeeID in ascending order.

SELECT 
	e.EmployeeID,
	e.FirstName,
	e.ManagerID,
	m.FirstName
FROM Employees e
JOIN Employees m
ON e.ManagerID = m.EmployeeID
WHERE e.ManagerID IN (3, 7)
ORDER BY e.EmployeeID

--Write a query that selects:
--EmployeeID
--EmployeeName
--ManagerName
--DepartmentName
--Show first 50 employees with their managers and 
--the departments they are in (show the departments of the employees). Order by EmployeeID.

SELECT TOP(50)
	e.EmployeeID,
	CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
	CONCAT(m.FirstName, ' ', m.LastName) AS ManagerName,
	d.[Name] AS DepartmentName
FROM Employees e
JOIN Employees m ON e.ManagerID = m.EmployeeID
JOIN Departments d ON e.DepartmentID = d.DepartmentID
ORDER BY e.EmployeeID

--Write a query that returns the value of the lowest average salary of all departments.

SELECT TOP(1) AVG(e.Salary) AS MinAverageSalary
FROM Employees e
GROUP BY e.DepartmentID
ORDER BY MinAverageSalary

--CountryCode
--MountainRange
--PeakName
--Elevation
--Filter all peaks in Bulgaria with elevation over 2835. 
--Return all the rows sorted by elevation in descending order.

USE Geography

SELECT 
	mc.CountryCode,
	m.MountainRange,
	p.PeakName,
	p.Elevation 
FROM MountainsCountries mc
JOIN Mountains m ON mc.MountainId = m.Id
JOIN Peaks p ON m.Id = p.MountainId
WHERE mc.CountryCode IN ('BG')
AND p.Elevation > 2835
ORDER BY p.Elevation DESC

--Write a query that selects:
--CountryCode
--MountainRanges
--Filter the count of the mountain ranges in the United States, Russia and Bulgaria.

SELECT 
	mc.CountryCode, 
	COUNT(m.MountainRange)
FROM MountainsCountries mc
JOIN Mountains m ON mc.MountainId = m.Id
GROUP BY mc.CountryCode
HAVING mc.CountryCode in ('BG', 'US', 'RU')

--Write a query that selects:
--CountryName
--RiverName
--Find the first 5 countries with or without rivers in Africa. Sort them by CountryName in ascending order.

SELECT TOP(5)
	c.CountryName,
	r.RiverName
FROM Countries c
LEFT JOIN CountriesRivers cr ON c.CountryCode = cr.CountryCode
LEFT JOIN Rivers r ON cr.RiverId = r.Id
LEFT JOIN Continents cont ON c.ContinentCode = cont.ContinentCode
WHERE cont.ContinentName IN ('Africa')
ORDER BY c.CountryName

--Find all the count of all countries, which don’t have a mountain.

SELECT 
	COUNT(c.CountryCode) AS Count
FROM Countries c
LEFT JOIN MountainsCountries mc ON c.CountryCode = mc.CountryCode
WHERE mc.MountainId IS NULL


--For each country, find the elevation of the highest peak and the length of the longest river, 
--sorted by the highest peak elevation (from highest to lowest), 
--then by the longest river length (from longest to smallest), then by country name (alphabetically). 
--Display NULL when no data is available in some of the columns. Limit only the first 5 rows.

SELECT TOP(5)
	c.CountryName,
	MAX(p.Elevation) AS HighestPeakElevation, 
	MAX(r.Length) AS LongestRiverLength
FROM Countries c
JOIN MountainsCountries mc ON c.CountryCode = mc.CountryCode
JOIN Mountains m ON m.Id = mc.MountainId
JOIN Peaks p ON m.Id = p.MountainId
JOIN CountriesRivers cr ON cr.CountryCode = c.CountryCode
JOIN Rivers r ON r.Id = cr.RiverId
GROUP BY c.CountryName
ORDER BY HighestPeakElevation DESC, LongestRiverLength DESC

--ContinentCode
--CurrencyCode
--CurrencyUsage
--Find all continents and their most used currency. Filter 
--any currency that is used in only one country. Sort your results by ContinentCode.

SELECT
	c.ContinentCode,
	c.CurrencyCode,
	COUNT(c.CurrencyCode) AS CurrencyUsage,
	DENSE_RANK() OVER (PARTITION BY c.ContinentCode ORDER BY COUNT(c.CurrencyCode) DESC) AS CurrencyRank
FROM Countries c
JOIN Currencies cr ON c.CurrencyCode = cr.CurrencyCode
GROUP BY c.CurrencyCode, c.ContinentCode
HAVING COUNT(c.CurrencyCode) > 1
ORDER BY c.ContinentCode


SELECT k.ContinentCode, k.CurrencyCode, k.CurrencyUsage FROM
(SELECT
	c.ContinentCode,
	c.CurrencyCode,
	COUNT(c.CurrencyCode) AS CurrencyUsage,
	DENSE_RANK() OVER (PARTITION BY c.ContinentCode ORDER BY COUNT(c.CurrencyCode) DESC) AS CurrencyRank
FROM Countries c
JOIN Currencies cr ON c.CurrencyCode = cr.CurrencyCode
GROUP BY c.CurrencyCode, c.ContinentCode
HAVING COUNT(c.CurrencyCode) > 1
) AS k
WHERE k.CurrencyRank = 1
ORDER BY k.ContinentCode, k.CurrencyCode