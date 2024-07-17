-- This view consolidates all relevant store-related data.
CREATE OR REPLACE VIEW StoreView AS
SELECT 
    o.Order_Id,
    o.Order_Date,
    o.Dellivery_Date,
    w.Worker_ID,
    w.Start_of_Work_Date,
    s.Supplier_ID,
    s.Region,
    sp.StoreProduct_ID,
    p.Product_ID,
    p.Product_Name,
    p.Quantity,
    p.Product_Price,
    p.Category_ID,
    pw.Purchase_Id
FROM 
    Orders o
JOIN 
    Order_Product op ON o.Order_Id = op.Order_Id
JOIN 
    Products p ON op.Product_ID = p.Product_ID
JOIN 
    StoreProducts sp ON p.Product_ID = sp.StoreProduct_ID
JOIN 
    Purchase_Worker pw ON pw.Purchase_Id = o.Order_Id
JOIN 
    Worker w ON w.Worker_ID = pw.Worker_ID
JOIN 
    Supplier s ON s.Supplier_ID = sp.StoreProduct_ID;

-- Test of StoreView
SELECT *
FROM StoreView
WHERE ROWNUM <= 10;

-- Query 1: Get the list of all orders along with the corresponding workers and suppliers
SELECT
    Worker_ID,
    Order_Id,
    Order_Date
FROM
    StoreView
WHERE
    Worker_ID IS NOT NULL
ORDER BY
    Worker_ID, Order_Date;

-- Query 2: Get the total value of products ordered by each worker
SELECT 
    sv.Worker_ID,
    SUM(sv.Product_Price * sv.Quantity) AS Total_Of_Products_Ordered
FROM 
    StoreView sv
GROUP BY 
    sv.Worker_ID;

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



