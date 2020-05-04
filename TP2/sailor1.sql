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




