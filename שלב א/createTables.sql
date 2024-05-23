-- ����� ���� ������
CREATE TABLE Movies (
    MovieID NUMERIC(3) PRIMARY KEY,
    Title VARCHAR2(30) NOT NULL,
    Genre VARCHAR2(15),
    Director VARCHAR2(30),
    ReleaseDate DATE,
    Duration INT NOT NULL,
    Rating INT
);

-- ����� ���� ��������
CREATE TABLE Dates (
    DateID NUMERIC(3) PRIMARY KEY,
    HourH VARCHAR2(15) NOT NULL,
    DayD VARCHAR2(15) NOT NULL,
    DateD DATE NOT NULL
);

-- ����� ���� �������
CREATE TABLE Theaters (
    TheaterID NUMERIC(3) PRIMARY KEY,
    TheaterName VARCHAR2(30) NOT NULL,
    Capacity INT NOT NULL
);

-- ����� ���� ��� ������
CREATE TABLE Schedules (
    ScheduleID NUMERIC(3) PRIMARY KEY,
    AvailableSeats INT NOT NULL,
    MovieID NUMERIC(3) NOT NULL,
    TheaterID NUMERIC(3) NOT NULL,
    DateID NUMERIC(3) NOT NULL,
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID),
    FOREIGN KEY (TheaterID) REFERENCES Theaters(TheaterID),
    FOREIGN KEY (DateID) REFERENCES Dates(DateID)
);

-- ����� ���� �������
CREATE TABLE Subscribers (
    SubscriberID NUMERIC(3) PRIMARY KEY,
    DiscountPercents INT NOT NULL,
    ExpirationDate DATE
);


-- ����� ���� ����� ��������
CREATE TABLE TicketSales (
    TicketID NUMERIC(3) PRIMARY KEY,
    Price NUMERIC(5, 2) NOT NULL,
    IsSold CHAR(1) DEFAULT 'N' CHECK (IsSold IN ('Y', 'N')) NOT NULL,
    ScheduleID NUMERIC(3) NOT NULL,
    SubscriberID NUMERIC(3),
    FOREIGN KEY (ScheduleID) REFERENCES Schedules(ScheduleID),
    FOREIGN KEY (SubscriberID) REFERENCES Subscribers(SubscriberID)
);

