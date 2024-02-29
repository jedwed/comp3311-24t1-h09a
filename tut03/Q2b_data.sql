-- Populate the database

-- Could also insert like this:
-- insert into Teacher (staffNo, nameFirst, nameLast) values (0, 'Hayden', 'Smith');
insert into Teacher values (0, 'Hayden', 'Smith');
insert into Teacher values (1, 'Yuekang', 'Li');
insert into Teacher values (2, 'John', 'Shepherd');
insert into Teacher values (3, 'Jake', 'Renzella');
insert into Teacher values (4, 'Edward', 'Qian');
insert into Subject values ('COMP1511', 'Programming Fundamentals');
insert into Subject values ('COMP1531', 'Software Engineering Fundamentals');
insert into Subject values ('COMP3311', 'Database Systems');
insert into Subject values ('COMP6080', 'Web Front-end Programming');
insert into Teaches values (0, 'COMP6080', '23T1');
insert into Teaches values (0, 'COMP1531', '23T2');
insert into Teaches values (0, 'COMP6080', '23T3');
insert into Teaches values (0, 'COMP6080', '24T1');
insert into Teaches values (0, 'COMP1531', '24T1');
insert into Teaches values (1, 'COMP3311', '24T1');
insert into Teaches values (2, 'COMP3311', '23T1');
insert into Teaches values (2, 'COMP3311', '23T3');
insert into Teaches values (3, 'COMP1531', '23T1');
insert into Teaches values (3, 'COMP1511', '23T2');
insert into Teaches values (4, 'COMP1531', '23T2');
insert into Teaches values (4, 'COMP1531', '23T3');
insert into Teaches values (4, 'COMP3311', '24T1');

-- Some basic queries you could try :):
-- select * from Teacher; 
-- select nameFirst, nameLast from Teacher; 
-- select name from Subject where subjectCode = 'COMP1531'; 

-- A query that returns all teachers in the database that teach COMP3311
-- create or replace view COMP3311Teachers(name)
-- as
-- select T.nameFirst || ' ' || T.nameLast, TS.semester
-- from Teacher as T
-- join Teaches as TS on T.staffNo = TS.staffNo
-- where TS.subjectCode = 'COMP3311'
-- ;

-- A query that returns all subjects that this mysterious Edward person teaches
-- create or replace view EdwardTeaches(subjectCode, name)
-- as
-- select S.subjectCode, S.name, TS.semester
-- from Subject as S
-- join Teaches as TS on S.subjectCode = TS.subjectCode
-- join Teacher as T on TS.staffNo = T.staffNo
-- where nameFirst = 'Edward' and nameLast = 'Qian'
-- ;
--
