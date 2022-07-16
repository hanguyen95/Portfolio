use SQLportfolio
go

create view return_table
as
(
select order_groupby.* ,  return_groupby.return_number_null,
		Case
			When return_number_null > 0 then return_number_null -- Replace null value by 0
			Else 0
		End
As return_number
from
	(select te.SalesTerritoryKey, sale.ProductKey, sum(sale.OrderQuantity) as order_number from -- Get number of order
		(select * from sales_2015 union
		select * from sales_2016 union
		select * from sales_2017) as sale
	left join Territories te
	on te.SalesTerritoryKey = sale.TerritoryKey
	group by te.SalesTerritoryKey, sale.ProductKey) as order_groupby
left join
	(select re.TerritoryKey, re.ProductKey, sum(re.ReturnQuantity) as return_number_null -- Get number of return (include null)
	from returns re
	group by re.TerritoryKey, re.productKey) as return_groupby
on order_groupby.SalesTerritoryKey = return_groupby.TerritoryKey and order_groupby.ProductKey=return_groupby.ProductKey  
) 

select * from return_table

select salesterritoryKey, sum(return_number)*100/sum(order_number) as ROR
from return_table
group by salesterritoryKey
order by 2 asc

select productkey, sum(return_number)*100/sum(order_number) as ROR
from return_table
group by productkey
order by 2 desc

