USE Olist
GO

SELECT * FROM marketing_qualified_leads;
SELECT * FROM closed_deals;

--Which origin is the most effective in generating leads?
SELECT origin, COUNT(*) AS num_leads
FROM marketing_qualified_leads
GROUP BY origin
ORDER BY 2 DESC;

--Monthly no. of Leads generated 
SELECT DATEPART(year, first_contact_date) AS year, 
	DATEPART(month, first_contact_date)	AS month, 
	COUNT(*) AS mql_num
FROM marketing_qualified_leads
GROUP BY DATEPART(year, first_contact_date), DATEPART(month, first_contact_date)
ORDER BY 1, 2;

--Conversion rate (percentage of MQLs who finally signed up as sellers (closed deals)) by year and month
SELECT DATEPART(year, mql.first_contact_date) AS year, 
	DATEPART(month, mql.first_contact_date)	AS month, 
	COUNT(mql.mql_id) AS mql_num, 
	COUNT(cd.mql_id) AS closed_deals, 
	CAST(100.0 * COUNT(cd.mql_id) / COUNT(mql.mql_id) AS decimal(5,2)) AS conversion_rate
FROM marketing_qualified_leads AS mql
LEFT JOIN closed_deals AS cd
ON mql.mql_id = cd.mql_id
GROUP BY DATEPART(year, first_contact_date), DATEPART(month, first_contact_date)
ORDER BY 1, 2;

--Duration took for the MQLs to convert and sign up as sellers
WITH yearly_running_total AS (
SELECT DATEPART(year, mql.first_contact_date) AS year, 
	DATEDIFF(day, mql.first_contact_date, cd.won_date) AS daystoconvert, 
	COUNT(*) AS num_seller,
	SUM(COUNT(*)) OVER (
		PARTITION BY DATEPART(year, mql.first_contact_date)
		ORDER BY DATEDIFF(day, mql.first_contact_date, cd.won_date)) AS running_total_seller,
	SUM(COUNT(*)) OVER (
		PARTITION BY DATEPART(year, mql.first_contact_date)) AS total_yearly_seller
FROM marketing_qualified_leads AS mql
JOIN closed_deals AS cd
ON mql.mql_id = cd.mql_id
GROUP BY DATEPART(year, mql.first_contact_date), DATEDIFF(day, mql.first_contact_date, cd.won_date)
)
SELECT year, daystoconvert, num_seller, running_total_seller, total_yearly_seller, 
	CAST (100.0 * running_total_seller / total_yearly_seller AS decimal(5,2)) AS running_percentage
FROM yearly_running_total;

--Closed deals by Lead behaviour profile 
SELECT lead_behaviour_profile, COUNT(*) AS num_closed_deals
FROM closed_deals
GROUP BY lead_behaviour_profile
ORDER BY 2 DESC;

--Top 5 performing and bottom 5 sales representative sr_id in ranking
SELECT TOP 5 RANK() OVER (
	ORDER BY COUNT(*) DESC
	) AS rank,
	sr_id, COUNT(*) AS num_closed_deals
FROM closed_deals
GROUP BY sr_id
ORDER BY 3 DESC;

SELECT TOP 5 RANK() OVER (
	ORDER BY COUNT(*) DESC
	) AS rank,
	sr_id, COUNT(*) AS num_closed_deals
FROM closed_deals
GROUP BY sr_id
ORDER BY 3;

--Top performing sales representative sr_id by the different types of lead behaviour profile (cat, eagle, wolf, shark)
WITH ranking AS (
	SELECT RANK() OVER (
		PARTITION BY lead_behaviour_profile
		ORDER BY COUNT(*) DESC
		) AS rank,
		sr_id, lead_behaviour_profile, COUNT(*) AS num_closed_deals
	FROM closed_deals
	WHERE lead_behaviour_profile IS NOT NULL 
	GROUP BY sr_id, lead_behaviour_profile
)
SELECT rank, sr_id, lead_behaviour_profile, num_closed_deals
FROM ranking
WHERE rank =1

--Business_segment and lead_type
SELECT business_segment, COUNT(*) AS num_closed_deals
FROM closed_deals
GROUP BY business_segment
ORDER BY 2 DESC;

SELECT lead_type, COUNT(*) AS num_closed_deals
FROM closed_deals
GROUP BY lead_type
ORDER BY 2 DESC;





