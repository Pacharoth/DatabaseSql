use classicmodels;

-- 1.Show first name and last name of customer from France.
select contactFirstName as firstName,contactLastName as lastName
from customers as c where
c.country = "France";

-- 2.Show the first name and last name of employee who is a sale manager.
select firstName, lastName from employees 
where jobTitle like '%sale% manager%';
-- 3.Show all product which is in “classic car” product line.
select * from products where productLine like "%classic car%";
-- 4.Show all products containing “Toyota” in its name.
select * from products where productName like '%Toyota%';
-- 5.Show all products with the scale smaller than 1:24.
select * from products where productScale >'1:24';
-- 6.Show all products from the vendor “Autoart Studio Design”.
select * from products where productVendor = 'Autoart Studio Design';
-- 7.Show all products with MSRP (the manufacturer’s suggested retail price) higher than
-- twice the cost of buyPrice.
select * from products where MSRP > 2*buyPrice;
-- 8. Show information of sale representative of the customer “Land of toys Inc.”
select e.* from customers c join employees e 
on c.salesRepEmployeeNumber = e.employeeNumber
where customerName like "%Land of toys Inc%";
-- 9. Show information about order that is shipped later than the required date.
select * from orders where requiredDate < shippedDate;

-- 10. Show all orders made by “La Rochelle Gifts”.
select orders.* from customers natural join orders 
where customerName = 'La Rochelle Gifts';

-- 11. Show all products ordered by “La Rochelle Gifts”.
select products.* from customers natural join orders
natural join orderdetails natural join products
where customerName = 'La Rochelle Gifts';

-- 12. Show customer’s name who has ordered more than 15 products in once.
select customerName from customers where 
customerNumber in (select customerNumber from orders
natural join orderdetails group by orderNumber having 15<count(productCode));

-- 13. Show the best-selling product in “2004-02”.
create view dateFebruary as
select * from orderdetails natural join
orders 
where year(orderDate) = 2004 and month(orderDate) = 2;

create view summationProduct as
select productCode, sum(quantityOrdered) as totalProduct from dateFebruary
group by productCode;
select products.* from products natural join 
summationProduct where totalProduct in
(select max(totalProduct) from summationProduct);

