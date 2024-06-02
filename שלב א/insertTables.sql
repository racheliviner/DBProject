-- insert Movies table
insert into Movies (MovieID, Title , Genre, Director, ReleaseDate, Duration, Rating) values (100, 'Crash', 'Musical', 'Ulrike Do Rosario', to_date('24-07-2019', 'dd-mm-yyyy'), 102, 9);
insert into Movies (MovieID, Title , Genre, Director, ReleaseDate, Duration, Rating) values (101, 'Notorious', 'Animation', 'Chanda Stirland', to_date('15-02-2017', 'dd-mm-yyyy'), 107, 8);
insert into Movies (MovieID, Title , Genre, Director, ReleaseDate, Duration, Rating) values (102, 'Giant', 'Biography', 'Dwight Lopez', to_date('02-02-2014', 'dd-mm-yyyy'), 108, 10);
insert into Movies (MovieID, Title , Genre, Director, ReleaseDate, Duration, Rating) values (103, 'Moana', 'Comedy', 'Grannie Brosnan', to_date('11-03-2007', 'dd-mm-yyyy'), 148, 2);
insert into Movies (MovieID, Title , Genre, Director, ReleaseDate, Duration, Rating) values (104, 'Deadpool', 'Fantasy', 'Lenard Pothergill', to_date('20-01-2002', 'dd-mm-yyyy'), 124, 9);
insert into Movies (MovieID, Title , Genre, Director, ReleaseDate, Duration, Rating) values (105, 'Gandhi', 'Action', 'Kele Hastin', to_date('31-12-2010', 'dd-mm-yyyy'), 94, 6);
insert into Movies (MovieID, Title , Genre, Director, ReleaseDate, Duration, Rating) values (106, 'Jumper', 'Documentary', 'Merlina Venables', to_date('21-06-2014', 'dd-mm-yyyy'), 76, 8);
insert into Movies (MovieID, Title , Genre, Director, ReleaseDate, Duration, Rating) values (107, 'Maverick', 'Fantasy', 'Zack Jeandet', to_date('22-07-2018', 'dd-mm-yyyy'), 61, 6);
insert into Movies (MovieID, Title , Genre, Director, ReleaseDate, Duration, Rating) values (108, 'Thor', 'Crime', 'Albertine Sedgwick', to_date('18-01-2016', 'dd-mm-yyyy'), 112, 8);
insert into Movies (MovieID, Title , Genre, Director, ReleaseDate, Duration, Rating) values (109, 'Iron Man', 'Comedy', 'Nefen Bruyett', to_date('06-03-2017', 'dd-mm-yyyy'), 169, 3);

-- insert Date table
 insert into DATES (DATEID, HOURH, DAYD, DATED) values (111, '22 : 11', 'fri', to_date('10-03-2024', 'dd-mm-yyyy'));
insert into DATES (DATEID, HOURH, DAYD, DATED) values (112, '21 : 8', 'tue', to_date('09-12-2024', 'dd-mm-yyyy'));
insert into DATES (DATEID, HOURH, DAYD, DATED) values (511, '22 : 43', 'wed', to_date('27-10-2024', 'dd-mm-yyyy'));
insert into DATES (DATEID, HOURH, DAYD, DATED) values (114, '19 : 29', 'thu', to_date('09-10-2024', 'dd-mm-yyyy'));
insert into DATES (DATEID, HOURH, DAYD, DATED) values (115, '20 : 33', 'sun', to_date('15-02-2024', 'dd-mm-yyyy'));
insert into DATES (DATEID, HOURH, DAYD, DATED) values (116, '20 : 20', 'tue', to_date('26-01-2024', 'dd-mm-yyyy'));
insert into DATES (DATEID, HOURH, DAYD, DATED) values (117, '23 : 37', 'thu', to_date('08-03-2024', 'dd-mm-yyyy'));
insert into DATES (DATEID, HOURH, DAYD, DATED) values (118, '19 : 7', 'sun', to_date('03-11-2024', 'dd-mm-yyyy'));
insert into DATES (DATEID, HOURH, DAYD, DATED) values (119, '18 : 54', 'sat', to_date('19-11-2024', 'dd-mm-yyyy'));
insert into DATES (DATEID, HOURH, DAYD, DATED) values (120, '22 : 51', 'wed', to_date('04-12-2024', 'dd-mm-yyyy'));

-- insert Theaters table
INSERT INTO THEATERS (THEATERID, THEATERNAME, CAPACITY) VALUES (111, 'Rose', 193);
INSERT INTO THEATERS (THEATERID, THEATERNAME, CAPACITY) VALUES (112, 'Tulip', 167);
INSERT INTO THEATERS (THEATERID, THEATERNAME, CAPACITY) VALUES (113, 'Lily', 251);
INSERT INTO THEATERS (THEATERID, THEATERNAME, CAPACITY) VALUES (114, 'Daisy', 263);
INSERT INTO THEATERS (THEATERID, THEATERNAME, CAPACITY) VALUES (115, 'Sunflower', 168);
INSERT INTO THEATERS (THEATERID, THEATERNAME, CAPACITY) VALUES (116, 'Marigold', 138);
INSERT INTO THEATERS (THEATERID, THEATERNAME, CAPACITY) VALUES (117, 'Orchid', 33);
INSERT INTO THEATERS (THEATERID, THEATERNAME, CAPACITY) VALUES (118, 'Lavender', 151);
INSERT INTO THEATERS (THEATERID, THEATERNAME, CAPACITY) VALUES (119, 'Poppy', 216);
INSERT INTO THEATERS (THEATERID, THEATERNAME, CAPACITY) VALUES (120, 'Peony', 148);

-- insert Schedules table
INSERT INTO Schedules (ScheduleID, TheaterID, AvailableSeats, MovieID, DateID) VALUES (111, 111, 0, 100, 111);
insert into SCHEDULES (SCHEDULEID, THEATERID, AVAILABLESEATS, MOVIEID, DATEID) values (112, 112, 0, 102, 511);
insert into SCHEDULES (SCHEDULEID, THEATERID, AVAILABLESEATS, MOVIEID, DATEID) values (113, 113, 0, 103, 112);
insert into SCHEDULES (SCHEDULEID, THEATERID, AVAILABLESEATS, MOVIEID, DATEID) values (114, 114, 0, 104, 120);
insert into SCHEDULES (SCHEDULEID, THEATERID, AVAILABLESEATS, MOVIEID, DATEID) values (115, 115, 0, 105, 114);
insert into SCHEDULES (SCHEDULEID, THEATERID, AVAILABLESEATS, MOVIEID, DATEID) values (116, 116, 0, 106, 115);
insert into SCHEDULES (SCHEDULEID, THEATERID, AVAILABLESEATS, MOVIEID, DATEID) values (117, 117, 0, 107, 116);
insert into SCHEDULES (SCHEDULEID, THEATERID, AVAILABLESEATS, MOVIEID, DATEID) values (118, 118, 0, 108, 117);
insert into SCHEDULES (SCHEDULEID, THEATERID, AVAILABLESEATS, MOVIEID, DATEID) values (119, 119, 0, 109, 118);
insert into SCHEDULES (SCHEDULEID, THEATERID, AVAILABLESEATS, MOVIEID, DATEID) values (120, 120, 0, 101, 119);

-- insert Subscribers table
insert into Subscribers (SubscriberID, DiscountPercents, ExpirationDate) values (100, 50, to_date('24-01-2029', 'dd-mm-yyyy'));
insert into Subscribers (SubscriberID, DiscountPercents, ExpirationDate) values (101, 20, to_date('04-07-2029', 'dd-mm-yyyy'));
insert into Subscribers (SubscriberID, DiscountPercents, ExpirationDate) values (102, 20, to_date('16-04-2030', 'dd-mm-yyyy'));
insert into Subscribers (SubscriberID, DiscountPercents, ExpirationDate) values (103, 30, to_date('16-11-2026', 'dd-mm-yyyy'));
insert into Subscribers (SubscriberID, DiscountPercents, ExpirationDate) values (104, 10, to_date('08-07-2024', 'dd-mm-yyyy'));
insert into Subscribers (SubscriberID, DiscountPercents, ExpirationDate) values (105, 40, to_date('01-06-2025', 'dd-mm-yyyy'));
insert into Subscribers (SubscriberID, DiscountPercents, ExpirationDate) values (106, 20, to_date('24-10-2024', 'dd-mm-yyyy'));
insert into Subscribers (SubscriberID, DiscountPercents, ExpirationDate) values (107, 20, to_date('23-02-2028', 'dd-mm-yyyy'));
insert into Subscribers (SubscriberID, DiscountPercents, ExpirationDate) values (108, 40, to_date('14-09-2025', 'dd-mm-yyyy'));
insert into Subscribers (SubscriberID, DiscountPercents, ExpirationDate) values (109, 40, to_date('15-08-2027', 'dd-mm-yyyy'));

-- insert TicketSales table
insert into TICKETSALES (TICKETID, PRICE, ISSOLD, SCHEDULEID, SUBSCRIBERID) values (111, 129.54, 'N', 111, 100);
insert into TICKETSALES (TICKETID, PRICE, ISSOLD, SCHEDULEID, SUBSCRIBERID) values (112, 60.67, 'N', 112, 101);
insert into TICKETSALES (TICKETID, PRICE, ISSOLD, SCHEDULEID, SUBSCRIBERID) values (113, 113.97, 'N', 113, 102);
insert into TICKETSALES (TICKETID, PRICE, ISSOLD, SCHEDULEID, SUBSCRIBERID) values (114, 66.99, 'N', 114, 103);
insert into TICKETSALES (TICKETID, PRICE, ISSOLD, SCHEDULEID, SUBSCRIBERID) values (115, 73.21, 'N', 115, 104);
insert into TICKETSALES (TICKETID, PRICE, ISSOLD, SCHEDULEID, SUBSCRIBERID) values (116, 142.44, 'N', 116, 105);
insert into TICKETSALES (TICKETID, PRICE, ISSOLD, SCHEDULEID, SUBSCRIBERID) values (117, 139.58, 'N', 117, 106);
insert into TICKETSALES (TICKETID, PRICE, ISSOLD, SCHEDULEID, SUBSCRIBERID) values (118, 103.84, 'N', 118, 107);
insert into TICKETSALES (TICKETID, PRICE, ISSOLD, SCHEDULEID, SUBSCRIBERID) values (119, 65.89, 'N', 119, 108);
insert into TICKETSALES (TICKETID, PRICE, ISSOLD, SCHEDULEID, SUBSCRIBERID) values (120, 132.75, 'N', 120, 109);

commit;




