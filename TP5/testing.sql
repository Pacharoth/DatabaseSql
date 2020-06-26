use producttest;
select * from product_t;
SELECT *,
if(standard_price<100, "Regular", "Luxurious") AS Classification
FROM product_t
order by standard_price;

