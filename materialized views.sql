use databaseproject;

Create view Top_Earners
WITH SCHEMABINDING as
Select Employee.EmployeeID, Employee.EMPName, Department.DepartmentName,Salary.NetSalary
From dbo.Employee
join dbo.Department ON Employee.DepartmentID = Department.DepartmentID
join dbo.Salary ON Employee.SalaryID = Salary.SalaryID;

CREATE UNIQUE CLUSTERED INDEX topEarners ON Top_Earners (EmployeeID);
select *from Top_Earners;

Create view YearlyDepartmentAllowances_Deductions
WITH SCHEMABINDING as
Select Department.DepartmentName,
    YEAR(SalaryHistory.Date) AS Year,
    SUM(Allowances.TotalAllowance) AS TotalAllowances,
    SUM(Deductions.TotalDeductions) AS TotalDeductions
FROM dbo.SalaryHistory 
join dbo.Employee  ON SalaryHistory.EmployeeID = Employee.EmployeeID
join dbo.Department ON Employee.DepartmentID = Department.DepartmentID
join dbo.Allowances  ON SalaryHistory.SalaryID = Allowances.SalaryID
join  dbo.Deductions  ON SalaryHistory.SalaryID = Deductions.SalaryID
group by Department.DepartmentName, YEAR(SalaryHistory.Date);
select *from YearlyDepartmentAllowances_Deductions;