create view order_table
as
select sale.TerritoryKey, sale.ProductKey, sum(sale.OrderQuantity) as order_number from -- Get number of order by productkey
		(select * from sales_2015 union
		select * from sales_2016 union
		select * from sales_2017) as sale
	group by sale.TerritoryKey, sale.ProductKey


create view return_table
as
select re.TerritoryKey, re.ProductKey, sum(returnquantity) as return_number_null
	from Returns re
	group by re.TerritoryKey, re.ProductKey

select order_table.TerritoryKey ,order_table.ProductKey, order_number, return_number_null, return_number_null*100/order_number as ROR
from order_table, return_table
where order_table.TerritoryKey = return_table.TerritoryKey and order_table.ProductKey = return_table.ProductKey

Use SQLportfolio
go
select *, return_number *100 / order_number
from return_summary_product



select *, return_number *100 / order_number
from return_summary_country
order by 5 asc




-----right result by left join
create view return_table
as
(
select order_groupby.* ,  return_groupby.return_number_null,
		Case
			When return_number_null > 0 then return_number_null -- Replace null value by 0
			Else 0
		End
As return_number -- Replace null value by 0
from
	(select te.SalesTerritoryKey, sale.ProductKey, sum(sale.OrderQuantity) as order_number from -- Get number of order by productkey
		(select * from sales_2015 union
		select * from sales_2016 union
		select * from sales_2017) as sale
	left join Territories te
	on te.SalesTerritoryKey = sale.TerritoryKey
	group by te.SalesTerritoryKey, sale.ProductKey) as order_groupby
left join
	(select re.TerritoryKey, re.ProductKey, sum(re.ReturnQuantity) as return_number_null -- Get number of return (include null) by product key
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

