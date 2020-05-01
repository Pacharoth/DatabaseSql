-- a.list name sailor rating > 7
SELECT sname from Sailors WHERE rating >7 ;
-- b.list name sailor rating >7 and younger than 50
SELECT sname from Sailors WHERE rating >7 and age <50;
-- c. list info Horitio
SELECT * from Sailors WHERE sname='Horatio';
-- d.list info of sailors whose start with 'A'
SELECT * from Sailors WHERE sname='A';