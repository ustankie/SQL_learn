-- Ćwiczenie 1
    -- 1. Napisz polecenie, które oblicza wartość sprzedaży dla każdego zamówienia
    -- w tablicy order details i zwraca wynik posortowany w malejącej kolejności
    -- (wg wartości sprzedaży).

    SELECT orderID, Quantity*UnitPrice*(1-Discount) AS [sale value]
    FROM [Order Details]
    ORDER BY Quantity*UnitPrice*(1-Discount) DESC

    -- 2. Zmodyfikuj zapytanie z poprzedniego punktu, tak aby zwracało pierwszych
    -- 10 wierszy

    SELECT TOP 10 with ties orderID, Quantity*UnitPrice*(1-Discount) AS [sale value]
    FROM [Order Details]
    ORDER BY Quantity*UnitPrice*(1-Discount) DESC


-- Ćwiczenie 2
    -- 1.Podaj liczbę zamówionych jednostek produktów dla produktów, dla których
    -- productid < 3
    SELECT SUM(Quantity)
    FROM [Order details]
    WHERE ProductID<3

    SELECT SUM(Quantity)
    FROM [Order details]
    WHERE ProductID<3
    GROUP BY ProductID
    
    SELECT SUM(Quantity)
    FROM [Order details]
    GROUP BY ProductID
    HAVING ProductID<3

    -- 2. Zmodyfikuj zapytanie z poprzedniego punktu, tak aby podawało liczbę
    -- zamówionych jednostek produktu dla wszystkich produktów
    SELECT SUM(Quantity)
    FROM [Order details]


    SELECT SUM(Quantity)
    FROM [Order details]
    GROUP BY ProductID

    -- 3. Podaj nr zamówienia oraz wartość zamówienia, dla zamówień, dla których
    -- łączna liczba zamawianych jednostek produktów jest > 250

    SELECT orderId, SUM(UnitPrice*Quantity*(1-Discount)) AS order_value
    FROM [Order details]
    GROUP BY orderID
    Having SUM(UnitPrice*Quantity*(1-Discount))>250



-- Ćwiczenie 3
    -- 1. Dla każdego pracownika podaj liczbę obsługiwanych przez niego zamówień


    SELECT EmployeeID,count(orderID) AS orders_quantity
    FROM Orders
    GROUP BY EmployeeID

    SELECT Employees.EmployeeID,count(orders.orderID) AS orders_quantity
    FROM Orders,Employees
    WHERE orders.EmployeeID=employees.EmployeeID
    GROUP BY Employees.EmployeeID

    -- 2. Dla każdego spedytora/przewoźnika podaj wartość "opłata za przesyłkę"
    -- przewożonych przez niego zamówień

    SELECT ShipVIA,sum(freight)
    From Orders
    GROUP By Shipvia

    SELECT ShipVIA,freight
    From Orders
    order By Shipvia

    SELECT Shippers.ShipperID,sum(orders.freight)
    From Shippers,Orders
    Where Shippers.ShipperID=orders.shipvia
    GROUP By Shippers.ShipperID


    SELECT Shippers.ShipperID,orders.freight
    From Shippers,Orders
    Where Shippers.ShipperID=orders.shipvia
    ORDER BY Shippers.ShipperID


    -- 3. Dla każdego spedytora/przewoźnika podaj wartość "opłata za przesyłkę"
    -- przewożonych przez niego zamówień w latach o 1996 do 1997
    SELECT Shippers.ShipperID,orders.freight
    From Shippers,Orders
    Where Shippers.ShipperID=orders.shipvia
    and orders.shippedDate>='1996-01-01' 
    and orders.shippedDate<'1998-01-01' 
    ORDER BY Shippers.ShipperID

    SELECT Shippers.ShipperID,sum(orders.freight)
    From Shippers,Orders
    Where Shippers.ShipperID=orders.shipvia
    and orders.shippedDate>='1996-01-01' 
    and orders.shippedDate<'1998-01-01' 
    GROUP By Shippers.ShipperID
    ORDER BY Shippers.ShipperID


-- Ćwiczenie 4
    -- 1. Dla każdego pracownika podaj liczbę obsługiwanych przez niego zamówień z
    -- podziałem na lata i miesiące

    SELECT employeeid, YEAR(OrderDate) AS year,MONTH(OrderDate) as month, COUNT(OrderID) as quantity
    FROM Orders
    GROUP BY  EmployeeID,YEAR(OrderDate),MONTH(OrderDate) 
    ORDER By EmployeeID,YEAR(OrderDate),MONTH(OrderDate) 

    SELECT Employees.employeeid, YEAR(OrderDate) AS year,MONTH(OrderDate) as month, COUNT(OrderID) as quantity
    FROM Orders,Employees
    WHERE Orders.EmployeeID=Employees.EmployeeID
    GROUP BY  employees.EmployeeID,YEAR(OrderDate),MONTH(OrderDate) 
    ORDER By employees.EmployeeID,YEAR(OrderDate),MONTH(OrderDate) 

    -- 2. Dla każdej kategorii podaj maksymalną i minimalną cenę produktu w tej
    -- kategorii

    SELECT CategoryID, MAX(UnitPrice) AS max, MIN(UnitPrice) as min
    FROM Products
    GROUP BY CategoryID

    SELECT Categories.CategoryID, MAX(UnitPrice) AS max, MIN(UnitPrice) as min
    FROM Categories,Products
    WHERE Categories.CategoryID=Products.CategoryID
    GROUP BY Categories.CategoryID


