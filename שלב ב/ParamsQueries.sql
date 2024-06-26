-- param querie number 1, multiselection
SELECT 
    M.Title AS Movie_Name,
    M.Duration AS Movie_Length,
    M.Genre AS Movie_Genre,
    D.DateD AS Screening_Date,
    D.HourH AS Screening_Time
FROM 
    Movies M
JOIN 
    Schedules S ON M.MovieID = S.MovieID
JOIN 
    Dates D ON S.DateID = D.DateID
WHERE 
    M.Genre IN (&<name="genre_list"
 list="select DISTINCT genre from movies"
 type="string" multiselect="yes">)
ORDER BY Genre,DateD

-- param querie number 2
SELECT 
    M.Title AS Movie_Name,
    M.Rating AS Movie_Rating,
    D.DateD AS Screening_Date,
    D.HourH AS Screening_Time
FROM 
    Movies M
JOIN 
    Schedules S ON M.MovieID = S.MovieID
JOIN 
    Dates D ON S.DateID = D.DateID
WHERE 
    M.Rating >= &<name="Minimum_desired_rating" hint= "Rating between 1-10" type="integer" default=5>
    AND D.DateD = &<name=screening_date type="date" required=true>
ORDER BY 
    M.Rating DESC, D.HourH;

-- param querie number 3
SELECT
    M.Director AS Director_Name,
    M.Title AS Movie_Name,
    M.Rating AS Movie_Rating,
    D.DateD AS Screening_Date,
    D.HourH AS Screening_Time
FROM
    Movies M
JOIN
    Schedules S ON M.MovieID = S.MovieID
JOIN
    Dates D ON S.DateID = D.DateID
JOIN
    Theaters T ON S.TheaterID = T.TheaterID
WHERE
    M.Director = &<name="director"
                   type="string"
                   list="SELECT DISTINCT Director FROM Movies ORDER BY Director" required=true>
    AND M.Rating = (
        SELECT MAX(Rating)
        FROM Movies
        WHERE Director = M.Director
    )
ORDER BY
    M.Title DESC;
    
-- param querie number 4
SELECT 
    M.MovieID, 
    M.Title, 
    M.Genre, 
    M.Director, 
    M.ReleaseDate, 
    M.Duration, 
    M.Rating
FROM 
    Movies M
WHERE 
    M.Director = &<name="Director"
                   type="string"
                   list="SELECT DISTINCT Director FROM Movies ORDER BY Director">
AND 
    M.MovieID = &<name="Movie"
                 type="string"
                 list="SELECT MovieID,Title FROM Movies WHERE Director = :Director ORDER BY Title" description="yes">
ORDER BY 
    M.Title;

-- param querie number 5  
SELECT 
    M.Title AS Movie_Title,
    T.TheaterName AS Theater,
    D.DateD AS Screening_Date,
    D.HourH AS Screening_Time,
    M.Duration AS Duration,
    M.Rating AS Rating
FROM 
    Movies M
JOIN 
    Schedules S ON M.MovieID = S.MovieID
JOIN 
    Theaters T ON S.TheaterID = T.TheaterID
JOIN 
    Dates D ON S.DateID = D.DateID
WHERE 
    T.TheaterName = &<name="Theater"
                      type="string"
                      list="SELECT DISTINCT TheaterName FROM Theaters ORDER BY TheaterName">
AND 
    D.DateD = &<name="ScreeningDate"
                type="Date"
                list="
                SELECT DISTINCT D.DateD AS DateD 
                FROM Schedules S 
                JOIN Dates D ON S.DateID = D.DateID 
                JOIN Theaters T ON S.TheaterID = T.TheaterID 
                WHERE T.TheaterName = :Theater 
                ORDER BY DateD">
ORDER BY 
    D.HourH;
