-- Ćw. 1
    -- 1. Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej pomiędzy
    -- 20.00 a 30.00, dla każdego produktu podaj dane adresowe dostawcy

        SELECT ProductName,Address,UnitPrice
        FROM Suppliers s INNER JOIN Products p
        ON S.SupplierID=p.SupplierID
        WHERE UnitPrice BETWEEN 20.00 AND 30.00

    -- 2. Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów dostarczanych
    -- przez firmę ‘Tokyo Tradersʼ

        SELECT ProductName, Discontinued,CompanyName
        FROM Products p Inner join Suppliers s
        ON p.SupplierID=s.SupplierID
        WHERE CompanyName='Tokyo Traders'

    -- 3. Czy są jacyś klienci którzy nie złożyli żadnego zamówienia w 1997 roku, jeśli tak to
    -- pokaż ich dane adresowe

        SELECT Address
        FROM Customers c LEFT OUTER JOIN (
            SELECT CustomerID
            FROM Orders
            WHERE YEAR(OrderDate)=1997
            
        )AS o
        ON o.CustomerID=c.CustomerID
        WHERE o.customerId is null

        SELECT c.Address, o.OrderDate
        FROM customers c LEFT OUTER JOIN orders o
        ON c.CustomerID=o.CustomerID AND YEAR(o.OrderDate)=1997
        WHERE o.CustomerID is null


    -- 4. Wybierz nazwy i numery telefonów dostawców, dostarczających produkty, których
    -- aktualnie nie ma w magazynie

        SELECT CompanyName,Phone
        FROM Suppliers s INNER JOIN Products p
        ON s.SupplierID=p.SupplierID AND UnitsInStock=0

select s.CompanyName,sh.CompanyName
from suppliers s cross JOIN shippers sh

-- Napisz polecenie zwracające listę produktów zamawianych w dniu 1996-07-08

    select distinct ProductName
    from products p inner join [Order Details] od
    on p.ProductID=od.ProductID
    INNER JOIN orders o
    on o.OrderID=od.OrderID
    where OrderDate='1996-07-08'

-- Ćw. 3
    -- 1. Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej pomiędzy
    -- 20.00 a 30.00, dla każdego produktu podaj dane adresowe dostawcy, interesują nas
    -- tylko produkty z kategorii ‘Meat/Poultryʼ

        select ProductName, UnitPrice, CategoryName
        from Products p inner join suppliers s
        on p.SupplierID=s.SupplierID
        INNER JOIN Categories c
        on c.CategoryID=p.CategoryID
        where CategoryName='Meat/Poultry' and UnitPrice BETWEEN 20.00 and 30.00

    -- 2. Wybierz nazwy i ceny produktów z kategorii ‘Confectionsʼ dla każdego produktu podaj
    -- nazwę dostawcy.

        select ProductName,UnitPrice,CompanyName,CategoryName
        from Products p inner join suppliers s
        on p.SupplierID=s.SupplierID
        INNER JOIN Categories c
        on c.CategoryID=p.CategoryID
        where CategoryName='Confections'

    -- 3. Wybierz nazwy i numery telefonów klientów , którym w 1997 roku przesyłki
    -- dostarczała firma ‘United Packageʼ

        SELECT distinct c.CompanyName, c.Phone --, s.CompanyName,ShippedDate
        from customers c inner join orders o
        on c.CustomerID=o.CustomerID
        INNER JOIN Shippers s
        on s.ShipperID=o.ShipVia
        where s.CompanyName='United Package' and YEAR(ShippedDate)=1997

    -- 4. Wybierz nazwy i numery telefonów klientów, którzy kupowali produkty z kategorii
    -- ‘Confectionsʼ

        select  distinct c.CompanyName,c.Phone,CategoryName
        from customers c inner join orders o
        on c.CustomerID=o.CustomerID
        inner join [Order Details] od
        on od.OrderID=o.OrderID
        inner join Products p
        on p.ProductID=od.ProductID
        inner join Categories ca
        on ca.CategoryID=p.CategoryID
        WHERE CategoryName='Confections'

        select CustomerID
        from Orders
        where orderID=10255

        select orderID, ProductID
        from [Order details]
        where productID=16

        select categoryName, categoryID
        from categories

        select productid, CategoryID
        from products
        where categoryID=3
        
        select CompanyName,CustomerID
        from Customers
        where CustomerID='RICSU'

-- Napisz polecenie, które pokazuje pary pracowników zajmujących to samo stanowisko.

    SELECT a.EmployeeID,a.firstname + ' '+ a.lastname as 'fullName 1', a.title, b.EmployeeID, b.firstname + ' '+ b.lastname as 'fullName 2'
    from employees a inner join employees b
    on a.title=b.title
    where a.EmployeeID<b.EmployeeID
-- Ćw. 4
    -- 1. Napisz polecenie, które wyświetla pracowników oraz ich podwładnych (baza
    -- northwind)

        SELECT e.EmployeeID, e.LastName 'pracownik', p.EmployeeID, p.LastName podwładny
        from Employees e full outer JOIN Employees p
        on p.ReportsTo=e.EmployeeID

    -- 2. Napisz polecenie, które wyświetla pracowników, którzy nie mają podwładnych (baza
    -- northwind)

        SELECT e.EmployeeID, e.LastName 'pracownik', p.EmployeeID, p.LastName podwładny
        from Employees e left outer JOIN Employees p
        on p.ReportsTo=e.EmployeeID
        where p.EmployeeID is null

        select reportsto, * from Employees

select firstname + ' ' + lastname as name,city, postalcode
from employees
union
select companyname, city, postalcode
from customers

select country from customers
intersect
select country from suppliers

-- klienci którzy złożyli zamówienia w 1997 r. a nie złożyli zamówień w roku poprzednim

    select o.customerid,companyname
    from customers c inner join orders o
    on o.customerId=c.customerid
    where year(orderdate)=1997
    except
    select o.customerId,companyname
    from customers c inner join orders o
    on o.customerId=c.customerid
    where year(orderdate)=1996

    select customerid from orders where year(orderdate) = 1997
    except
    select customerid from orders where year(orderdate) = 1996