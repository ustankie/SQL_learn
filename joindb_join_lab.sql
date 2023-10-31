select * from buyers
select * from sales
select * from produce

select buyer_name, s.buyer_id, prod_id, qty
from buyers as b, sales as s
where b.buyer_id = s.buyer_id


select buyer_name, sales.buyer_id, prod_id, qty
from buyers inner join sales
on buyers.buyer_id = sales.buyer_id

