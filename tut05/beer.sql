/* 
 * Beers database schema:
 *
 * Beers(name:string, manufacturer:string)
 * Bars(name:string, address:string, license#:integer)
 * Drinkers(name:string, address:string, phone:string)
 * Likes(drinker:string, beer:string)
 * Sells(bar:string, beer:string, price:real)
 * Frequents(drinker:string, bar:string)
 */

/*
 * Q7
 * Write a PLpgSQL function called hotelsIn() that takes a single argument giving the name of a suburb, 
 * and returns a text string containing the names of all hotels in that suburb, one per line.
 */

create or replace function hotelsIn(_addr text) returns text
as $$
declare
    res text := '';
    hotel Bars%rowtype;
    -- hotel record; --works too
begin
    for hotel in 
        select name from Bars where addr = _addr
    loop
        res := res || hotel.name || e'\n';
    end loop;
    return res;
end

$$ language plpgsql;

/*
 * Q8
 * Write a new PLpgSQL function called hotelsIn() that takes a single argument giving the name of a suburb 
 * and returns the names of all hotels in that suburb. 
 * The hotel names should all appear on a single line
 */

/*
 * Q9
 * Write a PLpgSQL procedure happyHourPrice that accepts 
 * the name of a hotel, the name of a beer and the number of dollars to deduct from the price, 
 * and returns a new price.
 * The procedure should check for the following errors:
 * - non-existent hotel (invalid hotel name)
 * - non-existent beer (invalid beer name)
 * - beer not available at the specified hotel
 * - invalid price reduction (e.g. making reduced price negative)
 * Use `to_char(price,'$9.99')` to format the prices.
 */

create or replace function happyHourPrice(_hotel text, _beer text, _discount real) returns text
as $$
declare
    _counter integer;
    _std_price real;
    _new_price real;
begin
    -- non-existent hotel (invalid hotel name)
    select count(*) into _counter from Bars where name = _hotel;
    if _counter = 0 then
        return 'There is no hotel called ' || _hotel;
    end if;
    -- non-existent beer (invalid beer name)
    select count(*) into _counter from Beers where name = _beer;
    if _counter = 0 then
        return 'There is no beer called ' || _beer;
    end if;

    select S.price into _std_price
    from Sells as S
    join Bars as BA on S.bar = BA.name
    join Beers as BE on S.beer = BE.name
    where BA.name = _hotel and BE.name = _beer;
    -- beer not available at the specified hotel
    raise notice 'found: %', found;
    if not found then
        return 'apsdfjpodjp hotel no sell beer';
    end if;

    _new_price := _std_price - _discount;
    if _new_price < 0 then
        return 'blah price too low' || _std_price;
    end if;

    return 'Happy hour price for ' || _beer || ' at ' || _hotel || ' is ' || to_char(_new_price,'$9.99');


    -- invalid price reduction (e.g. making reduced price negative)
end
$$ language plpgsql;



/*
 * Q10
 * Implement hotelsIn as a SQL function: a 'parameterised view'
 */

create or replace function hotelsIn(text) returns setof Bars
as 
$$
declare
    i record;
begin
    for i in select * from Bars where addr = $1
    loop
        return next i;
    end loop;
end
$$ language plpgsql;

