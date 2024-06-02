--hi
update me

--basic update 1
UPDATE Schedules s
SET s.AvailableSeats = (
    SELECT t.Capacity
    FROM Theaters t
    WHERE t.TheaterID = s.TheaterID
);

--basic update 2
-- Step 1: Update the number of available seats in Schedules
UPDATE Schedules
SET AvailableSeats = AvailableSeats - (
    SELECT COUNT(*)
    FROM TicketSales
    WHERE TicketSales.ScheduleID = Schedules.ScheduleID
    AND TicketSales.IsSold = 'N'
)
WHERE ScheduleID IN (
    SELECT ScheduleID
    FROM TicketSales
    WHERE IsSold = 'N'
);

-- Step 2: Update TicketSales to mark tickets as sold
UPDATE TicketSales
SET IsSold = 'Y'
WHERE IsSold = 'N';

--select number 1
--אחזר את הדירוג הממוצע של סרטים שיצאו בכל שנה יחד עם מספר הסרטים שיצאו בכל שנה.
SELECT EXTRACT(YEAR FROM ReleaseDate) AS ReleaseYear, 
       COUNT(*) AS NumberOfMovies, 
       AVG(Rating) AS AverageRating
FROM Movies
GROUP BY EXTRACT(YEAR FROM ReleaseDate)
ORDER BY ReleaseYear;

--select number 2
-- אחזר את 10 הסרטים המובילים לפי סך ההכנסות, כולל מספר הכרטיסים שנמכרו, מסודר לפי סך ההכנסות יורד.
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


--select number 3
-- מציג את הסרטים המוקרנים היום לצד השעה ומספר המקומות הפנוייים
SELECT m.Title AS MovieTitle, m.Genre, d.HourH AS ScreeningTime, s.AvailableSeats
FROM Movies m
JOIN Schedules s ON m.MovieID = s.MovieID
JOIN Dates d ON s.DateID = d.DateID
WHERE TRUNC(d.DateD) = TRUNC(SYSDATE);



--select number 4
--רשום את כל המנויים שתוקף המנוי שלהם יפוג במהלך החודש הקרוב, יחד עם אחוזי ההנחה ומספר הכרטיסים שרכשו.
SELECT sub.SubscriberID, 
       sub.DiscountPercents, 
       COUNT(ts.TicketID) AS TicketsPurchased
FROM Subscribers sub
LEFT JOIN TicketSales ts ON sub.SubscriberID = ts.SubscriberID
WHERE sub.ExpirationDate BETWEEN SYSDATE AND ADD_MONTHS(SYSDATE, 1)
GROUP BY sub.SubscriberID, sub.DiscountPercents
ORDER BY sub.ExpirationDate;

--delete number 1
--מחק את כל לוחות הזמנים של סרט שכבר לא מוצג (לדוגמה, לוחות זמנים של סרט שיצא לפני יותר משנה).
DELETE FROM Schedules
WHERE MovieID IN (
    SELECT MovieID 
    FROM Movies 
    WHERE ReleaseDate < ADD_MONTHS(SYSDATE, -12)
);

--delete number 2
--מחק את כל הכרטיסים שלא נמכרו והם לתאריכים קודמים.
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

--update number 1
--עדכן את המושבים הפנויים ללוח זמנים לאחר מכירת הכרטיסים.
UPDATE Schedules
SET AvailableSeats = AvailableSeats - (
    SELECT COUNT(*) 
    FROM TicketSales 
    WHERE ScheduleID = Schedules.ScheduleID 
    AND IsSold = 'Y'
)
WHERE ScheduleID = (SELECT ScheduleID FROM TicketSales WHERE TicketID = 1);

--update number 2
--הארך את תאריך תפוגת המנוי בשנה עבור מנויים שרכשו יותר מ-10 כרטיסים.
UPDATE Subscribers
SET ExpirationDate = ADD_MONTHS(ExpirationDate, 12)
WHERE SubscriberID IN (
    SELECT SubscriberID 
    FROM TicketSales 
    WHERE IsSold = 'Y'
    GROUP BY SubscriberID
    HAVING COUNT(*) > 10
);

