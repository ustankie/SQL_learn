-- Ćwiczenie 1
    -- 1. Podaj liczbę produktów o cenach mniejszych niż 10$ lub większych niż 20$
    
    SELECT COUNT(ProductID)
    FROM Products
    WHERE UnitPrice<10 or UnitPrice>20

    -- 2. Podaj maksymalną cenę produktu dla produktów o cenach poniżej 20$

    SELECT MAX(UnitPrice)
    FROM Products
    WHERE UnitPrice<20

    -- 3. Podaj maksymalną i minimalną i średnią cenę produktu dla produktów o produktach
    -- sprzedawanych w butelkach (‘bottle’)

    SELECT MAX(UnitPrice),MIN(UnitPrice),AVG(UnitPrice)
    FROM Products
    WHERE QuantityPerUnit LIKE '%bottle%'

    -- 4. Wypisz informację o wszystkich produktach o cenie powyżej średniej

    SELECT *
    FROM Products
    WHERE UnitPrice>(SELECT AVG(UnitPrice) FROM Products)

    SELECT AVG(UnitPrice) FROM Products

    -- 5. Podaj sumę/wartość zamówienia o numerze 10250

    SELECT SUM(UnitPrice*Quantity*(1-Discount))
    FROM [Order details]
    WHERE OrderID=10250


-- Ćwiczenie 2
    -- 1. Podaj maksymalną cenę zamawianego produktu dla każdego zamówienia

        SELECT OrderId,MAX(UnitPrice)
        FROM [Order Details]
        Group BY OrderId

    -- 2. Posortuj zamówienia wg maksymalnej ceny produktu

        SELECT OrderId, MAX(UnitPrice) as max
        FROM [Order Details]
        Group BY OrderId
        ORDER By MAX(UnitPrice)

    -- 3. Podaj maksymalną i minimalną cenę zamawianego produktu dla każdego zamówienia

        SELECT OrderID, MAX(UnitPrice) AS max,MIN(UnitPrice) as min
        FROM [Order Details]
        Group BY OrderId

    -- 4. Podaj liczbę zamówień dostarczanych przez poszczególnych spedytorów (przewoźników)

        select shipvia, count(orderID) as orders_shipped
        FROM Orders
        GROUP BY ShipVia

    -- 5. Który z spedytorów był najaktywniejszy w 1997 roku
        
        select TOP 1 shipvia, count(orderID) as orders_shipped
        FROM Orders
        WHERE ShippedDate>='1997-01-01' 
        and ShippedDate<'1998-01-01' 
        GROUP BY ShipVia
        ORDER BY orders_shipped DESC


-- Ćwiczenie 3
    -- 1. Wyświetl zamówienia dla których liczba pozycji zamówienia jest większa niż 5

        SELECT OrderID, COUNT(OrderID) as quantity
        from [Order details]
        group by OrderID
        Having COUNT(OrderID)>5

    -- 2. Wyświetl klientów dla których w 1998 roku zrealizowano więcej niż 8 zamówień (wyniki posortuj malejąco wg
    -- łącznej kwoty za dostarczenie zamówień dla każdego z klientów)

        SELECT CustomerID, count(OrderID) AS order_num
        from Orders
        where YEAR(OrderDate)=1998
        GROUP BY CustomerID
        HAVING count(OrderID)>8 
        Order BY SUM(freight) DESC

SELECT orderid, productid, SUM(quantity) AS total_quantity
FROM [order details]
WHERE orderid < 10250
GROUP BY orderid, productid
ORDER BY orderid, productid

SELECT productid, orderid, SUM(quantity) AS total_quantity
FROM orderhist
GROUP BY productid, orderid
WITH ROLLUP
ORDER BY productid, orderid

SELECT productid, orderid, SUM(quantity) AS total_quantity
FROM orderhist
GROUP BY productid, orderid
WITH CUBE
ORDER BY productid, orderid