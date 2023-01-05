-- creating a database
CREATE DATABASE Details_of_XYZ_Mall;
-- To delete a database
drop database Details_of_XYZ_Mall;

-- instructing to use 'details_of_xyz_mall' database
USE Details_of_XYZ_Mall;

-- Creating TABLE with CONSTRAINTS and DATA TYPES

 CREATE TABLE Product
 (New_Product_ID DECIMAL(10,4) PRIMARY KEY,
  Product_Name VARCHAR(100) UNIQUE,
  Sale_count INT,
  Emp_ID INT,
  CHECK(Sale_count > 1000));                   -- using CHECK constraint to Limit the value range of the "Sale_count" column

-- Inserting more than one rows in product table
insert into product values(1.0,'SUGR',100000,1003),
(2.0,'H&M',700000,1007),(3.0,'Tace_Bell',50000,1011),(4.0,'apple',50000,1016),
(5.0,'CROMA',200000,1018); 
  
 CREATE TABLE Branch
(Branch_ID INT PRIMARY KEY,
 Branch_Name VARCHAR(100) NOT NULL,
 Branch_Addr VARCHAR(500),
 New_Product_ID DECIMAL(10,4),
constraint fk_new_product_id foreign key (New_Product_ID) references product(New_Product_ID));

INSERT INTO branch VALUES(001,"Chennai","16 ABC Road",1.0);
INSERT INTO branch VALUES(002,"Coimbatore","120 15th Block",5.0);
INSERT INTO branch VALUES(003,"Mumbai","25 XYZ Road",2.0);
INSERT INTO branch VALUES(004,"Hydrabad","32 10th Street",3.0);

CREATE TABLE Employee
(Emp_ID INT PRIMARY KEY AUTO_INCREMENT,
 Emp_Name VARCHAR(100),
 Hire_Date DATE,
 Job_desc VARCHAR(100) DEFAULT "Unassigned",
 Salary INT,
 Branch_ID INT);

-- deleting the table
drop table employee;
drop table branch;
drop table product;

-- Adding AUTO_INCREMENT KEY in employee table
  ALTER TABLE Employee AUTO_INCREMENT = 1000;
  
-- Adding FOREIGN KEY Constraint to Employee table(pre-existing table)
ALTER TABLE employee
ADD constraint fk_branch_id FOREIGN KEY (Branch_ID) REFERENCES branch (Branch_ID);

-- Adding FOREIGN KEY Constraint to product table(pre-existing table)  
alter table product
add constraint fk_emp_id  FOREIGN KEY (Emp_ID) REFERENCES employee(Emp_ID);

-- drop foriegn key in product table
ALTER TABLE product
DROP FOREIGN KEY FK_emp_id;

select * from product;       -- display all rows and columns in the product table

-- Inserting values in a row in column order
INSERT INTO branch VALUES(001,"Chennai","16 ABC Road",1.0);
INSERT INTO branch VALUES(002,"Coimbatore","120 15th Block",5.0);
INSERT INTO branch VALUES(003,"Mumbai","25 XYZ Road",2.0);
INSERT INTO branch VALUES(004,"Hydrabad","32 10th Street",3.0);
select * from branch;

insert into employee(Emp_Name,Hire_Date,Job_desc, Salary,Branch_ID)values
('Gerald','1980-12-12','manager',850000,001),
('Renske','1981-02-20','manager','870000',002),
('Sarath','1981-04-02','Manager',830000,004),
('Cabrio','1981-05-15','worker',350000,003),
('William','1981-05-15','Cus_Ser_Rep',780000,004),
('Britne','1981-06-09','Cus_Ser_Rep',700000,001),
('Janette','1981-08-22','manager',800000,003),
('Mozhe','1981-09-06','worker',360600,002),
('Anthony','1981-10-18','Sale_Rep',700000,004), 
('Jennifer','1981-10-27',' Cus_Ser_Rep',800000,001),
('Alexis','1981-11-17','Cashier',450000,004),
('Sewall','1982-01-13','worker',350600,002),
('James','1982-08-02','Sale_Rep',650000,003),
('James','1982-04-23','Cashier', 400000,003),
('Alexis','1982-05-23','Sale_Rep',630000,004),
('Britne','1982-06-03','worker',360000,001),
('Adam','1982-06-03','worker',300600,003),       
('Whalen','1982-07-18','worker',250000,003),
('Anthony','1982-07-09','worker',250600,004),
('Mikkilineni','1982-08-26','worker',250600,002);
insert into  employee(Emp_Name,Hire_Date,Job_desc)values('mukesh','1982-09-02','Unassigned');
insert into  employee(Emp_Name,Hire_Date,Job_desc,salary)values('mukesh','1982-09-02','Unassigned',250000);
select * from employee;
      
 -- Deleting the particular rows which satisfy the given conditions using WHERE clause
 delete from employee
 where Emp_ID=1020 and Emp_Name='mukesh' and Hire_Date='1982-09-02';

 -- shows only distinct values without duplicates
 select distinct (job_desc) job from employee;
 
 -- showing Average,Maximum and Minimum salary of Employees from Employee table using AVG,MAX,MIN
 select job_desc,avg(salary) from employee
 where Job_desc='manager'; 
 
 select Job_desc, max(salary) from employee
 where Job_desc='worker';
 
  select job_desc,MIN(salary) from employee
 where Job_desc='manager'; 
 
 select * from employee
 where Emp_ID between 1005 and 1017;
 
 select * from employee
 where salary >(select avg(salary) from employee);

select * from employee
where salary>=700000;

-- Showing selected columns for the selective multiple Job_desc using WHERE clause with IN 
select Emp_ID,Emp_Name, job_desc,Salary  from employee
where job_desc in ('manager','cashier','worker');

/*Using Alise LIKE
Filters emp_name starting with A*/
select * from employee
where emp_name like 'A%';

-- Filters emp_name End with M
select Emp_Name,Job_desc from employee
where Emp_Name like'%m';

-- Filtering  Emp_name where r as 3rd character
select * from employee 
where emp_name like '__r%';

-- Updating emp_name 
update employee set Emp_Name='nivi'
where Emp_id='1019';

-- Updating hire_date
update employee set hire_date='1981-12-17'
where Emp_ID=1010;

-- Order by salary  in descending order
select * from employee 
order by salary desc;

-- Using ORDER BY in customized order
select * from employee
order by (case job_desc 
when 'manager' then 1
when 'cus_ser_rep' then 2
when 'sale_rep' then 3
 when 'cashier' then 4
 else 100 end);
 
-- showing  first 5 records 
select * from employee
limit 5;

-- displaying number of employees count of each job_desc using GROUP BY
select Job_desc,count(Emp_ID) from employee
group by Job_desc;

-- displaying number of employees count more than one of each job_desc using GROUP BY,HAVING
select Job_desc,count(Emp_ID) from employee
group by Job_desc
having count(Emp_ID)>1;


--  display the branch into in which any employee gets more than 5L
select branch_id,branch_name,New_Product_ID
from branch
where branch_id=any
(select branch_id from employee
where salary<500000);

select * from employee
where salary =(select min(salary)
from employee);

-- total count of entires in the table
 select count(*) total_count from employee;
 
 -- total salary in worker and used uppercase in job_desc
 select ucase(Job_desc) as job,sum(salary) from employee
 where Job_desc='worker';
 
  -- Using CONCAT displaying "Rs." with Salary column.
 select Emp_Name,Job_desc,concat("Rs.",salary) salary
 from employee;
 
 SELECT Emp_name,LEFT(hire_date,4)
FROM Employee;
 
 -- creating a index for Emp_name column
 create index name_index on employee (Emp_Name);
 
 -- drop index
 alter table employee
drop index name_index;
 
-- creating a view table job_avg_salary
create view job_avg_salary as
select avg(salary),job_desc from employee
where Job_desc='manager'
union
select avg(salary),job_desc from employee
where Job_desc like 'cus%'
union 
select avg(salary),job_desc from employee
where Job_desc ='sale_rep'
union
select avg(salary),job_desc from employee
where Job_desc ='cashier'
union
select avg(salary),job_desc from employee
where Job_desc like 'wo%';
select * from job_avg_salary;

-- inner join displays only matching rows
select employee.Emp_ID,employee.Emp_Name,employee.Job_desc,branch.Branch_ID
 from employee
 inner join branch
 on employee.Branch_ID=branch.Branch_ID
 group by Job_desc ;
 
 -- left join displays matching rows with all other rows in left table
select *from employee
left join branch
on employee.Branch_ID=branch.Branch_ID
order by emp_id ;


-- Right join displays matching rows with all other rows in Right table
 select * from branch b
 right join product p
 on b.New_Product_ID=p.New_Product_ID; 

CREATE VIEW emp_pro_sale AS
SELECT e.Emp_Name, p.product_name,P.sale_count 
FROM Employee E 
INNER JOIN PRODUCT p WHERE Emp_id = EMP_ID
GROUP BY Product_Name
Having sale_count >= 120000
ORDER BY Sale_count;

-- Updating View table
CREATE OR REPLACE VIEW emp_pro_sale AS 
SELECT e.Emp_Name, p.product_name,P.sale_count,p.new_product_id
FROM Employee E 
INNER JOIN PRODUCT p WHERE Emp_id = PEMP_ID
GROUP BY Product_Name
ORDER BY Sale_count;

SELECT * FROM emp_pro_sale;

SELECT * FROM Employee;



ALTER TABLE Employee DROP COLUMN Incentive;
-- on deleting a row in Product table , Emp_ID corresponding entries in the employee table will be made Null
ALTER TABLE Product
ADD CONSTRAINT Fk_EmpID FOREIGN KEY(PEmp_ID) REFERENCES Employee(Emp_ID)
ON DELETE SET NULL;

DELETE FROM Employee WHERE Emp_ID = 1018;
DELETE FROM PRODUCT WHERE PEmp_ID = 1017;

-- Here by deleting the details in Branch Table , Corresponding rows get deleted in Employee Table.
DELETE FROM Branch WHERE Branch_Name = "Mumbai";

SELECT * FROM Employee;
SELECT * FROM Product;
SELECT * FROM Branch;

-- on deleting a row in employee table corresponding entries in the branch table will be deleleted
ALTER TABLE Employee
ADD CONSTRAINT Fk_BranchID FOREIGN KEY(Branch_ID) REFERENCES Branch(Branch_ID)
ON DELETE CASCADE;

-- Here by deleting the details in Branch Table , Corresponding rows get deleted in Employee Table.
DELETE FROM Branch WHERE Branch_Name = "Mumbai";

-- displaying the branches containing atleast one "Manager"
SELECT Branch_id,Branch_name
FROM Branch B
WHERE EXISTS 
( SELECT * FROM Employee E
WHERE job_desc="Manager" AND B.Branch_id = E.Branch_id);
