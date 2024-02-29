
create table Teacher (
    staffNo integer check (staffNo >= 0) primary key,
    nameFirst varchar(50),
    nameLast varchar(50)
);

create table Subject (
    subjCode char(8),
    name text,
    primary key (subjCode)
);

create table Teaches (
    staffNo integer,
    subjCode char(8),
    semester char(4),
    foreign key (subjCode) references Subject(subjCode),
    foreign key (staffNo) references Teacher(staffNo),
    primary key (subjCode, staffNo, semester)
)
