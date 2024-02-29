create table Teacher (
    staffNo integer check staffNo > 0 primary key,
    nameFirst varchar(50),
    nameLast varchar(50)
);

create table Subject (
    subjCode char(8) primary key,
    -- because there is total participation on the Subject side
    -- in the relationship between Subject and Teacher,
    -- we enforce this by specifying the foreign key is 'not null'
    staffNo integer not null,
    semester char(4),
    foreign key (staffNo) references Teacher(staffNo)
)
