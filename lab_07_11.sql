--Subqueries

select t.orderid,t.customerid
from (select orderid,customerid from orders) as t

select productname, unitprice
, (select avg(unitprice) from products) as average
, unitprice - (select avg(unitprice) from products) as diff
from products
where UnitPrice>(select avg(UnitPrice) from Products)
--(where diff>0 źle)


select *,unitprice-average as diff
from (select productname,unitprice ,(select avg(UnitPrice) from Products) as average
from products) as t
where UnitPrice>average


select *, unitprice-average from 
(select productname, categoryid, unitprice
,( select avg(unitprice)
    from products as p_in
    where p_in.categoryid = p_out.categoryid ) as average
from products as p_out) t
where UnitPrice>average

;with t as (
    select productname, categoryid, unitprice
    ,( select avg(unitprice)
    from products as p_in
    where p_in.categoryid = p_out.categoryid ) as average
    from products as p_out
),
t1 as(
    select *, UnitPrice - average as diff from t
    where UnitPrice>average
)
select * from t1

