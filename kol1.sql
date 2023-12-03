-- SELECT CompanyName,
-- from customers c
-- left outer JOIN orders o
-- on o.CustomerID=c.CustomerID
-- join employees e
-- on e.EmployeeID=o.EmployeeID


;with t as(select companyName,firstname,lastname,count(orderId) orders_served
from customers c
left outer JOIN orders o
on o.CustomerID=c.CustomerID
join employees e
on e.EmployeeID=o.EmployeeID
where year(orderdate)=1997
group by CompanyName,e.employeeid,FirstName,LastName)

select * from t


-- zad 1)
-- Dla każdego klienta podaj imię i nazwisko pracownika, który w 1997r obsłużył
-- najwięcej jego zamówień, podaj także liczbę tych zamówień (jeśli jest kilku takich
-- pracownikow to wystarczy podać imię nazwisko jednego nich). Za datę obsłużenia
-- zamówienia należy przyjąć orderdate. Zbiór wynikowy powinien zawierać nazwę
-- klienta, imię i nazwisko pracownika oraz liczbę obsłużonych zamówień. (baza
-- northwind)


;with t as(select distinct cu.CustomerID, firstname,lastname,(select top 1 count(orderId)
    from orders o
    where year(orderdate)=1997 
    and cu.customerid=o.CustomerID
    group by customerid,employeeid
    order by count(orderId) desc
   ) as orders_served
from Customers cu
left outer join orders ord
on ord.CustomerID=cu.CustomerID
join Employees e
on e.EmployeeID=ord.EmployeeID
and e.EmployeeID in (select top 1 EmployeeID
    from orders orr
    where year(orderdate)=1997 and cu.customerid=orr.CustomerID
    group by customerid,employeeid
    order by count(orderId) desc
   ) 
)

select c.CompanyName,t.FirstName,t.LastName,t.orders_served
from t 
right outer join customers c
on c.CustomerID=t.CustomerID
order by c.CompanyName



select * from orders where CustomerID='LACOR'
 
select e.Firstname, count, c.CompanyName from (select top 1 o.EmployeeID, count(*) as count, o.CustomerID from Orders o where year(o.OrderDate)=1997
and o.customerId=c.CustomerId group by o.Employeeid, o.CustomerID order by count desc) as stat, Employees e, Customers c where
e.employeeId=stat.EmployeeID 
;

select top 1 o.EmployeeID, count(*) as count, o.CustomerID from Orders o where year(o.OrderDate)=1997
and o.customerId='ANTON' group by o.Employeeid, o.CustomerID;

select e.Firstname, c.CustomerId, 








select distinct cu.CompanyName, firstname,lastname,(select top 1 count(orderId)
    from orders o
    where year(orderdate)=1997 
    and cu.customerid=o.CustomerID
    -- and e.EmployeeID=o.EmployeeID
    group by customerid,employeeid
    order by count(orderId) desc
   ) as orders_served
from Customers cu
left outer join orders ord
on ord.CustomerID=cu.CustomerID
join Employees e
on e.EmployeeID=ord.EmployeeID
where  cu.CustomerID not in (select  CustomerID
    from orders orrr
    where year(orderdate)=1997 and cu.customerid=orrr.CustomerID
   ) 
order by CompanyName

-- zad 2)
-- Podaj liczbę̨ zamówień oraz wartość zamówień (uwzględnij opłatę za przesyłkę)
-- obsłużonych przez każdego pracownika w lutym 1997. Za datę obsłużenia
-- zamówienia należy uznać datę jego złożenia (orderdate). Jeśli pracownik nie
-- obsłużył w tym okresie żadnego zamówienia, to też powinien pojawić się na liście
-- (liczba obsłużonych zamówień oraz ich wartość jest w takim przypadku równa 0).
-- Zbiór wynikowy powinien zawierać: imię i nazwisko pracownika, liczbę obsłużonych
-- zamówień, wartość obsłużonych zamówień. (baza northwind)

select firstName,LastName,count(o.OrderID) num_of_orders,sum(freight+Quantity*(1-Discount)*UnitPrice) price
from employees e
left outer JOIN orders o
on o.EmployeeID=e.EmployeeID and month(orderdate)=2 and year(orderdate)=1997
left outer join [Order Details] ord
on ord.OrderID=o.OrderID
group by FirstName,LastName,e.EmployeeID

select * from Orders where EmployeeID=2

-- zad 3)
-- Podaj listę dzieci będących członkami biblioteki, które w dniu '2001-12-14'
-- zwróciły do biblioteki książkę o tytule 'Walking'. Zbiór wynikowy powinien zawierać
-- imię i nazwisko oraz dane adresowe dziecka. (baza library)

select j.member_no,m.firstname,m.lastname,street,city,state,zip,title
from juvenile j
join loanhist l 
on l.member_no=j.member_no and in_date>='2001-12-14' and in_date<'2001-12-15'
join title t
on t.title_no=l.title_no and title='Walking'
join member m
on m.member_no=j.adult_member_no
join adult a
on a.member_no=j.adult_member_no


select in_date,member_no
from loanhist l
join title t 
on t.title_no=l.title_no
where title='Walking' and in_date>='2001-12-14' and in_date<'2001-12-15'


select member_no
from juvenile
where member_no=3706

-- zad 1)
-- Podaj liczbę̨ zamówień oraz wartość zamówień (bez opłaty za przesyłkę)
-- obsłużonych przez każdego pracownika w marcu 1997. Za datę obsłużenia
-- zamówienia należy uznać datę jego złożenia (orderdate). Jeśli pracownik nie
-- obsłużył w tym okresie żadnego zamówienia, to też powinien pojawić się na liście
-- (liczba obsłużonych zamówień oraz ich wartość jest w takim przypadku równa 0).
-- Zbiór wynikowy powinien zawierać: imię i nazwisko pracownika, liczbę obsłużonych
-- zamówień, wartość obsłużonych zamówień, oraz datę najpóźniejszego zamówienia
-- (w badanym okresie). (baza northwind)


select e.EmployeeID, FirstName,lastname,count(orderid) served,(
    select top 1 orderdate
    from Orders ord
    where ord.EmployeeID=e.EmployeeID and Year(OrderDate)=1997 and month(orderdate)=2
    order by orderdate desc

)
from Employees e
left outer join orders o
on o.employeeid=e.employeeid and Year(OrderDate)=1997 and month(orderdate)=2
group by e.EmployeeID,FirstName,LastName

select * from orders where EmployeeID=9 and Year(OrderDate)=1997 and month(orderdate)=2

-- pt godz 15.00
-- zad 1)
-- Dla każdego produktu z kategorii 'confections' podaj wartość przychodu za ten
-- produkt w marcu 1997 (wartość sprzedaży tego produktu bez opłaty za przesyłkę).
-- Jeśli dany produkt (należący do kategorii 'confections') nie był sprzedawany w tym
-- okresie to też powinien pojawić się na liście (wartość sprzedaży w takim przypadku
-- jest równa 0) (baza northwind)

;with t as(
    select sum(ord.UnitPrice*(1-Discount)*Quantity) summ,p.ProductID
    from Categories c 
    join Products p
    on p.CategoryID=c.CategoryID and c.CategoryName='Confections'
    left outer join [Order Details] ord
    on ord.ProductID=p.ProductID
    join orders o
    on o.OrderID=ord.OrderID and year(OrderDate)=1997 and month(orderdate)=3
    group by p.ProductID,ProductName
)

SELECT p.ProductID,p.ProductName,summ
from Categories c 
join Products p
on p.CategoryID=c.CategoryID and c.CategoryName='Confections'
left outer join t
on t.ProductID=p.ProductID 


SELECT p.ProductID,ProductName
from Categories c 
join Products p
on p.CategoryID=c.CategoryID and c.CategoryName='Confections'


-- zad 3)
-- Dla każdego przewoźnika podaj nazwę produktu z kategorii 'Seafood', który ten
-- przewoźnik przewoził najczęściej w kwietniu 1997. Podaj też informację ile razy
-- dany przewoźnik przewoził ten produkt w tym okresie (jeśli takich produktów jest
-- więcej to wystarczy podać nazwę jednego z nich). Zbiór wynikowy powinien
-- zawierać nazwę przewoźnika, nazwę produktu oraz informację ile razy dany produkt
-- był przewożony (baza northwind)

select sh.ShipperID,p.productId,(select top 1 count(*) from Orders o
join [Order Details] ord on o.OrderID=ord.OrderID
join Products p
on p.ProductID=ord.ProductID 
join Categories c on c.CategoryID=p.CategoryID and c.CategoryName='Seafood'
where year(orderdate)=1997 and month(orderdate)=4 and o.shipvia=sh.shipperid
group by p.ProductID,shipvia,ProductName
order by count(*) desc) as cnt
from Shippers sh 
join orders o
on o.shipvia=sh.ShipperID
join [Order Details] ord 
on ord.OrderID=o.OrderID
join products p
on p.ProductID=ord.ProductID
join Categories c
on c.CategoryID=p.ProductID
where p.ProductID in (select top 1 p.ProductID from Orders oo
    join [Order Details] ord on oo.OrderID=ord.OrderID
    join Products p
    on p.ProductID=ord.ProductID 
    join Categories c on c.CategoryID=p.CategoryID and c.CategoryName='Seafood'
    where year(orderdate)=1997 and month(orderdate)=4 and oo.shipvia=sh.shipperid
    group by p.ProductID,shipvia,ProductName
    order by count(*) desc)


select * from Products
where categoryid=8

select shipvia, p.productid,productname,count(*) from Orders o
join [Order Details] ord on o.OrderID=ord.OrderID
join Products p
on p.ProductID=ord.ProductID 
join Categories c on c.CategoryID=p.CategoryID and c.CategoryName='Seafood'
where year(orderdate)=1997 and month(orderdate)=4
group by p.ProductID,shipvia,ProductName

select *
from products
where categoryid=8