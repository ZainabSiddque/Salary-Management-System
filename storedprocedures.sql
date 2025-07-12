use databaseproject;
CREATE PROCEDURE insert_department (
   @DepartmentID INT,
   @DepartmentName VARCHAR(100)
)
As
Begin
Insert into Department (DepartmentID, DepartmentName) values (@DepartmentID, @DepartmentName)
END;
exec insert_department 10, 'Department of Architecture and Design';
select *from department

CREATE PROCEDURE delete_dep (
    @DepartmentID INT
)
AS
BEGIN
Delete from SalaryHistory where EmployeeID in (select employeeID FROM Employee where DepartmentID = @DepartmentID);
Delete from Attendance where EmployeeID in (select employeeID FROM Employee where DepartmentID = @DepartmentID);
Delete from Employee where DepartmentID = @DepartmentID
Delete from Department Where DepartmentID = @DepartmentID
END;
exec delete_dep 8


CREATE PROCEDURE update_department (
      @DepartmentID INT,
      @NewDepartmentName VARCHAR(100))
As Begin
 UPDATE Department
 SET DepartmentName = @NewDepartmentName where DepartmentID = @DepartmentID
END;



CREATE PROCEDURE insert_allowance (
      @SalaryID INT,
    @AllowanceID INT,
    @BasicSalary DECIMAL,
    @CompensatoryAllowance DECIMAL,
    @HouseRent DECIMAL
)
As
Begin
   Insert into Allowances ( SalaryID,AllowanceID, BasicSalary, CompensatoryAllowance, HouseRent)
    Values ( @SalaryID,@AllowanceID, @BasicSalary, @CompensatoryAllowance, @HouseRent)
END;
exec insert_allowance 100, 201, 83725, 38438,7473
exec insert_allowance 67, 160, -32755, 33458,13834 -- error due to trigger

select *from allowances


CREATE PROCEDURE delete_allowance (
  @AllowanceID INT
)
As
Begin
    Delete from Allowances
    where AllowanceID = @AllowanceID
END;



  CREATE PROCEDURE update_allowance 
   @SalaryID INT,
  @AllowanceID INT,
   @NewBasicSalary DECIMAL,
    @NewCompensatoryAllowance DECIMAL,
    @NewHouseRent DECIMAL
AS Begin
  UPDATE Allowances
    SET BasicSalary = @NewBasicSalary,
      CompensatoryAllowance = @NewCompensatoryAllowance,
      HouseRent = @NewHouseRent
    where AllowanceID = @AllowanceID AND SalaryID= @SalaryID; 
END;

CREATE PROCEDURE insert_deduction (
   @SalaryID INT,
   @DeductionID INT,
    @CPF_GP DECIMAL,
    @TaxDeductions DECIMAL,
    @BenevolentGroupInsurances DECIMAL
)
As
Begin
 Insert into Deductions (SalaryID,DeductionID, CPF_GP, TaxDeductions, BenevolentGroupInsurances)
    values (@SalaryID,@DeductionID, @CPF_GP, @TaxDeductions, @BenevolentGroupInsurances);
END;


Create procedure delete_deduction (
 @DeductionID INT
)
As
Begin
    Delete from Deductions
where DeductionID = @DeductionID
END;


   CREATE PROCEDURE update_deduction (
    @SalaryID INT,
   @DeductionID INT,
   @NewCPF_GP DECIMAL,
   @NewTaxDeductions DECIMAL,
   @NewBenevolentGroupInsurances DECIMAL)
As Begin
 UPDATE Deductions
    SET CPF_GP = @NewCPF_GP,TaxDeductions = @NewTaxDeductions,BenevolentGroupInsurances = @NewBenevolentGroupInsurances where DeductionID = @DeductionID AND SalaryID= @SalaryID;
END;


CREATE PROCEDURE insert_salary (
  @SalaryID INT,
  @GrossSalary DECIMAL,
  @TotalDeductions DECIMAL
)
As
Begin
 Insert into Salary (SalaryID, GrossSalary, TotalDeductions) values (@SalaryID, @GrossSalary, @TotalDeductions)
END;




CREATE PROCEDURE delete_salary (
  @SalaryID INT
)
As
Begin
delete from Allowances where SalaryID = @SalaryID;
delete from Deductions where SalaryID = @SalaryID;
Delete from SalaryHistory where EmployeeID in (select employeeID FROM Employee where SalaryID = @SalaryID);
Delete from Attendance where EmployeeID in (select employeeID FROM Employee where SalaryID = @SalaryID);
delete from Employee where SalaryID = @SalaryID;
delete from SalaryHistory where SalaryID = @SalaryID;
 delete from Salary where SalaryID = @SalaryID
END;
exec delete_salary 56
select *from salary

CREATE PROCEDURE update_salary (
@SalaryID INT,
@NewGrossSalary DECIMAL,
@NewTotalDeductions DECIMAL
)
As Begin
 UPDATE Salary
 SET GrossSalary = @NewGrossSalary,TotalDeductions = @NewTotalDeductions where  SalaryID = @SalaryID
END;


CREATE PROCEDURE insert_salary_history (
    @HistoryID INT,
    @EmployeeID INT,
    @SalaryID INT,
    @Date DATE,
    @PreviousGrossSalary DECIMAL,
    @PreviousNetSalary DECIMAL
)
As
Begin
 Insert into SalaryHistory (HistoryID, EmployeeID, SalaryID, Date, PreviousGrossSalary, PreviousNetSalary)
 values (@HistoryID, @EmployeeID, @SalaryID, @Date, @PreviousGrossSalary, @PreviousNetSalary)
END;



CREATE PROCEDURE delete_salary_history (
@HistoryID INT
)
As
Begin
 Delete from SalaryHistory
   where HistoryID = @HistoryID
END;

CREATE PROCEDURE update_salary_history (
@HistoryID INT, 
@NewEmployeeID INT, 
@NewSalaryID INT, 
@NewDate DATE,
@NewPreviousGrossSalary DECIMAL,
@NewPreviousNetSalary DECIMAL
)
As Begin
  UPDATE SalaryHistory
   SET EmployeeID = @NewEmployeeID,SalaryID = @NewSalaryID,Date = @NewDate,PreviousGrossSalary = @NewPreviousGrossSalary,PreviousNetSalary = @NewPreviousNetSalary where HistoryID = @HistoryID
END;


CREATE PROCEDURE insert_employee (
    @EmployeeID INT,
    @EMPName VARCHAR(100),
    @JobTitle VARCHAR(50),
    @Experience INT,
    @DepartmentID INT,
    @SalaryID INT
)
As
Begin
Insert into Employee (EmployeeID, EMPName, JobTitle, Experience, DepartmentID, SalaryID)
values(@EmployeeID, @EMPName, @JobTitle, @Experience, @DepartmentID, @SalaryID)
END;


CREATE PROCEDURE delete_Emp (
  @EmployeeID INT
)
As
Begin
delete from Attendance where EmployeeID = @EmployeeID
delete from SalaryHistory where EmployeeID = @EmployeeID
delete from Employee where EmployeeID = @EmployeeID
END;
exec delete_Emp 11
exec delete_Emp 13
select *from Employee





CREATE PROCEDURE update_employee (
    @EmployeeID INT, 
	@NewEMPName VARCHAR(100), 
	@NewJobTitle VARCHAR(50),  
	@NewExperience INT,  
	@NewDepartmentID INT,  
	@NewSalaryID INT)
As begin
 UPDATE Employee
    SET 
	EMPName = @NewEMPName,
    JobTitle = @NewJobTitle,
	Experience = @NewExperience,
	DepartmentID = @NewDepartmentID,
	SalaryID = @NewSalaryID where EmployeeID = @EmployeeID
END;

CREATE PROCEDURE InsertAttendance (
    @AttendanceID INT,
    @EmployeeID INT,
    @Date DATE,
    @TimeIn TIME,
    @TimeOut TIME
)
As
Begin
 Insert into Attendance (AttendanceID, EmployeeID, Date, TimeIn, TimeOut)
   values (@AttendanceID, @EmployeeID, @Date, @TimeIn, @TimeOut);
  END;
  
CREATE PROCEDURE DeleteAttendance(
  @AttendanceID INT
)
As 
Begin
 Delete from Attendance where AttendanceID = @AttendanceID;
   END;
 


Create procedure UpdateAttendance(
@AttendanceID INT,
@EmployeeID INT,
@Date DATE, 
@TimeIn TIME,
@TimeOut TIME
)
As begin
    UPDATE Attendance
    SET TimeIn = @TimeIn, TimeOut = @TimeOut
    where AttendanceID = @AttendanceID AND EmployeeID = @EmployeeID AND Date = @Date;
END
