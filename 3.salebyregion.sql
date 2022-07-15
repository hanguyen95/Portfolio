-- sales by region
use SQLportfolio
select 
from 
	(select * from sales_2015 union
	select * from sales_2016 union
	select * from sales_2017) as sale
	group by TerritoryKey as region_groupby
join territories te
on sale.TerritoryKey = te.SalesTerritoryKey
join products pro
on sale.ProductKey = pro.ProductKey
group by sale.territoryKey