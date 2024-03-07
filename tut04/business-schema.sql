create table Employees (
      eid     integer,
      ename   text,
      age     integer,
      salary  real check (salary > 15000),
      primary key (eid)
);
create table Departments (
      did     integer,
      dname   text,
      budget  real,
      manager integer references Employees(eid) not null,
      primary key (did)
);
create table WorksIn (
      eid     integer references Employees(eid),
      did     integer references Departments(did),
      percent real,
      primary key (eid,did)
);
