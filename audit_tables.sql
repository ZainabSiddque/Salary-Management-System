use databaseproject
CREATE TABLE EmployeeHistory (
    EmployeeID INT,
    EMPName VARCHAR(100),
    JobTitle VARCHAR(50),
    Experience INT,
    DepartmentID INT,
    SalaryID INT,
    ChangeType VARCHAR(10),
    ChangeDate DATETIME DEFAULT GETDATE()
);
CREATE TRIGGER trg_Employee_Insert
ON Employee
FOR INSERT
AS
BEGIN
    INSERT INTO EmployeeHistory (EmployeeID, EMPName, JobTitle, Experience, DepartmentID, SalaryID, ChangeType)
    SELECT 
       EmployeeID, 
        EMPName, 
        JobTitle, 
        Experience, 
        DepartmentID, 
        SalaryID, 
        'INSERT'
    FROM inserted;
END;
exec insert_employee 300, 'Farah','Professor',3,7,67
exec insert_employee 400, 'Areesha','Instructor',6,3,90
CREATE TRIGGER trg_Employee_Update
ON Employee
FOR UPDATE
AS
BEGIN
    INSERT INTO EmployeeHistory (EmployeeID, EMPName, JobTitle, Experience, DepartmentID, SalaryID, ChangeType)
    SELECT 
        deleted.EmployeeID, 
        deleted.EMPName, 
        deleted.JobTitle, 
        deleted.Experience, 
        deleted.DepartmentID, 
        deleted.SalaryID, 
        'UPDATE'
    FROM deleted;
END;
UPDATE Employee
SET JobTitle = 'Senior Developer'
WHERE EmployeeID = 1;
UPDATE Employee 
set Experience = 10
where EmployeeID = 80

CREATE TRIGGER trg_Employee_Delete
ON Employee
FOR DELETE
AS
BEGIN
    INSERT INTO EmployeeHistory (EmployeeID, EMPName, JobTitle, Experience, DepartmentID, SalaryID, ChangeType)
    SELECT 
        deleted.EmployeeID, 
        deleted.EMPName, 
        deleted.JobTitle, 
        deleted.Experience, 
        deleted.DepartmentID, 
        deleted.SalaryID, 
        'DELETE'
    FROM deleted;
END;
exec delete_Emp 29
exec delete_Emp 4
exec delete_Emp 59
exec delete_Emp 49

select *from EmployeeHistory;
select *from Employee

CREATE TABLE AttendanceHistory (
    AttendanceID INT,
    EmployeeID INT,
    Date DATE,
    TimeIn TIME,
    TimeOut TIME,
    ChangeType VARCHAR(10),
    ChangeDate DATETIME DEFAULT GETDATE()
);
CREATE TRIGGER trg_Attendance_Insert
ON Attendance
FOR INSERT
AS
BEGIN
    INSERT INTO AttendanceHistory (AttendanceID, EmployeeID, Date, TimeIn, TimeOut, ChangeType)
    SELECT 
        AttendanceID,
        EmployeeID,
        Date,
        TimeIn,
        TimeOut,
        'INSERT'
    FROM inserted;
END;
exec InsertAttendance 1000, 60, '2023-09-11','11:37:11 AM', '02:03:50 PM'
exec InsertAttendance 10001, 61, '2022-07-13','08:50:23 AM', '09:20:44 PM'
exec InsertAttendance 10002, 81, '2022-07-13','10:20:27 AM', '09:10:50 PM'
exec InsertAttendance 10003, 11, '2021-05-12','08:30:43 AM', '11:20:35 PM'
exec InsertAttendance 10004, 45, '2022-07-13','09:50:53 AM', '02:30:54 PM'

SELECT *FROM ATTENDANCE;
SELECT *FROM ATTENDANCEHISTORY;
CREATE TRIGGER trg_Attendance_Update
ON Attendance
AFTER UPDATE
AS
BEGIN
    INSERT INTO AttendanceHistory (AttendanceID, EmployeeID, Date, TimeIn, TimeOut, ChangeType)
    SELECT 
        AttendanceID,
        EmployeeID,
        Date,
        TimeIn,
        TimeOut,
        'UPDATE'
    FROM inserted;
END;
Update Attendance
set EmployeeID = 50
where AttendanceID = 45

CREATE TRIGGER trg_Attendance_Delete
ON Attendance
AFTER DELETE
AS
BEGIN
    INSERT INTO AttendanceHistory (AttendanceID, EmployeeID, Date, TimeIn, TimeOut, ChangeType)
    SELECT 
        AttendanceID,
        EmployeeID,
        Date,
        TimeIn,
        TimeOut,
        'DELETE'
    FROM deleted;
END;
exec DeleteAttendance 33
select *from AttendanceHistory



