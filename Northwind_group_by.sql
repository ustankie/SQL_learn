SELECT TOP 5 with ties orderid, productid,quantity
from [Order Details]
order by Quantity desc

SELECT COUNT (*)
from Employees

SELECT COUNT (LastName)
from Employees

SELECT COUNT (ReportsTo)
from Employees


SELECT COUNT ('ala')
from Employees

SELECT COUNT (123)
from Employees

select sum(reportsto)
from Employees

-- Ćw 2
    -- 1. Podaj liczbę zamówionych jednostek produktów dla produktów, dla których
    -- productid < 3
    -- 2. Zmodyfikuj zapytanie z poprzedniego punktu, tak aby podawało liczbę
    -- zamówionych jednostek produktu dla wszystkich produktów
    -- 3. Podaj nr zamówienia oraz wartość zamówienia, dla zamówień, dla których
    -- łączna liczba zamawianych jednostek produktów jest > 250

    SELECT COUNT (unit)
    FROM Orders


-- Podaj sumę/wartość zamówienia o numerze 10250
SELECT ROUND(sum (UnitPrice*Quantity*(1-Discount)),2)
From [Order Details]
WHERE OrderID=10250


SELECT CAST(sum (UnitPrice*Quantity*(1-Discount))AS decimal(10,2))
From [Order Details]
WHERE OrderID=10250


-- Wypisz informację o wszystkich produktach o cenie powyżej średniej

declare @mean_ float;
set @mean_ = (SELECT SUM(UnitPrice) From Products)/(SELECT count (*)From Products);

SELECT @mean_

SELECT *
FROM Products
WHERE UnitPrice>@mean_


declare @mean_ float;
set @mean_ = (SELECT AVG (UnitPrice) From Products);

SELECT @mean_

SELECT *
FROM Products
WHERE UnitPrice>@mean_


select cast(0.1 as float) +  cast(0.1 as float) +  cast(0.3 as float)

select 0.1+0.2+0.3


SELECT productid ,SUM(quantity), avg(quantity), count (*) AS total_quantity
FROM orderhist
GROUP BY productid

SELECT productid, SUM(quantity) AS total_quantity
FROM [order details]
GROUP BY ProductID
order by 2

SELECT productid, SUM(quantity) AS total_quantity
FROM [order details]
GROUP BY ProductID
order by total_quantity

SELECT productid, SUM(quantity) AS total_quantity
FROM [order details]
GROUP BY ProductID
order by SUM(quantity)

-- Podaj maksymalną i minimalną cenę zamawianego produktu dla każdego zamówienia



-- Który z spedytorów był najaktywniejszy w 1997 roku
SELECT top 1 Shipvia
FROM orders
WHERE YEAR(OrderDate)=1997
Group by Shipvia
order By count(*) desc


SELECT productid, SUM(quantity)
AS total_quantity
FROM orderhist
GROUP BY productid
HAVING SUM(quantity)>=30 and productid>2


SELECT productid, SUM(quantity)
AS total_quantity
FROM orderhist
WHERE productid>2
GROUP BY productid
HAVING SUM(quantity)>=30

-- Wyświetl zamówienia dla których liczba pozycji zamówienia jest większa niż 5
SELECT OrderID, count(OrderID)
FROM [ORDER Details]
GROUP BY OrderID
HAving count(OrderID)>5

-- Wyświetl klientów dla których w 1998 roku zrealizowano więcej niż 8 zamówień (wyniki posortuj malejąco wg
-- łącznej kwoty za dostarczenie zamówień dla każdego z klientów)

SELECT  CustomerID, COUNT(CustomerID)
FROM Orders
WHERE YEAR (OrderDate)=1998
GROUP By CustomerID
HAVING COUNT(CustomerID)>8
ORDER BY SUM(FREIGHT) desc

    