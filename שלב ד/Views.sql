-- This view combines information from various store-related tables, including person details, products, categories, orders, and purchases.

CREATE VIEW StoreView AS
SELECT 
    p.Person_ID,
    p.Person_Name,
    c.Person_ID AS Client_ID,
    w.Person_ID AS Worker_ID,
    w.Start_of_Work_Date,
    s.Person_ID AS Supplier_ID,
    s.Region,
    sub.Person_ID AS Subscriber_ID,
    sub.DiscountPercent,
    sub.ExpirationDate,
    prod.Product_ID,
    prod.Product_Name,
    prod.Quantity,
    prod.Product_Price,
    cat.Category_ID,
    cat.Category_Name,
    sp.Product_ID AS Store_Product_ID,
    o.Order_ID,
    o.Order_Date,
    o.Delivery_Date,
    pur.Purchase_ID,
    pur.Purchase_Date,
    pur.Delivery_Date AS Purchase_Delivery_Date
FROM Person p
LEFT JOIN Client c ON p.Person_ID = c.Person_ID
LEFT JOIN Worker w ON p.Person_ID = w.Person_ID
LEFT JOIN Supplier s ON p.Person_ID = s.Person_ID
LEFT JOIN Subscribers sub ON c.Person_ID = sub.Person_ID
LEFT JOIN Products prod ON 1=1
LEFT JOIN Category cat ON prod.Category_ID = cat.Category_ID
LEFT JOIN Store_Products sp ON prod.Product_ID = sp.Product_ID
LEFT JOIN Orders o ON 1=1
LEFT JOIN Purchases pur ON 1=1;

-- Test of StoreView
SELECT *
FROM StoreView
LIMIT 10;

-- Query 1: Get all client purchases with product details and categories

SELECT 
    sv.Person_Name AS Client_Name,
    sv.Product_Name,
    sv.Product_Price,
    sv.Quantity,
    sv.Purchase_Date,
    sv.Category_Name
FROM StoreView sv
WHERE sv.Client_ID IS NOT NULL
  AND sv.Purchase_ID IS NOT NULL
  AND sv.Store_Product_ID IS NOT NULL
ORDER BY sv.Person_Name, sv.Purchase_Date DESC;

-- Query 2: Get the total value of orders for each supplier in a specific region

SELECT 
    sv.Person_Name AS Supplier_Name,
    sv.Region,
    COUNT(DISTINCT sv.Order_ID) AS Total_Orders,
    SUM(sv.Product_Price * sv.Quantity) AS Total_Order_Value
FROM StoreView sv
WHERE sv.Supplier_ID IS NOT NULL
  AND sv.Order_ID IS NOT NULL
  AND sv.Region = &<name="selected_region"
                    type="string"
                    list="SELECT DISTINCT Region FROM Supplier ORDER BY Region"
                    required=true>
GROUP BY sv.Person_Name, sv.Region
ORDER BY Total_Order_Value DESC;

-- This view combines information from various cinema-related tables, including person details, movies, tickets, theaters, dates, and purchases.

CREATE VIEW CinemaView AS
SELECT 
    p.Person_ID,
    p.Person_Name,
    c.Person_ID AS Client_ID,
    w.Person_ID AS Worker_ID,
    w.Start_of_Work_Date,
    sub.Person_ID AS Subscriber_ID,
    sub.DiscountPercent,
    sub.ExpirationDate,
    prod.Product_ID,
    prod.Product_Name,
    prod.Quantity,
    prod.Product_Price,
    cat.Category_ID,
    cat.Category_Name,
    t.Product_ID AS Ticket_ID,
    m.MovieID,
    m.Title,
    m.Genre,
    m.Director,
    m.ReleaseDate,
    m.Duration,
    m.Rating,
    d.DateID,
    d.HourH,
    d.DayD,
    d.DateD,
    th.TheaterID,
    th.TheaterName,
    th.Capacity,
    pur.Purchase_ID,
    pur.Purchase_Date,
    pur.Delivery_Date AS Purchase_Delivery_Date
FROM Person p
LEFT JOIN Client c ON p.Person_ID = c.Person_ID
LEFT JOIN Worker w ON p.Person_ID = w.Person_ID
LEFT JOIN Subscribers sub ON c.Person_ID = sub.Person_ID
LEFT JOIN Products prod ON 1=1
LEFT JOIN Category cat ON prod.Category_ID = cat.Category_ID
LEFT JOIN Tickets t ON prod.Product_ID = t.Product_ID
LEFT JOIN Movies m ON 1=1
LEFT JOIN Dates d ON 1=1
LEFT JOIN Theaters th ON 1=1
LEFT JOIN Purchases pur ON 1=1;

-- Test of CinemaView
SELECT *
FROM CinemaView
LIMIT 10;

-- Query 1: Get the most popular movies based on ticket sales

SELECT 
    cv.MovieID,
    cv.Title,
    cv.Genre,
    cv.Director,
    cv.Rating,
    COUNT(cv.Ticket_ID) AS Tickets_Sold
FROM CinemaView cv
WHERE cv.Ticket_ID IS NOT NULL
  AND cv.Purchase_ID IS NOT NULL
GROUP BY cv.MovieID, cv.Title, cv.Genre, cv.Director, cv.Rating
ORDER BY Tickets_Sold DESC
LIMIT 10;

-- Query 2: Get the revenue and occupancy rate for each theater on a specific date

SELECT 
    cv.TheaterID,
    cv.TheaterName,
    cv.DateD,
    cv.DayD,
    COUNT(cv.Ticket_ID) AS Tickets_Sold,
    SUM(cv.Product_Price) AS Total_Revenue,
    (COUNT(cv.Ticket_ID) * 100.0 / MAX(cv.Capacity)) AS Occupancy_Rate
FROM CinemaView cv
WHERE cv.Ticket_ID IS NOT NULL
  AND cv.Purchase_ID IS NOT NULL
  AND cv.DateD = &<name="selected_date"
                   type="date"
                   list="SELECT DISTINCT DateD FROM Dates ORDER BY DateD"
                   required=true>
GROUP BY cv.TheaterID, cv.TheaterName, cv.DateD, cv.DayD
ORDER BY Total_Revenue DESC;