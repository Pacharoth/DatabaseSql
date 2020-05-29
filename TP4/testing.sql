use producttest;
select * from product_t where
finish ='cherry';

select *,standard_price *0.8 from product_t;

select * from customer_t order by city desc;

select o.* from order_t o
where customer_ID in
(select ID from customer_t where state='CA');