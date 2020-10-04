--Service Db creation:

CREATE DATABASE Service
GO

USE Service
GO

CREATE TABLE Users(
	Id INT PRIMARY KEY IDENTITY,
	Username NVARCHAR(30) UNIQUE NOT NULL,
	[Password] NVARCHAR(50) NOT NULL,
	[Name] NVARCHAR(50),
	Birthdate DATETIME2,
	Age INT CHECK(Age BETWEEN 14 AND 110),
	Email NVARCHAR(50) NOT NULL
)

CREATE TABLE Departments(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL 
)

CREATE TABLE Employees(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(25),
	LastName NVARCHAR(25),
	Birthdate DATETIME2,
	Age INT CHECK(Age BETWEEN 18 AND 110),
	DepartmentId INT FOREIGN KEY REFERENCES Departments(Id)
)

CREATE TABLE Categories (
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,
	DepartmentId INT FOREIGN KEY REFERENCES Departments(Id) NOT NULL
)

CREATE TABLE Status(
	Id INT PRIMARY KEY IDENTITY,
	Label NVARCHAR(30) NOT NULL
)

CREATE TABLE Reports(
	Id INT PRIMARY KEY IDENTITY,
	CategoryId INT FOREIGN KEY REFERENCES Categories(Id) NOT NULL,
	StatusId INT FOREIGN KEY REFERENCES [dbo].[Status](Id) NOT NULL,
	OpenDate DATETIME2 NOT NULL,
	CloseDate DATETIME2,
	[Description] NVARCHAR(200) NOT NULL,
	UserId INT FOREIGN KEY REFERENCES Users(Id) NOT NULL,
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id)
)
GO

USE Service
GO

SELECT * FROM Categories
GO

SELECT * FROM Departments
GO

SELECT * FROM Employees
GO

SELECT * FROM Reports
GO

SELECT * FROM Status
GO

SELECT * FROM Users
GO

INSERT INTO Employees([FirstName], [LastName], [Birthdate], [DepartmentId]) 
VALUES
('Marlo', 'O''Malley', '1958-9-21', 1),
('Niki', 'Stanaghan', '1969-11-26', 4),
('Ayrton', 'Senna', '1960-03-21', 9),
('Ronnie', 'Peterson', '1944-02-14', 9),
('Giovanna', 'Amati', '1959-07-20', 5)

INSERT INTO Reports([CategoryId], [StatusId], [OpenDate], [CloseDate], [Description], [UserId], [EmployeeId])
VALUES
(1, 1, '2017-04-13', NULL, 'Stuck Road on Str.133', 6, 2),
(6, 3, '2015-09-05', '2015-12-06', 'Charity trail running', 3, 5),
(14, 2, '2015-09-07', NULL, 'Falling bricks on Str.58', 5, 2),
(4, 3, '2017-07-03', '2017-07-06', 'Cut off streetlight on Str.11', 1, 1)
GO

SELECT * FROM Employees
WHERE FirstName in ('Marlo', 'Niki')
GO

UPDATE Reports
SET CloseDate = GETDATE()
WHERE CloseDate is NULL
GO

DELETE FROM Reports
WHERE StatusId = 4
GO

SELECT 
	[Description], 
	FORMAT(CAST([OpenDate] AS DATE), 'dd-MM-yyyy') AS OpenDate
FROM Reports
WHERE EmployeeId IS NULL
ORDER BY DATEPART(YEAR, OpenDate), 
		DATEPART(MONTH, OpenDate),
		DATEPART(DAY, OpenDate),
		[Description]
GO

SELECT r.Description, c.Name AS CategoryName
FROM Reports AS r
JOIN Categories AS c
ON r.CategoryId = c.Id
WHERE r.CategoryId IS NOT NULL
ORDER BY Description, CategoryName
GO

SELECT 
c.[Name] AS CategoryName, 
COUNT(r.CategoryId) AS ReportsNumber
FROM Reports AS r
JOIN Categories AS c
ON r.CategoryId = c.Id
GROUP BY r.CategoryId, c.[Name]
GO



