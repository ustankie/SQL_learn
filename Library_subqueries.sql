-- Ćw. 3
    -- 1. Dla każdego dorosłego członka biblioteki podaj jego imię, nazwisko oraz liczbę jego
    -- dzieci.

        ;with t as( 
            select a.member_no, count(j.member_no) children_no
            from adult as a 
            join juvenile j
            on a.member_no=adult_member_no
            group by a.member_no
        )
        select m.member_no,firstname,lastname, children_no
        from member m
        join t
        on t.member_no=m.member_no
        order by children_no

        select * from adult

        -- assuming that adults that do not have children should be also displayed:
        ;with t as( 
            select a.member_no, count(j.member_no) children_no
            from adult as a 
            left outer join juvenile j
            on a.member_no=adult_member_no
            group by a.member_no
        )
        select m.member_no,firstname,lastname, children_no
        from member m
        join t
        on t.member_no=m.member_no
        order by children_no

    -- 2. Dla każdego dorosłego członka biblioteki podaj jego imię, nazwisko, liczbę jego dzieci,
    -- liczbę zarezerwowanych książek oraz liczbę wypożyczonych książek. 
    -- !!!! klucze!!!
    
    -- only those who have children, reservations and loans
        ;with t as( 
            select a.member_no, count(j.member_no) children_no
            from adult as a 
            left outer join juvenile j
            on a.member_no=adult_member_no
            group by a.member_no
        ), 
        reservations as(
            select member_no,count(isbn) reserved
            from reservation
            group by member_no
        ),
        loans as(
            select member_no, count(isbn) loaned
            from loan
            group by member_no
        )
        select m.member_no,firstname,lastname, children_no, loaned,reserved
        from member m
        join t
        on t.member_no=m.member_no
        join loans l
        on l.member_no=m.member_no
         join  reservations r
        on r.member_no=l.member_no
        order by children_no

    --only those having children

        ;with t as( 
            select a.member_no, count(j.member_no) children_no
            from adult as a 
            left outer join juvenile j
            on a.member_no=adult_member_no
            group by a.member_no
        ), 
        reservations as(
            select member_no,count(isbn) reserved
            from reservation
            group by member_no
        ),
        loans as(
            select member_no, count(isbn) loaned
            from loan
            group by member_no
        )
        select m.member_no,firstname,lastname, children_no, loaned,reserved
        from member m
        join t
        on t.member_no=m.member_no
        left outer join loans l
        on l.member_no=m.member_no
        left outer join  reservations r
        on r.member_no=l.member_no
        where children_no>0
        order by children_no

    --all 

        ;with t as( 
            select a.member_no, count(j.member_no) children_no
            from adult as a 
            left outer join juvenile j
            on a.member_no=adult_member_no
            group by a.member_no
        ), 
        reservations as(
            select member_no,count(isbn) reserved
            from reservation
            group by member_no
        ),
        loans as(
            select member_no, count(isbn) loaned
            from loan
            group by member_no
        )
        select m.member_no,firstname,lastname, children_no, loaned,reserved
        from member m
        join t
        on t.member_no=m.member_no
        left outer join loans l
        on l.member_no=m.member_no
        left outer join  reservations r
        on r.member_no=l.member_no
        order by children_no


    -- 3. Dla każdego dorosłego członka biblioteki podaj jego imię, nazwisko, liczbę jego dzieci,
    -- oraz liczbę książek zarezerwowanych i wypożyczonych przez niego i jego dzieci.
    -- !!!!difficult!!!!

        --only those having children

        ;with t as( 
            select a.member_no, count(j.member_no) children_no
            from adult as a 
            left outer join juvenile j
            on a.member_no=adult_member_no
            group by a.member_no
        ), 
        reservations as(
            select member_no,count(isbn) reserved
            from reservation
            group by member_no
        ),
        loans as(
            select member_no, count(isbn) loaned
            from loan
            group by member_no
        ),
        children_loans as(
            select j.adult_member_no, count(isbn) ch_loaned
            from loan l
            join member m
            on m.member_no=l.member_no
            join juvenile j
            on j.member_no=m.member_no
            group by j.adult_member_no

        ),
        children_reservations as(
            select j.adult_member_no, count(isbn) ch_reserved
            from reservation r
            join member m
            on m.member_no=r.member_no
            join juvenile j
            on j.member_no=m.member_no
            group by j.adult_member_no

        )

        select m.member_no,firstname,lastname, children_no, loaned,reserved,ch_loaned,ch_reserved
        from adult a
        join member m
        on m.member_no=a.member_no
        join t
        on t.member_no=m.member_no
        left outer join loans l
        on l.member_no=m.member_no
        left outer join  reservations r
        on r.member_no=l.member_no
        left outer join children_loans chl
        on chl.adult_member_no=a.member_no
        left outer join children_reservations chr
        on chr.adult_member_no=a.member_no
        where children_no>0
        -- order by children_no

        --all adults

        ;with children_num as( 
            select a.member_no, count(j.member_no) children_no
            from adult as a 
            left outer join juvenile j
            on a.member_no=adult_member_no
            group by a.member_no
        ), 
        reservations as(
            select member_no,count(isbn) reserved
            from reservation
            group by member_no
        ),
        loans as(
            select member_no, count(isbn) loaned
            from loan
            group by member_no
        ),
        children_loans as(
            select j.adult_member_no, count(isbn) ch_loaned
            from loan l
            join member m
            on m.member_no=l.member_no
            join juvenile j
            on j.member_no=m.member_no
            group by j.adult_member_no

        ),
        children_reservations as(
            select j.adult_member_no, count(isbn) ch_reserved
            from reservation r
            join member m
            on m.member_no=r.member_no
            join juvenile j
            on j.member_no=m.member_no
            group by j.adult_member_no

        )

        select m.member_no,firstname,lastname, children_no, loaned,reserved,ch_loaned,ch_reserved
        from adult a
        join member m
        on m.member_no=a.member_no
        left outer join children_num t
        on t.member_no=m.member_no
        left outer join loans l
        on l.member_no=m.member_no
        left outer join  reservations r
        on r.member_no=l.member_no
        left outer join children_loans chl
        on chl.adult_member_no=a.member_no
        left outer join children_reservations chr
        on chr.adult_member_no=a.member_no
        order by children_no


        
    -- 4. Dla każdego tytułu książki podaj ile razy ten tytuł był wypożyczany w 2001r
    --tylko loanhist czy loan też?

        select t.title_no,t.title, count(lid) loan_num
        from (select (isbn+ copy_no+out_date) as lid,title_no
                    from loanhist l
                    where year(out_date)=2001
                    ) lh
        right outer join title t
        on t.title_no=lh.title_no
        group by t.title_no,t.title

        select * from loanhist
        where title_no=1 and year(out_date)=2001

        --assuming that I should use data from both loanhist and loans

        ;with t1 as(
            select t.title_no,t.title, count(lid) loan_num1
            from (select (isbn+ copy_no+out_date) as lid,title_no
                        from loanhist l
                        where year(out_date)=2001
                        ) lh
            right outer join title t
            on t.title_no=lh.title_no
            group by t.title_no,t.title
        ),
        t2 as(
            select t.title_no,t.title, count(lid2) loan_num2
            from title t
            left outer join
            (select (isbn+ copy_no) as lid2,title_no
            from loan l
            where year(out_date)=2001 ) l2
            on t.title_no=l2.title_no
            group by t.title_no,t.title
        )

        select t1.title_no,t1.title,loan_num1+loan_num2 all_loans
        from t1 
        join t2
        on t1.title_no=t2.title_no
        

    -- 5. Dla każdego tytułu książki podaj ile razy ten tytuł był wypożyczany w 2002r

        select t.title_no,t.title, count(lid) loan_num
        from (select (isbn+ copy_no+out_date) as lid,title_no
                    from loanhist l
                    where year(out_date)=2002
                    ) lh
        right outer join title t
        on t.title_no=lh.title_no
        group by t.title_no,t.title

        select * from loanhist
        where title_no=1 and year(out_date)=2002

        --assuming that I should use data from both loanhist and loans

        ;with t1 as(
            select t.title_no,t.title, count(lid) loan_num1
            from (select (isbn+ copy_no+out_date) as lid,title_no
                        from loanhist l
                        where year(out_date)=2002
                        ) lh
            right outer join title t
            on t.title_no=lh.title_no
            group by t.title_no,t.title
        ),
        t2 as(
            select t.title_no,t.title, count(lid2) loan_num2
            from title t
            left outer join
            (select (isbn+ copy_no) as lid2,title_no
            from loan l
            where year(out_date)=2002 ) l2
            on t.title_no=l2.title_no
            group by t.title_no,t.title
        )

        select t1.title_no,t1.title,loan_num1+loan_num2 all_loans
        from t1 
        join t2
        on t1.title_no=t2.title_no

        