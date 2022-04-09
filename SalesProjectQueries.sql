-- Inspect Datasets
SELECT *
FROM SalesProject..sales

SELECT *
FROM SalesProject..returns

SELECT
	*
FROM
	SalesProject..sales FULL OUTER JOIN SalesProject..returns
	ON sales.[Order ID] = returns.[Order ID]

	
-- Purchasing activity by product category
WITH results AS(
	SELECT
		[Product Category],
		SUM([Quantity]) AS quantity,
		SUM([Sales]) AS total_sales,
		SUM([Profit]) AS total_profit,
		SUM(CASE WHEN [Returns] = 'yes' THEN 1 ELSE 0 END) AS return_count
	FROM
		SalesProject..sales FULL OUTER JOIN SalesProject..returns
		ON sales.[Order ID] = returns.[Order ID]
	GROUP BY [Product Category]
)
SELECT *
FROM results


-- Purchasing activity by segment
WITH results AS(
	SELECT
		[Segment],
		[Product Category],
		SUM([Quantity]) AS quantity,
		SUM([Sales]) AS total_sales
	FROM
		SalesProject..sales FULL OUTER JOIN SalesProject..returns
		ON sales.[Order ID] = returns.[Order ID]
	GROUP BY [Segment], [Product Category]
)
SELECT *
FROM results