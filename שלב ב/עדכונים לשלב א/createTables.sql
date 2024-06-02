-- ����� ���� ������
CREATE TABLE Movies (
    MovieID NUMERIC(3) PRIMARY KEY,
    Title VARCHAR2(100) NOT NULL,
    Genre VARCHAR2(100),
    Director VARCHAR2(100),
    ReleaseDate DATE,
    Duration INT NOT NULL CHECK (Duration <= 180),
    Rating INT CHECK (Rating >= 1 AND Rating <= 10)
);


-- ����� ���� ��������
CREATE TABLE Dates (
    DateID NUMERIC(3) PRIMARY KEY,
    HourH VARCHAR2(100) NOT NULL,
    DayD VARCHAR2(100) NOT NULL,
    DateD DATE NOT NULL,
    UNIQUE(HourH, DayD, DateD)
);

-- ����� ���� �������
CREATE TABLE Theaters (
    TheaterID NUMERIC(3) PRIMARY KEY,
    TheaterName VARCHAR2(100) NOT NULL,
    Capacity INT NOT NULL CHECK (Capacity >= 0)
);


-- ����� ���� ��� ������
CREATE TABLE Schedules (
    ScheduleID NUMERIC(3) PRIMARY KEY,
    TheaterID NUMERIC(3) NOT NULL,
    AvailableSeats INT DEFAULT 0 CHECK (AvailableSeats >= 0),--TheaterID.capacity לא שלילי, לא גדול מ
    MovieID NUMERIC(3) NOT NULL, 
    DateID NUMERIC(3) NOT NULL, --\DateID.hour == 10,12,15,18,21
    UNIQUE(DateID, TheaterID),
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID),
    FOREIGN KEY (TheaterID) REFERENCES Theaters(TheaterID),
    FOREIGN KEY (DateID) REFERENCES Dates(DateID)
);

-- ����� ���� �������
CREATE TABLE Subscribers (
    SubscriberID NUMERIC(3) PRIMARY KEY,
    DiscountPercents INT NOT NULL CHECK(DiscountPercents IN (10, 20, 30, 40, 50)),
    ExpirationDate DATE
);


-- ����� ���� ����� ��������
CREATE TABLE TicketSales (
    TicketID NUMERIC(3) PRIMARY KEY,
    Price NUMERIC(5, 2) DEFAULT 30 CHECK(Price IN (30, 50, 90)),
    IsSold CHAR(1) DEFAULT 'N' CHECK (IsSold IN ('Y', 'N')) NOT NULL,
    ScheduleID NUMERIC(3) NOT NULL,
    SubscriberID NUMERIC(3) DEFAULT NULL,
    FOREIGN KEY (ScheduleID) REFERENCES Schedules(ScheduleID),
    FOREIGN KEY (SubscriberID) REFERENCES Subscribers(SubscriberID)
);
