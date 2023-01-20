# How-to-extract-a-specific-row-s-in-a-dataset

Window function ROW_NUMBER () and OVER ()

How to retrieve a specific row/s in a dataset. 

For example, to get the highest or lowest, one canuse either MAX() or MIN(), but what if you are interested in retrieving the 2nd or 3rd highest profit
or sales in a dataset? To retrieve the specific rows, we used ROW_NUMBER() to set a column consisting of row numbers;
at the same time, we applied the OVER() function for partitioning the dataset by name of countries, and order by the highest profits. 

To retrieve the second row number, the second-highest profits in our dataset, we use a WITH clause to temporarily save the query result and then use
Select statement to extract our desired result.
