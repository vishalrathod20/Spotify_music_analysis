# Spotify Data Analysis Project

## Project Overview

This project focuses on performing various SQL-based analyses on a dataset containing information about tracks, albums, artists, and associated statistics such as streams, views, likes, energy, liveness, and more from Spotify. The queries are designed to retrieve insights into different aspects of the music data, ranging from basic filtering to more advanced calculations using window functions.

The queries are categorized based on complexity into three levels: **Easy**, **Medium**, and **Advanced**. Each level aims to cover different types of questions commonly encountered when analyzing large datasets for trends, performance metrics, and key insights about music consumption on streaming platforms like Spotify.

### Easy Level
1. Find all tracks that have over 1 billion streams.
2. List all the albums and their artists.
3. Get the total number of comments for tracks that are licensed.
4. Identify all tracks that are part of albums classified as singles.
5. Count how many tracks each artist has in total.

### Medium Level
1. How can I compute the average danceability for all tracks in each album within a dataset?
2. What approach should I take to identify the top five tracks with the highest energy values?
3. How can I filter and list all tracks where official_video = TRUE, displaying their views and likes?
4. What method would allow me to calculate the total views for all tracks within each album?
5. How can I retrieve the names of tracks that have more streams on Spotify than on YouTube?

### Advanced Level
1. Write a query using window functions to find the top 3 most-viewed tracks for each artist.
2. Write a query to find tracks where the liveness score is higher than the average liveness score.
3. Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
4. Write a query to find tracks where the energy-to-liveness ratio is greater than 1.2.
5. Calculate the cumulative sum of likes for tracks, ordered by the number of views, using window functions.

## Analysis Conclusion

Through this project, I explored and applied a range of SQL techniques to derive meaningful insights from Spotify's music data. For simpler tasks like filtering and aggregation, basic SQL functions were sufficient to answer questions such as the number of licensed tracks or artist-specific track counts. As the complexity increased, the project involved using advanced SQL features, including **window functions** and **common table expressions (WITH clauses)**, to handle more sophisticated queries. 

The analysis allowed me to:
- Examine streaming patterns and popular content.
- Calculate important metrics like danceability, energy, and views to understand track and album performance.
- Use window functions to rank and accumulate data, providing deeper insights into user engagement metrics such as views and likes.

This project demonstrates my proficiency in using SQL for large-scale data analysis, including the ability to answer complex business questions and derive actionable insights from data.
