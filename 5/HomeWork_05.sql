//1. Write a SQL query to find the names and salaries of 
//the employees that take the minimal salary in the company. Use a nested SELECT statement.

SELECT e.FirstName, e.LastName, e.Salary AS [Min Salary]
FROM Employees e 
	JOIN Employees em ON
	e.EmployeeID = em.EmployeeID
WHERE em.Salary = 
	(SELECT MIN(Salary) FROM Employees)

//2. Write a SQL query to find the names and salaries of the employees
//that have a salary that is up to 10% higher than the minimal salary for the company

SELECT e.FirstName, e.LastName, e.Salary
FROM Employees e 
	JOIN Employees em ON
	e.EmployeeID = em.EmployeeID
WHERE em.Salary > 
	(SELECT MIN(Salary) FROM Employees) AND 
	em.Salary <
	 (SELECT (MIN(Salary) + 0.1 * MIN(Salary)) FROM Employees) 

//3. Write a SQL query to find the full name, salary and department of the 
//   employees that take the minimal salary in their department. Use a nested SELECT statement

SELECT e.FirstName + ' ' + e.LastName, e.Salary AS [Min Dept Salary], d.Name
FROM Employees e 
	JOIN Employees em ON
	e.EmployeeID = em.EmployeeID
	JOIN Departments d ON
	e.DepartmentID = d.DepartmentID
WHERE em.Salary = 
	(SELECT MIN(Salary) FROM Employees
	WHERE DepartmentID = em.DepartmentID)
ORDER BY d.Name

//4. Write a SQL query to find the average salary in the department #1.

	SELECT AVG(Salary) AS [Average Salary] FROM Employees
	WHERE DepartmentID = '1'

//5. Write a SQL query to find the average salary  in the "Sales" department.

	SELECT AVG(e.Salary) AS [Average Salary], e.DepartmentID, d.Name 
	FROM Employees e
		JOIN Departments d ON
			e.DepartmentID = d.DepartmentID
	WHERE e.DepartmentID = 
		(SELECT DepartmentID FROM Departments
			WHERE Name = 'Sales')
	GROUP BY e.DepartmentID, d.Name

//6. Write a SQL query to find the number of employees in the "Sales" department.

	SELECT COUNT(*) AS [EMP NUM], e.DepartmentID, d.Name 
	FROM Employees e
		JOIN Departments d ON
			e.DepartmentID = d.DepartmentID
	WHERE e.DepartmentID = 
		(SELECT DepartmentID FROM Departments
			WHERE Name = 'Sales')
	GROUP BY e.DepartmentID, d.Name

//7. Write a SQL query to find the number of all employees that have manager.
SELECT COUNT(*) AS [EMP NUM]
	FROM Employees e
	WHERE e.ManagerID IS NOT NULL

//8. Write a SQL query to find the number of all employees that have no manager.
SELECT COUNT(*) AS [EMP NUM]
	FROM Employees e
	WHERE e.ManagerID IS NULL

//9. Write a SQL query to find all departments and the average salary for each of them.

SELECT AVG(e.Salary) AS [Average Salary], SUM(e.Salary)/COUNT(*) AS [AVG SAL], e.DepartmentID, d.Name 
	FROM Employees e
		JOIN Departments d ON
			e.DepartmentID = d.DepartmentID
	WHERE e.DepartmentID = d.DepartmentID
	GROUP BY e.DepartmentID, d.Name

//10. Write a SQL query to find the count of all employees in each department and for each town.

	SELECT COUNT(*) AS [EMP NUM], e.DepartmentID, d.Name AS [DEP Name], t.Name AS [TOWN Name] 
	FROM Employees e
		JOIN Departments d ON
			e.DepartmentID = d.DepartmentID
			JOIN Addresses a ON
			e.AddressID = a.AddressID
			JOIN Towns t ON
			a.TownID = t.TownID
	WHERE e.DepartmentID = d.DepartmentID AND a.TownID = t.TownID
	GROUP BY  t.Name, d.Name, e.DepartmentID

//11. Write a SQL query to find all managers that have exactly 5 employees. Display their first name and last name.

SELECT e.FirstName, e.LastName,e.EmployeeID, e.ManagerID
	FROM Employees e
		JOIN Departments d ON
			e.EmployeeID = d.ManagerID
	WHERE (SELECT COUNT(*) FROM Employees
			WHERE ManagerID = d.ManagerID) > 5

//12. Write a SQL query to find all employees along with their managers. 
//For employees that do not have manager display the value "(no manager)".

SELECT	e.FirstName, e.LastName, e.EmployeeID, 
		COALESCE(CONVERT(nvarchar(50), e.ManagerID), '(no manager)') AS [Manager],
		em.FirstName, em.LastName
	FROM Employees e
	JOIN Employees em ON em.EmployeeID = e.EmployeeID
	
//13. Write a SQL query to find the names of all employees whose last name is 
//exactly 5 characters long. Use the built-in LEN(str) function.

SELECT e.FirstName, e.LastName
	FROM Employees e
	WHERE LEN(e.LastName) = 5

//14. Write a SQL query to display the current date and time in the following format 
//"day.month.year hour:minutes:seconds:milliseconds". Search in  Google to find how to format dates in SQL Server.

	SELECT CONVERT(VARCHAR(24), GETDATE(), 113)
	SELECT FORMAT(getdate(), 'dd.mm.yyyy hh:mm:ss:ff')

//15. Write a SQL statement to create a table Users. Users should have username, password, full name and last login time. 
//Choose appropriate data types for the table fields. 
//Define a primary key column with a primary key constraint. 
//Define the primary key column as identity to facilitate inserting records. 
//Define unique constraint to avoid repeating usernames. 
//Define a check constraint to ensure the password is at least 5 characters long.

CREATE TABLE Users (
  UserID int PRIMARY KEY IDENTITY NOT NULL,
  UserName nvarchar(25) NOT NULL UNIQUE,
  UserPassword nvarchar(25) NOT NULL CHECK(LEN(UserPassword) > 5),
  UserFullName nvarchar(50) NOT NULL,
  LastLoginTime DateTime
)

//16. Write a SQL statement to create a view that displays the users from the 
//Users table that have been in the system today. Test if the view works correctly.

CREATE VIEW [User List Today Logins] AS
SELECT UserID, UserFullName
FROM Users
WHERE convert(varchar(10), LastLoginTime, 102) 
    = convert(varchar(10), getdate(), 102)

//17. Write a SQL statement to create a table Groups. Groups should have unique name 
//(use unique constraint). Define primary key and identity column.

CREATE TABLE Groups (
  GroupID int IDENTITY NOT NULL,
  GroupName nvarchar(25) NOT NULL UNIQUE,
  CONSTRAINT PK_Groups PRIMARY KEY(GroupID)
)

//18. Write a SQL statement to add a column GroupID to the table Users. 
//Fill some data in this new column and as well in the Groups table. 
//Write a SQL statement to add a foreign key constraint between tables Users and Groups tables.

ALTER TABLE Users 
ADD GroupID int

ALTER TABLE Users 
ADD CONSTRAINT FK_Users_Groups
  FOREIGN KEY (GroupID)
  REFERENCES Groups(GroupID)

//19. Write SQL statements to insert several records in the Users and Groups tables.

INSERT INTO Users (UserName,UserPassword,UserFullName,LastLoginTime)
VALUES ('stefano','123456','Stefan',GETDATE());

INSERT INTO Groups (GroupName)
VALUES	('Knitting'), 
		('Puzzle Making');

//20. Write SQL statements to update some of the records in the Users and Groups tables.

UPDATE Users
SET UserFullName='Stefano'
WHERE UserName='stefano';

UPDATE Groups
SET GroupName='Advanced Knitting'
WHERE GroupName='Knitting';

//21. Write SQL statements to delete some of the records from the Users and Groups tables.

DELETE FROM Users
WHERE UserID = '3';

DELETE FROM Groups
WHERE GroupID = '1';

//22. Write SQL statements to insert in the Users table the names of all employees from the Employees table. 
//Combine the first and last names as a full name. For username use the first letter of the first name + the last name (in lowercase). 
//Use the same for the password, and NULL for last login time.

SET IDENTITY_INSERT Users OFF

INSERT INTO Users (UserName, UserPassword, UserFullName, LastLoginTime,GroupID)
SELECT	LOWER(Left(FirstName,3)+''+LastName),
		LOWER(Left(FirstName,1)+''+LastName+'pass'),
		FirstName+''+LastName,
		GETDATE(),
		3
FROM Employees

--DROP TABLE Users
--DROP TABLE Groups

SELECT LOWER(CAST(SUBSTRING(FirstName,1,1)AS nvarchar(1)))+''+LOWER(CAST(REPLACE(LastName, ' ', '')AS nvarchar(24))),
LastName FROM Employees

//23. Write a SQL statement that changes the password to NULL for all users
// that have not been in the system since 10.03.2010.

UPDATE Users
	SET UserPassword = 'prazna'
WHERE LastLoginTime > '10.03.2010';

//24. Write a SQL statement that deletes all users without passwords (NULL password). -- prazna -> in place of NULL password

DELETE FROM Users
WHERE UserPassword = 'prazna'

//25. Write a SQL query to display the average employee salary by department and job title.

SELECT AVG(e.Salary), e.JobTitle, d.Name 
FROM Employees e 
	JOIN Departments d ON
		e.DepartmentID = d.DepartmentID
GROUP BY d.Name, e.JobTitle

//26. Write a SQL query to display the minimal employee salary by department 
//and job title along with the name of some of the employees that take it.

SELECT MIN(e.Salary) [Min Salary], e.FirstName, e.LastName, e.JobTitle, d.Name [Department Name]
FROM Employees e 
	JOIN Departments d ON
		e.DepartmentID = d.DepartmentID
GROUP BY d.Name,e.FirstName, e.LastName, e.JobTitle

//27. Write a SQL query to display the town where maximal number of employees work.

SELECT TOP 1 COUNT(e.EmployeeID) [# Employees], t.Name
FROM Employees e 
	JOIN Addresses d ON
		e.AddressID = d.AddressID
	JOIN Towns t ON
		d.TownID = t.TownID
GROUP BY t.Name
ORDER BY COUNT(e.EmployeeID) DESC

//28.Write a SQL query to display the number of managers from each town.

SELECT COUNT(e.ManagerID) [# Managers], t.Name
FROM Employees e 
	JOIN Addresses a ON
		e.AddressID = a.AddressID
	JOIN Towns t ON
		a.TownID = t.TownID
	JOIN Departments d ON
		e.ManagerID = d.ManagerID
GROUP BY t.Name

//29. Write a SQL to create table WorkHours to store work reports for each employee 
//(employee id, date, task, hours, comments). Dont forget to define  identity, primary key and appropriate foreign key. 

CREATE TABLE Tasks
(
	TaskID INT IDENTITY(1,1) PRIMARY KEY,
	Name nvarchar(50) NOT NULL
)

CREATE TABLE WorkHours (
	WorkHoursID INT IDENTITY NOT NULL,
	EmployeeID int NOT NULL,
	TaskID int NOT NULL,
	ADate DateTime,
	HoursWorked int NULL,
	Comments nvarchar(250),
	CONSTRAINT PK_WorkHours				PRIMARY KEY(WorkHoursID),
	CONSTRAINT FK_WorkHours_Employees	FOREIGN KEY(EmployeeID) REFERENCES Employees(EmployeeID),
	CONSTRAINT FK_WorkHours_Tasks		FOREIGN KEY(TaskID)		REFERENCES Tasks(TaskID)	   
)

DROP TABLE WorkHours
//Issue few SQL statements to insert, update and delete of some data in the table.
//Define a table WorkHoursLogs to track all changes in the WorkHours table with triggers. 
//For each change keep the old record data, the new record data and the command (insert / update / delete).

INSERT INTO WorkHours (EmployeeID, TaskID, ADate, HoursWorked,Comments)
VALUES
(2, 1, GETDATE(), 8, 'work went well'),
(3, 1, GETDATE(), 5, 'work went well')

CREATE TABLE WorkHoursLog
(
	LogID INT IDENTITY PRIMARY KEY,
	ExecutedCommand nvarchar(20) NULL,
	WorkHoursID INT NULL,
	OldEmployeeID INT FOREIGN KEY(OldEmployeeID) REFERENCES Employees(EmployeeID) NULL,
	[OldDate] datetime NULL,
	OldTaskID INT FOREIGN KEY(OldTaskID) REFERENCES Tasks(TaskID) NULL,
	[OldHours] INT NULL,
	OldComments nvarchar(250) NULL,
	NewEmployeeID INT FOREIGN KEY(NewEmployeeID) REFERENCES Employees(EmployeeID) NULL,
	[NewDate] datetime NULL,
	NewTaskID INT FOREIGN KEY(NewTaskID) REFERENCES Tasks(TaskID) NULL,
	[NewHours] INT NULL,
	NewComments nvarchar(250) NULL
)

-- http://www.codeproject.com/Articles/25600/Triggers-Sql-Server 
-- and http://www.sqlteam.com/article/an-introduction-to-triggers-part-i-> good articles on triggers

ALTER TRIGGER TR_WorkHoursDelete --first do a CREATE TRIGGER, same for the other two TR_'s
ON WorkHours
FOR DELETE
AS
	INSERT INTO WorkHoursLog
	SELECT 'DELETE', WorkHoursID, NULL, NULL, NULL, NULL, NULL,
			EmployeeID, GETDATE(), TaskID, HoursWorked, Comments
	FROM deleted

	PRINT 'AFTER DELETE TRIGGER fired.'
GO
 
ALTER TRIGGER TR_WorkHoursInsert
ON WorkHours
FOR INSERT
AS
	INSERT INTO WorkHoursLog
	SELECT 'INSERT', WorkHoursID,NULL, NULL, NULL, NULL, NULL,
			EmployeeID, GETDATE(), TaskID, HoursWorked, Comments
	FROM inserted 

	PRINT 'AFTER INSERT trigger fired.'
GO
 
ALTER TRIGGER TR_WorkHoursUpdate
ON WorkHours
FOR UPDATE
AS
    INSERT INTO WorkHoursLog
    SELECT 'UPDATE', d.WorkHoursID, d.EmployeeID, d.ADate, d.TaskID, d.HoursWorked, d.Comments,
    i.EmployeeID, GETDATE(), i.TaskID, i.HoursWorked, i.Comments  
    FROM inserted i, deleted d

	PRINT 'AFTER UPDATE Trigger fired.'
GO

-- TESTING OF TRIGGERS --
DELETE FROM WorkHours WHERE WorkHoursID = 5
 
INSERT INTO WorkHours (EmployeeID, TaskID, ADate, HoursWorked,Comments)
	VALUES
--(7, 1, GETDATE(), 8, 'work went well'),
--(5, 1, GETDATE(), 8, 'work went well'),
(10, 1, GETDATE(), 12, 'work went well')

UPDATE WorkHours
SET HoursWorked = 123
FROM WorkHours
WHERE WorkHoursID = 4; --and on 1 before the 4

-- END TESTING OF TRIGGERS--

//30. Start a database transaction, delete all employees from the 'Sales' 
//department along with all dependent records from the other tables. At the end rollback the transaction.

BEGIN TRAN
ALTER TABLE Departments NOCHECK CONSTRAINT FK_Departments_Employees
DELETE FROM Employees
WHERE DepartmentID =
	(SELECT DepartmentID FROM Departments WHERE Name = 'Sales')
ROLLBACK TRAN

//31. Start a database transaction and drop the table EmployeesProjects. 
//Now how you could restore back the lost table data?

BEGIN TRAN
DROP TABLE EmployeesProjects
ROLLBACK TRAN

//32. Find how to use temporary tables in SQL Server. Using temporary tables
// backup all records from EmployeesProjects and restore them back after dropping and re-creating the table.

CREATE TABLE #LocalTempTable(
EmployeeID int,
ProjectID int
)

SELECT * INTO LocalTempTable FROM dbo.EmployeesProjects

SELECT * FROM LocalTempTable

DROP TABLE EmployeesProjects

CREATE TABLE EmployeesProjects(
  EmployeeID int NOT NULL,
  ProjectID int NOT NULL,
  CONSTRAINT PK_EmployeesProjects PRIMARY KEY CLUSTERED (EmployeeID ASC, ProjectID ASC)
)

INSERT INTO EmployeesProjects
SELECT * FROM LocalTempTable;