-- Create the main content table for the streaming platform project
CREATE TABLE bingewatch (
	show_id VARCHAR(6),
	type VARCHAR(10),
	title VARCHAR(200),
	director VARCHAR(250),
	casts VARCHAR(1000),
	country VARCHAR(200),
	date_added VARCHAR(50),
	release_year INT,
	rating VARCHAR(10),
	duration VARCHAR(20),
	listed_in VARCHAR(100),
	description VARCHAR(300)
);

-- View all records in the bingewatch table
SELECT * FROM bingewatch;

-- Get the total number of content entries
SELECT COUNT(*) AS total_content FROM bingewatch;

-- List all distinct content types (e.g., Movie, TV Show)
SELECT DISTINCT type FROM bingewatch;

-- Count the number of Movies and TV Shows
SELECT 
	type, 
	COUNT(*) AS total_content 
FROM bingewatch 
GROUP BY type;

-- Find the most frequent rating for each content type
SELECT
	type,
	rating,
	count
FROM (
	SELECT 
		type,
		rating,
		COUNT(*) AS count,
		RANK() OVER (PARTITION BY type ORDER BY COUNT(*) DESC) AS ranking
	FROM bingewatch
	GROUP BY type, rating
) AS new_table
WHERE ranking = 1;

-- List all movies released in a specific year (e.g., 2021)
SELECT title 
FROM bingewatch 
WHERE type = 'Movie' AND release_year = 2021;

-- Find the top 5 countries producing the most content
SELECT 
	UNNEST(string_to_array(country, ',')) AS country_new, 
	COUNT(show_id) AS total_content 
FROM bingewatch 
GROUP BY country_new 
ORDER BY total_content DESC 
LIMIT 5;

-- List all movies with the longest duration
SELECT * 
FROM bingewatch 
WHERE type = 'Movie' 
	AND duration = (SELECT MAX(duration) FROM bingewatch);

-- Retrieve content added in the last 5 years
SELECT * 
FROM bingewatch 
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';

-- Find all movies or TV shows directed by Don Michael Paul
SELECT title, type 
FROM bingewatch 
WHERE director ILIKE '%Don Michael Paul%';

-- List all TV Shows with more than 5 seasons
SELECT type, duration 
FROM bingewatch 
WHERE type = 'TV Show' AND duration > '5 Seasons' 
ORDER BY duration ASC;

-- Count content items by genre
SELECT 
	UNNEST(string_to_array(listed_in, ',')) AS genre, 
	COUNT(show_id) AS total_content 
FROM bingewatch 
GROUP BY genre;

-- Get the top 5 years in which India released the most content (as a percentage of its total)
SELECT
	EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) AS year,
	COUNT(*) AS content_count,
	ROUND(
		COUNT(*)::NUMERIC / (SELECT COUNT(*) FROM bingewatch WHERE country = 'India')::NUMERIC * 100, 
		2
	) AS average_content_year
FROM bingewatch
WHERE country = 'India'
GROUP BY year
ORDER BY average_content_year DESC
LIMIT 5;

-- List all movies and TV Shows that are categorized as Comedies
SELECT * 
FROM bingewatch 
WHERE listed_in ILIKE '%Comedies%';

-- Find all content without a listed director
SELECT * 
FROM bingewatch 
WHERE director IS NULL;

-- Count the number of appearances by actor 'Vijay Sethupathi' in the last 10 years
SELECT * 
FROM bingewatch 
WHERE casts ILIKE '%Vijay Sethupathi%' 
	AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;

-- Get the top 10 most featured actors in Indian content
SELECT
	TRIM(UNNEST(string_to_array(casts, ','))) AS actors,
	COUNT(*) AS total_content
FROM bingewatch
WHERE country ILIKE '%India%'
GROUP BY actors
ORDER BY total_content DESC
LIMIT 10;

-- Categorize content as 'Bad_Content' if the description contains 'kill' or 'violence'
SELECT *, 
	CASE 
		WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' THEN 'Violent'
		ELSE 'Non-Violent'
	END AS category
FROM bingewatch;
