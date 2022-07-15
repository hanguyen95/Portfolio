drop view if exists product_summary;
use SQLportfolio
go
create view product_summary
as
(
select order_groupby.*, return_groupby.return_number_null,
		Case
			When return_number_null > 0 then return_number_null -- Replace null value by 0
			Else 0
		End
As return_number -- Replace null value by 0
from
	(select sale.ProductKey, sum(sale.OrderQuantity) as order_number from -- Get number of order by productkey
		(select * from sales_2015 union
		select * from sales_2016 union
		select * from sales_2017) as sale
	group by sale.ProductKey) as order_groupby
left join
	(select re.ProductKey, sum(re.ReturnQuantity) as return_number_null -- Get number of return (include null) by product key
	from returns re
	group by re.ProductKey) as return_groupby
on order_groupby.ProductKey = return_groupby.ProductKey
) 

Use SQLportfolio
Select ps.ProductKey, ps.order_number, ps.return_number,
  (ps.return_number / ps.order_number) * 100 as return_rate, -- calculate return_rate
  p.ProductSKU ,p.ProductName, p.ProductPrice, p.ProductCost
From product_summary ps
Join products p
On ps.ProductKey = p.ProductKey
Order by 1 asc