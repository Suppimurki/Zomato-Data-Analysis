USE zomato_analytics;

-- Q.1 Find the Numbers of Resturants based on City and Country.
SELECT 
CountryCode,
City,
COUNT(*) AS Number_of_Restaurants
FROM zomato
GROUP BY CountryCode, City
ORDER BY CountryCode, City;
-------------------------------------------------------------------------------------------------------------------

-- Q.2 Numbers of Resturants opening based on Year , Quarter , Month.
SELECT
YEAR(open_date) AS Year,
QUARTER(open_date) AS Quarter,
MONTH(open_date) AS Month,
COUNT(*) AS Number_of_Restaurants
FROM (
SELECT STR_TO_DATE(Datekey_Opening, '%Y_%m_%d') AS open_date
FROM zomato
) t
GROUP BY Year, Quarter, Month
ORDER BY Year, Quarter, Month;
-------------------------------------------------------------------------------------------------------------------------------

-- Q.3 Count of Resturants based on Average Ratings.
SELECT
Rating,
COUNT(*) AS Number_of_Restaurants
FROM zomato
GROUP BY Rating
ORDER BY Rating;
---------------------------------------------------------------------------------------------------------------------------------------------

-- Q.4 Create buckets based on Average Price of reasonable size and find out how many resturants falls in each buckets.
SELECT
CASE
	WHEN Average_Cost_for_two < 200 THEN 'Below 200'
	WHEN Average_Cost_for_two BETWEEN 200 AND 399 THEN '200 – 399'
	WHEN Average_Cost_for_two BETWEEN 400 AND 599 THEN '400 – 599'
	WHEN Average_Cost_for_two BETWEEN 600 AND 999 THEN '600 – 999'
	ELSE '1000 & Above'
END AS Price_Bucket,
COUNT(*) AS Number_of_Restaurants
FROM zomato
WHERE Average_Cost_for_two IS NOT NULL
GROUP BY Price_Bucket
ORDER BY Price_Bucket;
----------------------------------------------------------------------------------------------------------------------------------------------------

-- Q.5 Percentage of Resturants based on "Has_Table_booking".
SELECT
Has_Table_booking,
COUNT(*) AS Number_of_Restaurants,
ROUND(
	COUNT(*) * 100.0 / (SELECT COUNT(*) FROM zomato),
	2
) AS Percentage_of_Restaurants
FROM zomato
GROUP BY Has_Table_booking;
----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q.6 Percentage of Resturants based on "Has_Online_delivery".
SELECT
Has_Online_delivery,
COUNT(*) AS Number_of_Restaurants,
ROUND(
	COUNT(*) * 100.0 / (SELECT COUNT(*) FROM zomato),
	2
) AS Percentage_of_Restaurants
FROM zomato
GROUP BY Has_Online_delivery;

