use SAILOR;
-- 1.insert data and observe data
insert into Sailors values (22,"Dara",8,25);
-- result output
-- ERROR 1062 (23000): Duplicate entry '22' for key 'Sailors.PRIMARY'
insert into Sailors values (null,"Dara",8,25);
-- result OUTPUT
-- ERROR 1048 (23000): Column 'sid' cannot be null
insert into Sailors values ("Dara",22,8,25);
-- result OUTPUT
-- ERROR 1366 (HY000): Incorrect integer value: 'Dara' for column 'sid' at row 1
-- ERROR 1366 (HY000): Incorrect integer value: 'Sok' for column 'sid' at row 1
insert into Sailors values ("Sok",22,7,35);
-- insert into reserves
insert into Reserves values(74,105,"1998-08-09");
-- result OUTPUT
-- ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`SAILOR`.`Reserves`, CONSTRAINT `Reserves_ibfk_1` FOREIGN KEY (`bid`) REFERENCES `Boats` (`bid`))
insert into Reserves values(74,104,"980809");
-- result OUTPUT
-- Query OK, 1 row affected (0.10 sec)

-- exercise 2
-- a.list name sailor rating > 7
SELECT sname from Sailors WHERE rating >7 ;
-- b.list name sailor rating >7 and younger than 50
SELECT sname from Sailors WHERE rating >7 and age <50;
-- c. list info Horitio
SELECT * from Sailors WHERE sname='Horatio';
-- d.list info of sailors whose start with 'A'
SELECT * from Sailors WHERE sname like 'A%';
-- A% is start with letter A
-- we use like operator to search for a specific thing in columns
-- e. List info of sailors whose start with letter A and end with letter Y
SELECT * from Sailors where sname like 'A%Y';
-- result 
-- we got Andy info
-- f. list info of all red boat
SELECT * FROM Boats where color ='red' ;
-- g. List info about boats reservation in October 1998
-- select month(day), year(day) from Reserves;
SELECT * from Reserves where year(day)='1998' and month(day)='10';
-- h. find the names of sailors who have reserved boat 103
SELECT sname from Sailors,Reserves where bid = 103 and Sailors.sid=Reserves.sid;
-- i. find the names of sailors who reserved red boats.
select sname from Reserves,Sailors,Boats where Reserves.sid=Sailors.sid and Reserves.bid = Boats.bid and Boats.color='red' 
union 
select sname from Reserves,Sailors,Boats where Reserves.sid=Sailors.sid and Reserves.bid = Boats.bid and Boats.color='red';
-- k.find the names of sailors who reserved red or green boats.
select sname from Sailors join Reserves on Reserves.sid = Sailors.sid join Boats on Reserves.bid = Boats.bid where Boats.color ='red' 
union 
select sname from Sailors join Reserves on Reserves.sid = Sailors.sid join Boats on Reserves.bid = Boats.bid where Boats.color ='green';
-- l. Find the names of sailors who have reserved a red and a green boat.
select s.sname from Sailors s join Reserves r on r.sid=s.sid join Boats b on b.bid =r.bid where color ='red' and 
s.sid in 
(select s1.sid from Sailors s1 join Reserves r1 on s1.sid=r1.sid join Boats b1 on b1.bid=r1.bid where color='green');
-- m. Find pairs of boats that have the same name.
select b1.bid,b1.bname,b1.color from Boats b1 join Boats b2 on b1.bid !=b2.bid where b1.bname = b2.bname;



