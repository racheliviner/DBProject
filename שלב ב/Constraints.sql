-- Movies Table
ALTER TABLE Movies
MODIFY Duration INT CHECK (Duration <= 180);

ALTER TABLE Movies
MODIFY Rating INT CHECK (Rating >= 1 AND Rating <= 10);

-- Dates Table
ALTER TABLE Dates
ADD CONSTRAINT unique_hour_day_date UNIQUE(HourH, DayD, DateD);

-- Theaters Table
ALTER TABLE Theaters
MODIFY Capacity INT  CHECK (Capacity >= 0);

-- Schedules Table
ALTER TABLE Schedules
MODIFY AvailableSeats INT DEFAULT 0 CHECK (AvailableSeats >= 0);

ALTER TABLE Schedules
ADD CONSTRAINT unique_date_theater UNIQUE(DateID, TheaterID);

-- Subscribers Table
ALTER TABLE Subscribers
MODIFY DiscountPercents INT DEFAULT 30 CHECK(DiscountPercents IN (10, 20, 30, 40, 50));

-- TicketSales Table
ALTER TABLE TicketSales
MODIFY Price NUMERIC(5, 2) CHECK(Price IN (30, 50, 90));

ALTER TABLE TicketSales
MODIFY SubscriberID NUMERIC(3) DEFAULT NULL;
