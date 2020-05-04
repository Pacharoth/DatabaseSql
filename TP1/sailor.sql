create database SAILOR;
-- /*2.create table Sailors Boats Reserve
-- Sailors*/
use SAILOR;

create table Sailors(sid int not null,sname varchar(100) not null, rating int not null, age int not null, constraint sailors_ID primary key(sid));
-- /*Boats*/
create table Boats(bid int not null, bname varchar(100) not null, color varchar(100) not null, constraint boats_ID primary key(bid));
-- Reserves
create table Reserves(sid int not null,bid int not null,constraint sid_id foreign key(sid) references Sailors(sid),constraint foreign key(bid) references Boats(bid),day date);
-- 3.Change the attribute age in Sailors into decimal;
alter table Sailors modify age decimal(3,1) not null;
-- 4.add check constraint rating which rating from 0-10;
alter table Sailors modify rating int not null check( rating >=0 and rating <=10);
alter table Sailors add constraint check_rating check(rating>=0 and rating <=10);
-- 5 insert data to database;
-- insert data into sailors;
insert into Sailors values(22,'Dustin',7,45.0);
insert into Sailors values(29,'Brutus',1,33.0);
insert into Sailors values(31,'Lubber',8,55.5);
insert into Sailors values(32,'Andy',8,25.5);
insert into Sailors values(58,'Rusty',10,35.0);
insert into Sailors values(64,'Horatio',7,35.0);
insert into Sailors values(71,'Zorba',10,16.0);
insert into Sailors values(74,'Horatio',9,35.0);
insert into Sailors values(85,'Art',3,25.5);
insert into Sailors values(95,'Bob',3,63.5);
-- insert data into boats
insert into Boats values(101,'Interlake','blue');
insert into Boats values(102,'Interlake','red');
insert into Boats values(103,'Clipper','green');
insert into Boats values(104,'Marine','red');
-- insert data into reserves
insert into Reserves values(22,101,'98/10/10');
insert into Reserves values(22,102,'98/10/10');
insert into Reserves values(22,103,'98/8/10');
insert into Reserves values(22,104,'98/7/10');
insert into Reserves values(31,102,'98/10/11');
insert into Reserves values(31,103,'98/6/11');
insert into Reserves values(31,104,'98/12/11');
insert into Reserves values(64,101,'98/5/9');
insert into Reserves values(64,102,'98/8/9');
insert into Reserves values(74,103,'98/8/9');


