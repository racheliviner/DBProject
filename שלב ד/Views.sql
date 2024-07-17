-- This view consolidates all relevant store-related data.

CREATE OR REPLACE VIEW Store_View AS
SELECT 
    w.Worker_ID,
    w.Start_of_Work_Date,
    s.Supplier_ID,
    s.Region,
    sp.storeProduct_ID AS Store_Product_ID,
    o.Order_Id,
    o.Order_Date,
    o.Dellivery_Date,
    os.Supplier_ID AS Order_Supplier_ID,
    ow.Worker_ID AS Order_Worker_ID,
    pw.Worker_ID AS Purchase_Worker_ID,
    op.Product_ID AS Order_Product_ID
FROM 
    Worker w
    LEFT JOIN Order_Worker ow ON w.Worker_ID = ow.Worker_ID
    LEFT JOIN Purchase_Worker pw ON w.Worker_ID = pw.Worker_ID
    LEFT JOIN Orders o ON ow.Order_Id = o.Order_Id
    LEFT JOIN Order_Supplier os ON o.Order_Id = os.Order_Id
    LEFT JOIN Order_Product op ON o.Order_Id = op.Order_Id
    LEFT JOIN Supplier s ON os.Supplier_ID = s.Supplier_ID
    LEFT JOIN StoreProducts sp ON op.Product_ID = sp.storeProduct_ID;

-- Test of StoreView
SELECT *
FROM Store_View
WHERE ROWNUM <= 10;

-- Query 1: Get the list of all orders along with the corresponding workers and suppliers

SELECT 
    Order_Id,
    Order_Date,
    Dellivery_Date,
    Worker_ID,
    Supplier_ID
FROM 
    Store_View
ORDER BY 
    Order_Date;


-- Query 2: Get the number of products ordered by each worker

SELECT 
    Worker_ID,
    COUNT(Order_Product_ID) AS Number_of_Products_Ordered
FROM 
    Store_View
GROUP BY 
    Worker_ID
ORDER BY 
    Number_of_Products_Ordered DESC;


-- This view consolidates all relevant cinema-related data.

CREATE OR REPLACE VIEW Cinema_View AS
SELECT 
    t.Ticket_ID,
    t.TheaterID,
    t.MovieID,
    t.DateID,
    m.Title,
    m.Genre,
    m.Director,
    m.ReleaseDate,
    m.Duration,
    m.Rating,
    d.HourH,
    d.DayD,
    d.DateD,
    th.TheaterName,
    th.Capacity
FROM 
    Tickets t
    LEFT JOIN Movies m ON t.MovieID = m.MovieID
    LEFT JOIN Dates d ON t.DateID = d.DateID
    LEFT JOIN Theaters th ON t.TheaterID = th.TheaterID;


-- Test of CinemaView
SELECT *
FROM Cinema_View
WHERE ROWNUM <= 10;

-- Query 1: Get the list of all tickets sold along with the movie title, theater name, and show date

SELECT 
    Ticket_ID,
    Title AS Movie_Title,
    TheaterName AS Theater_Name,
    DateD AS Show_Date
FROM 
    Cinema_View
ORDER BY 
    DateD;

-- Query 2: Get the number of tickets sold for each movie

SELECT 
    MovieID,
    Title AS Movie_Title,
    COUNT(Ticket_ID) AS Number_of_Tickets_Sold
FROM 
    Cinema_View
GROUP BY 
    MovieID, Title
ORDER BY 
    Number_of_Tickets_Sold DESC;



