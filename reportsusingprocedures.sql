use databaseproject;
create procedure empcountindep
as
begin
select Department.DepartmentName,
count(Employee.EmployeeID) AS EmployeeCount from Department
left join Employee on Department.DepartmentID = Employee.DepartmentID
group by DepartmentName;
end;
exec empcountindep

create procedure EmpNetSalary
as begin 
Select Employee.EmployeeID, Employee.EMPName, Salary.NetSalary
from Employee
join Salary on Employee.SalaryID = Salary.SalaryID
order by EmployeeID;
end;
exec EmpNetSalary;


create procedure empattendancereport
@startdate Date,
@enddate Date
as begin
select Employee.EmployeeID, Employee.EMPName,Attendance.Date,Attendance.TimeIn, Attendance.TimeOut
from Attendance
join Employee on Attendance.EmployeeID = Employee.EmployeeID
where Attendance.Date between @startdate and @enddate
order by Employee.EmployeeID, Attendance.Date, Attendance.TimeIn
end;
exec empattendancereport '2021-06-15','2023-06-11';