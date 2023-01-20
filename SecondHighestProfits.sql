/****** Script for SelectTopNRows command from SSMS  ******/
/**Window function ROW_NUMBER () and OVER ()
How to extract a specific row/s in a dataset. For example, to get the highest or lowest, one can 
use either MAX () or MIN (), but what if you are interested in retrieving the 2nd or 3rd highest profit
or sales in a dataset? To retrieve the specific rows, we used ROW_NUMBER () to set a column consisting of numbers of rows; 
at the same time, we applied the OVER () function for partitioning the dataset order by the highest profits. To extract the 
second row, the second-highest profits in our dataset, we use a WITH clause to temporarily save the query result and then use 
the select statement to extract our desired result.**/
with highest_profits as (

SELECT 
	  st.Name as Country
	  ,case soh.OnlineOrderFlag
	  when 1 then 'Online'
	  when 0 then 'Reseller'
	  end as SalesChannels
	  ,soh.OrderDate
	  ,sum(CAST(sod.[UnitPrice] - pp.[StandardCost] as decimal(18,2))) as [Total Profit]
	  ,ROW_NUMBER() over(partition by st.Name 
						order by sum(CAST(sod.[UnitPrice] - pp.[StandardCost] as decimal(18,2))) desc) as RowNumber
  FROM [AdventureWorks2012].[Sales].[SalesOrderDetail] sod
  left join [Sales].[SalesOrderHeader] soh
  on sod.SalesOrderID = soh.SalesOrderID
  left join [Sales].[SalesTerritory] st
  on soh.TerritoryID = st.TerritoryID
  inner join [Production].[Product] pp
  on sod.ProductID = pp.ProductID

  where OnlineOrderFlag = 1
 
  group by st.Name, OnlineOrderFlag, OrderDate

 )
  select * from highest_profits
  where RowNumber = 2

