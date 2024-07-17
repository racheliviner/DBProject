CREATE TABLE PERSON(
    pid NUMBER(3),
    pName VARCHAR(150) Default NULL,
    PRIMARY KEY (pid)
);


alter table client MODIFY (Client_Name VARCHAR(15) NULL);
alter table subscribers MODIFY(DiscountPercents INT NULL);
insert into subscribers (SubscriberID) select Client_Id from client where Is_Club_Member = 1 and client.Client_Id NOT IN (select SubscriberID from subscribers); 
ALTER TABLE client DROP COLUMN Is_Club_Member;
insert into CLIENT c (Client_Id) select SubscriberID from SUBSCRIBERS s where s.SubscriberID NOT IN (select Client_Id from client);
insert into PERSON p (pid,pname) select CLIENT_ID,CLIENT_NAME from CLIENT c;
insert into PERSON p (pid,pname) select WORKER_ID,WORKER_NAME from WORKER w where w.WORKER_ID NOT IN (SELECT pid from person);
insert into PERSON p (pid,pname) select SUPPLIER_ID,SUPPLIER_NAME from SUPPLIER s where s.SUPPLIER_ID NOT IN (select pid from person);
ALTER TABLE client DROP COLUMN Client_Name;
ALTER TABLE WORKER DROP COLUMN WORKER_NAME;
ALTER TABLE SUPPLIER DROP COLUMN SUPPLIER_NAME;

--add FK_SB
alter table SUBSCRIBERS
ADD CONSTRAINT FK_SB
FOREIGN KEY (SubscriberID) REFERENCES client(Client_Id);

--add FK_CL
alter table client
ADD CONSTRAINT FK_CL
FOREIGN KEY (CLIENT_ID) REFERENCES PERSON(pid);

--add FK_WR
alter table WORKER
ADD CONSTRAINT FK_WR
FOREIGN KEY (WORKER_ID) REFERENCES PERSON(pid);

--add FK_SP
alter table SUPPLIER
ADD CONSTRAINT FK_SP
FOREIGN KEY (SUPPLIER_ID) REFERENCES PERSON(pid);

------------------------------------------------------------------

 CREATE TABLE STOREPRODUCTS(
   StoreProduct_Id NUMERIC(3),
   PRIMARY KEY (StoreProduct_Id),
   FOREIGN KEY (StoreProduct_Id) REFERENCES PRODUCTS(Product_Id)
 );
alter table PRODUCTS MODIFY (  Product_Name VARCHAR(15) NULL);
 
insert into STOREPRODUCTS select Product_Id from PRODUCTS;
insert into CATEGORYS (CATEGORY_ID,CATEGORY_NAME) values (700,'Movie');
insert into PRODUCTS (Product_ID, Quantity, Product_Price, Category_ID) 
 select TICKETID,AVAILABLESEATS,PRICE,700 from TICKETSALES NATURAL JOIN SCHEDULES 
 where ticketid not in (select PRODUCT_ID from PRODUCTS);

 CREATE TABLE TICKETS (
    Ticket_ID NUMERIC(3),
    TheaterID NUMERIC(3),
    MovieID NUMERIC(3), 
    DateID NUMERIC(3), 
    PRIMARY KEY (Ticket_ID),
    FOREIGN KEY (Ticket_ID) REFERENCES PRODUCTS(Product_Id),
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID),
    FOREIGN KEY (TheaterID) REFERENCES Theaters(TheaterID),
    FOREIGN KEY (DateID) REFERENCES Dates(DateID)
);

insert into TICKETS (Ticket_ID,THEATERID,MOVIEID,DATEID) 
 select TICKETID,THEATERID,MOVIEID,DATEID from TICKETSALES NATURAL JOIN SCHEDULES;
 
--drope SYS_C008021
alter table ORDER_PRODUCT drop CONSTRAINT SYS_C008021;
--add FK_op1
alter table ORDER_PRODUCT
ADD CONSTRAINT FK_op
FOREIGN KEY (PRODUCT_ID) REFERENCES STOREPRODUCTS(StoreProduct_Id);

drop table TICKETSALES;
drop table SCHEDULES;






