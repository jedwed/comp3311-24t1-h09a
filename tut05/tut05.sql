
/* 
 * Q1
 * Write a simple PLpgSQL function that returns the square of its argument value
 */
create or replace function sqr(input numeric) returns numeric
as $$
    select (input * input); 
$$ language sql;


/*
 * Q2
 * Write a PLpgSQL function that spreads the letters in some text.
 */
create or replace function spread(input text) returns text
as $$
declare
    res text := '';
begin
    -- loop through characters of input
    for i in 1..length(input)
    loop
        res := res || substring(input, i, 1) || ' ';
    end loop;
    return res;
end
$$ language plpgsql;


/*
 * Q3
 * Write a PLpgSQL function to return a table of the first n positive integers. 
 */
create or replace function seq(n integer) returns setof integer
as $$
begin
    for i in 1..n
    loop
        return next i;
    end loop;
end
$$ language plpgsql;


/*
 * Q4
 * Generalise the previous function so that it returns a table of integers, 
 * starting from lo up to at most hi, with an increment of inc. 
 * The function should also be able to count down from lo to hi if the value of inc is negative. 
 * An inc value of 0 should produce an empty table.
 */ 


/*
 * Q5
 * Re-implement the seq(int) function from above as an SQL function, and making use of the generic seq(int,int,int) function defined above.
 */

/*
 * Q6
 * Create a factorial function based on the above sequence returning functions.
 */


