-- Write SQL statement for the following question

-- 1. List all customers' name and city
use producttest;
select name, city from customer_t;

-- 2.List the information of customer from 'CA'(state).
select * from customer_t
	where
		state ='CA';

-- 3.List ID,description and standard price of product made from 'ash'
select ID,description,standard_price from product_t
	where
		finish like '%ash';
        
-- 4.List the information of product that is made from 'ash' and costs
-- between 15 and 80
select * from product_t
where 
finish like '%ash' and standard_price >15
and standard_price < 80;

-- 5.Show all products and sort the result by stand price
-- from cheapest to the most expensive
select * from product_t 
where standard_price order by standard_price ASC;

-- 6. Show the cross product between customer and order
select * from customer_t,order_t;

-- 7. Show information of customer who made order on 2004-04-01
select distinct customer_t.* from customer_t,order_t
where
order_date = '2004-04-01';

-- 8.Show information of products in the order number 106
select p.* from product_t as p
join order_line_t as o on
o.product_ID = p.ID
where
o.order_ID = 106;

-- 9.Show the information of customer who has made order number 106
select distinct c.* from customer_t c
inner join order_t od on
od.customer_ID=c.ID
join order_line_t o on
o.order_ID = od.ID
where o.order_ID = 106;

-- 10. Show the order which contains book self
select od.* from order_t od
join order_line_t o on 
o.order_ID = od.ID
inner join product_t p on
o.product_ID=p.ID
where p.description = 'book shelf';
-- 11. show the order which contains table lamp
select od.* from order_t od
join order_line_t o on 
o.order_ID = od.ID
inner join product_t p on
o.product_ID=p.ID
where 
p.description='table lamp';

-- 12. Show the order which contain book shelf or table lamp;
select distinct od.* from order_t od
join order_line_t o on 
o.order_ID = od.ID
inner join product_t p on
o.product_ID=p.ID
where 
p.description = 'book shelf' or p.description='table lamp';

-- 12.Show the order which book shelf and table lamp
select od.* from order_t od
join order_line_t o on 
o.order_ID = od.ID
inner join product_t p on
o.product_ID=p.ID
where 
p.description = 'book shelf'
and od.ID in
(select od.ID from order_t od
join order_line_t o on 
o.order_ID = od.ID
inner join product_t p on
o.product_ID=p.ID
where 
p.description = 'table lamp' );

--  13.Show the order which book shelf and table lamp
select od.* from order_t od
join order_line_t o on 
o.order_ID = od.ID
inner join product_t p on
o.product_ID=p.ID
where 
p.description = 'book shelf'
and od.ID not in
(select od.ID from order_t od
join order_line_t o on 
o.order_ID = od.ID
inner join product_t p on
o.product_ID=p.ID
where 
p.description = 'table lamp' );
