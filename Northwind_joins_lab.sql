-- inner join
select productid, productname, companyname
from products
inner join suppliers
on products.supplierid = suppliers.supplierid

select * 
from Products
where productID=1

SELECT * 
From Suppliers
where SupplierID=1

select distinct companyname
from orders
inner join customers
on orders.customerid = customers.customerid
where orderdate > '1998-03-01'

select companyname, customers.customerid, orderdate
from customers
left outer join orders
on customers.customerid = orders.customerid
where orderid is null

-- Czy są jacyś klienci którzy nie złożyli żadnego zamówienia w 1997 roku, jeśli tak to
-- pokaż ich dane adresowe

    -- -???
    select DISTINCT Address, Customers.CompanyName
    from orders  join Customers
    on orders.CustomerID=customers.CustomerID
    where YEAR(OrderDate)=1997 
    order by Customers.CompanyName

    -- OK, trudne!
    SELECT Customers.CompanyName, Customers.Address
    FROM Customers LEFT OUTER JOIN (
        SELECT CustomerID
        FROM Orders
        WHERE YEAR(OrderDate) = 1997) AS OrderIn1997
        ON Customers.CustomerID = OrderIn1997.CustomerID
    WHERE OrderIn1997.CustomerID IS NULL

-- też OK
    (SELECT c.CompanyName, c.Address, o.OrderDate
    FROM Customers AS c LEFT OUTER JOIN Orders AS o
    ON o.CustomerID = c.CustomerID AND YEAR(o.OrderDate) = 1997
    WHERE OrderID IS NULL)

-- Wybierz nazwy i numery telefonów dostawców, dostarczających produkty, których
-- aktualnie nie ma w magazynie

    select Suppliers.CompanyName, Suppliers.Phone
    from suppliers  JOIN products
    on Suppliers.SupplierID=products.SupplierID
    where UnitsInStock = 0

    