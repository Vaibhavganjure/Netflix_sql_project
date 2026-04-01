# 📊 Netflix Movies and TV Shows Data Analysis using SQL

## 🚀 Project Overview

This project focuses on analyzing Netflix Movies and TV Shows data using SQL.
It includes solving real-world business problems such as content distribution, trends, actor analysis, and classification of content.

---

## 📂 Dataset

The dataset contains information about:

* Show ID
* Type (Movie / TV Show)
* Title
* Director
* Cast
* Country
* Date Added
* Release Year
* Rating
* Duration
* Genre (listed_in)
* Description

---

## 🛠️ Database Schema

```sql
CREATE TABLE netflix (
    show_id VARCHAR(6),
    type VARCHAR(10),
    title VARCHAR(150),
    director VARCHAR(250),
    casts VARCHAR(1000),
    country VARCHAR(150),
    date_added VARCHAR(50),
    release_year INT,
    rating VARCHAR(10),
    duration VARCHAR(20),
    listed_in VARCHAR(100),
    description VARCHAR(250)
);
```

---

## 📌 Key Business Problems Solved

### 1. Count Movies vs TV Shows

```sql
SELECT type, COUNT(*) 
FROM netflix 
GROUP BY type;
```

---

### 2. Most Common Rating by Type

```sql
SELECT * FROM (
    SELECT type, rating, COUNT(*),
           RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) AS rank
    FROM netflix
    GROUP BY type, rating
) t
WHERE rank = 1;
```

---

### 3. Movies Released in 2020

```sql
SELECT * 
FROM netflix 
WHERE type='Movie' AND release_year=2020;
```

---

### 4. Top 5 Countries with Most Content

```sql
SELECT UNNEST(STRING_TO_ARRAY(country, ',')) AS country,
       COUNT(*)
FROM netflix
GROUP BY country
ORDER BY COUNT(*) DESC
LIMIT 5;
```

---

### 5. Longest Movie

```sql
SELECT title, duration 
FROM netflix 
WHERE duration = (SELECT MAX(duration) FROM netflix);
```

---

### 6. Content Added in Last 5 Years

```sql
SELECT *
FROM netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';
```

---

### 7. Content by Director

```sql
SELECT title 
FROM netflix 
WHERE director ILIKE '%Rajiv Chilaka%';
```

---

### 8. TV Shows with More than 5 Seasons

```sql
SELECT *
FROM netflix
WHERE type='TV Show'
  AND SPLIT_PART(duration,' ',1)::INT > 5;
```

---

### 9. Content Count by Genre

```sql
SELECT UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre,
       COUNT(*)
FROM netflix
GROUP BY genre;
```

---

### 10. Avg Content Release by India (Top 5 Years)

```sql
SELECT EXTRACT(YEAR FROM TO_DATE(date_added,'Month DD, YYYY')) AS year,
       COUNT(*) AS total
FROM netflix
WHERE country='India'
GROUP BY year
ORDER BY total DESC
LIMIT 5;
```

---

### 11. Documentary Movies

```sql
SELECT title 
FROM netflix 
WHERE listed_in ILIKE '%Documentaries%';
```

---

### 12. Content Without Director

```sql
SELECT * 
FROM netflix 
WHERE director IS NULL;
```

---

### 13. Movies with Salman Khan (Last 10 Years)

```sql
SELECT *
FROM netflix
WHERE casts ILIKE '%Salman Khan%'
  AND TO_DATE(date_added,'Month DD, YYYY') > CURRENT_DATE - INTERVAL '10 years';
```

---

### 14. Top 10 Actors in Indian Movies

```sql
SELECT UNNEST(STRING_TO_ARRAY(casts, ',')) AS actor,
       COUNT(*) AS total_movies
FROM netflix
WHERE country='India'
GROUP BY actor
ORDER BY total_movies DESC
LIMIT 10;
```

---

### 15. Content Categorization (Bad vs Good)

```sql
SELECT CASE 
        WHEN description ILIKE '%kill%' 
          OR description ILIKE '%violence%' 
        THEN 'Bad'
        ELSE 'Good'
       END AS category,
       COUNT(*)
FROM netflix
GROUP BY category;
```

---

## 🧠 Skills Used

* SQL (PostgreSQL)
* Data Cleaning
* String Functions (`STRING_TO_ARRAY`, `UNNEST`)
* Date Functions (`TO_DATE`, `EXTRACT`)
* Window Functions (`RANK`)
* Conditional Logic (`CASE`)

---

## 📈 Key Learnings

* Handling comma-separated data using `UNNEST`
* Working with real-world messy data
* Writing optimized analytical queries
* Using SQL for business insights

---

## 💡 Future Improvements

* Build dashboard using Power BI / Tableau
* Optimize queries with indexing
* Use Python for advanced analytics

---

## ⭐ If you like this project

Give it a star ⭐ on GitHub and feel free to contribute!

---
