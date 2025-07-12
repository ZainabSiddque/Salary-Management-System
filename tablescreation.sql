create database databaseproject;
use databaseproject;
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);
CREATE TABLE Salary (
    SalaryID INT PRIMARY KEY,
    GrossSalary DECIMAL,
    TotalDeductions DECIMAL,  
    NetSalary AS (GrossSalary - TotalDeductions) PERSISTED
);

CREATE TABLE Allowances (
SalaryID INT,
    AllowanceID INT PRIMARY KEY,
    BasicSalary DECIMAL,
    CompensatoryAllowance DECIMAL,
    HouseRent DECIMAL,
    TotalAllowance AS (CompensatoryAllowance + HouseRent) PERSISTED
	FOREIGN KEY (SalaryID) REFERENCES Salary(SalaryID)
);

CREATE TABLE Deductions (
SalaryID INT,
    DeductionID INT PRIMARY KEY,
    CPF_GP DECIMAL,
    TaxDeductions DECIMAL,
    BenevolentGroupInsurances DECIMAL,
    TotalDeductions AS (CPF_GP + TaxDeductions + BenevolentGroupInsurances) PERSISTED
	FOREIGN KEY (SalaryID) REFERENCES Salary(SalaryID)
);



CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    EMPName VARCHAR(100),
    JobTitle VARCHAR(50),
    Experience INT,
    DepartmentID INT,
    SalaryID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY (SalaryID) REFERENCES Salary(SalaryID)
);



CREATE TABLE SalaryHistory (
    HistoryID INT PRIMARY KEY,
    EmployeeID INT,
    SalaryID INT,
    Date DATE,
    PreviousGrossSalary DECIMAL,
    PreviousNetSalary DECIMAL,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (SalaryID) REFERENCES Salary(SalaryID)
);

CREATE TABLE Attendance (
    AttendanceID INT,
    EmployeeID INT,
    Date DATE,
    TimeIn TIME,
    TimeOut TIME,
    PRIMARY KEY (AttendanceID, EmployeeID, Date , TimeIn, TimeOut),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);