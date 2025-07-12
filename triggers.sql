use databaseproject;
CREATE TRIGGER triggerdepID ON Department
FOR INSERT
AS
BEGIN
    DECLARE @DepartmentId INT;
    SELECT @DepartmentId = DepartmentId FROM inserted;
    IF @DepartmentId < 9
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR('DepartmentId cannot be less than 9', 16, 2);
    END;
END;

CREATE TRIGGER triggerAllowance ON Allowances
AFTER INSERT
AS 
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE BasicSalary < 0 OR CompensatoryAllowance < 0 OR HouseRent < 0)
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR('Allowance values cannot be negative', 16, 1);
    END;
END;

CREATE TRIGGER triggerCPGP ON Deductions
AFTER INSERT
AS 
BEGIN
    DECLARE @CPF_GP Decimal;
    SELECT @CPF_GP = CPF_GP FROM inserted;
    IF @CPF_GP > 15000
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR('CPF & GP cannot exceed 15000',16,3);
    END;
END;


CREATE TRIGGER triggerInsertSalary ON Salary
AFTER INSERT
AS
BEGIN
    DECLARE @InsertedSalaryID INT;
    SELECT @InsertedSalaryID = SalaryID FROM inserted;
    IF @InsertedSalaryID <= 0
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR('SalaryID must be greater than 0.', 16, 1);
    END;
END;

CREATE TRIGGER CheckExperience ON Employee
FOR INSERT, UPDATE
AS
BEGIN
    DECLARE @Experience INT;
    SELECT @Experience = Experience FROM inserted; 
    IF @Experience < 0
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR('Experience cannot be negative',16,1);
    END;
END;

CREATE TRIGGER triggerInsertAttendance_TimeCheck
ON Attendance
AFTER INSERT
AS
BEGIN
    DECLARE @InsertedTimeIn TIME;
    DECLARE @InsertedTimeOut TIME;
    SELECT @InsertedTimeIn = TimeIn, @InsertedTimeOut = TimeOut FROM inserted;
    IF @InsertedTimeIn >= @InsertedTimeOut
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR('TimeIn must be before TimeOut.', 16, 1);
    END;
END;

CREATE TRIGGER triggerDeleteDepartment ON Department
AFTER DELETE
AS 
BEGIN
    DECLARE @DeletedDepartmentID INT;
    SELECT @DeletedDepartmentID = DepartmentID FROM deleted;
    IF @@ROWCOUNT > 0
    BEGIN
        PRINT 'Department Record with DepartmentID ' + CONVERT(NVARCHAR(10), @DeletedDepartmentID) + ' is being deleted.';
    END
    ELSE
    BEGIN
        PRINT 'DepartmentID does not exist. No record deleted.';
    END;
END;

CREATE TRIGGER triggerDeleteAllowance
ON Allowances
AFTER DELETE
AS
BEGIN
    DECLARE @DeletedAllowanceID INT;
    SELECT @DeletedAllowanceID = AllowanceID FROM deleted;
    IF @@ROWCOUNT > 0
    BEGIN
        PRINT 'Allowance Record with AllowanceID ' + CONVERT(NVARCHAR(10), @DeletedAllowanceID) + ' is being deleted.';
    END
    ELSE
    BEGIN
        PRINT 'AllowanceID does not exist. No record deleted.';
    END;
END;

CREATE TRIGGER triggerDeleteDeduction ON Deductions
AFTER DELETE
AS
BEGIN
    DECLARE @DeletedDeductionID INT;
    SELECT @DeletedDeductionID = DeductionID FROM deleted;
    IF @@ROWCOUNT > 0
    BEGIN
        PRINT 'Deduction Record with DeductionID ' + CONVERT(NVARCHAR(10), @DeletedDeductionID) + ' is being deleted.';
    END
    ELSE
    BEGIN
        PRINT 'DeductionID does not exist. No record deleted.';
    END;
END;



CREATE TRIGGER triggerrDeleteSalaryHistory
ON SalaryHistory
AFTER DELETE
AS
BEGIN
    DECLARE @DeletedHistoryID INT;
    SELECT @DeletedHistoryID = HistoryID FROM deleted;
    IF @@ROWCOUNT > 0
    BEGIN
        PRINT 'Salary History Record with HistoryID ' + CONVERT(NVARCHAR(10), @DeletedHistoryID) + ' has been deleted.';
    END
    ELSE
    BEGIN
        PRINT 'HistoryID does not exist. No record deleted.';
    END;
END;
CREATE TRIGGER triggerDeleteEmployee
ON Employee
AFTER DELETE
AS
BEGIN
    DECLARE @DeletedEmployeeID INT;
    SELECT @DeletedEmployeeID = EmployeeID FROM deleted;
    IF @@ROWCOUNT > 0
    BEGIN
        PRINT 'Employee Record with EmployeeID ' + CONVERT(NVARCHAR(10), @DeletedEmployeeID) + ' is being deleted.';
    END
    ELSE
    BEGIN
        PRINT 'EmployeeID does not exist. No record deleted.';
    END;
END;

CREATE TRIGGER triggerDeleteAttendance
ON Attendance
AFTER DELETE
AS
BEGIN
    DECLARE @DeletedAttendanceID INT;
    SELECT @DeletedAttendanceID = AttendanceID FROM deleted;
    IF @@ROWCOUNT > 0
    BEGIN
        PRINT 'Attendance record with AttendanceID ' + CONVERT(NVARCHAR(10), @DeletedAttendanceID) + ' has been deleted.';
    END
    ELSE
    BEGIN
        PRINT 'Attendance Record does not exist. No record deleted.';
    END;
END;

CREATE TRIGGER triggerDeleteSalary
ON Salary
AFTER DELETE
AS
BEGIN
    DECLARE @DeletedSalaryID INT;
    SELECT @DeletedSalaryID = salaryID FROM deleted;    
    IF @@ROWCOUNT > 0
    BEGIN
        PRINT 'Salary Record with SalaryID ' + CONVERT(NVARCHAR(10), @DeletedSalaryID) + ' has been deleted.';
    END
    ELSE
    BEGIN
        PRINT 'SalaryID does not exist. No record deleted.';
    END;
END;

CREATE TRIGGER trgAfterUpdateAttendance
ON Attendance
After UPDATE
As begin
    DECLARE @UpdatedAttendanceID INT;
select @UpdatedAttendanceID = AttendanceID FROM inserted;
if @@ROWCOUNT > 0
    begin
        print 'Attendance Record with ID ' + CONVERT(NVARCHAR(10), @UpdatedAttendanceID) + ' has been updated.';
    END
    else
    begin
        print 'No Attendance Record was updated.';
    END;
END;


CREATE TRIGGER triggerSalaryhistory
ON SalaryHistory
After UPDATE
As begin
    print 'Salary History Record Updated';
END;


CREATE TRIGGER triggerUpdateSalary
ON Salary
After UPDATE
As begin
    print 'Salary Record Updated';
END;


CREATE TRIGGER triggerUpdateDeductions
ON Deductions
After UPDATE
As begin
    DECLARE @UpdatedDeductionID INT;
select @UpdatedDeductionID = DeductionID FROM inserted;
if @@ROWCOUNT > 0
    begin
        print 'Deduction Record with DeductionID ' + CONVERT(NVARCHAR(10), @UpdatedDeductionID) + ' has been updated.';
    END;
END;

CREATE TRIGGER triggerUpdateAllowances
ON Allowances
After UPDATE
As begin
    DECLARE @UpdatedAllowanceID INT;
select @UpdatedAllowanceID = AllowanceID FROM inserted;
if @@ROWCOUNT > 0
    begin
        print 'Allowance Record with AllowanceID ' + CONVERT(NVARCHAR(10), @UpdatedAllowanceID) + ' has been updated.';
    END;
END;


CREATE TRIGGER trgAfterUpdateDepartment
ON Department
After UPDATE
As begin
    declare @UpdatedDepartmentID INT;
	select @UpdatedDepartmentID = DepartmentID FROM inserted;
if @@ROWCOUNT > 0
    begin
        print 'Department Record with DepartmentID ' + CONVERT(NVARCHAR(10), @UpdatedDepartmentID) + ' has been updated.';
    END;
END;
