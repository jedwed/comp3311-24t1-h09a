/*
 * Q2 
 * A new government initiative to get more young people into work 
 * cuts the salary levels of all workers under 25 by 20%. 
 * Write an SQL statement to implement this policy change.
 */
update Employees
set    salary = 0.8 * salary
where  age < 25;

/*
 * A VIEW is a virtual table that you can select from
 * Helps you create useful abstractions
 */
create or replace view EmployeeDepartments
as
select W.eid, D.dname  
from   WorksIn as W
join   Departments as D on W.did = D.did
;



/*
 * Q3
 * The company has several years of growth and high profits, 
 * and considers that the Sales department is primarily responsible for this. 
 * Write an SQL statement to give all employees in the Sales department a 10% pay rise.
 */
update Employees
set    salary = 1.1 * salary
where  eid in (
    -- list of eids in the sales departments
    select eid
    from   EmployeeDepartments
    where  dname = 'Sales'
    -- subquery without using a VIEW
    -- select W.eid
    -- from   WorksIn as W
    -- join   Departments as D on W.did = D.did
    -- where  D.dname = 'Sales'
);


