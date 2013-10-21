//4. Write a SQL query to find all information about all departments (use "TelerikAcademy" database).
SELECT * FROM Departments

//5. Write a SQL query to find all department names
SELECT Name FROM Departments

//6. Write a SQL query to find the salary of each employee
SELECT FirstName,LastName,Salary FROM Employees

//7. Write a SQL to find the full name of each employee
SELECT FirstName + ' ' + LastName as [Full Name] FROM Employees

//8. Write a SQL query to find the email addresses of each employee (by his first and last name). 
//Consider that the mail domain is telerik.com. Emails should look like “"John.Doe@telerik.com". 
//The produced column should be named "Full Email Addresses"

//9. Write a SQL query to find all different employee salaries
SELECT DISTINCT Salary FROM Employees

//10. Write a SQL query to find all information about the employees whose job title is “Sales Representative
SELECT * FROM Employees Where JobTitle = 'Sales Representative'

//11. Write a SQL query to find the names of all employees whose first name starts with "SA".
SELECT FirstName,LastName FROM Employees WHERE FirstName LIKE 'SA%'

//12.Write a SQL query to find the names of all employees whose last name contains "ei".
SELECT FirstName,LastName FROM Employees WHERE LastName LIKE '%ei%'

//13. Write a SQL query to find the salary of all employees whose salary is in the range [20000…30000].
SELECT FirstName,LastName,Salary FROM Employees WHERE Salary > 20000 AND Salary < 30000

//14. Write a SQL query to find the names of all employees whose salary is 25000, 14000, 12500 or 23600.
SELECT FirstName,LastName,Salary FROM Employees WHERE Salary = 25000 OR Salary = 14000 OR Salary = 12500 OR Salary = 23600

//15. Write a SQL query to find all employees that do not have manager.
SELECT FirstName,LastName FROM Employees WHERE ManagerID IS NULL

//16. Write a SQL query to find all employees that have salary more than 50000. Order them in decreasing order by salary.
SELECT FirstName,LastName,Salary FROM Employees WHERE Salary > 50000 ORDER BY(Salary)DESC

//17. Write a SQL query to find the top 5 best paid employees.
SELECT TOP 5 FirstName,LastName,Salary FROM Employees ORDER BY(Salary)DESC

//18. Write a SQL query to find all employees along with their address. Use inner join with ON clause.
SELECT FirstName,LastName, AddressText 
FROM Employees AS e 
	INNER JOIN Addresses AS a 
		ON e.AddressID = a.AddressID

//19. Write a SQL query to find all employees and their address. Use equijoins (conditions in the WHERE clause).
SELECT e.FirstName, e.LastName, a.AddressText 
FROM Employees AS e, Addresses AS a 
	WHERE 
		e.AddressID = a.AddressID

//20. Write a SQL query to find all employees along with their manager.
SELECT e.FirstName, e.LastName, em.LastName 
FROM Employees e, Employees em
	WHERE 
		em.EmployeeID = e.ManagerID

//21. Write a SQL query to find all employees, along with their manager and their address. Join the 3 tables: Employees e, Employees m and Addresses a.
SELECT e.FirstName, e.LastName, em.LastName, a.AddressText 
FROM Employees e, Employees em, Addresses a
	WHERE 
		em.EmployeeID = e.ManagerID AND e.AddressID=a.AddressID ORDER BY (em.LastName)

//22. Write a SQL query to find all departments and all town names as a single list. Use UNION.
SELECT Name FROM Departments
UNION
SELECT Name FROM Towns
ORDER BY Name

//23. Write a SQL query to find all the employees and the manager for each of them along with the employees that do not have manager. Use right outer join. Rewrite the query to use left outer join.
SELECT e.FirstName, e.LastName, em.LastName AS [Manager Name]
FROM Employees em RIGHT OUTER JOIN Employees e
	ON em.EmployeeID = e.ManagerID

//24. Write a SQL query to find the names of all employees 
//from the departments "Sales" and "Finance" whose hire year is between 1995 and 2005.
SELECT e.FirstName, e.LastName, d.Name, e.HireDate
	FROM Employees AS e INNER JOIN Departments AS d 
		ON e.DepartmentID = d.DepartmentID
			WHERE d.Name = 'Sales' OR d.Name = 'Finance' AND (e.HireDate > 1995 OR e.HireDate < 2005)
				ORDER BY(e.HireDate)

 AND