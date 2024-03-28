create table Student (
    sid integer,
    name text,
    primary key (sid)
);

create table Course (
    code char(8),
    lic text,
    quota integer,
    numStudents integer default 0,
    primary key (code)
);

create table Enrolment (
    course char(8),
    sid integer,
    primary key (course, sid),
    foreign key (course) references Course(code),
    foreign key (sid) references Student(sid)
);

-- We want to enforce the following constraint:
-- numStudents for each course is equal to the number of enrollments for that course

create or replace function increment_num_students() returns trigger
as $$
begin
    update Course set numStudents = numStudents + 1 where new.course = code;
    return new;
end
$$ language plpgsql;

create trigger num_students_insert
after insert on Enrolment
    for each row execute procedure increment_num_students();

create or replace function update_num_students() returns trigger
as $$
begin
    update Course set numStudents = numStudents + 1 where new.course = code;
    update Course set numStudents = numStudents - 1 where old.course = code;
    return new;
end
$$ language plpgsql;

create trigger num_students_update
after update on Enrolment
    for each row execute procedure update_num_students();




insert into Course values ('COMP1511', 'Jake Renzella', 1000);
insert into Course values ('COMP1531', 'Hayden Smith' , 1000);
insert into Course values ('COMP3311', 'Yuekang Li'   , 1000);

insert into Student values (0, 'John Smith'   );
insert into Student values (1, 'John Doe'     );
insert into Student values (2, 'Daniel Jacobs');


-- create assertion NumStudentsIsCorrect check (
--     -- check that there doesn't exist a course where numstudents isn't equal to the number of enrolments
--     not exists (
--         select *
--         from Course as C
--         where numStudents <> (
--             select count(*)
--             from Enrolment
--             where course = C.code
--         )
--     )
-- );

-- a trigger that increments numStudents for every single enrollment

