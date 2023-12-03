-- Napisz polecenie które podaje listę książek (mumery ISBN) zarezerwowanych przez
-- osobę o nazwisku: Stephen A. Graff
    select distinct r.isbn, m.firstname +' '+ m.middleinitial +'. '+ m.lastname as fullName
    from reservation as r join member as m
    on m.member_no = r.member_no
    where m.firstname = 'Stephen' and m.lastname = 'Graff' and middleinitial = 'A'

--Podaj informacje o karach zapłaconych za przetrzymywanie książki o tytule ‘Tao Teh
-- Kingʼ. Interesuje nas data oddania książki, ile dni była przetrzymywana i jaką
-- zapłacono karę

    select due_date, in_date, -datediff(day, in_date, due_date) "days over", fine_paid
    from loanhist lh join title t on lh.title_no = t.title_no
    where t.title = 'Tao Teh King'
    and datediff(day, in_date, due_date) < 0

--1.Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza library). Interesuje nas imię, nazwisko i data urodzenia dziecka.

    select firstname, lastname, birth_date
    from member m join  juvenile j 
    on m.member_no = j.member_no

 -- Napisz polecenie, które podaje tytuły aktualnie wypożyczonych książek
    