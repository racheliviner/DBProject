-- select number 1
SELECT EXTRACT(YEAR FROM ReleaseDate) AS ReleaseYear,
       COUNT(*) AS NumberOfMovies,
       AVG(Rating) AS AverageRating
FROM Movies
GROUP BY EXTRACT(YEAR FROM ReleaseDate)
ORDER BY ReleaseYear;

-- select number 2
SELECT Title, TicketsSold, TotalRevenue
FROM (
    SELECT m.Title,
         COUNT(ts.TicketID) AS TicketsSold,
         SUM(ts.Price) AS TotalRevenue
    FROM TicketSales ts
    JOIN Schedules s ON ts.ScheduleID = s.ScheduleID
    JOIN Movies m ON s.MovieID = m.MovieID
    WHERE ts.IsSold = 'Y'
    GROUP BY m.Title
    ORDER BY TotalRevenue DESC
)
WHERE ROWNUM <= 10;

-- select number 3
SELECT m.Title AS MovieTitle, m.Genre, d.HourH AS ScreeningTime, s.AvailableSeats
FROM Movies m
JOIN Schedules s ON m.MovieID = s.MovieID
JOIN Dates d ON s.DateID = d.DateID
WHERE TRUNC(d.DateD) = TRUNC(SYSDATE);

-- select number 4
SELECT
    EXTRACT(YEAR FROM D.DateD) AS Year,
    EXTRACT(MONTH FROM D.DateD) AS Month,
    COUNT(TS.TicketID) AS TicketsSold
FROM
    TicketSales TS
JOIN
    Schedules S ON TS.ScheduleID = S.ScheduleID
JOIN
    Dates D ON S.DateID = D.DateID
JOIN
    Theaters TH ON S.TheaterID = TH.TheaterID
WHERE
    TS.IsSold = 'Y'
GROUP BY
    EXTRACT(YEAR FROM D.DateD),
    EXTRACT(MONTH FROM D.DateD)
ORDER BY
    Year,
    Month;
    
-- delete number 1
DELETE FROM TicketSales
WHERE IsSold = 'N'
AND ScheduleID IN (
    SELECT ScheduleID 
    FROM Schedules 
    WHERE DateID IN (
        SELECT DateID 
        FROM Dates 
        WHERE DateD < SYSDATE
    )
);
commit;

-- delete number 2
DELETE FROM TicketSales
WHERE IsSold = 'N'
AND SubscriberID NOT IN (
    SELECT DISTINCT ts1.SubscriberID
    FROM TicketSales ts1
    JOIN Schedules s ON ts1.ScheduleID = s.ScheduleID
    JOIN Dates d ON s.DateID = d.DateID
    WHERE ts1.IsSold = 'Y'
    AND d.DateD >= SYSDATE - 3
);
commit;

-- update number 1
UPDATE Schedules s
SET AvailableSeats = (
    SELECT t.Capacity - COUNT(ts.TicketID)
    FROM Theaters t
    JOIN Schedules s2 ON t.TheaterID = s2.TheaterID
    LEFT JOIN TicketSales ts ON s2.ScheduleID = ts.ScheduleID AND ts.IsSold = 'Y'
    WHERE s2.ScheduleID = s.ScheduleID
    GROUP BY t.Capacity
);
commit;

-- update number 2
UPDATE TicketSales ts
SET Price = Price * 0.8
WHERE ScheduleID IN (
    SELECT s.ScheduleID
    FROM Schedules s
    JOIN Movies m ON s.MovieID = m.MovieID
    LEFT JOIN TicketSales ts2 ON s.ScheduleID = ts2.ScheduleID AND ts2.IsSold = 'Y'
    GROUP BY s.ScheduleID, m.Rating
    HAVING COUNT(ts2.TicketID) < 10 AND m.Rating < 5
);
commit;




