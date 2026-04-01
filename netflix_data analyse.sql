CREATE TABLE netflix (
    show_id VARCHAR(6),
    type VARCHAR(10),
    title varchar(150),
    director varchar(250),
    casts varchar(1000),
    country varchar(150),
    date_added VARCHAR(50),
    release_year INT,
    rating VARCHAR(10),
    duration VARCHAR(20),
    listed_in varchar(100),
    description varchar(250)
);

select * from netflix limit 50;
-- 15 Business Problems

-- 1. Count the number of Movies vs TV Shows

select type,count(type) as total_count from netflix GROUP by type;

-- 2. Find the most common rating for movies and TV shows
select * from (select type,rating,count(rating),rank() over(partition by type order by count(rating) desc)as max_rating from netflix group by type,rating) as t1 where max_rating=1;

-- 3. List all movies released in a specific year (e.g., 2020)
select * from netflix where type='Movie' and release_year=2020;

-- 4. Find the top 5 countries with the most content on Netflix
select unnest(string_to_array(country,','))as countries,count(show_id) from netflix group by country order by count(show_id) desc limit 5;

-- 5. Identify the longest movie or TV show duration
select title,duration from netflix where type='Movie' and duration=(select max(duration)from netflix);

-- 6. Find content added in the last 5 years
select *,to_date(date_added,'Month dd,yyyy') as last_5 from netflix where to_date(date_added,'Month dd,yyyy')>=current_date-interval '5 years';

-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
select title,director from netflix where director like '%Rajiv Chilaka%';

-- 8. List all TV shows with more than 5 seasons
select * from netflix where type='TV Show' and split_part(duration,' ',1)::numeric >5; 

-- 9. Count the number of content items in each genre
select unnest(string_to_array(listed_in,','))as genre,count(show_id) from netflix group by genre;

-- 10. Find each year and the average numbers of content release by India on netflix.
-- return top 5 year with highest avg content release !

select extract(year from to_date(date_added,'Month DD,YYYY'))as years,count(*)::numeric,round(count(*)/(select count(*)from netflix where country='India')::numeric *100,2) as average  from netflix where country='India' group by years order by average desc limit 5;

-- 11. List all movies that are documentaries

select title from netflix where listed_in like '%Documentaries%';
-- 12. Find all content without a director

select * from netflix where director is null;

-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

select title,date_added,release_year from netflix where casts like '%Salman Khan%' and to_date(date_added,'Month DD, YYYY') > current_date - interval '10 years' ;

-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

select unnest(string_to_array(casts,',')) as names,count(*) from netflix where country='India' group by names order by count(*) desc limit 10;

-- 15. Categorize the content based on the presence of the keywords 'kill' and 'violence' in the description field.
-- Label content containing these keywords as 'Bad' and all other content as 'Good'. Count how many items fall into each category.
select case when description ilike '%kill%' or description ilike '%violence%' then 'bad' else 'good' end category,count(*) from netflix group by category;

-- or

with table1 as (
select case when description ilike '%kill%' or description ilike '%violence%' then 'bad' else 'good' end category from netflix
)


select category,count(*) from table1 group by category;




