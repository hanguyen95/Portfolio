-- top 10 products with the highest sale

select top 10 sale.ProductKey, products.ProductName, sum(sale.OrderQuantity) as order_number
from
	(select * from Sales_2015
	union
	select * from Sales_2016
	union
	select * from Sales_2017)
	as sale
join Products
on sale.ProductKey = Products.ProductKey
group by sale.ProductKey, products.ProductName
order by 3 desc

