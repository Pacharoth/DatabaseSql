-- create database sailor
create database SAILOR;
-- /*2.create table Sailors Boats Reserve
-- Sailors*/
use SAILOR;
create table Sailors(sid int not null,sname varchar(100) not null, 
rating int not null, age int not null, constraint sailors_ID primary key(sid));
-- /*Boats*/
create table Boats(bid int not null, bname varchar(100) not null
, color varchar(100) not null, constraint boats_ID primary key Boats(bid));
-- Reserves
create table Reserves(sid int not null,bid int not null,
constraint sid_bid primary key(sid,bid),
constraint sid_id foreign key(sid) references Sailors(sid),
constraint bid_id foreign key(bid) references Boats(bid),day date);
-- 3.Change the attribute age in Sailors into decimal;
alter table Sailors modify age decimal(3,1) not null;
-- 4.add check constraint rating which rating from 0-10;
alter table Sailors modify rating int not null check( rating >=0 and rating <=10);
alter table Sailors add constraint check_rating check(rating>=0 and rating <=10);
-- 5 insert data to database;
-- insert data into sailors;
insert into Sailors values
(22,'Dustin',7,45.0),
(29,'Brutus',1,33.0),
(31,'Lubber',8,55.5),
(32,'Andy',8,25.5),
(58,'Rusty',10,35.0),
(64,'Horatio',7,35.0),
(71,'Zorba',10,16.0),
(74,'Horatio',9,35.0),
(85,'Art',3,25.5),
(95,'Bob',3,63.5);
-- insert data into boats
insert into Boats values
(101,'Interlake','blue'),
(102,'Interlake','red'),
(103,'Clipper','green'),
(104,'Marine','red');
-- insert data into reserves
insert into Reserves values
(22,101,'98/10/10'),
(22,102,'98/10/10'),
(22,103,'98/8/10'),
(22,104,'98/7/10'),
(31,102,'98/10/11'),
(31,103,'98/6/11'),
(31,104,'98/12/11'),
(64,101,'98/5/9'),
(64,102,'98/8/9'),
(74,103,'98/8/9');


