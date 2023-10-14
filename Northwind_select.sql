-- Wybierz nazwy i ceny produktów z kategorii 'Meat/Poultry'
-- v1
SELECT Products.ProductName, Products.UnitPrice
FROM Products INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE Categories.CategoryName = 'Meat/Poultry'

--v2
declare @id int
set @id = (select CategoryID from Categories where CategoryName = 'Meat/Poultry')

select * from Products where CategoryID = @id

--v3
select * from Products where CategoryID = (select CategoryID from Categories where CategoryName = 'Meat/Poultry')
 
 --v4
SELECT Products.ProductName, Products.UnitPrice
FROM Products, Categories
WHERE Categories.CategoryName = 'Meat/Poultry'
and Products.CategoryID = Categories.CategoryID

/*Wyszukaj informacje o stanowisku pracowników, których nazwiska zaczynają się
na literę z zakresu od B do L*/

-- v1
SELECT Title, LastName
FROM Employees
WHERE LastName LIKE '[B-L]%'

-- v2
--żle
SELECT Title, LastName
FROM Employees
WHERE LastName >= 'B' AND LastName <='L'

--dobrze
SELECT Title, LastName
FROM Employees
WHERE LastName >= 'B' AND LastName <'M'


--wybrać nazwy dostawców, którzy nie mają faxu
SELECT companyName, fax
FROM suppliers
WHERE fax IS NULL


SELECT 1 + NULL + 2

SELECT *
FROM Products

-- Napisz instrukcję select tak aby wybrać numer zlecenia, datę zamówienia, numer
-- klienta dla wszystkich niezrealizowanych jeszcze zleceń, dla których krajem
-- odbiorcy jest Argentyna

SELECT OrderID, OrderDate, CustomerID
FROM Orders 
WHERE ShipCountry='Argentina' AND (ShippedDate IS NuLL OR ShippedDate > GETDATE())

SELECT GETDATE()

-- Wybierz informację o produktach (grupa, nazwa, cena), produkty posortuj wg
-- grup a w grupach malejąco wg ceny

SELECT Categories.CategoryName AS Name, Products.ProductName AS Product, Products.UnitPrice Price
FROM Categories, Products
WHERE Categories.CategoryID=Products.CategoryID
ORDER BY Categories.CategoryName, Products.UnitPrice DESC


SELECT CategoryName, 1 AS '1'
FROM Categories


SELECT *, [multiplied price] - UnitPrice diff
FROM (SELECT(ProductName, UnitPrice * 1.05 AS [multiplied price] ) FROM Products)

SELECT firstname,lastname, 'Id number: ' + cast(EmployeeID AS varchar)
FROM Employees

SELECT firstname,lastname, 'Id number: ' + ltrim(str (EmployeeID))
FROM Employees

-- Napisz polecenie które dla każdego dostawcy (supplier) pokaże pojedynczą kolumnę zawierającą nr telefonu i
-- nr faksu w formacie
-- (numer telefonu i faksu mają być oddzielone przecinkiem)

SELECT Suppliers.SupplierID,
       Suppliers.Phone  + IIF(Suppliers.Fax IS NULL, '',','+ Suppliers.Fax)
FROM Suppliers

SELECT Suppliers.SupplierID,
       Suppliers.Phone  + isnull(', '+Suppliers.Fax , '')
FROM Suppliers


SELECT Suppliers.SupplierID,
       concat(Suppliers.Phone,  isnull(', '+Suppliers.Fax , ''))
FROM Suppliers 

-- HOME: library