-- Ćw. 1
    -- 1. Dla każdego zamówienia podaj łączną liczbę zamówionych jednostek towaru oraz
    -- nazwę klienta.

        SELECT o.orderid, quantity,companyname
        from [order details] od inner join orders o
        on od.orderid=o.orderid
        inner join customers c
        on c.customerId=o.customerid

        SELECT  sum(quantity),companyname
        from [order details] od inner join orders o
        on od.orderid=o.orderid
        inner join customers c
        on c.customerId=o.customerid
        group by  o.CustomerID,CompanyName

    -- 2. Zmodyfikuj poprzedni przykład, aby pokazać tylko takie zamówienia, dla których
    -- łączna liczba zamówionych jednostek jest większa niż 250

        SELECT sum(quantity),CompanyName,o.OrderID
        from [order details] od inner join orders o
        on od.orderid=o.orderid
        inner join customers c
        on c.customerId=o.customerid
        group by o.orderid,CompanyName
        Having sum(quantity)>250

        SELECT  sum(quantity) sumQuantity,companyname
        from [order details] od inner join orders o
        on od.orderid=o.orderid
        inner join customers c
        on c.customerId=o.customerid
        group by  o.CustomerID,CompanyName
        Having sum(quantity)>250


    -- 3. Dla każdego zamówienia podaj łączną wartość tego zamówienia oraz nazwę klienta.

        SELECT o.orderid,sum(UnitPrice*Quantity*(1-Discount)) as allCost,  CompanyName
        from [order details] od inner join orders o
        on od.orderid=o.orderid
        inner join customers c
        on c.customerId=o.customerid
        group by o.orderid, CompanyName


    -- 4. Zmodyfikuj poprzedni przykład, aby pokazać tylko takie zamówienia, dla których
    -- łączna liczba jednostek jest większa niż 250.

        SELECT o.orderid,sum(UnitPrice*Quantity*(1-Discount)) as allCost,  CompanyName
        from [order details] od inner join orders o
        on od.orderid=o.orderid
        inner join customers c
        on c.customerId=o.customerid
        group by o.orderid, CompanyName
        Having sum(quantity)>250

    -- 5. Zmodyfikuj poprzedni przykład tak żeby dodać jeszcze imię i nazwisko pracownika
    -- obsługującego zamówienie
    
        SELECT o.orderid,sum(UnitPrice*Quantity*(1-Discount)) as allCost,  CompanyName, FirstName,LastName
        from [order details] od inner join orders o
        on od.orderid=o.orderid
        inner join customers c
        on c.customerId=o.customerid
        inner join Employees e
        on e.EmployeeID=o.EmployeeID
        group by o.orderid, CompanyName, FirstName,LastName
        Having sum(quantity)>250

-- Ćw. 2
    -- 1. Dla każdej kategorii produktu (nazwa), podaj łączną liczbę zamówionych przez
    -- klientów jednostek towarów z tej kategorii.

        SELECT CategoryName, sum(Quantity) quantity_bought
        from categories c left outer join Products p
        on c.CategoryID=p.CategoryID
        INNER join [Order Details] od
        on od.ProductID=p.ProductID
        group by c.categoryId,CategoryName


    -- 2. Dla każdej kategorii produktu (nazwa), podaj łączną wartość zamówionych przez
    -- klientów jednostek towarów z tej kategorii.

        SELECT CategoryName, sum(Quantity*od.UnitPrice*(1-Discount)) 'value'
        from categories c left outer join Products p
        on c.CategoryID=p.CategoryID
        INNER join [Order Details] od
        on od.ProductID=p.ProductID
        group by c.categoryId,CategoryName

    -- 3. Posortuj wyniki w zapytaniu z poprzedniego punktu wg:
    -- a) łącznej wartości zamówień

        SELECT CategoryName, sum(Quantity*od.UnitPrice*(1-Discount)) 'value'
        from categories c left outer join Products p
        on c.CategoryID=p.CategoryID
        INNER join [Order Details] od
        on od.ProductID=p.ProductID
        group by c.categoryId,CategoryName
        ORDER BY sum(Quantity*od.UnitPrice*(1-Discount))

    -- b) łącznej liczby zamówionych przez klientów jednostek towarów.

        SELECT CategoryName, sum(Quantity*od.UnitPrice*(1-Discount)) 'value'
        from categories c left outer join Products p
        on c.CategoryID=p.CategoryID
        INNER join [Order Details] od
        on od.ProductID=p.ProductID
        group by c.categoryId,CategoryName
        ORDER BY sum(Quantity)

    -- 4. Dla każdego zamówienia podaj jego wartość uwzględniając opłatę za przesyłkę

        select o.orderid, sum(Quantity*UnitPrice*(1-Discount))+freight totalValue
        from orders o inner join [order details] od
        on o.orderid=od.orderid
        group by o.orderid,freight

        select freight 
        from Orders
        where orderid=10248

-- Ćw. 3
    -- 1. Dla każdego przewoźnika (nazwa) podaj liczbę zamówień które przewieźli w 1997r
        
        select CompanyName, count(orderid) ordersShipped
        from shippers s LEFT OUTER JOIN orders o
        on o.shipvia=s.ShipperID AND YEAR(ShippedDate)=1997
        GROUP BY shipperId, CompanyName 

    -- 2. Który z przewoźników był najaktywniejszy (przewiózł największą liczbę zamówień) w
    -- 1997r, podaj nazwę tego przewoźnika

        select top 1 CompanyName, count(orderid) ordersShipped
        from shippers s LEFT OUTER JOIN orders o
        on o.shipvia=s.ShipperID AND YEAR(ShippedDate)=1997
        GROUP BY shipperId, CompanyName 
        ORDER BY count(orderid) DESC

    -- 3. Dla każdego pracownika (imię i nazwisko) podaj łączną wartość zamówień
    -- obsłużonych przez tego pracownika

        SELECT FirstName,LastName, sum(orderid) ordersServed
        from employees e left outer join orders o
        on o.EmployeeID=e.EmployeeID
        GROUP BY o.EmployeeID, FirstName,LastName

    -- 4. Który z pracowników obsłużył największą liczbę zamówień w 1997r, podaj imię i
    -- nazwisko takiego pracownika

        SELECT top 1 FirstName,LastName, sum(orderid) ordersServed
        from employees e left outer join orders o
        on o.EmployeeID=e.EmployeeID and year(OrderDate)=1997
        GROUP BY o.EmployeeID, FirstName,LastName
        order by ordersServed DESC

    -- 5. Który z pracowników obsłużył najaktywniejszy (obsłużył zamówienia o największej
    -- wartości) w 1997r, podaj imię i nazwisko takiego pracownika

        SELECT top 1 with ties FirstName,LastName, sum(Quantity*UnitPrice*(1-Discount)) 'value'
        from employees e left outer join orders o
        on o.EmployeeID=e.EmployeeID AND YEAR(OrderDate)=1997
        inner join [Order Details] od
        on od.OrderID=o.OrderID
        group by e.EmployeeID, FirstName,LastName
        order by 'value' DESC

-- Ćw. 4
    -- 1. Dla każdego pracownika (imię i nazwisko) podaj łączną wartość zamówień
    -- obsłużonych przez tego pracownika
    -- ???

        SELECT FirstName,LastName, sum(orderid) ordersServed
        from employees e left outer join orders o
        on o.EmployeeID=e.EmployeeID
        GROUP BY o.EmployeeID, FirstName,LastName

    -- Ogranicz wynik tylko do pracowników
    -- a) którzy mają podwładnych


        SELECT e.EmployeeID,e.FirstName,e.LastName,sum(orderid) ordersServed
        from Employees e left outer join Employees p
        on p.ReportsTo=e.EmployeeID
        left outer join orders o
        on o.EmployeeID=e.EmployeeID
        where p.EmployeeID is not null
        GROUP BY e.EmployeeID, e.FirstName,e.LastName



    -- b) którzy nie mają podwładnych
    
        SELECT e.EmployeeID,e.FirstName,e.LastName,sum(orderid) ordersServed
        from Employees e left outer join Employees p
        on p.ReportsTo=e.EmployeeID
        left outer join orders o
        on o.EmployeeID=e.EmployeeID
        where p.EmployeeID is null
        GROUP BY e.EmployeeID, e.FirstName,e.LastName
    