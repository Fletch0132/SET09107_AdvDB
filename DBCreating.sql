/*Question Two - Implementing the re-designed database*/


/*DROP TYPES*/
drop type Customer force;
drop type Employee force;
drop type SavingsAcc force;
drop type CurrentAcc force;
drop type Account force;
drop type People force;
drop type Branch force;
drop type phone_array force;
drop type Address force;
drop type Name force;

------------------------------------------------

/*TYPES*/
/*Name*/
create type Name as object(
title varchar2(10),
firstName varchar2(20),
surName varchar2(20))
not final;


/*Address*/
create type Address as object(
street varchar2(30),
city varchar2(30),
postCode varchar2(8))
not final;


/*Phone Varray*/
create type phone_array as varray(3) of varchar2(11);


/*Branch*/
create type Branch as object(
bID int,
bAddress Address,
bPhone varchar2(11))
not final;


/*People*/
create type People as object(
pName Name,
pAddress Address,
pPhone phone_array,
niNum varchar2(9))
Not Final;


/*Account*/
create type Account as object(
accNum int, 
balance decimal(13,2),
inRate decimal(5,4),
openDate Date)
Not Final;


/*CurrentAcc - inherits from Account*/
create type CurrentAcc under Account(
limitOfFreeOD decimal(13,2),
bID int)
Not Final;


/*SavingsAcc - inherit from Account*/
create type SavingsAcc under Account(
bID int)
Not Final;


/*Employee - Inherits from People*/
create type Employee under People(
empID int,
position varchar2(10),
supervisorID int,
salary decimal(13,2),
bID int, 
joinDate Date)
not final;


/*Customer - Inherits from People*/
create type Customer under People(
custID int)
not Final;

----------------------------------------------------------------

/*DROP TABLES*/
drop table tableCustAccSavings force;
drop table tableCustAccCurrent force;
drop table tableCustomer force;
drop table tableEmployee force;
drop table tableSavingsAcc force;
drop table tableCurrentAcc force;
drop table tableBranch force;


----------------------------------------------------------------

/*TABLES*/
/*Branch*/
create table tableBranch of Branch(
Primary Key(bID));


/*Current - previous Account*/
create table tableCurrentAcc of CurrentAcc(
Primary Key(accNum),
FOREIGN Key(bID) References tableBranch(bID));


/*Savings*/
create table tableSavingsAcc of SavingsAcc(
Primary Key(accNum),
Foreign Key(bID) References tableBranch(bID));


/*Employee*/
create table tableEmployee of Employee(
Primary Key(empID),
FOREIGN Key(bID) References tableBranch(bID),
FOREIGN Key(empID) References tableEmployee(empID));


/*Customer*/
create table tableCustomer of Customer(
Primary Key(custID));


/*CustomerAccount - Current*/
create table tableCustAccCurrent(
custID ref Customer Scope is tableCustomer,
accNum ref CurrentAcc Scope is tableCurrentAcc);


/*CustomerAccount - Savings*/
create table tableCustAccSavings(
custID ref Customer Scope is tableCustomer,
accNum ref SavingsAcc Scope is tableSavingsAcc);








