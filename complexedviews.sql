use databaseproject;

--calculates average salary for each department
create view AverageDepSalary as 
Select Department.DepartmentName,
AVG(Salary.GrossSalary) as AverageGrossSalary,
AVG(Salary.NetSalary) as AverageNetSalary
from Employee
join Department on Employee.DepartmentID = Department.DepartmentID
join Salary on Employee.SalaryID = Salary.SalaryID
group by DepartmentName;
select *from AverageDepSalary;

--calculates maximum allowance of each employee
create view MaxEmpAllowance as
Select Employee.EMPName,
MAX(Allowances.TotalAllowance) as MaximumEmployeeAllowance
from Salary
join Employee on Salary.SalaryID = Employee.EmployeeID
join Allowances on Salary.SalaryID = Allowances.SalaryID
group by EMPName;
select *from MaxEmpAllowance;

--attendance records of employees
create view EmpAttendancePerformance as
Select Employee.EmployeeID, Employee.EMPName, Employee.JobTitle,
Department.DepartmentName, Attendance.AttendanceID,
MAX(Attendance.TimeIn) as firstcheckIn,
MIN(Attendance.TimeOut) as fisrtcheckOut,
DATEDIFF(MINUTE, MIN(Attendance.TimeIn), MAX(Attendance.TimeOut)) / 60.0 AS HoursWorked
from Attendance
join Employee on Attendance.EmployeeID = Employee.EmployeeID
join Department on Employee.DepartmentID = Department.DepartmentID
group by Employee.EmployeeID, Employee.EMPName, Employee.JobTitle,
Department.DepartmentName, Attendance.AttendanceID;
select *from EmpAttendancePerformance;