use databaseproject;
Alter Table Department
Add constraint check_depname Check(DepartmentName IN ('Department of Architecture and Design','Department of Chemical Engineering',
'Department of Computer Sciences','Department of Electrical Engineering','Department of Humanities','Department of Management Sciences',
'Department of Mathematics','Department of Physics','Department of Statistics'));

Alter Table Allowances
Add constraint check_BasicSalary CHECK (BasicSalary >= 0),
constraint check_CompensatoryAllowance CHECK (CompensatoryAllowance >= 0),
constraint check_HouseRent CHECK (HouseRent >= 0);

Alter Table Deductions
Add Constraint chk_deductions Check(CPF_GP >= 0 AND TaxDeductions >= 0 AND BenevolentGroupInsurances >= 0);

ALTER TABLE Salary
Add constraint CHECKSalaryID CHECK (SalaryID > 0);

ALTER TABLE SalaryHistory
Add constraint  ChecK_Date CHECK (Date IS NOT NULL);

ALTER TABLE Employee
Add constraint CK_Experience_NonNegative CHECK (Experience >= 0 );

ALTER TABLE Attendance
Add constraint Check_TimeIn_TimeOut CHECK (TimeIn < TimeOut);

ALTER TABLE Attendance
Add constraint CHK_Attendance_AttendanceID 
CHECK (AttendanceID > 0);