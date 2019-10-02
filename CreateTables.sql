CREATE DATABASE Minions

GO

USE Minions

GO

CREATE TABLE Minions (
	Id INT NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
	Age INT NOT NULL
)

CREATE TABLE Towns (
	Id INT NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
)

GO

ALTER TABLE Minions
ADD CONSTRAINT PK_Id
PRIMARY KEY(Id)

GO

ALTER TABLE Towns
ADD CONSTRAINT PK_TownId
PRIMARY KEY(Id)

ALTER TABLE Minions
ADD TownId INT

ALTER TABLE Minions
ADD CONSTRAINT FK_MinionsTownId
FOREIGN KEY(TownId) REFERENCES Towns(Id)

GO

INSERT INTO Towns(Id, [Name]) VALUES 
(1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna')

ALTER TABLE Minions
DROP COLUMN Age

ALTER TABLE Minions
ADD Age INT

INSERT INTO Minions(Id, [Name], Age, TownId) VALUES
(1, 'Kevin', 22, 1),
(2, 'Bob', 15, 3),
(3, 'Steward', NULL, 2) 

SELECT [Id], [Name], [Age], [TownId] FROM Minions

GO

USE Minions
TRUNCATE TABLE Minions

SELECT * FROM Minions

DROP TABLE Minions
DROP TABLE Towns

USE Minions
DROP TABLE People

CREATE TABLE People (
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(200) NOT NULL,
	Picture VARBINARY(MAX) CHECK(DATALENGTH(Picture) <= 2097152),
	Height DECIMAL(3,2),
	[Weight] DECIMAL(5,2),
	Gender CHAR(1) NOT NULL CHECK(Gender = 'f' OR Gender = 'm'),
	Birthdate DATE NOT NULL,
	Biography NVARCHAR(MAX)
)


INSERT INTO People 
([Name], Picture, Height, [Weight], Gender, Birthdate, Biography) VALUES
('Pipi', NULL, 1.65, 66.4, 'f', '2018/12/16', 'Alabala1'),
('Mipi', NULL, 1.64, 56.4, 'f', '2018/11/16', 'Alabala13'),
('Lipi', NULL, 1.62, 58.4, 'f', '2018/10/16', 'Alabala14'),
('Ripi', NULL, 1.61, 59.4, 'f', '2018/09/16', 'Alabala15'),
('Hipi', NULL, 1.67, 59.4, 'f', '2018/08/16', 'Alabala18')

SELECT * FROM People