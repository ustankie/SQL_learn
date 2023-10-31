-- Ćw. 2
    -- 1. Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza
    -- library). Interesuje nas imię, nazwisko i data urodzenia dziecka.

        select firstname,lastname,birth_date
        from member m inner join juvenile j
        on m.member_no=j.member_no

    -- 2. Napisz polecenie, które podaje tytuły aktualnie wypożyczonych książek

        SELECT distinct title
        FROM title t INNER JOIN loan l
        ON t.title_no=l.title_no


    -- 3. Podaj informacje o karach zapłaconych za przetrzymywanie książki o tytule ‘Tao Teh
    -- Kingʼ. Interesuje nas data oddania książki, ile dni była przetrzymywana i jaką
    -- zapłacono karę

        SELECT title, fine_paid,in_date, DATEDIFF(day,in_date,due_date) as kept
        FROM loanhist l INNER JOIN title t
        ON t.title_no=l.title_no AND title='Tao Teh King' AND fine_paid is not null

    -- 4. Napisz polecenie które podaje listę książek (mumery ISBN) zarezerwowanych przez
    -- osobę o nazwisku: Stephen A. Graff

        SELECT isbn, firstname + ' '+middleinitial+ ' '+lastname as fullName
        FROM reservation r JOIN member m
        ON m.member_no=r.member_no
        WHERE firstname='Stephen' and middleinitial='A' and lastname='Graff'

-- Ćw.3
    -- 5. Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza
    -- library). Interesuje nas imię, nazwisko, data urodzenia dziecka i adres zamieszkania
    -- dziecka.

        SELECT firstname + ' '+middleinitial+' '+lastname as fullName, j.birth_date, street+' '+city+' '+a.state+' '+zip as 'Address'
        from juvenile j inner JOIN member m
        on m.member_no=j.member_no
        inner join adult a
        on a.member_no=j.adult_member_no


    -- 6. Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza
    -- library). Interesuje nas imię, nazwisko, data urodzenia dziecka, adres zamieszkania
    -- dziecka oraz imię i nazwisko rodzica.

        SELECT m.firstname + ' '+m.middleinitial+' '+m.lastname as fullNameChild, 
            j.birth_date, street+' '+city+' '+a.state+' '+zip as 'Address',
            m2.firstname + ' '+m2.middleinitial+' '+m2.lastname as fullNameParent
        from juvenile j inner JOIN member m
        on m.member_no=j.member_no
        inner join adult a
        on a.member_no=j.adult_member_no
        inner join member m2
        on m2.member_no=a.member_no

        select *
        from member inner join juvenile
        on member.member_no=juvenile.member_no
        where firstname='Angela' and lastname='Anderson'

        select member_no,adult_member_no
        from juvenile
        where member_no=2

        select *
        from member 
        where member_no=1

-- Ćw. 4
    -- 1. Napisz polecenie, które wyświetla adresy członków biblioteki, którzy mają dzieci
    -- urodzone przed 1 stycznia 1996 (baza library)
    -- ????

        SELECT  j.birth_date, street+' '+city+' '+a.state+' '+zip as 'Address'
        FROM juvenile j inner join adult a
        on a.member_no=j.adult_member_no
        where j.birth_date<'1996-01-01'
        order by j.birth_date desc

    -- 2. Napisz polecenie, które wyświetla adresy członków biblioteki, którzy mają dzieci
    -- urodzone przed 1 stycznia 1996. Interesują nas tylko adresy takich członków
    -- biblioteki, którzy aktualnie nie przetrzymują książek. (baza library)
    -- ???

        SELECT  j.birth_date, street+' '+city+' '+a.state+' '+zip as 'Address', l.member_no, a.member_no
        FROM juvenile j inner join adult a
        on a.member_no=j.adult_member_no and j.birth_date<'1996-01-01' 
        left outer join loan l 
        on l.member_no=a.member_no 
        where l.member_no is null
        order by j.birth_date desc
    
-- Ćw. 5
    -- 1. Podaj listę członków biblioteki mieszkających w Arizonie (AZ), którzy mają więcej niż dwoje
    -- dzieci zapisanych do biblioteki

        select a.member_no,count(j.member_no) as children_no, a.state
        from juvenile j inner join adult a
        on a.member_no=j.adult_member_no and a.state='AZ'
        group by a.member_no, a.state
        having count(j.member_no)>2
        order by count(j.member_no) 

        select a.member_no, a.state
        from juvenile j inner join adult a
        on a.member_no=j.adult_member_no and a.state='AZ'


    -- 2. Podaj listę członków biblioteki mieszkających w Arizonie (AZ) którzy mają więcej niż
    -- dwoje dzieci zapisanych do biblioteki oraz takich którzy mieszkają w Kaliforni (CA) i
    -- mają więcej niż troje dzieci zapisanych do biblioteki

        select a.member_no,count(j.member_no) as children_no, a.state
        from juvenile j inner join adult a
        on a.member_no=j.adult_member_no and a.state='AZ'
        group by a.member_no, a.state
        having count(j.member_no)>2
        UNION
        select a.member_no,count(j.member_no) as children_no, a.state
        from juvenile j inner join adult a
        on a.member_no=j.adult_member_no and a.state='CA'
        group by a.member_no, a.state
        having count(j.member_no)>3
        order by count(j.member_no) 