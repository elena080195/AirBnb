--Average price per night for each neighborhood
SELECT neighbourhood, ROUND(AVG(price),0) AS Average_Price 
FROM airbnb..airbnb_listing
GROUP BY neighbourhood
ORDER BY Average_Price DESC; 

--Listings with the highest number of reviews
SELECT l.name, l.neighbourhood_group, r.number_of_reviews
FROM airbnb..airbnb_listing l
JOIN airbnb_listing_review r ON l.id=r.id
ORDER BY r.number_of_reviews DESC
OFFSET 0 ROWS FETCH FIRST 10 ROWS ONLY; 

--Average number of reviews per month for different room types
SELECT room_type, ROUND(AVG(reviews_per_month), 2) AS Average_Reviews_Monthly
FROM airbnb..airbnb_listing_review r 
JOIN airbnb_listing l ON r.id=l.id
GROUP BY room_type
ORDER BY Average_Reviews_Monthly DESC

--Top 5 most popular neighbourhood groups based on the total number of reviews
SELECT l.neighbourhood_group, SUM(r.number_of_reviews) AS Total_Reviews
FROM airbnb_listing l
JOIN airbnb_listing_review r ON l.id=r.id
GROUP BY l.neighbourhood_group
ORDER BY total_reviews DESC
OFFSET 0 ROWS FETCH FIRST 5 ROWS ONLY;

--Neighbourhoods with the highest average price per night for entire home/apartment
SELECT neighbourhood, ROUND(AVG(price),0) AS Average_Price
FROM airbnb_listing
WHERE room_type = 'Entire home/apt'
GROUP BY neighbourhood
ORDER BY Average_Price DESC
OFFSET 0 ROWS FETCH FIRST 3 ROWS ONLY;

--Top 10 hosts with the most listings
SELECT DISTINCT host_id, host_name, calculated_host_listings_count AS listing_count
FROM airbnb..airbnb_host
ORDER BY calculated_host_listings_count DESC 
OFFSET 0 ROWS FETCH FIRST 10 ROWS ONLY;

--Hosts with the most diverse property listings
SELECT h.host_id, COUNT(DISTINCT(l.room_type)) AS unique_room_type
FROM airbnb_listing l
JOIN airbnb_host h ON l.host_id=h.host_id
GROUP BY h.host_id
ORDER BY unique_room_type DESC
OFFSET 0 ROWS FETCH FIRST 10 ROWS ONLY;

--The percentage of listings in each neighbourhood group compared to the total number of listings
SELECT neighbourhood_group,
       COUNT(*) AS total_listings,
       ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER (),0) AS Percentage_of_total_listings
FROM airbnb_listing
GROUP BY neighbourhood_group
ORDER BY Percentage_of_total_listings DESC;

