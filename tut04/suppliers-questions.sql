/*
 * Q12
 * Find the names of suppliers who supply some red part.
 */
select S.sname
from   Suppliers as S
join   Catalog as C on S.sid = C.sid
join   Parts as P on C.pid = P.pid
where  P.colour = 'red';

/*
 * Q13
 * Find the sids of suppliers who supply some red or green part.
 */
select C.sid
from   Catalog
join   Parts as P on C.pid = P.pid
where  P.colour = 'red' or P.colour = 'green';

/*
 * Q15
 * Find the sids of suppliers who supply some red part and some green part.
 */
select C.sid
from   Catalog
join   Parts as P on C.pid = P.pid
where  P.colour = 'red'
intersect
select C.sid
from   Catalog
join   Parts as P on C.pid = P.pid
where  P.colour = 'green';

/*
 * Q16
 * Find the sids of suppliers who supply every part.
 */

-- Rephrase: find sids of suppliers for whomst there doesn't exist a part they don't supply
select S.sid
from Suppliers as S
where not exists (
    -- parts that C.sid doesn't supply
    select P.pid from Parts as P
    except
    select C.pid from Catalog as C where C.sid = S.sid
)
