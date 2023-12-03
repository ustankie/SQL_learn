select buyer_name, qty
from buyers cross join sales

-- to samo:

select buyer_name, qty
from buyers, sales

select buyer_name, qty
from buyers join sales
on 1=1

-- w starej wersji nie da się określić rodzaju złączenia (tylko inner join)
-- inner join przemienny

-- Napisz polecenie zwracające listę produktów niezamawianych w dniu 1996-07-08
-- źle
select distinct productname
from orders as O
inner join [order details] as OD
on O.orderid = OD.orderid
inner join products as P
on OD.productid = P.productid
where orderdate != '1996-07-08'



    -- 3. Wybierz nazwy i numery telefonów klientów , którym w 1997 roku przesyłek nie
    -- dostarczała firma ‘United Packageʼ
-- źle

        SELECT distinct c.CompanyName, c.Phone , s.CompanyName,ShippedDate
        from customers c inner join orders o
        on c.CustomerID=o.CustomerID
        INNER JOIN Shippers s
        on s.ShipperID=o.ShipVia
        where s.CompanyName='United Package' and YEAR(ShippedDate)=1997

        select * from
        (SELECT c.customerid as abc , c.CompanyName, c.Phone , s.CompanyName,ShippedDate
        from customers c inner join orders o
        on c.CustomerID=o.CustomerID
        INNER JOIN Shippers s
        on s.ShipperID=o.ShipVia and YEAR(ShippedDate)=1997
        where s.CompanyName='United Package')
        where CustomerID is null

    
    -- 4. Wybierz nazwy i numery telefonów klientów, którzy nie kupowali produkty z kategorii
    -- ‘Confectionsʼ

-- źle

        select  distinct c.CompanyName,c.Phone,CategoryName
        from customers c inner join orders o
        on c.CustomerID=o.CustomerID
        inner join [Order Details] od
        on od.OrderID=o.OrderID
        inner join Products p
        on p.ProductID=od.ProductID
        inner join Categories ca
        on ca.CategoryID=p.CategoryID
        WHERE CategoryName!='Confections'

-- Napisz polecenie, które pokazuje pary pracowników zajmujących to samo stanowisko.

    select a.employeeid, a.lastname as name
    , a.title as title
    , b.employeeid, b.lastname as name
    , b.title as title
    from employees as a
    inner join employees as b
    on a.title =b.title
    where a.employeeid < b.employeeid

    select * from Employees


    select ba.buyer_name as buyer1, p.prod_name ,bb.buyer_name as buyer2
    from sales as a
    join sales as b
    on a.prod_id = b.prod_id
    join buyers ba
    on ba.buyer_id=a.buyer_id
    join buyers bb
    on bb.buyer_id=b.buyer_id
    join produce p
    on p.prod_id=a.prod_id
    where a.buyer_id < b.buyer_id

    -- 1. Napisz polecenie, które wyświetla pracowników, którzy mają podwładnych  (baza
    -- northwind)

        SELECT distinct e.EmployeeID, e.LastName 'pracownik'
        from Employees e inner JOIN Employees p
        on p.ReportsTo=e.EmployeeID


        select firstname + ' ' + lastname as name,city, postalcode,'prac'
        from employees
        union
        select companyname, city, postalcode,'cust'
        from customers
    
        select 1
        union select 1

        --union - problem kiedy dwóch pracowników (eliminacja duplikatów), którzy się tak samo nazywają 
        -- -> union all (efektywniejszy - bierze zbiór i dokleja drugi)
    
        select 1
        union all select 1

        select country from customers
        intersect
        select country from suppliers