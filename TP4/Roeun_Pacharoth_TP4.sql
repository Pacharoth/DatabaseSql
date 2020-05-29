-- Write SQL statement for the following questions (sub query and join are recommended)
-- 1. Show id and name of customer along with order id and oder_date of the order they have
-- made.
use producttest;
select distinct c.ID, c.name ,od.ID,od.order_date from customer_t c	
join order_t od on 							
od.customer_ID = c.ID;		/* To show the name id of customer with order id
								1. Look at the connection of table between tables
                                2.Join table by id then we got result*/	
-- 2. Show id and description of product and its quantity in each order.
select distinct p.ID,p.description ,o.quantity from product_t p
inner join order_line_t o on
o.product_ID = p.ID where
o.quantity in (
select o1.quantity from order_line_t o1);	/* To show id description and quantity there are many way
											   1.Look table and join product and orderline 
                                               by join with their id
                                               2.Check quantity in other subquery or we can check where exists
                                               and use coleration subquery . They have same result*/

-- 3. Show id and name of customer along with id and description of product they have
-- ordered.
select c.ID,c.name,p.ID,p.description
from customer_t c
join  order_t od 
join order_line_t o 
join product_t p on( 
o.order_ID = od.ID and
od.customer_ID = c.ID
and o.product_ID = p.ID);		# just join all table condition by their id then select ID name pID
							# description so those connect will show which product that customer order
                            
-- 4.Repeat 1. and include the customers who has never made any order to the result (by using
-- outer join).
select distinct c.ID, c.name ,od.ID,od.order_date from customer_t c
left outer join order_t od on 
od.customer_ID = c.ID;				/* using left outer join to show the name that never order or something
										just intialize it is different from right outer join and the id of the
                                        order they sorted and also show customer which not order too when use left
                                        join. for right outer join same as the join */

-- 5.Show product with the lowest standard price.
select * from product_t p1 where
standard_price < all (
select standard_price from product_t p
where p.ID != p1.ID);					/*for this just do coleration check id if not the same then compare 
										It is like Big O^2 compare how it iterate just for me, but it depend on 
                                        row of table (count as loop)*/

-- 6.Show product with the same name.
select * from product_t p
where description = any(
select description from product_t p1
where p1.ID != p.ID);				/* we can use in or = any the result is the same just check description(name in
										this subject) if equal any in that query which contain different id so
                                        we got the result*/
