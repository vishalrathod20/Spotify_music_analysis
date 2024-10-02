-- Advanced SQL Project -- Spotify Data sets

-- create table

CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

-- EDA 
SELECT COUNT(*) FROM spotify;

SELECT COUNT(DISTINCT artist) FROM spotify;

SELECT DISTINCT album_type FROM spotify;

SELECT MAX(duration_min) FROM spotify;

SELECT MIN(duration_min) FROM spotify;

SELECT * FROM spotify
WHERE duration_min = 0;

DELETE FROM spotify
WHERE duration_min = 0;
SELECT * FROM spotify
WHERE duration_min = 0;

SELECT DISTINCT channel FROM spotify;

SELECT DISTINCT most_played_on FROM spotify;

----------------------------------------|
--- Data Analysis -Easy Category        |
----------------------------------------|

--1). Find all tracks that have over 1 billion streams.
--2). List all the albums and their artists.
--3). Get the total number of comments for tracks that are licensed.
--4). Identify all tracks that are part of albums classified as singles.
--5). Count how many tracks each artist has in total.

--------------------------------------------------------------------------------------------------------------------

--1). Find all tracks that have over 1 billion streams.
-- Solution :-
SELECT * FROM spotify
WHERE stream > 1000000000;
			   
--2). List all the albums and their artists.
-- solution:-
SELECT DISTINCT album,artist FROM spotify;

--3). Get the total number of comments for tracks that are licensed.
-- solution :-
SELECT sum(comments) as total_comments FROM spotify
where licensed = 'true';

--4). Identify all tracks that are part of albums classified as singles.
-- solution :-
SELECT * FROM spotify
WHERE album_type LIKE 'single';

--5). Count how many tracks each artist has in total.
-- Solution :-
SELECT artist,
       count(track) as total_no_songs
FROM spotify
GROUP BY artist
ORDER BY 2 desc;

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

-----------------------------------------------------------+
-- Medium level                                            |
-----------------------------------------------------------+
-- 1)How can I compute the average danceability for all tracks in each album within a dataset?
-- 2)What approach should I take to identify the top five tracks with the highest energy values?
-- 3)How can I filter and list all tracks where official_video = TRUE, displaying their views and likes?
-- 4)What method would allow me to calculate the total views for all tracks within each album?
-- 5)How can I retrieve the names of tracks that have more streams on Spotify than on YouTube?

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

-- 1)How can I compute the average danceability for all tracks in each album within a dataset?
-- solution :-
SELECT
    album,
    AVG(danceability) AS avg_danceability
FROM spotify
GROUP BY 1
ORDER BY 2 DESC;

-- 2)What approach should I take to identify the top five tracks with the highest energy values?
-- solution :-
SELECT
    track,
    MAX(energy)
FROM spotify
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;


--  3)How can I filter and list all tracks where official_video = TRUE, displaying their views and likes?
-- solution:-
SELECT track, views, likes
FROM spotify
WHERE official_video = TRUE;


-- 4)What method would allow me to calculate the total views for all tracks within each album?
-- solution :-
SELECT
    album,
    track,
    SUM(views)
FROM spotify
GROUP BY 1,2
ORDER BY 3 DESC;

-- 5)How can I retrieve the names of tracks that have more streams on Spotify than on YouTube?
-- solution :-
SELECT * FROM
(
    SELECT
        track,
        COALESCE(SUM(CASE WHEN most_played_on = 'Youtube' THEN stream END),0) AS streamed_on_youtube,
        COALESCE(SUM(CASE WHEN most_played_on = 'Spotify' THEN stream END),0) AS streamed_on_spotify
FROM spotify
GROUP BY 1
) AS t1
WHERE
    streamed_on_spotify > streamed_on_youtube
    AND
    streamed_on_youtube <> 0

------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------+
-- Advance level                                           |
-----------------------------------------------------------+
-- 1.Write a query using window functions to find the top 3 most-viewed tracks for each artist.
-- 2.Write a query to find tracks where the liveness score is higher than the average liveness score.
-- 3.Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
-- 4.Write a query to find tracks where the energy-to-liveness ratio is greater than 1.2.
-- 5.Calculate the cumulative sum of likes for tracks, ordered by the number of views, using window functions.

------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

--1.Write a query using window functions to find the top 3 most-viewed tracks for each artist.
--solution
WITH RankedTracks AS (
    SELECT
        artist,
        track,
        album,
        views,
        ROW_NUMBER() OVER (PARTITION BY artist ORDER BY views DESC) AS rank
    FROM
        spotify
)
SELECT
    artist,
    track,
    album,
    views
FROM
    RankedTracks
WHERE
    rank <= 3
ORDER BY
    artist, rank;

-- 2.Write a query to find tracks where the liveness score is higher than the average liveness score.
--solution
SELECT
    artist,
    track,
    album,
    liveness
FROM
    spotify
WHERE
    liveness > (SELECT AVG(liveness) FROM spotify);

-- 3.Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
--solution
WITH EnergyValues AS (
    SELECT
        album,
        MAX(energy) AS max_energy,
        MIN(energy) AS min_energy
    FROM
        spotify
    GROUP BY
        album
)
SELECT
    album,
    (max_energy - min_energy) AS energy_difference
FROM
    EnergyValues;

--4.Write a query to find tracks where the energy-to-liveness ratio is greater than 1.2.
--solution
SELECT
    artist,
    track,
    album,
    energy,
    liveness,
    (energy / liveness) AS energy_liveness_ratio
FROM
    spotify
WHERE
    (energy / liveness) > 1.2;

--5.Calculate the cumulative sum of likes for tracks, ordered by the number of views, using window functions.
--solution
SELECT
    artist,
    track,
    album,
    views,
    likes,
    SUM(likes) OVER (ORDER BY views DESC) AS cumulative_likes
FROM
    spotify
ORDER BY
    views DESC;
