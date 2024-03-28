create table R(
    a int, 
    b int, 
    c text, 
    -- we want primary key (a, b)
);


create or replace function check_primary_key() returns trigger
as $$
declare
    count_var integer,
begin
    -- primary key is not null
    if new.a is null or new.b is null then
        raise exception 'Error: Primary key cannot be null';
    end if;
    -- SOMETHING I MISSED DURING THE TUTORIAL:
    -- We only return early if the update doesn't change an a or b attribute
    if TG_OP = 'UPDATE' and old.a = new.a and old.b = new.b then
        return new;
    end if;
    -- primary key is unique
    select count(*) into count_var from R where a = new.a and b = new.b 
    if count_var > 0 then
        raise exception 'Error: primary key already exists in R';
    end if;
    return new;
    
end
$$ language plpsql;

create trigger primary_key
before insert or update 
on R
for each row execute check_primary_key();

