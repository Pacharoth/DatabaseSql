use producttest;
-- Write SQL statement for the following questions
-- 1. Find all products ordered by “John Doe”
select p.* from product_t as p
join order_line_t as o
join order_t as od
join customer_t as c
	on(p.ID = o.product_ID
		and od.ID = o.order_ID
		and c.ID = od.customer_ID)
	where
		c.name ='John Doe';				

-- 2. Find customer who has ordered any products ordered by “John Doe”.
select distinct c.* from customer_t as c
left join order_t as od
on c.ID = od.customer_ID
left join order_line_t as o
on od.ID = o.order_ID
left join product_t as p
on p.ID = o.product_ID
	where 
        p.ID in (select p1.ID from product_t as p1
        join order_line_t as o1 on p1.ID=o1.product_ID
        join order_t as od1 on o1.order_ID=od1.ID
        join customer_t as c1 on od1.customer_ID=c1.ID
        where c1.name='John Doe')
        and c.name not in(select name from 
        customer_t where
        name ='John Doe');
-- intialize
-- select p1.ID from product_t as p1
--         join order_line_t as o1 on p1.ID=o1.product_ID
--         join order_t as od1 on o1.order_ID=od1.ID
--         join customer_t as c1 on od1.customer_ID=c1.ID
--         where c1.name='John Doe';				

-- 3. Find customer who has ordered any products finished in “Natural Ash”
select distinct c.* from product_t as p
join order_line_t as o
join order_t as od
join customer_t as c
	on(p.ID = o.product_ID
		and od.ID = o.order_ID
		and c.ID = od.customer_ID)
	where 
		p.finish = any(select finish from product_t
						where finish='Natural Ash')
                        order by c.ID;	
-- 4. Find order that contains more than 2 products.
select od.*from order_t as od
join order_line_t as o on
o.order_ID = od.ID
join product_t as p on
p.ID = o.product_ID
where exists(
select o1.order_ID from
order_line_t as o1 where
o.order_ID = o1.order_ID
and o.product_ID != o1.product_ID)
and 2< any(select count(*) from
order_line_t as o1
where o.order_ID=o1.order_ID)
 group by od.ID;			/* look to order_line_t to which data that has more than 2 product
											if not insert 1 more in any id of order
                                            1. join 3 table order_line_t product_t and order_r by their id
                                            2. check as coleration subquery orderID equal but productID not equal(case)
                                            3.check count of the order_ID row bigger than 2
                                            4. if wanna check it right or not add o.* at select*/

-- insert into order_line_t values(101,1001,1);
-- 5. Find customer who has made more than 1 order.
select distinct c.* from customer_t as c
join order_t as od on
c.ID = od.customer_ID where exists
(select od1.ID from
order_t as od1 where
od1.ID !=od.ID and c.ID =od1.customer_ID );

-- 6. Pair customer and his/her total number of orders.
select c.*,count(od.ID) as total_order from 
customer_t as c 
left join order_t as od on 
c.ID = od.customer_ID group by c.ID;

-- 7. Find the total number of unit of “office chair” sold in April, 2004.
select p.*,sum(o.quantity) as total_unit from product_t as p
join order_line_t as o on
p.ID = o.product_ID 
join order_t as od on
od.ID = o.order_ID
join customer_t as c on
od.customer_ID = c.ID where
p.description in(
select description from product_t
where description = 'office chair') and exists
(select order_ID from order_line_t
where month(order_date)=4 and year(order_date)=2004) 
group by p.ID;

-- 8. Find the total cost of order made by “John Doe”.
select c.*,sum(p.standard_price*o.quantity) as total_cost_order from product_t as p
join order_line_t as o on
p.ID = o.product_ID 
join order_t as od on
od.ID = o.order_ID
join customer_t as c on
od.customer_ID = c.ID  where
c.name in (select name from customer_t
where name ='John Doe') group by c.ID;	

-- 9. Find the average cost of order made by “John Doe”.
select c.*,avg(p.standard_price*o.quantity) as average_cost_order from product_t as p
join order_line_t as o on
p.ID = o.product_ID 
join order_t as od on
od.ID = o.order_ID
join customer_t as c on
od.customer_ID = c.ID where
c.name in (select name from customer_t
where name ='John Doe') group by c.ID;				/*75*1+15*1+40*1=130/3=43.3333 why 1 cus quantity that customer order why divide 3 cus three products
										that he purchase*/ 


-- 10. Find the order that contain all products made from cherry.
select distinct od.* from customer_t as c
join order_t as od
on c.ID = od.customer_ID
join order_line_t as o
on od.ID = o.order_ID
join product_t  as p
on o.product_ID = p.ID where
not exists(select * from product_t
where finish like "%cherry%" and id not in
(select product_ID from order_line_t o
where o.order_ID=od.ID));

-- 11. Find the customer who has ordered all kind of table lamp.
select * from customer_t c
where c.ID in (select customer_ID from order_t od
where not exists(select * from product_t
where description like 'table lamp' and ID not in(
select product_ID from order_line_t where
od.ID = order_id)));
