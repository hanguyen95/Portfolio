Select
  sum(sale.OrderQuantity * p.ProductPrice) / sum(sale.OrderQuantity) As avg_price,
  sum(sale.OrderQuantity * p.ProductPrice) / count(distinct sale.OrderNumber) As avg_revenue_per_invoice,
  (sum(OrderQuantity * (ProductPrice - productCOst)) / sum(OrderQuantity * ProductPrice))*100 as profit_margin
From 
	(Select * from Sales_2015 union
	Select * from sales_2016 union
	Select * from sales_2017) as sale
join product_summary ps
on ps.ProductKey = sale.productKey
join Products p
on p.productKey = ps.ProductKey