create assertion NumStudentsIsCorrect check (
    -- check that there doesn't exist a course where numstudents isn't equal to the number of enrolments
    not exists (
        select *
        from Course as C
        where numStudents <> (
            select count(*)
            from Enrolment as E
            where E.course = C.code
        )
    )
);

