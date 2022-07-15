-- top 10 products with the highest return rate

select top 10 returns.ProductKey, products.ProductName, sum(returns.ReturnQuantity) as return_number
from returns
join products
on returns.ProductKey = products.ProductKey
group by returns.ProductKey, products.ProductName
order by 3 desc
