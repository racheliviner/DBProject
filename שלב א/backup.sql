prompt PL/SQL Developer import file
prompt Created on יום ראשון 26 מאי 2024 by vider
set feedback off
set define off
prompt Creating DATES...
create table DATES
(
  dateid NUMBER(3) not null,
  hourh  VARCHAR2(100) not null,
  dayd   VARCHAR2(100) not null,
  dated  DATE not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DATES
  add primary key (DATEID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating MOVIES...
create table MOVIES
(
  movieid     NUMBER(3) not null,
  title       VARCHAR2(100) not null,
  genre       VARCHAR2(100),
  director    VARCHAR2(100),
  releasedate DATE,
  duration    INTEGER not null,
  rating      INTEGER
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table MOVIES
  add primary key (MOVIEID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating THEATERS...
create table THEATERS
(
  theaterid   NUMBER(3) not null,
  theatername VARCHAR2(100) not null,
  capacity    INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table THEATERS
  add primary key (THEATERID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating SCHEDULES...
create table SCHEDULES
(
  scheduleid     NUMBER(3) not null,
  theaterid      NUMBER(3) not null,
  availableseats INTEGER not null,
  movieid        NUMBER(3) not null,
  dateid         NUMBER(3) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SCHEDULES
  add primary key (SCHEDULEID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SCHEDULES
  add foreign key (MOVIEID)
  references MOVIES (MOVIEID);
alter table SCHEDULES
  add foreign key (THEATERID)
  references THEATERS (THEATERID);
alter table SCHEDULES
  add foreign key (DATEID)
  references DATES (DATEID);

prompt Creating SUBSCRIBERS...
create table SUBSCRIBERS
(
  subscriberid     NUMBER(3) not null,
  discountpercents INTEGER not null,
  expirationdate   DATE
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SUBSCRIBERS
  add primary key (SUBSCRIBERID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TICKETSALES...
create table TICKETSALES
(
  ticketid     NUMBER(3) not null,
  price        NUMBER(5,2) not null,
  issold       CHAR(1) default 'N' not null,
  scheduleid   NUMBER(3) not null,
  subscriberid NUMBER(3)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TICKETSALES
  add primary key (TICKETID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TICKETSALES
  add foreign key (SCHEDULEID)
  references SCHEDULES (SCHEDULEID);
alter table TICKETSALES
  add foreign key (SUBSCRIBERID)
  references SUBSCRIBERS (SUBSCRIBERID);
alter table TICKETSALES
  add check (IsSold IN ('Y', 'N'));

prompt Disabling triggers for DATES...
alter table DATES disable all triggers;
prompt Disabling triggers for MOVIES...
alter table MOVIES disable all triggers;
prompt Disabling triggers for THEATERS...
alter table THEATERS disable all triggers;
prompt Disabling triggers for SCHEDULES...
alter table SCHEDULES disable all triggers;
prompt Disabling triggers for SUBSCRIBERS...
alter table SUBSCRIBERS disable all triggers;
prompt Disabling triggers for TICKETSALES...
alter table TICKETSALES disable all triggers;
prompt Disabling foreign key constraints for SCHEDULES...
alter table SCHEDULES disable constraint SYS_C007227;
alter table SCHEDULES disable constraint SYS_C007228;
alter table SCHEDULES disable constraint SYS_C007229;
prompt Disabling foreign key constraints for TICKETSALES...
alter table TICKETSALES disable constraint SYS_C007237;
alter table TICKETSALES disable constraint SYS_C007238;
prompt Deleting TICKETSALES...
delete from TICKETSALES;
commit;
prompt Deleting SUBSCRIBERS...
delete from SUBSCRIBERS;
commit;
prompt Deleting SCHEDULES...
delete from SCHEDULES;
commit;
prompt Deleting THEATERS...
delete from THEATERS;
commit;
prompt Deleting MOVIES...
delete from MOVIES;
commit;
prompt Deleting DATES...
delete from DATES;
commit;
prompt Loading DATES...
insert into DATES (dateid, hourh, dayd, dated)
values (100, '18 : 23', 'fri', to_date('06-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (101, '22 : 46', 'mon', to_date('23-04-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (102, '20 : 14', 'thu', to_date('27-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (103, '22 : 43', 'tue', to_date('30-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (104, '23 : 43', 'sun', to_date('13-04-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (105, '21 : 10', 'fri', to_date('12-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (106, '21 : 47', 'wed', to_date('30-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (107, '22 : 45', 'thu', to_date('12-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (108, '21 : 44', 'fri', to_date('13-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (109, '23 : 1', 'sun', to_date('18-04-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (110, '22 : 0', 'tue', to_date('20-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (111, '23 : 23', 'thu', to_date('23-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (112, '20 : 51', 'wed', to_date('18-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (113, '23 : 59', 'mon', to_date('11-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (114, '19 : 52', 'sun', to_date('08-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (115, '18 : 20', 'mon', to_date('18-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (116, '21 : 12', 'wed', to_date('09-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (117, '21 : 40', 'sat', to_date('19-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (118, '23 : 43', 'wed', to_date('12-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (119, '22 : 20', 'tue', to_date('07-04-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (120, '18 : 52', 'fri', to_date('11-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (121, '21 : 45', 'tue', to_date('08-03-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (122, '23 : 26', 'sun', to_date('04-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (123, '20 : 20', 'sun', to_date('28-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (124, '21 : 2', 'fri', to_date('05-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (125, '23 : 11', 'mon', to_date('01-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (126, '20 : 34', 'thu', to_date('06-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (127, '20 : 37', 'sun', to_date('12-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (128, '19 : 14', 'wed', to_date('01-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (129, '18 : 27', 'thu', to_date('16-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (130, '21 : 38', 'thu', to_date('17-03-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (131, '22 : 7', 'tue', to_date('26-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (132, '21 : 27', 'fri', to_date('09-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (133, '23 : 40', 'sat', to_date('24-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (134, '23 : 11', 'sun', to_date('02-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (135, '21 : 28', 'tue', to_date('11-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (136, '22 : 24', 'tue', to_date('22-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (137, '22 : 49', 'sun', to_date('26-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (138, '22 : 5', 'mon', to_date('12-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (139, '19 : 17', 'wed', to_date('30-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (140, '20 : 37', 'fri', to_date('22-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (141, '22 : 56', 'fri', to_date('27-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (142, '23 : 38', 'thu', to_date('23-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (143, '23 : 19', 'fri', to_date('02-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (144, '22 : 44', 'thu', to_date('17-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (145, '23 : 17', 'mon', to_date('17-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (146, '18 : 50', 'wed', to_date('15-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (147, '23 : 38', 'sat', to_date('19-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (148, '18 : 37', 'sat', to_date('18-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (149, '23 : 32', 'thu', to_date('06-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (150, '22 : 29', 'wed', to_date('06-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (151, '18 : 49', 'sat', to_date('10-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (152, '20 : 35', 'wed', to_date('19-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (153, '20 : 59', 'sun', to_date('02-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (154, '20 : 26', 'tue', to_date('23-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (155, '19 : 9', 'fri', to_date('03-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (156, '23 : 32', 'thu', to_date('02-03-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (157, '20 : 42', 'sat', to_date('19-05-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (158, '21 : 43', 'sun', to_date('05-03-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (159, '19 : 48', 'tue', to_date('31-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (160, '18 : 14', 'wed', to_date('29-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (161, '23 : 45', 'mon', to_date('21-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (162, '22 : 49', 'sun', to_date('28-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (163, '22 : 2', 'wed', to_date('24-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (164, '23 : 24', 'wed', to_date('26-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (165, '20 : 21', 'sat', to_date('25-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (166, '21 : 46', 'thu', to_date('06-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (167, '18 : 20', 'fri', to_date('28-05-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (168, '21 : 57', 'wed', to_date('15-04-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (169, '20 : 6', 'thu', to_date('18-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (170, '22 : 25', 'sun', to_date('18-03-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (171, '19 : 41', 'wed', to_date('26-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (172, '19 : 11', 'fri', to_date('03-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (173, '19 : 8', 'sun', to_date('18-05-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (174, '21 : 33', 'tue', to_date('06-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (175, '20 : 39', 'fri', to_date('20-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (176, '22 : 55', 'sat', to_date('31-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (177, '18 : 18', 'sun', to_date('29-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (178, '20 : 8', 'tue', to_date('10-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (179, '19 : 42', 'sun', to_date('18-05-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (180, '20 : 47', 'wed', to_date('17-05-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (181, '18 : 24', 'wed', to_date('15-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (182, '21 : 25', 'tue', to_date('17-03-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (183, '23 : 14', 'sat', to_date('26-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (184, '22 : 18', 'thu', to_date('12-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (185, '23 : 18', 'wed', to_date('01-03-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (186, '23 : 15', 'thu', to_date('24-03-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (187, '18 : 53', 'fri', to_date('26-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (188, '21 : 7', 'tue', to_date('29-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (189, '23 : 11', 'fri', to_date('08-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (190, '21 : 10', 'fri', to_date('25-04-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (191, '22 : 42', 'sun', to_date('05-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (192, '23 : 12', 'fri', to_date('12-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (193, '20 : 43', 'wed', to_date('20-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (194, '18 : 35', 'tue', to_date('10-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (195, '19 : 17', 'sat', to_date('28-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (196, '18 : 0', 'sat', to_date('04-03-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (197, '22 : 14', 'sun', to_date('10-04-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (198, '23 : 3', 'thu', to_date('15-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (199, '18 : 57', 'thu', to_date('04-03-2024', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into DATES (dateid, hourh, dayd, dated)
values (200, '18 : 40', 'sat', to_date('22-04-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (201, '23 : 55', 'mon', to_date('01-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (202, '18 : 21', 'sat', to_date('16-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (203, '21 : 4', 'sun', to_date('19-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (204, '21 : 13', 'wed', to_date('18-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (205, '18 : 0', 'sat', to_date('02-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (206, '20 : 47', 'thu', to_date('28-05-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (207, '18 : 2', 'thu', to_date('31-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (208, '21 : 43', 'wed', to_date('27-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (209, '19 : 57', 'tue', to_date('31-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (210, '20 : 15', 'tue', to_date('21-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (211, '23 : 40', 'wed', to_date('31-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (212, '20 : 30', 'mon', to_date('30-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (213, '19 : 39', 'wed', to_date('01-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (214, '19 : 32', 'sat', to_date('13-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (215, '20 : 14', 'wed', to_date('11-05-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (216, '23 : 19', 'fri', to_date('18-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (217, '19 : 35', 'sat', to_date('13-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (218, '22 : 25', 'wed', to_date('01-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (219, '19 : 42', 'sat', to_date('24-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (220, '18 : 33', 'fri', to_date('30-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (221, '22 : 2', 'thu', to_date('15-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (222, '18 : 55', 'mon', to_date('09-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (223, '19 : 59', 'mon', to_date('12-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (224, '19 : 23', 'thu', to_date('09-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (225, '21 : 16', 'fri', to_date('03-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (226, '23 : 27', 'sat', to_date('28-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (227, '22 : 1', 'wed', to_date('24-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (228, '20 : 1', 'sat', to_date('28-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (229, '22 : 43', 'tue', to_date('23-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (230, '23 : 1', 'sat', to_date('24-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (231, '21 : 0', 'tue', to_date('15-03-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (232, '22 : 48', 'sat', to_date('14-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (233, '20 : 10', 'sun', to_date('26-04-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (234, '23 : 23', 'mon', to_date('12-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (235, '20 : 36', 'sun', to_date('26-03-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (236, '23 : 29', 'sat', to_date('06-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (237, '21 : 57', 'tue', to_date('29-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (238, '18 : 20', 'tue', to_date('30-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (239, '19 : 7', 'thu', to_date('21-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (240, '19 : 22', 'sat', to_date('11-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (241, '23 : 8', 'tue', to_date('07-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (242, '20 : 44', 'sun', to_date('21-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (243, '19 : 42', 'sat', to_date('14-04-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (244, '20 : 31', 'sat', to_date('05-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (245, '21 : 42', 'fri', to_date('10-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (246, '20 : 51', 'thu', to_date('29-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (247, '19 : 28', 'sun', to_date('06-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (248, '18 : 53', 'sun', to_date('13-05-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (249, '21 : 45', 'sat', to_date('29-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (250, '20 : 27', 'fri', to_date('23-04-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (251, '19 : 45', 'fri', to_date('09-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (252, '22 : 36', 'fri', to_date('05-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (253, '23 : 40', 'wed', to_date('28-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (254, '18 : 1', 'mon', to_date('23-05-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (255, '20 : 17', 'mon', to_date('05-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (256, '22 : 5', 'wed', to_date('23-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (257, '22 : 18', 'thu', to_date('16-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (258, '19 : 56', 'fri', to_date('19-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (259, '20 : 23', 'sun', to_date('30-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (260, '22 : 13', 'mon', to_date('13-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (261, '23 : 11', 'fri', to_date('24-03-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (262, '21 : 42', 'sat', to_date('09-04-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (263, '21 : 5', 'sat', to_date('15-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (264, '18 : 38', 'fri', to_date('22-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (265, '18 : 44', 'thu', to_date('16-03-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (266, '21 : 3', 'wed', to_date('06-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (267, '20 : 26', 'mon', to_date('26-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (268, '18 : 46', 'fri', to_date('29-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (269, '22 : 21', 'mon', to_date('25-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (270, '21 : 14', 'fri', to_date('13-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (271, '21 : 33', 'sun', to_date('08-03-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (272, '22 : 10', 'wed', to_date('11-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (273, '19 : 44', 'thu', to_date('06-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (274, '21 : 6', 'mon', to_date('10-04-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (275, '20 : 56', 'mon', to_date('12-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (276, '18 : 36', 'wed', to_date('02-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (277, '19 : 57', 'mon', to_date('30-05-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (278, '18 : 24', 'tue', to_date('03-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (279, '20 : 34', 'thu', to_date('04-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (280, '18 : 18', 'sun', to_date('21-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (281, '19 : 42', 'sun', to_date('04-04-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (282, '18 : 52', 'sat', to_date('26-03-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (283, '20 : 9', 'mon', to_date('31-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (284, '21 : 4', 'mon', to_date('19-03-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (285, '18 : 27', 'wed', to_date('01-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (286, '18 : 28', 'sat', to_date('02-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (287, '20 : 15', 'mon', to_date('03-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (288, '21 : 33', 'thu', to_date('23-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (289, '18 : 42', 'thu', to_date('14-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (290, '20 : 34', 'mon', to_date('13-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (291, '22 : 31', 'sun', to_date('27-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (292, '20 : 24', 'sat', to_date('18-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (293, '18 : 3', 'tue', to_date('25-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (294, '19 : 7', 'wed', to_date('28-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (295, '22 : 53', 'fri', to_date('25-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (296, '21 : 26', 'sat', to_date('18-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (297, '23 : 31', 'thu', to_date('15-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (298, '20 : 52', 'thu', to_date('25-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (299, '22 : 42', 'tue', to_date('12-03-2024', 'dd-mm-yyyy'));
commit;
prompt 200 records committed...
insert into DATES (dateid, hourh, dayd, dated)
values (300, '19 : 50', 'sun', to_date('30-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (301, '19 : 38', 'fri', to_date('02-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (302, '22 : 30', 'sun', to_date('11-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (303, '18 : 58', 'mon', to_date('03-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (304, '18 : 23', 'thu', to_date('28-04-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (305, '18 : 39', 'sat', to_date('14-04-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (306, '21 : 53', 'tue', to_date('20-03-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (307, '18 : 32', 'fri', to_date('15-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (308, '23 : 34', 'fri', to_date('19-03-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (309, '21 : 47', 'fri', to_date('10-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (310, '22 : 13', 'mon', to_date('29-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (311, '22 : 13', 'wed', to_date('17-04-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (312, '19 : 49', 'sun', to_date('18-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (313, '19 : 18', 'fri', to_date('13-05-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (314, '23 : 12', 'thu', to_date('10-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (315, '19 : 5', 'sat', to_date('13-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (316, '21 : 41', 'sun', to_date('06-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (317, '22 : 49', 'wed', to_date('11-03-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (318, '19 : 19', 'wed', to_date('08-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (319, '23 : 32', 'wed', to_date('21-03-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (320, '23 : 4', 'wed', to_date('13-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (321, '22 : 22', 'mon', to_date('12-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (322, '18 : 52', 'sat', to_date('13-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (323, '20 : 36', 'wed', to_date('06-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (324, '18 : 19', 'fri', to_date('15-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (325, '22 : 42', 'mon', to_date('15-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (326, '19 : 19', 'fri', to_date('23-05-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (327, '18 : 2', 'sun', to_date('29-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (328, '19 : 28', 'fri', to_date('02-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (329, '19 : 26', 'tue', to_date('14-04-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (330, '22 : 21', 'sun', to_date('14-05-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (331, '18 : 34', 'mon', to_date('26-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (332, '19 : 28', 'wed', to_date('05-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (333, '20 : 10', 'fri', to_date('09-04-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (334, '20 : 10', 'tue', to_date('21-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (335, '22 : 2', 'tue', to_date('30-03-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (336, '20 : 17', 'thu', to_date('01-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (337, '18 : 48', 'tue', to_date('16-03-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (338, '19 : 35', 'sun', to_date('18-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (339, '21 : 38', 'thu', to_date('05-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (340, '21 : 8', 'thu', to_date('26-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (341, '20 : 37', 'wed', to_date('05-04-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (342, '20 : 18', 'wed', to_date('16-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (343, '20 : 3', 'sun', to_date('30-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (344, '21 : 42', 'tue', to_date('05-03-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (345, '22 : 30', 'wed', to_date('10-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (346, '20 : 59', 'tue', to_date('10-04-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (347, '19 : 40', 'fri', to_date('03-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (348, '22 : 16', 'sun', to_date('02-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (349, '21 : 8', 'wed', to_date('10-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (350, '19 : 34', 'mon', to_date('15-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (351, '18 : 47', 'tue', to_date('12-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (352, '22 : 55', 'wed', to_date('19-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (353, '22 : 12', 'fri', to_date('27-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (354, '18 : 22', 'wed', to_date('22-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (355, '20 : 45', 'sun', to_date('12-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (356, '19 : 45', 'thu', to_date('04-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (357, '23 : 33', 'sun', to_date('09-05-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (358, '23 : 18', 'sun', to_date('24-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (359, '22 : 12', 'mon', to_date('14-03-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (360, '23 : 2', 'thu', to_date('04-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (361, '20 : 22', 'wed', to_date('25-05-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (362, '23 : 2', 'tue', to_date('01-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (363, '21 : 10', 'tue', to_date('24-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (364, '20 : 26', 'mon', to_date('21-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (365, '20 : 23', 'mon', to_date('01-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (366, '18 : 15', 'thu', to_date('17-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (367, '20 : 23', 'wed', to_date('07-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (368, '22 : 8', 'fri', to_date('26-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (369, '23 : 4', 'thu', to_date('25-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (370, '19 : 45', 'sun', to_date('11-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (371, '21 : 23', 'wed', to_date('30-04-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (372, '20 : 7', 'sat', to_date('28-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (373, '20 : 49', 'tue', to_date('25-04-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (374, '23 : 41', 'tue', to_date('25-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (375, '19 : 42', 'wed', to_date('30-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (376, '23 : 15', 'wed', to_date('09-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (377, '18 : 9', 'fri', to_date('15-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (378, '23 : 43', 'sat', to_date('24-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (379, '22 : 5', 'mon', to_date('15-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (380, '21 : 34', 'sun', to_date('06-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (381, '20 : 49', 'thu', to_date('20-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (382, '22 : 15', 'sat', to_date('21-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (383, '22 : 39', 'sat', to_date('27-03-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (384, '18 : 22', 'fri', to_date('16-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (385, '21 : 7', 'sat', to_date('14-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (386, '18 : 35', 'thu', to_date('06-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (387, '21 : 8', 'tue', to_date('31-03-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (388, '21 : 28', 'wed', to_date('19-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (389, '23 : 59', 'mon', to_date('20-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (390, '20 : 5', 'tue', to_date('03-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (391, '20 : 0', 'mon', to_date('20-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (392, '22 : 23', 'sat', to_date('27-04-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (393, '20 : 13', 'tue', to_date('05-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (394, '23 : 27', 'mon', to_date('19-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (395, '23 : 40', 'fri', to_date('24-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (396, '21 : 30', 'fri', to_date('14-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (397, '21 : 39', 'tue', to_date('24-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (398, '23 : 47', 'sun', to_date('26-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (399, '23 : 41', 'sun', to_date('15-06-2024', 'dd-mm-yyyy'));
commit;
prompt 300 records committed...
insert into DATES (dateid, hourh, dayd, dated)
values (400, '18 : 14', 'fri', to_date('13-05-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (401, '19 : 21', 'mon', to_date('31-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (402, '22 : 54', 'fri', to_date('28-03-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (403, '18 : 56', 'sun', to_date('13-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (404, '19 : 16', 'thu', to_date('24-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (405, '19 : 50', 'wed', to_date('27-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (406, '18 : 24', 'thu', to_date('27-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (407, '18 : 49', 'sat', to_date('05-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (408, '21 : 44', 'thu', to_date('04-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (409, '20 : 10', 'mon', to_date('14-05-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (410, '21 : 56', 'sat', to_date('23-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (411, '19 : 27', 'tue', to_date('08-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (412, '20 : 21', 'sun', to_date('17-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (413, '23 : 16', 'thu', to_date('24-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (414, '21 : 23', 'fri', to_date('30-05-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (415, '22 : 47', 'thu', to_date('17-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (416, '18 : 40', 'sun', to_date('05-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (417, '20 : 0', 'sun', to_date('19-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (418, '19 : 2', 'sun', to_date('29-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (419, '19 : 54', 'tue', to_date('15-04-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (420, '20 : 15', 'sun', to_date('28-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (421, '22 : 24', 'tue', to_date('09-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (422, '19 : 43', 'fri', to_date('22-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (423, '19 : 7', 'tue', to_date('10-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (424, '22 : 49', 'sun', to_date('10-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (425, '19 : 53', 'wed', to_date('31-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (426, '20 : 6', 'tue', to_date('10-05-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (427, '20 : 12', 'sat', to_date('11-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (428, '18 : 27', 'tue', to_date('17-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (429, '22 : 22', 'sat', to_date('04-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (430, '20 : 47', 'sat', to_date('24-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (431, '20 : 33', 'tue', to_date('08-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (432, '22 : 50', 'thu', to_date('19-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (433, '23 : 33', 'thu', to_date('17-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (434, '18 : 32', 'sun', to_date('06-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (435, '23 : 26', 'sun', to_date('03-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (436, '20 : 22', 'wed', to_date('14-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (437, '21 : 1', 'thu', to_date('28-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (438, '21 : 27', 'thu', to_date('24-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (439, '23 : 4', 'thu', to_date('28-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (440, '20 : 25', 'mon', to_date('21-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (441, '23 : 27', 'sun', to_date('18-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (442, '22 : 9', 'fri', to_date('10-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (443, '19 : 56', 'thu', to_date('23-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (444, '23 : 24', 'fri', to_date('11-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (445, '22 : 52', 'thu', to_date('07-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (446, '22 : 0', 'mon', to_date('09-03-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (447, '19 : 49', 'wed', to_date('30-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (448, '22 : 8', 'tue', to_date('14-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (449, '18 : 45', 'fri', to_date('01-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (450, '22 : 15', 'mon', to_date('03-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (451, '22 : 11', 'thu', to_date('14-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (452, '21 : 52', 'mon', to_date('30-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (453, '22 : 12', 'fri', to_date('19-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (454, '21 : 13', 'wed', to_date('19-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (455, '23 : 10', 'sun', to_date('27-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (456, '19 : 34', 'tue', to_date('17-03-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (457, '20 : 16', 'wed', to_date('27-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (458, '22 : 32', 'mon', to_date('30-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (459, '21 : 55', 'fri', to_date('02-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (460, '20 : 3', 'wed', to_date('02-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (461, '21 : 57', 'sat', to_date('17-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (462, '21 : 17', 'sun', to_date('07-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (463, '22 : 40', 'wed', to_date('03-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (464, '20 : 13', 'fri', to_date('16-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (465, '19 : 34', 'tue', to_date('03-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (466, '21 : 12', 'wed', to_date('10-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (467, '19 : 2', 'tue', to_date('16-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (468, '21 : 12', 'tue', to_date('01-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (469, '19 : 47', 'sat', to_date('14-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (470, '19 : 53', 'wed', to_date('16-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (471, '22 : 6', 'sun', to_date('29-05-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (472, '21 : 34', 'thu', to_date('01-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (473, '21 : 54', 'sat', to_date('16-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (474, '22 : 55', 'tue', to_date('15-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (475, '23 : 40', 'sun', to_date('23-04-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (476, '21 : 30', 'sun', to_date('17-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (477, '21 : 2', 'fri', to_date('17-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (478, '18 : 7', 'sat', to_date('21-01-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (479, '23 : 25', 'sat', to_date('24-04-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (480, '18 : 0', 'tue', to_date('16-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (481, '18 : 15', 'wed', to_date('03-03-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (482, '19 : 45', 'thu', to_date('17-02-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (483, '21 : 8', 'sat', to_date('13-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (484, '20 : 6', 'fri', to_date('30-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (485, '23 : 47', 'mon', to_date('08-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (486, '22 : 35', 'wed', to_date('27-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (487, '21 : 49', 'tue', to_date('27-04-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (488, '23 : 56', 'sun', to_date('15-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (489, '18 : 15', 'thu', to_date('10-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (490, '23 : 15', 'thu', to_date('25-12-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (491, '22 : 58', 'sun', to_date('11-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (492, '20 : 5', 'tue', to_date('29-03-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (493, '22 : 48', 'wed', to_date('20-10-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (494, '19 : 17', 'thu', to_date('10-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (495, '22 : 40', 'fri', to_date('13-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (496, '20 : 39', 'fri', to_date('07-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (497, '20 : 18', 'fri', to_date('02-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (498, '21 : 25', 'wed', to_date('10-11-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (499, '21 : 53', 'wed', to_date('07-04-2024', 'dd-mm-yyyy'));
commit;
prompt 400 records loaded
prompt Loading MOVIES...
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (100, 'Crash', 'Musical', 'Ulrike Do Rosario', to_date('24-07-2019', 'dd-mm-yyyy'), 102, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (101, 'Notorious', 'Animation', 'Chanda Stirland', to_date('15-02-2017', 'dd-mm-yyyy'), 107, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (102, 'Giant', 'Biography', 'Dwight Lopez', to_date('02-02-2014', 'dd-mm-yyyy'), 108, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (103, 'Moana', 'Comedy', 'Grannie Brosnan', to_date('11-03-2007', 'dd-mm-yyyy'), 148, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (104, 'Deadpool', 'Fantasy', 'Lenard Pothergill', to_date('20-01-2002', 'dd-mm-yyyy'), 124, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (105, 'Gandhi', 'Action', 'Kele Hastin', to_date('31-12-2010', 'dd-mm-yyyy'), 94, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (106, 'Jumper', 'Documentary', 'Merlina Venables', to_date('21-06-2014', 'dd-mm-yyyy'), 76, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (107, 'Maverick', 'Fantasy', 'Zack Jeandet', to_date('22-07-2018', 'dd-mm-yyyy'), 61, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (108, 'Thor', 'Crime', 'Albertine Sedgwick', to_date('18-01-2016', 'dd-mm-yyyy'), 112, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (109, 'Iron Man', 'Comedy', 'Nefen Bruyett', to_date('06-03-2017', 'dd-mm-yyyy'), 169, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (110, 'Crash', 'Biography', 'Ninnetta Klewi', to_date('10-09-2022', 'dd-mm-yyyy'), 180, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (111, 'Star Trek', 'Action', 'Kirstin Meas', to_date('24-03-2012', 'dd-mm-yyyy'), 94, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (112, 'Brave', 'Horror', 'Farly Haverty', to_date('29-01-2011', 'dd-mm-yyyy'), 129, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (113, 'Witness', 'Sport', 'Bruce Shrimpton', to_date('05-01-2021', 'dd-mm-yyyy'), 82, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (114, 'Zombieland', 'Biography', 'Felecia Simoneschi', to_date('31-05-2001', 'dd-mm-yyyy'), 177, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (115, 'Dumbo', 'Comedy', 'Avictor Hews', to_date('02-05-2015', 'dd-mm-yyyy'), 127, 5);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (116, 'Clerks', 'Comedy', 'Nada Cogar', to_date('01-07-2003', 'dd-mm-yyyy'), 114, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (117, 'Amelie', 'Thriller', 'Ossie Ilyushkin', to_date('22-07-2012', 'dd-mm-yyyy'), 176, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (118, 'Trumbo', 'Documentary', 'Maisey Haughton', to_date('30-06-2009', 'dd-mm-yyyy'), 111, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (119, 'Rio', 'Romance', 'Reiko Bucher', to_date('11-09-2008', 'dd-mm-yyyy'), 144, 5);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (120, 'Black Swan', 'Adventure', 'Esta Papen', to_date('14-06-2005', 'dd-mm-yyyy'), 114, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (121, 'Goonies', 'Sport', 'Philippe Conradie', to_date('05-03-2009', 'dd-mm-yyyy'), 99, 5);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (122, 'Rio', 'Documentary', 'Norman Deadman', to_date('22-12-2015', 'dd-mm-yyyy'), 73, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (123, 'Twister', 'Horror', 'Ursola Masson', to_date('27-03-2022', 'dd-mm-yyyy'), 64, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (124, 'Jaws', 'Adventure', 'Kizzie Keepin', to_date('17-01-2008', 'dd-mm-yyyy'), 91, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (125, 'Singles', 'Romance', 'Gene Fulloway', to_date('25-11-2006', 'dd-mm-yyyy'), 149, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (126, 'Contact', 'Action', 'Lark Wolfindale', to_date('04-12-2009', 'dd-mm-yyyy'), 106, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (127, 'Witness', 'Biography', 'Patty Teasdale', to_date('16-08-2001', 'dd-mm-yyyy'), 89, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (128, 'Shrek', 'Fantasy', 'Blane Edge', to_date('11-12-2020', 'dd-mm-yyyy'), 109, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (129, 'Superbad', 'Sci-Fi', 'Filbert Muzzollo', to_date('09-11-2007', 'dd-mm-yyyy'), 111, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (130, 'Watchmen', 'Adventure', 'Ana England', to_date('19-07-2000', 'dd-mm-yyyy'), 62, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (131, 'Trumbo', 'Horror', 'Mallorie Lilly', to_date('06-09-2004', 'dd-mm-yyyy'), 120, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (132, 'Shrek', 'History', 'Aldis Luton', to_date('28-11-2004', 'dd-mm-yyyy'), 125, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (133, 'Gandhi', 'War', 'Lorraine Bothbie', to_date('18-04-2013', 'dd-mm-yyyy'), 89, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (134, 'Matilda', 'Comedy', 'Manolo Vasilkov', to_date('12-11-2009', 'dd-mm-yyyy'), 87, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (135, 'Dumbo', 'Family', 'Rebekkah Leverette', to_date('07-06-2004', 'dd-mm-yyyy'), 72, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (136, 'Jumanji', 'Drama', 'Roseann Esmond', to_date('01-08-2016', 'dd-mm-yyyy'), 81, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (137, 'Star Trek', 'Thriller', 'Giacobo Carty', to_date('14-04-2013', 'dd-mm-yyyy'), 116, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (138, 'Gandhi', 'Thriller', 'Patton Bussy', to_date('30-07-2009', 'dd-mm-yyyy'), 103, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (139, 'Bolt', 'Thriller', 'Ophelie Ertel', to_date('01-03-2013', 'dd-mm-yyyy'), 144, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (140, 'Superbad', 'Sci-Fi', 'Peri Lambkin', to_date('19-02-2014', 'dd-mm-yyyy'), 138, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (141, 'Looper', 'Biography', 'Benn Richings', to_date('29-07-2013', 'dd-mm-yyyy'), 97, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (142, 'Cop Land', 'Thriller', 'Vasilis Hannum', to_date('18-05-2020', 'dd-mm-yyyy'), 87, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (143, 'Selma', 'Documentary', 'Gordie Chilley', to_date('20-11-2020', 'dd-mm-yyyy'), 118, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (144, 'Rushmore', 'Mystery', 'Sindee Chieze', to_date('10-05-2002', 'dd-mm-yyyy'), 155, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (145, 'Xanadu', 'Thriller', 'Tedie Benne', to_date('30-03-2005', 'dd-mm-yyyy'), 174, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (146, 'Erin Brock', 'Mystery', 'Elwood Nelissen', to_date('05-02-2013', 'dd-mm-yyyy'), 108, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (147, 'Witness', 'Sci-Fi', 'Brion Fellows', to_date('16-07-2010', 'dd-mm-yyyy'), 97, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (148, 'Gandhi', 'Family', 'Rabi Champley', to_date('07-03-2003', 'dd-mm-yyyy'), 172, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (149, 'Jumper', 'Sport', 'Pietra Folshom', to_date('20-02-2019', 'dd-mm-yyyy'), 162, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (150, 'Tombstone', 'Sci-Fi', 'Mike Grimsell', to_date('13-05-2021', 'dd-mm-yyyy'), 122, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (151, 'Speed', 'Thriller', 'Graehme Presnail', to_date('05-06-2008', 'dd-mm-yyyy'), 151, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (152, 'Hancock', 'Mystery', 'Aylmer Crombie', to_date('03-11-2002', 'dd-mm-yyyy'), 104, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (153, 'Gandhi', 'Sci-Fi', 'Abra Parkisson', to_date('18-11-2003', 'dd-mm-yyyy'), 67, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (154, 'Gandhi', 'Western', 'Nevile Waterfall', to_date('03-09-2022', 'dd-mm-yyyy'), 125, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (155, 'Deadpool', 'Musical', 'Enrichetta Goff', to_date('12-07-2006', 'dd-mm-yyyy'), 138, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (156, 'Gremlins', 'Western', 'Kelsi Blayd', to_date('28-11-2021', 'dd-mm-yyyy'), 136, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (157, 'Memento', 'War', 'Corrine Pannett', to_date('17-06-2009', 'dd-mm-yyyy'), 86, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (158, 'Rushmore', 'Romance', 'Audi Kubacki', to_date('24-08-2007', 'dd-mm-yyyy'), 65, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (159, 'The Mask', 'Sport', 'Gwenette Physick', to_date('22-11-2010', 'dd-mm-yyyy'), 78, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (160, 'Speed', 'Drama', 'Raff Manus', to_date('03-02-2007', 'dd-mm-yyyy'), 174, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (161, 'Twister', 'History', 'Natal Haslock', to_date('17-05-2011', 'dd-mm-yyyy'), 145, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (162, 'X-', 'Mystery', 'Kaitlyn Kibbey', to_date('01-12-2003', 'dd-mm-yyyy'), 108, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (163, 'Rocky', 'Adventure', 'Sunshine Veazey', to_date('05-07-2022', 'dd-mm-yyyy'), 79, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (164, 'Coraline', 'Western', 'Drucill Beaves', to_date('23-10-2004', 'dd-mm-yyyy'), 127, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (165, 'Gattaca', 'Sci-Fi', 'Sherry Cawood', to_date('17-05-2015', 'dd-mm-yyyy'), 134, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (166, 'Nim''s Island', 'Drama', 'Gwendolyn Howes', to_date('27-02-2023', 'dd-mm-yyyy'), 124, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (167, 'Deadpool', 'Documentary', 'Sammy Madrell', to_date('03-12-2012', 'dd-mm-yyyy'), 93, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (168, 'Lincoln', 'Sci-Fi', 'Mendie Mushet', to_date('28-06-2015', 'dd-mm-yyyy'), 75, 5);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (169, 'Coco', 'Western', 'Farly Dumbelton', to_date('25-03-2016', 'dd-mm-yyyy'), 148, 5);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (170, 'Casino', 'Biography', 'Bogart Burle', to_date('21-03-2016', 'dd-mm-yyyy'), 127, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (171, 'Gattaca', 'History', 'Shir Redman', to_date('16-09-2020', 'dd-mm-yyyy'), 166, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (172, 'Moana', 'Drama', 'Astrid Cinelli', to_date('09-03-2002', 'dd-mm-yyyy'), 149, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (173, 'Aliens', 'Horror', 'Annamaria Ismead', to_date('11-11-2002', 'dd-mm-yyyy'), 160, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (174, 'Dumbo', 'Adventure', 'Consuelo Impey', to_date('12-10-2021', 'dd-mm-yyyy'), 83, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (175, 'Risen', 'Animation', 'Sharla Dorcey', to_date('14-08-2011', 'dd-mm-yyyy'), 105, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (176, 'Whiplash', 'Biography', 'Nadia Peddowe', to_date('11-08-2007', 'dd-mm-yyyy'), 106, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (177, 'Poltergeist', 'Biography', 'Sterling Ingles', to_date('09-11-2012', 'dd-mm-yyyy'), 84, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (178, 'Doubt', 'History', 'Venus Bumfrey', to_date('06-02-2011', 'dd-mm-yyyy'), 135, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (179, 'Twister', 'Drama', 'Cletus Staley', to_date('02-03-2015', 'dd-mm-yyyy'), 163, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (180, 'Zoolander', 'Crime', 'Frieda McGorley', to_date('09-01-2015', 'dd-mm-yyyy'), 87, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (181, 'Sin City', 'Fantasy', 'Gard Vannoort', to_date('25-10-2014', 'dd-mm-yyyy'), 89, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (182, 'Ali', 'Adventure', 'Felipe Bignal', to_date('07-11-2005', 'dd-mm-yyyy'), 145, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (183, 'Chappie', 'Sport', 'Gustavus Wilbor', to_date('26-04-2016', 'dd-mm-yyyy'), 156, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (184, 'Risen', 'Sci-Fi', 'Jemimah Aldritt', to_date('10-09-2020', 'dd-mm-yyyy'), 163, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (185, 'Thor', 'Documentary', 'Thorvald Bagenal', to_date('11-09-2011', 'dd-mm-yyyy'), 172, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (186, 'Avatar', 'Romance', 'Joline Picford', to_date('04-09-2000', 'dd-mm-yyyy'), 73, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (187, 'Iron Man', 'Romance', 'Sargent Collar', to_date('06-08-2017', 'dd-mm-yyyy'), 160, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (188, 'Godzilla', 'Crime', 'Ivor Halshaw', to_date('11-07-2002', 'dd-mm-yyyy'), 60, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (189, 'Maverick', 'Sport', 'Hirsch Becks', to_date('18-11-2001', 'dd-mm-yyyy'), 115, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (190, 'Chocolat', 'Biograp', 'Sam Antoniewicz', to_date('07-04-2012', 'dd-mm-yyyy'), 127, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (191, 'Moana', 'Thriller', 'Witty Zimmerman', to_date('11-05-2013', 'dd-mm-yyyy'), 113, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (192, 'Casino', 'Adventure', 'Lynelle Adnams', to_date('04-08-2002', 'dd-mm-yyyy'), 67, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (193, 'Witness', 'Thriller', 'Aida Tourne', to_date('26-10-2019', 'dd-mm-yyyy'), 120, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (194, 'Sideways', 'Western', 'Pris Brach', to_date('09-08-2009', 'dd-mm-yyyy'), 90, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (195, 'Matilda', 'Drama', 'Cord MacKnockiter', to_date('10-05-2004', 'dd-mm-yyyy'), 119, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (196, 'Elf', 'Sport', 'Rabbi Pershouse', to_date('11-05-2013', 'dd-mm-yyyy'), 146, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (197, 'Rocky', 'Horror', 'Joey Aitken', to_date('17-06-2006', 'dd-mm-yyyy'), 90, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (198, 'Moonlight', 'Sci-Fi', 'Randi Pattini', to_date('02-09-2008', 'dd-mm-yyyy'), 69, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (199, 'Labyrinth', 'Mystery', 'Olly Schubuser', to_date('09-04-2014', 'dd-mm-yyyy'), 133, 9);
commit;
prompt 100 records committed...
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (200, 'Moon', 'Horror', 'Margarethe De Simoni', to_date('30-05-2011', 'dd-mm-yyyy'), 116, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (201, 'Contact', 'Comedy', 'Katleen Fermor', to_date('06-07-2014', 'dd-mm-yyyy'), 72, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (202, 'Unforgiven', 'Sport', 'Isidro Marini', to_date('30-03-2004', 'dd-mm-yyyy'), 78, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (203, 'Ant-Man', 'Fantasy', 'Albie Cheak', to_date('12-12-2014', 'dd-mm-yyyy'), 71, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (204, 'Trumbo', 'Sci-Fi', 'Ola Quantick', to_date('23-12-2022', 'dd-mm-yyyy'), 180, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (205, 'Frida', 'Animation', 'Batholomew Rains', to_date('14-03-2005', 'dd-mm-yyyy'), 133, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (206, 'Hancock', 'Biography', 'Jenni Fantin', to_date('27-05-2013', 'dd-mm-yyyy'), 117, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (207, 'Gandhi', 'Mystery', 'Spence Orwell', to_date('13-04-2007', 'dd-mm-yyyy'), 146, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (208, 'Amelie', 'War', 'Benni Gergely', to_date('20-05-2016', 'dd-mm-yyyy'), 79, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (209, 'Witness', 'War', 'Cathe Kulver', to_date('25-12-2000', 'dd-mm-yyyy'), 142, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (210, 'Sideways', 'Romance', 'Fara Bumby', to_date('26-01-2021', 'dd-mm-yyyy'), 140, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (211, 'Rocky', 'Romance', 'Whit Welfair', to_date('24-11-2015', 'dd-mm-yyyy'), 180, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (212, 'Twister', 'Crime', 'Aloise Boom', to_date('02-05-2023', 'dd-mm-yyyy'), 111, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (213, 'Giant', 'Drama', 'Luke Strognell', to_date('04-10-2019', 'dd-mm-yyyy'), 81, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (214, 'Whiplash', 'Crime', 'Bobbye Durnall', to_date('07-04-2020', 'dd-mm-yyyy'), 66, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (215, 'Zombieland', 'War', 'Saunders Purbrick', to_date('21-06-2023', 'dd-mm-yyyy'), 108, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (216, 'Fargo', 'Animation', 'Giralda Oyley', to_date('04-12-2000', 'dd-mm-yyyy'), 96, 5);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (217, 'Giant', 'Adventure', 'Lorain Buttrick', to_date('07-06-2019', 'dd-mm-yyyy'), 100, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (218, 'Black Swan', 'Musical', 'Luce Rantoull', to_date('30-08-2004', 'dd-mm-yyyy'), 68, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (219, 'Twister', 'Fantasy', 'Zitella Baxstair', to_date('14-03-2019', 'dd-mm-yyyy'), 166, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (220, 'Paprika', 'Sci-Fi', 'Lolly McIlenna', to_date('22-12-2021', 'dd-mm-yyyy'), 152, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (221, 'Fargo', 'Musical', 'Powell Remmer', to_date('10-02-2011', 'dd-mm-yyyy'), 88, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (222, 'Rushmore', 'History', 'Ronny Brownsmith', to_date('16-02-2013', 'dd-mm-yyyy'), 120, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (223, 'Witness', 'Romance', 'Etta Sackett', to_date('28-11-2022', 'dd-mm-yyyy'), 110, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (224, 'Bolt', 'Fantasy', 'Ivar Riddoch', to_date('13-02-2024', 'dd-mm-yyyy'), 179, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (225, 'Beetlejuice', 'Action', 'Eunice Goligher', to_date('21-11-2017', 'dd-mm-yyyy'), 179, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (226, 'Chocolat', 'Animation', 'Isaak Frye', to_date('24-10-2020', 'dd-mm-yyyy'), 108, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (227, 'Paprika', 'Adventure', 'Jeanne Dafforne', to_date('21-09-2016', 'dd-mm-yyyy'), 78, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (228, 'Signs', 'Crime', 'Chelsie Thorneley', to_date('12-12-2018', 'dd-mm-yyyy'), 159, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (229, 'Amelie', 'Drama', 'Esra Bretelle', to_date('17-03-2012', 'dd-mm-yyyy'), 112, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (230, 'Up', 'Comedy', 'Ciro Ellesmere', to_date('15-02-2001', 'dd-mm-yyyy'), 140, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (231, 'Signs', 'Animation', 'Torrance Dobrowlski', to_date('17-08-2014', 'dd-mm-yyyy'), 104, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (232, 'Whiplash', 'Horror', 'Lamar Adnett', to_date('18-06-2023', 'dd-mm-yyyy'), 146, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (233, 'Coraline', 'Drama', 'Lib Frost', to_date('29-01-2020', 'dd-mm-yyyy'), 71, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (234, 'Moon', 'Western', 'Ulrick Skrzynski', to_date('05-04-2009', 'dd-mm-yyyy'), 169, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (235, 'Memento', 'Biography', 'Adriano Chapling', to_date('26-08-2019', 'dd-mm-yyyy'), 175, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (236, 'Gigi', 'Adventure', 'Otto Schrir', to_date('06-04-2020', 'dd-mm-yyyy'), 137, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (237, 'Gremlins', 'Drama', 'Nell Augur', to_date('21-09-2016', 'dd-mm-yyyy'), 99, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (238, 'Wild', 'Animation', 'Janis Normanton', to_date('29-05-2012', 'dd-mm-yyyy'), 177, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (239, 'Clerks', 'Action', 'Olivero Djordjevic', to_date('25-07-2001', 'dd-mm-yyyy'), 112, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (240, 'Superbad', 'Thriller', 'Karlis De Goey', to_date('26-02-2005', 'dd-mm-yyyy'), 163, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (241, 'Thor', 'Sport', 'Ethelbert Pelman', to_date('16-04-2019', 'dd-mm-yyyy'), 141, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (242, 'Thor', 'Thriller', 'Bruno Plaster', to_date('01-04-2018', 'dd-mm-yyyy'), 117, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (243, 'Avatar', 'Documentary', 'Randy Truscott', to_date('05-05-2010', 'dd-mm-yyyy'), 98, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (244, 'Erin Brock', 'Horror', 'Randy Benedettini', to_date('11-05-2012', 'dd-mm-yyyy'), 146, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (245, 'Spartacus', 'Horror', 'Kamilah Beckerleg', to_date('02-09-2008', 'dd-mm-yyyy'), 164, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (246, 'Matilda', 'Action', 'Erv Syrie', to_date('04-01-2012', 'dd-mm-yyyy'), 72, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (247, 'Scarface', 'Family', 'Walden Proger', to_date('05-01-2007', 'dd-mm-yyyy'), 154, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (248, 'Hercules', 'Horror', 'Allegra Connett', to_date('08-12-2002', 'dd-mm-yyyy'), 94, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (249, 'Labyrinth', 'Sport', 'Dew Norway', to_date('02-07-2020', 'dd-mm-yyyy'), 111, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (250, 'Titanic', 'Comedy', 'Elayne Markwick', to_date('05-08-2005', 'dd-mm-yyyy'), 167, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (251, 'Babe', 'History', 'Alison Fellibrand', to_date('14-02-2012', 'dd-mm-yyyy'), 156, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (252, 'Ratatouille', 'War', 'Colly Novic', to_date('02-09-2017', 'dd-mm-yyyy'), 179, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (253, 'Risen', 'War', 'Cordula Lehrer', to_date('16-06-2006', 'dd-mm-yyyy'), 99, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (254, 'Patton', 'History', 'Briggs Lortzing', to_date('18-12-2007', 'dd-mm-yyyy'), 141, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (255, 'Singles', 'Horror', 'Amanda Gerwood', to_date('01-05-2010', 'dd-mm-yyyy'), 108, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (256, 'Black Swan', 'Action', 'Aaren Mangan', to_date('13-03-2018', 'dd-mm-yyyy'), 122, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (257, 'Contact', 'Thriller', 'Octavius Kinneir', to_date('28-06-2020', 'dd-mm-yyyy'), 89, 5);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (258, 'Rudy', 'Animation', 'Avrit Janata', to_date('18-04-2010', 'dd-mm-yyyy'), 127, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (259, 'Casino', 'Action', 'Finlay Swalteridge', to_date('07-12-2016', 'dd-mm-yyyy'), 96, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (260, 'Rushmore', 'Musical', 'Alonzo Pavy', to_date('23-01-2021', 'dd-mm-yyyy'), 103, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (261, 'Zoolander', 'Adventure', 'Giffard Naire', to_date('10-04-2012', 'dd-mm-yyyy'), 149, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (262, 'Gravity', 'Family', 'Clair Bantock', to_date('22-11-2023', 'dd-mm-yyyy'), 131, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (263, 'Paprika', 'Sci-Fi', 'Issie Olrenshaw', to_date('20-09-2016', 'dd-mm-yyyy'), 156, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (264, 'Psycho', 'Adventure', 'Alfi Hammerberger', to_date('07-09-2023', 'dd-mm-yyyy'), 162, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (265, 'Labyrinth', 'Fantasy', 'Marian Lutsch', to_date('13-02-2010', 'dd-mm-yyyy'), 135, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (266, 'Thor', 'War', 'Kerrill Highton', to_date('09-04-2023', 'dd-mm-yyyy'), 122, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (267, 'Unbroken', 'Adventure', 'Iolande Comusso', to_date('13-06-2023', 'dd-mm-yyyy'), 60, 5);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (268, 'Dumbo', 'Musical', 'Wilt Margarson', to_date('27-02-2020', 'dd-mm-yyyy'), 130, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (269, 'Jaws', 'Thriller', 'Marylinda Copas', to_date('05-05-2021', 'dd-mm-yyyy'), 82, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (270, 'Bolt', 'Crime', 'Raynell Lamminam', to_date('22-08-2001', 'dd-mm-yyyy'), 164, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (271, 'Shutter', 'Comedy', 'Jolene Denisevich', to_date('17-05-2002', 'dd-mm-yyyy'), 97, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (272, 'Spartacus', 'Mystery', 'Ardyce Beckensall', to_date('08-02-2022', 'dd-mm-yyyy'), 132, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (273, 'Matilda', 'Western', 'Kathi Castillon', to_date('19-06-2012', 'dd-mm-yyyy'), 172, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (274, 'Hackers', 'Action', 'Alina Liddel', to_date('20-04-2021', 'dd-mm-yyyy'), 108, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (275, 'Notorious', 'Action', 'Brynne Manuello', to_date('13-08-2022', 'dd-mm-yyyy'), 147, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (276, 'Amadeus', 'Fantasy', 'Harman Crate', to_date('22-11-2005', 'dd-mm-yyyy'), 122, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (277, 'Deadpool', 'Sport', 'Erica Langley', to_date('21-10-2022', 'dd-mm-yyyy'), 175, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (278, 'Arrival', 'Documentary', 'Niall Mustard', to_date('23-09-2007', 'dd-mm-yyyy'), 127, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (279, 'Clueless', 'Biography', 'Clywd Finlaison', to_date('28-02-2016', 'dd-mm-yyyy'), 119, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (280, 'Kill Bill', 'Drama', 'Fanchette Brothers', to_date('13-03-2015', 'dd-mm-yyyy'), 83, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (281, 'Gigi', 'Family', 'Ellene Drinkel', to_date('13-09-2005', 'dd-mm-yyyy'), 180, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (282, 'Cinderella', 'Mystery', 'Merralee Wrench', to_date('27-09-2009', 'dd-mm-yyyy'), 63, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (283, 'Rango', 'Crime', 'Kenon Paulitschke', to_date('01-11-2007', 'dd-mm-yyyy'), 79, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (284, 'Moonlight', 'War', 'Giralda Conachie', to_date('28-02-2009', 'dd-mm-yyyy'), 85, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (285, 'Spartacus', 'Documentary', 'Gwendolen Marians', to_date('31-12-2004', 'dd-mm-yyyy'), 113, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (286, 'Hugo', 'Mystery', 'Alexine Mowday', to_date('10-07-2009', 'dd-mm-yyyy'), 149, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (287, 'Trumbo', 'Drama', 'Nonah Hiscoke', to_date('24-12-2013', 'dd-mm-yyyy'), 134, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (288, 'Rio', 'Horror', 'Emogene Hadgraft', to_date('12-02-2006', 'dd-mm-yyyy'), 98, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (289, 'District 9', 'Horror', 'Seka Allbones', to_date('05-11-2011', 'dd-mm-yyyy'), 180, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (290, 'Split', 'History', 'Maryanna Streader', to_date('12-09-2003', 'dd-mm-yyyy'), 109, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (291, 'Airplane', 'Sci-Fi', 'Zara Kiljan', to_date('14-11-2018', 'dd-mm-yyyy'), 82, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (292, 'Boyhood', 'Action', 'Alley Mark', to_date('09-12-2022', 'dd-mm-yyyy'), 82, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (293, 'Risen', 'Sci-Fi', 'Trumaine Yanov', to_date('02-06-2014', 'dd-mm-yyyy'), 119, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (294, 'Coraline', 'Adventure', 'Enrichetta Conlon', to_date('28-06-2009', 'dd-mm-yyyy'), 96, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (295, 'Notebook', 'Comedy', 'Dredi Cansdell', to_date('02-06-2012', 'dd-mm-yyyy'), 63, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (296, 'Cop Land', 'Biography', 'Tully Torn', to_date('19-11-2022', 'dd-mm-yyyy'), 139, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (297, 'Boyhood', 'Crime', 'Barde Eeles', to_date('28-08-2017', 'dd-mm-yyyy'), 162, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (298, 'Contact', 'Drama', 'Jennine Bottlestone', to_date('22-12-2017', 'dd-mm-yyyy'), 156, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (299, 'Twister', 'Thriller', 'Eddie Lince', to_date('09-01-2015', 'dd-mm-yyyy'), 108, 10);
commit;
prompt 200 records committed...
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (300, 'Split', 'Comedy', 'Rafaelita Drummond', to_date('18-05-2016', 'dd-mm-yyyy'), 147, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (301, 'Capote', 'Mystery', 'Staci Abdee', to_date('06-04-2014', 'dd-mm-yyyy'), 160, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (302, 'Goonies', 'War', 'Tally Deeney', to_date('27-09-2019', 'dd-mm-yyyy'), 70, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (303, 'Rudy', 'Horror', 'Latashia Romi', to_date('15-08-2010', 'dd-mm-yyyy'), 104, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (304, 'Sideways', 'Thriller', 'Pasquale Barstowk', to_date('11-01-2016', 'dd-mm-yyyy'), 143, 5);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (305, 'Scream', 'War', 'Dorelia Millmoe', to_date('26-09-2014', 'dd-mm-yyyy'), 135, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (306, 'Avatar', 'Action', 'Lek Darrigone', to_date('15-06-2018', 'dd-mm-yyyy'), 99, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (307, 'Memento', 'Animation', 'Giusto Normington', to_date('12-08-2012', 'dd-mm-yyyy'), 154, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (308, 'Platoon', 'Musical', 'Dinny Wichard', to_date('10-06-2003', 'dd-mm-yyyy'), 77, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (309, 'Hancock', 'Sci-Fi', 'Eugine Skynner', to_date('02-02-2006', 'dd-mm-yyyy'), 110, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (310, 'Gandhi', 'Sport', 'Frasco Milch', to_date('27-03-2006', 'dd-mm-yyyy'), 108, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (311, 'Moana', 'Sci-Fi', 'Anita Westbrook', to_date('13-11-2006', 'dd-mm-yyyy'), 151, 5);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (312, 'Hugo', 'Fantasy', 'Dell Skipworth', to_date('09-10-2003', 'dd-mm-yyyy'), 113, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (313, 'Twister', 'History', 'Lauralee Saltern', to_date('01-04-2002', 'dd-mm-yyyy'), 176, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (314, 'Ted', 'History', 'Fleming De Lorenzo', to_date('20-09-2005', 'dd-mm-yyyy'), 156, 5);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (315, 'Avatar', 'Drama', 'Winfield Abrashkov', to_date('14-02-2004', 'dd-mm-yyyy'), 166, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (316, 'Patton', 'Musical', 'Dael Lockyear', to_date('26-10-2015', 'dd-mm-yyyy'), 129, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (317, 'Frida', 'Drama', 'Buddy Beadell', to_date('16-08-2016', 'dd-mm-yyyy'), 84, 5);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (318, 'Grease', 'Crime', 'Jewel Southey', to_date('06-11-2023', 'dd-mm-yyyy'), 122, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (319, 'Capote', 'Sport', 'Jacenta Clendennen', to_date('20-03-2022', 'dd-mm-yyyy'), 103, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (320, 'Doubt', 'Drama', 'Dione Piddlesden', to_date('29-05-2023', 'dd-mm-yyyy'), 68, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (321, 'Gravity', 'Biography', 'Hal Trevillion', to_date('21-08-2021', 'dd-mm-yyyy'), 63, 5);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (322, 'Black Swan', 'Mystery', 'Farah Beaford', to_date('14-02-2007', 'dd-mm-yyyy'), 160, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (323, 'Unforgiven', 'Musical', 'Mirabelle Paver', to_date('20-04-2022', 'dd-mm-yyyy'), 89, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (324, 'Crash', 'Musical', 'Clarice Batman', to_date('07-11-2014', 'dd-mm-yyyy'), 75, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (325, 'Witness', 'Family', 'Lodovico Franseco', to_date('22-05-2000', 'dd-mm-yyyy'), 166, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (326, 'Platoon', 'Documentary', 'Osmund Springer', to_date('31-08-2014', 'dd-mm-yyyy'), 171, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (327, 'Cowboys', 'Horror', 'Wilfrid Rizzardini', to_date('24-07-2016', 'dd-mm-yyyy'), 102, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (328, 'Star Trek', 'Documentary', 'Colleen Goulstone', to_date('13-06-2001', 'dd-mm-yyyy'), 75, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (329, 'Twister', 'Sport', 'Demott Hebson', to_date('19-03-2022', 'dd-mm-yyyy'), 118, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (330, 'Tombstone', 'Thriller', 'Norry Rollings', to_date('24-11-2016', 'dd-mm-yyyy'), 110, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (331, 'Speed', 'Adventure', 'Ingrim Adds', to_date('23-01-2018', 'dd-mm-yyyy'), 98, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (332, 'Thor', 'Family', 'Blanche Jaques', to_date('02-06-2016', 'dd-mm-yyyy'), 124, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (333, 'Rango', 'History', 'Clayson MacCorkell', to_date('28-05-2004', 'dd-mm-yyyy'), 160, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (334, 'Arrival', 'Sci-Fi', 'Dion McCumskay', to_date('08-01-2015', 'dd-mm-yyyy'), 126, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (335, 'Skyfall', 'Animation', 'Maxwell Syder', to_date('04-02-2024', 'dd-mm-yyyy'), 110, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (336, 'Holes', 'Documentary', 'Annmaria Bromidge', to_date('15-09-2011', 'dd-mm-yyyy'), 175, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (337, 'Chocolat', 'Animation', 'Reiko Palluschek', to_date('03-12-2017', 'dd-mm-yyyy'), 85, 5);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (338, 'Flubber', 'Mystery', 'Shawn Dougherty', to_date('05-09-2023', 'dd-mm-yyyy'), 136, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (339, 'Split', 'Musical', 'Nona Benneton', to_date('08-10-2000', 'dd-mm-yyyy'), 72, 5);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (340, 'Gladiator', 'Action', 'Kizzie Dulieu', to_date('30-01-2024', 'dd-mm-yyyy'), 142, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (341, 'Casino', 'Thriller', 'Shawn Williscroft', to_date('12-01-2011', 'dd-mm-yyyy'), 139, 5);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (342, 'X-', 'Musical', 'Chris Elvy', to_date('20-02-2024', 'dd-mm-yyyy'), 79, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (343, 'Jumanji', 'Crime', 'Noll Mannix', to_date('15-02-2013', 'dd-mm-yyyy'), 139, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (344, 'Shutter', 'Crime', 'Theda Sarchwell', to_date('02-09-2014', 'dd-mm-yyyy'), 67, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (345, 'Giant', 'Documentary', 'Marissa Picot', to_date('22-02-2013', 'dd-mm-yyyy'), 73, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (346, 'Star Trek', 'Sport', 'Leanor Woodcroft', to_date('02-11-2005', 'dd-mm-yyyy'), 156, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (347, 'Amelie', 'Thriller', 'Hunt Ashbey', to_date('27-08-2018', 'dd-mm-yyyy'), 138, 5);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (348, 'Witness', 'Sport', 'Lief Ronisch', to_date('07-12-2000', 'dd-mm-yyyy'), 80, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (349, 'Crash', 'Biography', 'Neil Gilliam', to_date('17-12-2001', 'dd-mm-yyyy'), 177, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (350, 'Crash', 'Action', 'Hedvig Mars', to_date('05-09-2002', 'dd-mm-yyyy'), 134, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (351, 'Kill Bill', 'Crime', 'Leesa Dalwood', to_date('23-07-2005', 'dd-mm-yyyy'), 135, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (352, 'Ratatouille', 'History', 'Carlotta Winstone', to_date('02-06-2010', 'dd-mm-yyyy'), 67, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (353, 'Trumbo', 'History', 'Salome Gredden', to_date('01-06-2009', 'dd-mm-yyyy'), 178, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (354, 'Speed', 'Mystery', 'Levey Paudin', to_date('13-03-2012', 'dd-mm-yyyy'), 129, 5);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (355, 'Stargate', 'History', 'Ruthy Rosenstein', to_date('08-11-2010', 'dd-mm-yyyy'), 146, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (356, 'Sideways', 'Animation', 'Bert Slowan', to_date('26-09-2009', 'dd-mm-yyyy'), 72, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (357, 'Airplane', 'War', 'Connie Withull', to_date('17-02-2015', 'dd-mm-yyyy'), 122, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (358, 'Clerks', 'History', 'Fawnia Heaysman', to_date('31-07-2004', 'dd-mm-yyyy'), 99, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (359, 'Ted', 'Family', 'Luigi Bossons', to_date('18-10-2019', 'dd-mm-yyyy'), 130, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (360, 'Fences', 'Horror', 'Darlene McKinty', to_date('04-09-2007', 'dd-mm-yyyy'), 104, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (361, 'Flubber', 'Musical', 'Errick Aulton', to_date('02-07-2001', 'dd-mm-yyyy'), 145, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (362, 'Bolt', 'Crime', 'Toby Humblestone', to_date('13-10-2015', 'dd-mm-yyyy'), 92, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (363, 'Twister', 'Horror', 'Evangelina Saw', to_date('21-10-2009', 'dd-mm-yyyy'), 159, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (364, 'Tombstone', 'Crime', 'Doralynne Gannaway', to_date('12-11-2001', 'dd-mm-yyyy'), 150, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (365, 'Aliens', 'Mystery', 'Abbey Robel', to_date('25-12-2016', 'dd-mm-yyyy'), 87, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (366, 'Gravity', 'Animation', 'Natka Tysack', to_date('04-03-2004', 'dd-mm-yyyy'), 127, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (367, 'Iron Man', 'Horror', 'Gregorio Hirsthouse', to_date('05-03-2015', 'dd-mm-yyyy'), 161, 5);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (368, 'Signs', 'Mystery', 'Seymour Jatczak', to_date('28-05-2003', 'dd-mm-yyyy'), 77, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (369, 'Capote', 'Mystery', 'Greta Bras', to_date('08-10-2014', 'dd-mm-yyyy'), 67, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (370, 'Whiplash', 'Documentary', 'Cristine Gagan', to_date('08-10-2018', 'dd-mm-yyyy'), 112, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (371, 'Casino', 'Sport', 'Cassy Killingworth', to_date('22-02-2010', 'dd-mm-yyyy'), 129, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (372, 'Logan', 'Biography', 'Candy Le Gassick', to_date('27-01-2023', 'dd-mm-yyyy'), 131, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (373, 'Aliens', 'Family', 'Mattias Braybrook', to_date('15-10-2023', 'dd-mm-yyyy'), 147, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (374, 'Lincoln', 'Biography', 'Ewell Korb', to_date('31-05-2019', 'dd-mm-yyyy'), 134, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (375, 'Spartacus', 'Fantasy', 'Roselin Gurnay', to_date('26-10-2020', 'dd-mm-yyyy'), 135, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (376, 'Sideways', 'History', 'Evania Curton', to_date('18-03-2016', 'dd-mm-yyyy'), 159, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (377, 'Singles', 'Thriller', 'Elnar Foulis', to_date('25-02-2011', 'dd-mm-yyyy'), 105, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (378, 'Mad Max', 'Sci-Fi', 'Albertina Shinfield', to_date('23-06-2022', 'dd-mm-yyyy'), 101, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (379, 'Shrek', 'History', 'Goldina Lovie', to_date('21-09-2006', 'dd-mm-yyyy'), 131, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (380, 'Hancock', 'Mystery', 'Laurene Cristofolo', to_date('30-10-2006', 'dd-mm-yyyy'), 100, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (381, 'Selma', 'Documentary', 'Clemmie Verni', to_date('06-01-2005', 'dd-mm-yyyy'), 150, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (382, 'Gattaca', 'Action', 'Roobbie Possek', to_date('02-08-2016', 'dd-mm-yyyy'), 133, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (383, 'Ray', 'Family', 'Goober Withull', to_date('05-09-2003', 'dd-mm-yyyy'), 95, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (384, 'Notorious', 'Sport', 'Wendy Langthorne', to_date('18-02-2019', 'dd-mm-yyyy'), 171, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (385, 'True Lies', 'Action', 'Dorise Rhead', to_date('30-05-2001', 'dd-mm-yyyy'), 81, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (386, 'Speed', 'Western', 'Hartwell Ertelt', to_date('25-12-2010', 'dd-mm-yyyy'), 83, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (387, 'Sideways', 'Sport', 'Grant Suttle', to_date('27-07-2010', 'dd-mm-yyyy'), 103, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (388, 'Unforgiven', 'History', 'Lorne Springate', to_date('15-06-2019', 'dd-mm-yyyy'), 176, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (389, 'Dumbo', 'Drama', 'Edlin Samper', to_date('28-09-2014', 'dd-mm-yyyy'), 164, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (390, 'Giant', 'History', 'Abran Sabbin', to_date('21-10-2001', 'dd-mm-yyyy'), 117, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (391, 'Shutter', 'Biography', 'Buffy Kolakovic', to_date('18-06-2020', 'dd-mm-yyyy'), 94, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (392, 'Up', 'Animation', 'Jeannine Garfoot', to_date('04-08-2020', 'dd-mm-yyyy'), 156, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (393, 'Frozen', 'Action', 'Braden Tivenan', to_date('17-07-2008', 'dd-mm-yyyy'), 88, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (394, 'Hancock', 'Animation', 'Rois Bucknall', to_date('08-10-2013', 'dd-mm-yyyy'), 85, 5);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (395, 'Looper', 'Mystery', 'Reta Skelhorn', to_date('06-10-2023', 'dd-mm-yyyy'), 134, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (396, 'Moana', 'Thriller', 'Dory Wilstead', to_date('20-05-2010', 'dd-mm-yyyy'), 150, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (397, 'Watchmen', 'War', 'Thorsten Pillman', to_date('06-03-2003', 'dd-mm-yyyy'), 82, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (398, 'Coraline', 'Biograp', 'Ynes O'' Mullan', to_date('08-11-2016', 'dd-mm-yyyy'), 171, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (399, 'Brave', 'Biography', 'Webster Ellse', to_date('05-10-2020', 'dd-mm-yyyy'), 143, 7);
commit;
prompt 300 records committed...
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (400, 'Lincoln', 'Action', 'Ebenezer Tapner', to_date('19-01-2016', 'dd-mm-yyyy'), 73, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (401, 'Matilda', 'Thriller', 'Kris Colter', to_date('13-03-2002', 'dd-mm-yyyy'), 124, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (402, 'Clueless', 'Documentary', 'Teresa Mair', to_date('15-06-2001', 'dd-mm-yyyy'), 72, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (403, 'Superbad', 'Thriller', 'Leslie O''Hear', to_date('02-04-2022', 'dd-mm-yyyy'), 76, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (404, 'Gattaca', 'Western', 'Nettie Whipple', to_date('30-05-2011', 'dd-mm-yyyy'), 176, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (405, 'Casino', 'Mystery', 'Hamnet McKenzie', to_date('29-12-2006', 'dd-mm-yyyy'), 128, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (406, 'Trumbo', 'Horror', 'Maure Olijve', to_date('09-02-2006', 'dd-mm-yyyy'), 95, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (407, 'Xanadu', 'Fantasy', 'Dorie Joskovitch', to_date('13-06-2006', 'dd-mm-yyyy'), 144, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (408, 'Bambi', 'Mystery', 'Mareah Fussell', to_date('22-02-2005', 'dd-mm-yyyy'), 80, 5);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (409, 'Black Swan', 'Sci-Fi', 'Georgianne Leiden', to_date('25-05-2001', 'dd-mm-yyyy'), 66, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (410, 'Sin City', 'Romance', 'Ray O''Hallagan', to_date('17-10-2008', 'dd-mm-yyyy'), 176, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (411, 'Sideways', 'History', 'Ana Pittam', to_date('10-07-2003', 'dd-mm-yyyy'), 99, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (412, 'Grease', 'Sci-Fi', 'Aline Huck', to_date('06-04-2022', 'dd-mm-yyyy'), 87, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (413, 'Iron Man', 'Drama', 'Baxie Bellson', to_date('30-01-2017', 'dd-mm-yyyy'), 116, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (414, 'Jumper', 'Horror', 'Cassius Creelman', to_date('19-03-2018', 'dd-mm-yyyy'), 150, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (415, 'Grease', 'Mystery', 'Genevra Dietmar', to_date('20-07-2004', 'dd-mm-yyyy'), 135, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (416, 'Manhunter', 'War', 'Curry Longmuir', to_date('30-08-2013', 'dd-mm-yyyy'), 99, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (417, 'Black Swan', 'Documentary', 'Brittne Emilien', to_date('15-07-2016', 'dd-mm-yyyy'), 114, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (418, 'Fury', 'Biography', 'Augustus Dabs', to_date('28-06-2018', 'dd-mm-yyyy'), 85, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (419, 'Aliens', 'Romance', 'Effie Van Der Weedenburg', to_date('28-03-2009', 'dd-mm-yyyy'), 67, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (420, 'Arrival', 'History', 'Lanette Beeho', to_date('05-01-2002', 'dd-mm-yyyy'), 67, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (421, 'Contact', 'Animation', 'Amby Cruddace', to_date('22-10-2017', 'dd-mm-yyyy'), 157, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (422, 'Big Fish', 'Crime', 'Kamilah Izkovici', to_date('26-03-2013', 'dd-mm-yyyy'), 175, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (423, 'Ted', 'Comedy', 'Corrie Atkyns', to_date('06-03-2002', 'dd-mm-yyyy'), 78, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (424, 'Aliens', 'Family', 'Richy Matfin', to_date('26-06-2000', 'dd-mm-yyyy'), 143, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (425, 'Lincoln', 'Mystery', 'Stephine Bassham', to_date('18-05-2023', 'dd-mm-yyyy'), 124, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (426, 'Rushmore', 'Action', 'Loy Senechell', to_date('12-05-2009', 'dd-mm-yyyy'), 136, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (427, 'Up', 'War', 'Ellette Sidey', to_date('03-02-2022', 'dd-mm-yyyy'), 80, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (428, 'Moana', 'Thriller', 'Joelynn Elster', to_date('14-12-2015', 'dd-mm-yyyy'), 140, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (429, 'Brave', 'Musical', 'Meredeth Szymanek', to_date('04-10-2004', 'dd-mm-yyyy'), 139, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (430, 'Coco', 'Action', 'Florrie Flury', to_date('21-06-2022', 'dd-mm-yyyy'), 159, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (431, 'Signs', 'Animation', 'Natalie Hoodspeth', to_date('01-01-2019', 'dd-mm-yyyy'), 140, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (432, 'Memento', 'War', 'Sacha Henzley', to_date('22-05-2010', 'dd-mm-yyyy'), 101, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (433, 'Godzilla', 'Comedy', 'Emalia Scopyn', to_date('30-01-2009', 'dd-mm-yyyy'), 156, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (434, 'Elf', 'Action', 'Odessa Friedlos', to_date('22-06-2001', 'dd-mm-yyyy'), 165, 5);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (435, 'Unforgiven', 'Horror', 'Monty Lehrmann', to_date('18-05-2004', 'dd-mm-yyyy'), 71, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (436, 'Rudy', 'Thriller', 'Sile Gimblet', to_date('22-11-2021', 'dd-mm-yyyy'), 180, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (437, 'Deadpool', 'Western', 'Agatha Huckabe', to_date('07-02-2007', 'dd-mm-yyyy'), 135, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (438, 'Serenity', 'Action', 'Ari Cotterel', to_date('20-07-2002', 'dd-mm-yyyy'), 161, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (439, 'Tombstone', 'Documentary', 'Pansie Rosencwaig', to_date('04-10-2010', 'dd-mm-yyyy'), 67, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (440, 'Dune', 'Romance', 'Catie MacRury', to_date('18-05-2012', 'dd-mm-yyyy'), 158, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (441, 'Boyhood', 'Family', 'Ashlin Daish', to_date('20-05-2003', 'dd-mm-yyyy'), 161, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (442, 'Xanadu', 'Sci-Fi', 'Armando Carass', to_date('12-04-2019', 'dd-mm-yyyy'), 179, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (443, 'Godzilla', 'Biography', 'Adriana Windle', to_date('02-05-2010', 'dd-mm-yyyy'), 178, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (444, 'Unforgiven', 'History', 'Lauree Pilgrim', to_date('11-08-2005', 'dd-mm-yyyy'), 107, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (445, 'Rudy', 'Romance', 'Kilian Giacomazzo', to_date('15-06-2004', 'dd-mm-yyyy'), 115, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (446, 'Spartacus', 'Western', 'Lyon Cleyburn', to_date('04-10-2015', 'dd-mm-yyyy'), 60, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (447, 'Gandhi', 'Musical', 'Sibylle MacFadyen', to_date('07-07-2009', 'dd-mm-yyyy'), 164, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (448, 'Fargo', 'Horror', 'Grethel Darter', to_date('03-03-2002', 'dd-mm-yyyy'), 129, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (449, 'Goonies', 'Western', 'Gina Hollyman', to_date('03-02-2011', 'dd-mm-yyyy'), 96, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (450, 'Fences', 'Western', 'Arleyne Hedgecock', to_date('11-12-2014', 'dd-mm-yyyy'), 70, 5);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (451, 'Titanic', 'Fantasy', 'Vernor Whyke', to_date('15-06-2023', 'dd-mm-yyyy'), 171, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (452, 'Amelie', 'Sci-Fi', 'Laure Noye', to_date('04-03-2017', 'dd-mm-yyyy'), 122, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (453, 'Clueless', 'Sport', 'Penn Hewlings', to_date('12-10-2003', 'dd-mm-yyyy'), 107, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (454, 'Gattaca', 'Comedy', 'Daron Cash', to_date('11-11-2021', 'dd-mm-yyyy'), 144, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (455, 'Gandhi', 'Biography', 'Daniella Showler', to_date('27-08-2006', 'dd-mm-yyyy'), 128, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (456, 'Kill Bill', 'Western', 'Abbi Casa', to_date('04-05-2004', 'dd-mm-yyyy'), 137, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (457, 'Wild', 'Sci-Fi', 'Benni Curley', to_date('17-11-2013', 'dd-mm-yyyy'), 121, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (458, 'Stargate', 'Crime', 'Elissa Francillo', to_date('06-09-2002', 'dd-mm-yyyy'), 139, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (459, 'Gladiator', 'Thriller', 'Filip Martell', to_date('10-06-2010', 'dd-mm-yyyy'), 129, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (460, 'Doubt', 'Family', 'Ber MacGillavery', to_date('04-03-2021', 'dd-mm-yyyy'), 66, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (461, 'Amadeus', 'War', 'Salaidh Gever', to_date('28-01-2005', 'dd-mm-yyyy'), 94, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (462, 'Coco', 'Mystery', 'Cordelie Girard', to_date('27-08-2019', 'dd-mm-yyyy'), 128, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (463, 'Twister', 'Musical', 'Isac Bickerstaff', to_date('31-08-2006', 'dd-mm-yyyy'), 179, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (464, 'Frida', 'War', 'Hirsch Dubble', to_date('03-10-2000', 'dd-mm-yyyy'), 135, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (465, 'Creed', 'Horror', 'Eadie McKern', to_date('20-12-2010', 'dd-mm-yyyy'), 171, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (466, 'Split', 'Sport', 'Mikael Libermore', to_date('09-01-2017', 'dd-mm-yyyy'), 65, 7);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (467, 'Unbroken', 'War', 'Jayson Winser', to_date('14-10-2009', 'dd-mm-yyyy'), 172, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (468, 'Memento', 'Romance', 'Constantino Scandred', to_date('22-09-2022', 'dd-mm-yyyy'), 114, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (469, 'Capote', 'Western', 'Titos Fairbrass', to_date('15-06-2001', 'dd-mm-yyyy'), 142, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (470, 'Twister', 'Family', 'Eryn Gouch', to_date('19-12-2010', 'dd-mm-yyyy'), 176, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (471, 'Clerks', 'Western', 'Maddie Wisedale', to_date('12-11-2008', 'dd-mm-yyyy'), 163, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (472, 'Ben-Hur', 'Comedy', 'Esteban Junifer', to_date('08-03-2006', 'dd-mm-yyyy'), 95, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (473, 'Manhunter', 'War', 'Bernadina Shoppee', to_date('14-01-2022', 'dd-mm-yyyy'), 126, 5);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (474, 'Logan', 'Crime', 'Rafaela Trevena', to_date('08-12-2007', 'dd-mm-yyyy'), 164, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (475, 'Serenity', 'Thriller', 'Flin Murphey', to_date('02-05-2017', 'dd-mm-yyyy'), 137, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (476, 'Hugo', 'Sci-Fi', 'Robbi Clampett', to_date('27-01-2009', 'dd-mm-yyyy'), 90, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (477, 'Frozen', 'Thriller', 'Alexandre Schlagman', to_date('15-05-2016', 'dd-mm-yyyy'), 176, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (478, 'Birdman', 'Drama', 'Delmor Rosie', to_date('07-03-2006', 'dd-mm-yyyy'), 132, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (479, 'Grease', 'Sci-Fi', 'Trix Palfery', to_date('22-04-2006', 'dd-mm-yyyy'), 119, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (480, 'Gattaca', 'Crime', 'Lotty Minshall', to_date('23-03-2013', 'dd-mm-yyyy'), 158, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (481, 'Trumbo', 'Sci-Fi', 'Saudra Duce', to_date('19-05-2020', 'dd-mm-yyyy'), 85, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (482, 'The Mask', 'Western', 'Alano Purdon', to_date('16-01-2024', 'dd-mm-yyyy'), 145, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (483, 'Titanic', 'Sport', 'Zsa zsa Southan', to_date('27-03-2015', 'dd-mm-yyyy'), 119, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (484, 'Labyrinth', 'Documentary', 'Ange Midgely', to_date('03-01-2010', 'dd-mm-yyyy'), 146, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (485, 'Casino', 'Documentary', 'Monique Paff', to_date('28-05-2006', 'dd-mm-yyyy'), 64, 4);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (486, 'Giant', 'Biography', 'Yettie Partridge', to_date('06-11-2003', 'dd-mm-yyyy'), 150, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (487, 'Doubt', 'Documentary', 'Kinnie Reede', to_date('23-08-2012', 'dd-mm-yyyy'), 153, 2);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (488, 'Grease', 'Sci-Fi', 'Ludwig Valentelli', to_date('26-03-2006', 'dd-mm-yyyy'), 135, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (489, 'Crash', 'History', 'Griff Welling', to_date('14-07-2006', 'dd-mm-yyyy'), 143, 6);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (490, 'Serenity', 'Animation', 'Spenser Bartels-Ellis', to_date('24-10-2018', 'dd-mm-yyyy'), 155, 3);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (491, 'Elf', 'Drama', 'Vivienne Grimditch', to_date('13-11-2009', 'dd-mm-yyyy'), 117, 5);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (492, 'Scarface', 'Fantasy', 'Cobby Tossell', to_date('27-07-2005', 'dd-mm-yyyy'), 128, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (493, 'Clerks', 'Crime', 'Quinlan Pargent', to_date('13-05-2011', 'dd-mm-yyyy'), 116, 5);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (494, 'Rocky II', 'Adventure', 'Lena Metheringham', to_date('27-02-2003', 'dd-mm-yyyy'), 79, 1);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (495, 'Hancock', 'Thriller', 'Morton Worts', to_date('19-04-2018', 'dd-mm-yyyy'), 63, 9);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (496, 'Zoolander', 'Action', 'Aretha Crosthwaite', to_date('08-04-2022', 'dd-mm-yyyy'), 105, 8);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (497, 'Amadeus', 'Western', 'Wheeler Dougher', to_date('04-03-2017', 'dd-mm-yyyy'), 100, 5);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (498, 'Ant-Man', 'Documentary', 'Essie Decroix', to_date('30-07-2001', 'dd-mm-yyyy'), 118, 10);
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (499, 'Holes', 'Horror', 'Ephrem Whitebread', to_date('07-10-2002', 'dd-mm-yyyy'), 87, 1);
commit;
prompt 400 records committed...
insert into MOVIES (movieid, title, genre, director, releasedate, duration, rating)
values (500, 'Spartacus', 'Animation', 'Brunhilde Gyrgorcewicx', to_date('09-05-2012', 'dd-mm-yyyy'), 166, 2);
commit;
prompt 401 records loaded
prompt Loading THEATERS...
insert into THEATERS (theaterid, theatername, capacity)
values (111, 'Rose', 193);
insert into THEATERS (theaterid, theatername, capacity)
values (112, 'Tulip', 167);
insert into THEATERS (theaterid, theatername, capacity)
values (113, 'Lily', 251);
insert into THEATERS (theaterid, theatername, capacity)
values (114, 'Daisy', 263);
insert into THEATERS (theaterid, theatername, capacity)
values (115, 'Sunflower', 168);
insert into THEATERS (theaterid, theatername, capacity)
values (116, 'Marigold', 138);
insert into THEATERS (theaterid, theatername, capacity)
values (117, 'Orchid', 33);
insert into THEATERS (theaterid, theatername, capacity)
values (118, 'Lavender', 151);
insert into THEATERS (theaterid, theatername, capacity)
values (119, 'Poppy', 216);
insert into THEATERS (theaterid, theatername, capacity)
values (120, 'Peony', 148);
insert into THEATERS (theaterid, theatername, capacity)
values (121, 'Iris', 278);
insert into THEATERS (theaterid, theatername, capacity)
values (122, 'Chrysanthemum', 296);
insert into THEATERS (theaterid, theatername, capacity)
values (123, 'Daffodil', 172);
insert into THEATERS (theaterid, theatername, capacity)
values (124, 'Geranium', 188);
insert into THEATERS (theaterid, theatername, capacity)
values (125, 'Hibiscus', 57);
insert into THEATERS (theaterid, theatername, capacity)
values (126, 'Jasmine', 70);
insert into THEATERS (theaterid, theatername, capacity)
values (127, 'Lilac', 289);
insert into THEATERS (theaterid, theatername, capacity)
values (128, 'Magnolia', 162);
insert into THEATERS (theaterid, theatername, capacity)
values (129, 'Petunia', 199);
insert into THEATERS (theaterid, theatername, capacity)
values (130, 'Violet', 284);
insert into THEATERS (theaterid, theatername, capacity)
values (131, 'Begonia', 58);
insert into THEATERS (theaterid, theatername, capacity)
values (132, 'Carnation', 144);
insert into THEATERS (theaterid, theatername, capacity)
values (133, 'Camellia', 165);
insert into THEATERS (theaterid, theatername, capacity)
values (134, 'Azalea', 242);
insert into THEATERS (theaterid, theatername, capacity)
values (135, 'Buttercup', 51);
insert into THEATERS (theaterid, theatername, capacity)
values (136, 'Bluebell', 71);
insert into THEATERS (theaterid, theatername, capacity)
values (137, 'Crocus', 121);
insert into THEATERS (theaterid, theatername, capacity)
values (138, 'Dahlia', 260);
insert into THEATERS (theaterid, theatername, capacity)
values (139, 'Foxglove', 99);
insert into THEATERS (theaterid, theatername, capacity)
values (140, 'Gardenia', 94);
insert into THEATERS (theaterid, theatername, capacity)
values (141, 'Gladiolus', 242);
insert into THEATERS (theaterid, theatername, capacity)
values (142, 'Hyacinth', 293);
insert into THEATERS (theaterid, theatername, capacity)
values (143, 'Impatiens', 234);
insert into THEATERS (theaterid, theatername, capacity)
values (144, 'Lantana', 232);
insert into THEATERS (theaterid, theatername, capacity)
values (145, 'Morning Glory', 37);
insert into THEATERS (theaterid, theatername, capacity)
values (146, 'Narcissus', 22);
insert into THEATERS (theaterid, theatername, capacity)
values (147, 'Oleander', 241);
insert into THEATERS (theaterid, theatername, capacity)
values (148, 'Primrose', 95);
insert into THEATERS (theaterid, theatername, capacity)
values (149, 'Ranunculus', 40);
insert into THEATERS (theaterid, theatername, capacity)
values (150, 'Snapdragon', 214);
insert into THEATERS (theaterid, theatername, capacity)
values (151, 'Zinnia', 45);
insert into THEATERS (theaterid, theatername, capacity)
values (152, 'Amaryllis', 197);
insert into THEATERS (theaterid, theatername, capacity)
values (153, 'Anemone', 252);
insert into THEATERS (theaterid, theatername, capacity)
values (154, 'Bachelors Button', 180);
insert into THEATERS (theaterid, theatername, capacity)
values (155, 'Bergamot', 297);
insert into THEATERS (theaterid, theatername, capacity)
values (156, 'Calendula', 69);
insert into THEATERS (theaterid, theatername, capacity)
values (157, 'Columbine', 297);
insert into THEATERS (theaterid, theatername, capacity)
values (158, 'Cosmos', 155);
insert into THEATERS (theaterid, theatername, capacity)
values (159, 'Delphinium', 224);
insert into THEATERS (theaterid, theatername, capacity)
values (160, 'Forget-Me-Not', 119);
insert into THEATERS (theaterid, theatername, capacity)
values (161, 'Freesia', 124);
insert into THEATERS (theaterid, theatername, capacity)
values (162, 'Heliotrope', 48);
insert into THEATERS (theaterid, theatername, capacity)
values (163, 'Hollyhock', 34);
insert into THEATERS (theaterid, theatername, capacity)
values (164, 'Hydrangea', 123);
insert into THEATERS (theaterid, theatername, capacity)
values (165, 'Lobelia', 194);
insert into THEATERS (theaterid, theatername, capacity)
values (166, 'Lupine', 117);
insert into THEATERS (theaterid, theatername, capacity)
values (167, 'Mimosa', 161);
insert into THEATERS (theaterid, theatername, capacity)
values (168, 'Nemesia', 169);
insert into THEATERS (theaterid, theatername, capacity)
values (169, 'Nigella', 137);
insert into THEATERS (theaterid, theatername, capacity)
values (170, 'Phlox', 79);
insert into THEATERS (theaterid, theatername, capacity)
values (171, 'Poinsettia', 193);
insert into THEATERS (theaterid, theatername, capacity)
values (172, 'Scabiosa', 60);
insert into THEATERS (theaterid, theatername, capacity)
values (173, 'Stock', 76);
insert into THEATERS (theaterid, theatername, capacity)
values (174, 'Sweet Pea', 201);
insert into THEATERS (theaterid, theatername, capacity)
values (175, 'Verbena', 194);
insert into THEATERS (theaterid, theatername, capacity)
values (176, 'Yarrow', 60);
insert into THEATERS (theaterid, theatername, capacity)
values (177, 'Alstroemeria', 252);
insert into THEATERS (theaterid, theatername, capacity)
values (178, 'Aster', 240);
insert into THEATERS (theaterid, theatername, capacity)
values (179, 'Bellflower', 175);
insert into THEATERS (theaterid, theatername, capacity)
values (180, 'Bougainvillea', 107);
insert into THEATERS (theaterid, theatername, capacity)
values (181, 'Bouvardia', 171);
insert into THEATERS (theaterid, theatername, capacity)
values (182, 'Candytuft', 170);
insert into THEATERS (theaterid, theatername, capacity)
values (183, 'Canna', 21);
insert into THEATERS (theaterid, theatername, capacity)
values (184, 'Cherry Blossom', 290);
insert into THEATERS (theaterid, theatername, capacity)
values (185, 'Clematis', 216);
insert into THEATERS (theaterid, theatername, capacity)
values (186, 'Coreopsis', 199);
insert into THEATERS (theaterid, theatername, capacity)
values (187, 'Cornflower', 210);
insert into THEATERS (theaterid, theatername, capacity)
values (188, 'Corydalis', 115);
insert into THEATERS (theaterid, theatername, capacity)
values (189, 'Crown Imperial', 218);
insert into THEATERS (theaterid, theatername, capacity)
values (190, 'Cyclamen', 87);
insert into THEATERS (theaterid, theatername, capacity)
values (191, 'Dianthus', 34);
insert into THEATERS (theaterid, theatername, capacity)
values (192, 'Dusty Miller', 300);
insert into THEATERS (theaterid, theatername, capacity)
values (193, 'Echinacea', 40);
insert into THEATERS (theaterid, theatername, capacity)
values (194, 'Edelweiss', 280);
insert into THEATERS (theaterid, theatername, capacity)
values (195, 'Epimedium', 206);
insert into THEATERS (theaterid, theatername, capacity)
values (196, 'Euphorbia', 250);
insert into THEATERS (theaterid, theatername, capacity)
values (197, 'Gaillardia', 158);
insert into THEATERS (theaterid, theatername, capacity)
values (198, 'Gazania', 174);
insert into THEATERS (theaterid, theatername, capacity)
values (199, 'Gentian', 118);
insert into THEATERS (theaterid, theatername, capacity)
values (200, 'Geum', 241);
insert into THEATERS (theaterid, theatername, capacity)
values (201, 'Goldenrod', 197);
insert into THEATERS (theaterid, theatername, capacity)
values (202, 'Heuchera', 250);
insert into THEATERS (theaterid, theatername, capacity)
values (203, 'Honeysuckle', 65);
insert into THEATERS (theaterid, theatername, capacity)
values (204, 'Hosta', 210);
insert into THEATERS (theaterid, theatername, capacity)
values (205, 'Kalanchoe', 23);
insert into THEATERS (theaterid, theatername, capacity)
values (206, 'Larkspur', 275);
insert into THEATERS (theaterid, theatername, capacity)
values (207, 'Liatris', 220);
insert into THEATERS (theaterid, theatername, capacity)
values (208, 'Lobelia', 241);
insert into THEATERS (theaterid, theatername, capacity)
values (209, 'Lychnis', 251);
insert into THEATERS (theaterid, theatername, capacity)
values (210, 'Matthiola', 229);
commit;
prompt 100 records committed...
insert into THEATERS (theaterid, theatername, capacity)
values (211, 'Meconopsis', 44);
insert into THEATERS (theaterid, theatername, capacity)
values (212, 'Montbretia', 168);
insert into THEATERS (theaterid, theatername, capacity)
values (213, 'Nasturtium', 63);
insert into THEATERS (theaterid, theatername, capacity)
values (214, 'Nemophila', 229);
insert into THEATERS (theaterid, theatername, capacity)
values (215, 'Osteospermum', 58);
insert into THEATERS (theaterid, theatername, capacity)
values (216, 'Pansy', 277);
insert into THEATERS (theaterid, theatername, capacity)
values (217, 'Passionflower', 271);
insert into THEATERS (theaterid, theatername, capacity)
values (218, 'Penstemon', 171);
insert into THEATERS (theaterid, theatername, capacity)
values (219, 'Periwinkle', 296);
insert into THEATERS (theaterid, theatername, capacity)
values (220, 'Plumeria', 216);
insert into THEATERS (theaterid, theatername, capacity)
values (221, 'Polyanthus', 267);
insert into THEATERS (theaterid, theatername, capacity)
values (222, 'Portulaca', 39);
insert into THEATERS (theaterid, theatername, capacity)
values (223, 'Rhododendron', 232);
insert into THEATERS (theaterid, theatername, capacity)
values (224, 'Rudbeckia', 123);
insert into THEATERS (theaterid, theatername, capacity)
values (225, 'Salpiglossis', 66);
insert into THEATERS (theaterid, theatername, capacity)
values (226, 'Saxifrage', 20);
insert into THEATERS (theaterid, theatername, capacity)
values (227, 'Schizanthus', 119);
insert into THEATERS (theaterid, theatername, capacity)
values (228, 'Sedum', 81);
insert into THEATERS (theaterid, theatername, capacity)
values (229, 'Solidago', 171);
insert into THEATERS (theaterid, theatername, capacity)
values (230, 'Streptocarpus', 115);
insert into THEATERS (theaterid, theatername, capacity)
values (231, 'Tithonia', 55);
insert into THEATERS (theaterid, theatername, capacity)
values (232, 'Trillium', 28);
insert into THEATERS (theaterid, theatername, capacity)
values (233, 'Tropaeolum', 270);
insert into THEATERS (theaterid, theatername, capacity)
values (234, 'Verbascum', 212);
insert into THEATERS (theaterid, theatername, capacity)
values (235, 'Viola', 184);
insert into THEATERS (theaterid, theatername, capacity)
values (236, 'Wallflower', 278);
insert into THEATERS (theaterid, theatername, capacity)
values (237, 'Watsonia', 54);
insert into THEATERS (theaterid, theatername, capacity)
values (238, 'Weigela', 258);
insert into THEATERS (theaterid, theatername, capacity)
values (239, 'Wisteria', 126);
insert into THEATERS (theaterid, theatername, capacity)
values (240, 'Zantedeschia', 118);
insert into THEATERS (theaterid, theatername, capacity)
values (241, 'Zephyranthes', 243);
insert into THEATERS (theaterid, theatername, capacity)
values (242, 'Achillea', 289);
insert into THEATERS (theaterid, theatername, capacity)
values (243, 'Agapanthus', 87);
insert into THEATERS (theaterid, theatername, capacity)
values (244, 'Agastache', 125);
insert into THEATERS (theaterid, theatername, capacity)
values (245, 'Alchemilla', 253);
insert into THEATERS (theaterid, theatername, capacity)
values (246, 'Allium', 175);
insert into THEATERS (theaterid, theatername, capacity)
values (247, 'Alyssum', 218);
insert into THEATERS (theaterid, theatername, capacity)
values (248, 'Amaranthus', 22);
insert into THEATERS (theaterid, theatername, capacity)
values (249, 'Anthurium', 72);
insert into THEATERS (theaterid, theatername, capacity)
values (250, 'Aquilegia', 272);
insert into THEATERS (theaterid, theatername, capacity)
values (251, 'Armeria', 115);
insert into THEATERS (theaterid, theatername, capacity)
values (252, 'Artemisia', 203);
insert into THEATERS (theaterid, theatername, capacity)
values (253, 'Asclepias', 209);
insert into THEATERS (theaterid, theatername, capacity)
values (254, 'Aspidistra', 176);
insert into THEATERS (theaterid, theatername, capacity)
values (255, 'Astilbe', 234);
insert into THEATERS (theaterid, theatername, capacity)
values (256, 'Astrantia', 290);
insert into THEATERS (theaterid, theatername, capacity)
values (257, 'Babiana', 195);
insert into THEATERS (theaterid, theatername, capacity)
values (258, 'Balsam', 53);
insert into THEATERS (theaterid, theatername, capacity)
values (259, 'Baptisia', 58);
insert into THEATERS (theaterid, theatername, capacity)
values (260, 'Beardtongue', 171);
insert into THEATERS (theaterid, theatername, capacity)
values (261, 'Bee Balm', 108);
insert into THEATERS (theaterid, theatername, capacity)
values (262, 'Bellis', 42);
insert into THEATERS (theaterid, theatername, capacity)
values (263, 'Bleeding Heart', 213);
insert into THEATERS (theaterid, theatername, capacity)
values (264, 'Boronia', 29);
insert into THEATERS (theaterid, theatername, capacity)
values (265, 'Brunnera', 178);
insert into THEATERS (theaterid, theatername, capacity)
values (266, 'Butterfly Bush', 285);
insert into THEATERS (theaterid, theatername, capacity)
values (267, 'Calibrachoa', 182);
insert into THEATERS (theaterid, theatername, capacity)
values (268, 'Campanula', 177);
insert into THEATERS (theaterid, theatername, capacity)
values (269, 'Catmint', 27);
insert into THEATERS (theaterid, theatername, capacity)
values (270, 'Celosia', 115);
insert into THEATERS (theaterid, theatername, capacity)
values (271, 'Cheiranthus', 213);
insert into THEATERS (theaterid, theatername, capacity)
values (272, 'Chionodoxa', 215);
insert into THEATERS (theaterid, theatername, capacity)
values (273, 'Clivia', 245);
insert into THEATERS (theaterid, theatername, capacity)
values (274, 'Coleus', 283);
insert into THEATERS (theaterid, theatername, capacity)
values (275, 'Convallaria', 199);
insert into THEATERS (theaterid, theatername, capacity)
values (276, 'Corydalis', 27);
insert into THEATERS (theaterid, theatername, capacity)
values (277, 'Dicentra', 214);
insert into THEATERS (theaterid, theatername, capacity)
values (278, 'Doronicum', 179);
insert into THEATERS (theaterid, theatername, capacity)
values (279, 'Dracaena', 256);
insert into THEATERS (theaterid, theatername, capacity)
values (280, 'Dryas', 46);
insert into THEATERS (theaterid, theatername, capacity)
values (281, 'Echeveria', 30);
insert into THEATERS (theaterid, theatername, capacity)
values (282, 'Eryngium', 67);
insert into THEATERS (theaterid, theatername, capacity)
values (283, 'Eupatorium', 221);
insert into THEATERS (theaterid, theatername, capacity)
values (284, 'Felicia', 111);
insert into THEATERS (theaterid, theatername, capacity)
values (285, 'Fuchsia', 179);
insert into THEATERS (theaterid, theatername, capacity)
values (286, 'Gaura', 145);
insert into THEATERS (theaterid, theatername, capacity)
values (287, 'Genista', 257);
insert into THEATERS (theaterid, theatername, capacity)
values (288, 'Gerbera', 270);
insert into THEATERS (theaterid, theatername, capacity)
values (289, 'Globularia', 141);
insert into THEATERS (theaterid, theatername, capacity)
values (290, 'Gypsophila', 271);
insert into THEATERS (theaterid, theatername, capacity)
values (291, 'Hakonechloa', 180);
insert into THEATERS (theaterid, theatername, capacity)
values (292, 'Helichrysum', 103);
insert into THEATERS (theaterid, theatername, capacity)
values (293, 'Hellebore', 239);
insert into THEATERS (theaterid, theatername, capacity)
values (294, 'Hepatica', 219);
insert into THEATERS (theaterid, theatername, capacity)
values (295, 'Heucherella', 165);
insert into THEATERS (theaterid, theatername, capacity)
values (296, 'Hibbertia', 41);
insert into THEATERS (theaterid, theatername, capacity)
values (297, 'Himalayan Blue Poppy', 109);
insert into THEATERS (theaterid, theatername, capacity)
values (298, 'Honesty', 69);
insert into THEATERS (theaterid, theatername, capacity)
values (299, 'Hyssop', 208);
insert into THEATERS (theaterid, theatername, capacity)
values (300, 'Inula', 118);
insert into THEATERS (theaterid, theatername, capacity)
values (301, 'Ipomoea', 210);
insert into THEATERS (theaterid, theatername, capacity)
values (302, 'Ixora', 287);
insert into THEATERS (theaterid, theatername, capacity)
values (303, 'Jacobinia', 169);
insert into THEATERS (theaterid, theatername, capacity)
values (304, 'Knautia', 30);
insert into THEATERS (theaterid, theatername, capacity)
values (305, 'Kniphofia', 280);
insert into THEATERS (theaterid, theatername, capacity)
values (306, 'Kochia', 187);
insert into THEATERS (theaterid, theatername, capacity)
values (307, 'Lamium', 88);
insert into THEATERS (theaterid, theatername, capacity)
values (308, 'Lantana', 28);
insert into THEATERS (theaterid, theatername, capacity)
values (309, 'Lathyrus', 244);
insert into THEATERS (theaterid, theatername, capacity)
values (310, 'Leucanthemum', 127);
commit;
prompt 200 records committed...
insert into THEATERS (theaterid, theatername, capacity)
values (311, 'Lewisia', 33);
insert into THEATERS (theaterid, theatername, capacity)
values (312, 'Ligularia', 295);
insert into THEATERS (theaterid, theatername, capacity)
values (313, 'Linaria', 84);
insert into THEATERS (theaterid, theatername, capacity)
values (314, 'Lithodora', 99);
insert into THEATERS (theaterid, theatername, capacity)
values (315, 'Lobularia', 245);
insert into THEATERS (theaterid, theatername, capacity)
values (316, 'Lotus', 202);
insert into THEATERS (theaterid, theatername, capacity)
values (317, 'Lunaria', 248);
insert into THEATERS (theaterid, theatername, capacity)
values (318, 'Rose', 167);
insert into THEATERS (theaterid, theatername, capacity)
values (319, 'Tulip', 32);
insert into THEATERS (theaterid, theatername, capacity)
values (320, 'Lily', 36);
insert into THEATERS (theaterid, theatername, capacity)
values (321, 'Daisy', 30);
insert into THEATERS (theaterid, theatername, capacity)
values (322, 'Sunflower', 137);
insert into THEATERS (theaterid, theatername, capacity)
values (323, 'Marigold', 85);
insert into THEATERS (theaterid, theatername, capacity)
values (324, 'Orchid', 198);
insert into THEATERS (theaterid, theatername, capacity)
values (325, 'Lavender', 141);
insert into THEATERS (theaterid, theatername, capacity)
values (326, 'Poppy', 62);
insert into THEATERS (theaterid, theatername, capacity)
values (327, 'Peony', 292);
insert into THEATERS (theaterid, theatername, capacity)
values (328, 'Iris', 77);
insert into THEATERS (theaterid, theatername, capacity)
values (329, 'Chrysanthemum', 240);
insert into THEATERS (theaterid, theatername, capacity)
values (330, 'Daffodil', 41);
insert into THEATERS (theaterid, theatername, capacity)
values (331, 'Geranium', 219);
insert into THEATERS (theaterid, theatername, capacity)
values (332, 'Hibiscus', 240);
insert into THEATERS (theaterid, theatername, capacity)
values (333, 'Jasmine', 115);
insert into THEATERS (theaterid, theatername, capacity)
values (334, 'Lilac', 245);
insert into THEATERS (theaterid, theatername, capacity)
values (335, 'Magnolia', 130);
insert into THEATERS (theaterid, theatername, capacity)
values (336, 'Petunia', 97);
insert into THEATERS (theaterid, theatername, capacity)
values (337, 'Violet', 273);
insert into THEATERS (theaterid, theatername, capacity)
values (338, 'Begonia', 123);
insert into THEATERS (theaterid, theatername, capacity)
values (339, 'Carnation', 98);
insert into THEATERS (theaterid, theatername, capacity)
values (340, 'Camellia', 217);
insert into THEATERS (theaterid, theatername, capacity)
values (341, 'Azalea', 79);
insert into THEATERS (theaterid, theatername, capacity)
values (342, 'Buttercup', 215);
insert into THEATERS (theaterid, theatername, capacity)
values (343, 'Bluebell', 232);
insert into THEATERS (theaterid, theatername, capacity)
values (344, 'Crocus', 87);
insert into THEATERS (theaterid, theatername, capacity)
values (345, 'Dahlia', 92);
insert into THEATERS (theaterid, theatername, capacity)
values (346, 'Foxglove', 50);
insert into THEATERS (theaterid, theatername, capacity)
values (347, 'Gardenia', 76);
insert into THEATERS (theaterid, theatername, capacity)
values (348, 'Gladiolus', 121);
insert into THEATERS (theaterid, theatername, capacity)
values (349, 'Hyacinth', 94);
insert into THEATERS (theaterid, theatername, capacity)
values (350, 'Impatiens', 131);
insert into THEATERS (theaterid, theatername, capacity)
values (351, 'Lantana', 247);
insert into THEATERS (theaterid, theatername, capacity)
values (352, 'Morning Glory', 237);
insert into THEATERS (theaterid, theatername, capacity)
values (353, 'Narcissus', 100);
insert into THEATERS (theaterid, theatername, capacity)
values (354, 'Oleander', 83);
insert into THEATERS (theaterid, theatername, capacity)
values (355, 'Primrose', 251);
insert into THEATERS (theaterid, theatername, capacity)
values (356, 'Ranunculus', 172);
insert into THEATERS (theaterid, theatername, capacity)
values (357, 'Snapdragon', 204);
insert into THEATERS (theaterid, theatername, capacity)
values (358, 'Zinnia', 67);
insert into THEATERS (theaterid, theatername, capacity)
values (359, 'Amaryllis', 166);
insert into THEATERS (theaterid, theatername, capacity)
values (360, 'Anemone', 54);
insert into THEATERS (theaterid, theatername, capacity)
values (361, 'Bachelors Button', 230);
insert into THEATERS (theaterid, theatername, capacity)
values (362, 'Bergamot', 93);
insert into THEATERS (theaterid, theatername, capacity)
values (363, 'Calendula', 251);
insert into THEATERS (theaterid, theatername, capacity)
values (364, 'Columbine', 34);
insert into THEATERS (theaterid, theatername, capacity)
values (365, 'Cosmos', 95);
insert into THEATERS (theaterid, theatername, capacity)
values (366, 'Delphinium', 233);
insert into THEATERS (theaterid, theatername, capacity)
values (367, 'Forget-Me-Not', 114);
insert into THEATERS (theaterid, theatername, capacity)
values (368, 'Freesia', 68);
insert into THEATERS (theaterid, theatername, capacity)
values (369, 'Heliotrope', 90);
insert into THEATERS (theaterid, theatername, capacity)
values (370, 'Hollyhock', 266);
insert into THEATERS (theaterid, theatername, capacity)
values (371, 'Hydrangea', 183);
insert into THEATERS (theaterid, theatername, capacity)
values (372, 'Lobelia', 130);
insert into THEATERS (theaterid, theatername, capacity)
values (373, 'Lupine', 268);
insert into THEATERS (theaterid, theatername, capacity)
values (374, 'Mimosa', 158);
insert into THEATERS (theaterid, theatername, capacity)
values (375, 'Nemesia', 224);
insert into THEATERS (theaterid, theatername, capacity)
values (376, 'Nigella', 102);
insert into THEATERS (theaterid, theatername, capacity)
values (377, 'Phlox', 128);
insert into THEATERS (theaterid, theatername, capacity)
values (378, 'Poinsettia', 278);
insert into THEATERS (theaterid, theatername, capacity)
values (379, 'Scabiosa', 109);
insert into THEATERS (theaterid, theatername, capacity)
values (380, 'Stock', 75);
insert into THEATERS (theaterid, theatername, capacity)
values (381, 'Sweet Pea', 276);
insert into THEATERS (theaterid, theatername, capacity)
values (382, 'Verbena', 279);
insert into THEATERS (theaterid, theatername, capacity)
values (383, 'Yarrow', 189);
insert into THEATERS (theaterid, theatername, capacity)
values (384, 'Alstroemeria', 62);
insert into THEATERS (theaterid, theatername, capacity)
values (385, 'Aster', 126);
insert into THEATERS (theaterid, theatername, capacity)
values (386, 'Bellflower', 63);
insert into THEATERS (theaterid, theatername, capacity)
values (387, 'Bougainvillea', 104);
insert into THEATERS (theaterid, theatername, capacity)
values (388, 'Bouvardia', 295);
insert into THEATERS (theaterid, theatername, capacity)
values (389, 'Candytuft', 239);
insert into THEATERS (theaterid, theatername, capacity)
values (390, 'Canna', 280);
insert into THEATERS (theaterid, theatername, capacity)
values (391, 'Cherry Blossom', 196);
insert into THEATERS (theaterid, theatername, capacity)
values (392, 'Clematis', 241);
insert into THEATERS (theaterid, theatername, capacity)
values (393, 'Coreopsis', 238);
insert into THEATERS (theaterid, theatername, capacity)
values (394, 'Cornflower', 101);
insert into THEATERS (theaterid, theatername, capacity)
values (395, 'Corydalis', 203);
insert into THEATERS (theaterid, theatername, capacity)
values (396, 'Crown Imperial', 54);
insert into THEATERS (theaterid, theatername, capacity)
values (397, 'Cyclamen', 177);
insert into THEATERS (theaterid, theatername, capacity)
values (398, 'Dianthus', 55);
insert into THEATERS (theaterid, theatername, capacity)
values (399, 'Dusty Miller', 247);
insert into THEATERS (theaterid, theatername, capacity)
values (400, 'Echinacea', 286);
insert into THEATERS (theaterid, theatername, capacity)
values (401, 'Edelweiss', 155);
insert into THEATERS (theaterid, theatername, capacity)
values (402, 'Epimedium', 148);
insert into THEATERS (theaterid, theatername, capacity)
values (403, 'Euphorbia', 121);
insert into THEATERS (theaterid, theatername, capacity)
values (404, 'Gaillardia', 278);
insert into THEATERS (theaterid, theatername, capacity)
values (405, 'Gazania', 227);
insert into THEATERS (theaterid, theatername, capacity)
values (406, 'Gentian', 159);
insert into THEATERS (theaterid, theatername, capacity)
values (407, 'Geum', 23);
insert into THEATERS (theaterid, theatername, capacity)
values (408, 'Goldenrod', 203);
insert into THEATERS (theaterid, theatername, capacity)
values (409, 'Heuchera', 66);
insert into THEATERS (theaterid, theatername, capacity)
values (410, 'Honeysuckle', 206);
commit;
prompt 300 records committed...
insert into THEATERS (theaterid, theatername, capacity)
values (411, 'Hosta', 77);
insert into THEATERS (theaterid, theatername, capacity)
values (412, 'Kalanchoe', 82);
insert into THEATERS (theaterid, theatername, capacity)
values (413, 'Larkspur', 170);
insert into THEATERS (theaterid, theatername, capacity)
values (414, 'Liatris', 55);
insert into THEATERS (theaterid, theatername, capacity)
values (415, 'Lobelia', 84);
insert into THEATERS (theaterid, theatername, capacity)
values (416, 'Lychnis', 237);
insert into THEATERS (theaterid, theatername, capacity)
values (417, 'Matthiola', 245);
insert into THEATERS (theaterid, theatername, capacity)
values (418, 'Meconopsis', 217);
insert into THEATERS (theaterid, theatername, capacity)
values (419, 'Montbretia', 194);
insert into THEATERS (theaterid, theatername, capacity)
values (420, 'Nasturtium', 78);
insert into THEATERS (theaterid, theatername, capacity)
values (421, 'Nemophila', 230);
insert into THEATERS (theaterid, theatername, capacity)
values (422, 'Osteospermum', 74);
insert into THEATERS (theaterid, theatername, capacity)
values (423, 'Pansy', 48);
insert into THEATERS (theaterid, theatername, capacity)
values (424, 'Passionflower', 282);
insert into THEATERS (theaterid, theatername, capacity)
values (425, 'Penstemon', 128);
insert into THEATERS (theaterid, theatername, capacity)
values (426, 'Periwinkle', 197);
insert into THEATERS (theaterid, theatername, capacity)
values (427, 'Plumeria', 72);
insert into THEATERS (theaterid, theatername, capacity)
values (428, 'Polyanthus', 57);
insert into THEATERS (theaterid, theatername, capacity)
values (429, 'Portulaca', 211);
insert into THEATERS (theaterid, theatername, capacity)
values (430, 'Rhododendron', 243);
insert into THEATERS (theaterid, theatername, capacity)
values (431, 'Rudbeckia', 215);
insert into THEATERS (theaterid, theatername, capacity)
values (432, 'Salpiglossis', 259);
insert into THEATERS (theaterid, theatername, capacity)
values (433, 'Saxifrage', 81);
insert into THEATERS (theaterid, theatername, capacity)
values (434, 'Schizanthus', 175);
insert into THEATERS (theaterid, theatername, capacity)
values (435, 'Sedum', 225);
insert into THEATERS (theaterid, theatername, capacity)
values (436, 'Solidago', 135);
insert into THEATERS (theaterid, theatername, capacity)
values (437, 'Streptocarpus', 87);
insert into THEATERS (theaterid, theatername, capacity)
values (438, 'Tithonia', 241);
insert into THEATERS (theaterid, theatername, capacity)
values (439, 'Trillium', 162);
insert into THEATERS (theaterid, theatername, capacity)
values (440, 'Tropaeolum', 282);
insert into THEATERS (theaterid, theatername, capacity)
values (441, 'Verbascum', 118);
insert into THEATERS (theaterid, theatername, capacity)
values (442, 'Viola', 85);
insert into THEATERS (theaterid, theatername, capacity)
values (443, 'Wallflower', 76);
insert into THEATERS (theaterid, theatername, capacity)
values (444, 'Watsonia', 102);
insert into THEATERS (theaterid, theatername, capacity)
values (445, 'Weigela', 38);
insert into THEATERS (theaterid, theatername, capacity)
values (446, 'Wisteria', 246);
insert into THEATERS (theaterid, theatername, capacity)
values (447, 'Zantedeschia', 34);
insert into THEATERS (theaterid, theatername, capacity)
values (448, 'Zephyranthes', 239);
insert into THEATERS (theaterid, theatername, capacity)
values (449, 'Achillea', 237);
insert into THEATERS (theaterid, theatername, capacity)
values (450, 'Agapanthus', 28);
insert into THEATERS (theaterid, theatername, capacity)
values (451, 'Agastache', 133);
insert into THEATERS (theaterid, theatername, capacity)
values (452, 'Alchemilla', 44);
insert into THEATERS (theaterid, theatername, capacity)
values (453, 'Allium', 196);
insert into THEATERS (theaterid, theatername, capacity)
values (454, 'Alyssum', 256);
insert into THEATERS (theaterid, theatername, capacity)
values (455, 'Amaranthus', 84);
insert into THEATERS (theaterid, theatername, capacity)
values (456, 'Anthurium', 20);
insert into THEATERS (theaterid, theatername, capacity)
values (457, 'Aquilegia', 107);
insert into THEATERS (theaterid, theatername, capacity)
values (458, 'Armeria', 60);
insert into THEATERS (theaterid, theatername, capacity)
values (459, 'Artemisia', 176);
insert into THEATERS (theaterid, theatername, capacity)
values (460, 'Asclepias', 176);
insert into THEATERS (theaterid, theatername, capacity)
values (461, 'Aspidistra', 135);
insert into THEATERS (theaterid, theatername, capacity)
values (462, 'Astilbe', 63);
insert into THEATERS (theaterid, theatername, capacity)
values (463, 'Astrantia', 121);
insert into THEATERS (theaterid, theatername, capacity)
values (464, 'Babiana', 180);
insert into THEATERS (theaterid, theatername, capacity)
values (465, 'Balsam', 218);
insert into THEATERS (theaterid, theatername, capacity)
values (466, 'Baptisia', 90);
insert into THEATERS (theaterid, theatername, capacity)
values (467, 'Beardtongue', 42);
insert into THEATERS (theaterid, theatername, capacity)
values (468, 'Bee Balm', 56);
insert into THEATERS (theaterid, theatername, capacity)
values (469, 'Bellis', 248);
insert into THEATERS (theaterid, theatername, capacity)
values (470, 'Bleeding Heart', 101);
insert into THEATERS (theaterid, theatername, capacity)
values (471, 'Boronia', 271);
insert into THEATERS (theaterid, theatername, capacity)
values (472, 'Brunnera', 288);
insert into THEATERS (theaterid, theatername, capacity)
values (473, 'Butterfly Bush', 128);
insert into THEATERS (theaterid, theatername, capacity)
values (474, 'Calibrachoa', 192);
insert into THEATERS (theaterid, theatername, capacity)
values (475, 'Campanula', 56);
insert into THEATERS (theaterid, theatername, capacity)
values (476, 'Catmint', 100);
insert into THEATERS (theaterid, theatername, capacity)
values (477, 'Celosia', 76);
insert into THEATERS (theaterid, theatername, capacity)
values (478, 'Cheiranthus', 153);
insert into THEATERS (theaterid, theatername, capacity)
values (479, 'Chionodoxa', 76);
insert into THEATERS (theaterid, theatername, capacity)
values (480, 'Clivia', 276);
insert into THEATERS (theaterid, theatername, capacity)
values (481, 'Coleus', 191);
insert into THEATERS (theaterid, theatername, capacity)
values (482, 'Convallaria', 99);
insert into THEATERS (theaterid, theatername, capacity)
values (483, 'Corydalis', 259);
insert into THEATERS (theaterid, theatername, capacity)
values (484, 'Dicentra', 142);
insert into THEATERS (theaterid, theatername, capacity)
values (485, 'Doronicum', 188);
insert into THEATERS (theaterid, theatername, capacity)
values (486, 'Dracaena', 71);
insert into THEATERS (theaterid, theatername, capacity)
values (487, 'Dryas', 218);
insert into THEATERS (theaterid, theatername, capacity)
values (488, 'Echeveria', 131);
insert into THEATERS (theaterid, theatername, capacity)
values (489, 'Eryngium', 257);
insert into THEATERS (theaterid, theatername, capacity)
values (490, 'Eupatorium', 61);
insert into THEATERS (theaterid, theatername, capacity)
values (491, 'Felicia', 193);
insert into THEATERS (theaterid, theatername, capacity)
values (492, 'Fuchsia', 267);
insert into THEATERS (theaterid, theatername, capacity)
values (493, 'Gaura', 26);
insert into THEATERS (theaterid, theatername, capacity)
values (494, 'Genista', 30);
insert into THEATERS (theaterid, theatername, capacity)
values (495, 'Gerbera', 218);
insert into THEATERS (theaterid, theatername, capacity)
values (496, 'Globularia', 130);
insert into THEATERS (theaterid, theatername, capacity)
values (497, 'Gypsophila', 176);
insert into THEATERS (theaterid, theatername, capacity)
values (498, 'Hakonechloa', 217);
insert into THEATERS (theaterid, theatername, capacity)
values (499, 'Helichrysum', 174);
insert into THEATERS (theaterid, theatername, capacity)
values (500, 'Hellebore', 214);
insert into THEATERS (theaterid, theatername, capacity)
values (501, 'Hepatica', 186);
insert into THEATERS (theaterid, theatername, capacity)
values (502, 'Heucherella', 55);
insert into THEATERS (theaterid, theatername, capacity)
values (503, 'Hibbertia', 298);
insert into THEATERS (theaterid, theatername, capacity)
values (504, 'Himalayan Blue Poppy', 225);
insert into THEATERS (theaterid, theatername, capacity)
values (505, 'Honesty', 300);
insert into THEATERS (theaterid, theatername, capacity)
values (506, 'Hyssop', 90);
insert into THEATERS (theaterid, theatername, capacity)
values (507, 'Inula', 273);
insert into THEATERS (theaterid, theatername, capacity)
values (508, 'Ipomoea', 215);
insert into THEATERS (theaterid, theatername, capacity)
values (509, 'Ixora', 43);
insert into THEATERS (theaterid, theatername, capacity)
values (510, 'Jacobinia', 168);
commit;
prompt 400 records loaded
prompt Loading SCHEDULES...
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (100, 371, 183, 440, 256);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (101, 147, 241, 319, 364);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (102, 282, 67, 291, 365);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (103, 504, 225, 326, 306);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (104, 455, 84, 231, 104);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (105, 328, 77, 290, 127);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (106, 468, 56, 201, 411);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (107, 144, 232, 186, 471);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (108, 369, 90, 249, 182);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (109, 170, 79, 144, 295);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (110, 195, 206, 236, 459);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (111, 456, 20, 396, 316);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (112, 306, 187, 141, 142);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (113, 430, 243, 141, 393);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (114, 359, 166, 100, 436);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (115, 288, 270, 151, 427);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (116, 501, 186, 160, 408);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (117, 193, 40, 283, 389);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (118, 381, 276, 165, 483);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (119, 506, 90, 331, 271);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (120, 401, 155, 162, 254);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (121, 246, 175, 194, 367);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (122, 377, 128, 139, 226);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (123, 165, 194, 173, 270);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (124, 437, 87, 280, 277);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (125, 456, 20, 193, 205);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (126, 135, 51, 147, 451);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (127, 286, 145, 348, 276);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (128, 198, 174, 396, 473);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (129, 344, 87, 372, 448);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (130, 492, 267, 202, 384);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (131, 432, 259, 435, 446);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (132, 211, 44, 424, 311);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (133, 459, 176, 465, 383);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (134, 305, 280, 483, 157);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (135, 482, 99, 394, 116);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (136, 111, 193, 174, 412);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (137, 153, 252, 129, 116);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (138, 230, 115, 405, 494);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (139, 405, 227, 448, 279);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (140, 416, 237, 441, 217);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (141, 155, 297, 418, 245);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (142, 494, 30, 100, 376);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (143, 437, 87, 148, 457);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (144, 306, 187, 463, 467);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (145, 352, 237, 454, 334);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (146, 274, 283, 293, 323);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (147, 455, 84, 257, 377);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (148, 197, 158, 209, 479);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (149, 356, 172, 105, 192);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (150, 266, 285, 165, 464);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (151, 152, 197, 220, 447);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (152, 311, 33, 254, 215);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (153, 482, 99, 263, 344);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (154, 465, 218, 445, 217);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (155, 410, 206, 439, 229);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (156, 458, 60, 443, 365);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (157, 327, 292, 311, 109);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (158, 337, 273, 470, 359);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (159, 281, 30, 150, 115);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (160, 207, 220, 175, 414);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (161, 137, 121, 406, 472);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (162, 198, 174, 470, 304);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (163, 354, 83, 499, 203);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (164, 260, 171, 280, 324);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (165, 191, 34, 148, 160);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (166, 182, 170, 238, 179);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (167, 137, 121, 412, 372);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (168, 231, 55, 485, 203);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (169, 169, 137, 462, 121);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (170, 424, 282, 207, 495);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (171, 228, 81, 476, 352);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (172, 418, 217, 496, 385);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (173, 129, 199, 263, 393);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (174, 429, 211, 126, 225);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (175, 489, 257, 409, 208);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (176, 378, 278, 271, 303);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (177, 284, 111, 342, 180);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (178, 452, 44, 130, 480);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (179, 227, 119, 138, 408);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (180, 304, 30, 295, 161);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (181, 375, 224, 434, 333);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (182, 467, 42, 222, 179);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (183, 361, 230, 475, 298);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (184, 398, 55, 254, 214);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (185, 246, 175, 291, 217);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (186, 346, 50, 141, 130);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (187, 404, 278, 187, 182);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (188, 246, 175, 111, 442);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (189, 421, 230, 367, 191);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (190, 436, 135, 445, 302);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (191, 233, 270, 277, 194);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (192, 197, 158, 385, 221);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (193, 276, 27, 482, 480);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (194, 127, 289, 375, 300);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (195, 268, 177, 255, 372);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (196, 331, 219, 415, 403);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (197, 216, 277, 103, 455);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (198, 436, 135, 142, 240);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (199, 443, 76, 414, 333);
commit;
prompt 100 records committed...
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (200, 239, 126, 246, 187);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (201, 249, 72, 219, 301);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (202, 172, 60, 396, 424);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (203, 385, 126, 103, 151);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (204, 397, 177, 100, 398);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (205, 163, 34, 414, 298);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (206, 121, 278, 497, 216);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (207, 384, 62, 411, 430);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (208, 342, 215, 252, 358);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (209, 497, 176, 341, 491);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (210, 414, 55, 400, 117);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (211, 375, 224, 429, 378);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (212, 444, 102, 500, 364);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (213, 322, 137, 401, 371);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (214, 304, 30, 120, 237);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (215, 506, 90, 331, 284);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (216, 482, 99, 448, 160);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (217, 210, 229, 413, 144);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (218, 343, 232, 416, 376);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (219, 117, 33, 454, 391);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (220, 223, 232, 173, 217);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (221, 412, 82, 296, 409);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (222, 152, 197, 257, 492);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (223, 314, 99, 364, 174);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (224, 391, 196, 108, 202);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (225, 232, 28, 336, 233);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (226, 203, 65, 303, 381);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (227, 144, 232, 338, 410);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (228, 445, 38, 111, 257);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (229, 204, 210, 265, 426);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (230, 388, 295, 381, 148);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (231, 371, 183, 433, 459);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (232, 356, 172, 143, 273);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (233, 265, 178, 339, 415);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (234, 197, 158, 152, 289);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (235, 447, 34, 367, 335);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (236, 376, 102, 139, 363);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (237, 328, 77, 405, 320);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (238, 492, 267, 197, 157);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (239, 294, 219, 190, 382);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (240, 421, 230, 290, 142);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (241, 464, 180, 183, 226);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (242, 483, 259, 284, 443);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (243, 472, 288, 161, 149);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (244, 238, 258, 110, 397);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (245, 270, 115, 341, 266);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (246, 301, 210, 445, 449);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (247, 359, 166, 222, 465);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (248, 387, 104, 319, 363);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (249, 246, 175, 363, 285);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (250, 376, 102, 452, 164);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (251, 322, 137, 272, 315);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (252, 410, 206, 310, 200);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (253, 371, 183, 433, 324);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (254, 408, 203, 491, 337);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (255, 296, 41, 445, 113);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (256, 210, 229, 431, 267);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (257, 278, 179, 101, 290);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (258, 346, 50, 239, 155);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (259, 355, 251, 180, 178);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (260, 226, 20, 256, 397);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (261, 229, 171, 168, 434);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (262, 160, 119, 336, 115);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (263, 492, 267, 104, 410);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (264, 404, 278, 460, 370);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (265, 488, 131, 153, 223);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (266, 420, 78, 262, 101);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (267, 388, 295, 299, 363);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (268, 376, 102, 296, 391);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (269, 298, 69, 170, 417);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (270, 464, 180, 211, 258);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (271, 391, 196, 181, 123);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (272, 436, 135, 268, 366);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (273, 457, 107, 406, 345);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (274, 181, 171, 167, 268);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (275, 490, 61, 373, 379);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (276, 510, 168, 409, 370);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (277, 289, 141, 190, 376);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (278, 180, 107, 178, 223);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (279, 491, 193, 183, 100);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (280, 334, 245, 152, 332);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (281, 225, 66, 276, 399);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (282, 368, 68, 232, 302);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (283, 191, 34, 277, 212);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (284, 429, 211, 207, 101);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (285, 369, 90, 311, 295);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (286, 126, 70, 131, 446);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (287, 350, 131, 153, 470);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (288, 277, 214, 437, 326);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (289, 285, 179, 313, 410);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (290, 478, 153, 166, 432);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (291, 473, 128, 419, 334);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (292, 494, 30, 131, 131);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (293, 361, 230, 146, 437);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (294, 275, 199, 194, 348);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (295, 179, 175, 263, 244);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (296, 204, 210, 281, 388);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (297, 390, 280, 197, 284);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (298, 362, 93, 310, 268);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (299, 177, 252, 135, 495);
commit;
prompt 200 records committed...
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (300, 420, 78, 254, 191);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (301, 144, 232, 445, 151);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (302, 158, 155, 324, 328);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (303, 445, 38, 417, 112);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (304, 210, 229, 473, 137);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (305, 347, 76, 341, 206);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (306, 228, 81, 435, 400);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (307, 400, 286, 497, 127);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (308, 480, 276, 282, 393);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (309, 453, 196, 281, 262);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (310, 461, 135, 307, 168);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (311, 275, 199, 248, 448);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (312, 144, 232, 232, 376);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (313, 419, 194, 285, 246);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (314, 241, 243, 143, 401);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (315, 494, 30, 303, 343);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (316, 302, 287, 349, 427);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (317, 480, 276, 265, 280);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (318, 227, 119, 161, 230);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (319, 249, 72, 325, 106);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (320, 413, 170, 411, 287);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (321, 126, 70, 305, 353);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (322, 122, 296, 470, 423);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (323, 469, 248, 487, 339);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (324, 471, 271, 222, 369);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (325, 273, 245, 134, 396);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (326, 454, 256, 138, 258);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (327, 403, 121, 143, 421);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (328, 380, 75, 291, 235);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (329, 244, 125, 205, 357);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (330, 346, 50, 280, 401);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (331, 188, 115, 109, 190);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (332, 128, 162, 100, 272);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (333, 337, 273, 363, 279);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (334, 497, 176, 319, 177);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (335, 231, 55, 132, 410);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (336, 364, 34, 387, 166);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (337, 406, 159, 123, 370);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (338, 148, 95, 270, 451);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (339, 175, 194, 367, 453);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (340, 170, 79, 212, 174);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (341, 432, 259, 149, 283);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (342, 468, 56, 213, 494);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (343, 282, 67, 453, 370);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (344, 440, 282, 443, 405);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (345, 300, 118, 125, 385);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (346, 317, 248, 168, 469);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (347, 406, 159, 184, 167);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (348, 451, 133, 420, 490);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (349, 374, 158, 229, 241);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (350, 433, 81, 367, 297);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (351, 163, 34, 193, 280);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (352, 440, 282, 236, 461);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (353, 471, 271, 211, 278);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (354, 399, 247, 334, 135);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (355, 315, 245, 218, 451);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (356, 180, 107, 213, 420);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (357, 437, 87, 467, 268);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (358, 418, 217, 354, 453);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (359, 136, 71, 179, 201);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (360, 352, 237, 374, 223);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (361, 321, 30, 312, 202);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (362, 294, 219, 156, 108);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (363, 393, 238, 457, 107);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (364, 323, 85, 317, 344);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (365, 150, 214, 258, 361);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (366, 402, 148, 381, 414);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (367, 318, 167, 162, 274);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (368, 320, 36, 294, 361);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (369, 506, 90, 287, 195);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (370, 263, 213, 459, 427);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (371, 185, 216, 218, 416);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (372, 403, 121, 285, 223);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (373, 298, 69, 129, 397);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (374, 321, 30, 484, 211);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (375, 285, 179, 429, 323);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (376, 244, 125, 269, 328);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (377, 140, 94, 331, 176);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (378, 118, 151, 292, 117);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (379, 296, 41, 155, 342);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (380, 498, 217, 103, 398);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (381, 124, 188, 139, 135);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (382, 467, 42, 132, 456);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (383, 266, 285, 193, 250);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (384, 181, 171, 197, 355);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (385, 394, 101, 167, 343);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (386, 430, 243, 142, 379);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (387, 383, 189, 247, 130);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (388, 442, 85, 188, 394);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (389, 124, 188, 277, 414);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (390, 290, 271, 225, 344);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (391, 350, 131, 405, 442);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (392, 343, 232, 414, 259);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (393, 492, 267, 251, 378);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (394, 128, 162, 324, 198);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (395, 362, 93, 209, 105);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (396, 227, 119, 189, 116);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (397, 454, 256, 466, 357);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (398, 395, 203, 294, 449);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (399, 480, 276, 140, 165);
commit;
prompt 300 records committed...
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (400, 300, 118, 482, 233);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (401, 119, 216, 168, 242);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (402, 493, 26, 183, 340);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (403, 404, 278, 285, 275);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (404, 400, 286, 184, 249);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (405, 124, 188, 154, 165);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (406, 143, 234, 101, 328);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (407, 454, 256, 212, 367);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (408, 177, 252, 395, 454);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (409, 211, 44, 237, 177);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (410, 365, 95, 499, 153);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (411, 137, 121, 450, 329);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (412, 464, 180, 285, 261);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (413, 201, 197, 328, 322);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (414, 450, 28, 441, 118);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (415, 329, 240, 359, 477);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (416, 256, 290, 180, 281);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (417, 165, 194, 307, 310);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (418, 139, 99, 280, 363);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (419, 245, 253, 410, 435);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (420, 480, 276, 232, 400);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (421, 207, 220, 301, 394);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (422, 192, 300, 336, 139);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (423, 417, 245, 455, 405);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (424, 174, 201, 296, 253);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (425, 231, 55, 157, 244);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (426, 169, 137, 366, 282);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (427, 468, 56, 404, 445);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (428, 262, 42, 201, 497);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (429, 122, 296, 119, 226);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (430, 199, 118, 243, 490);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (431, 487, 218, 102, 143);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (432, 126, 70, 431, 490);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (433, 317, 248, 300, 268);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (434, 361, 230, 229, 199);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (435, 403, 121, 402, 291);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (436, 183, 21, 395, 362);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (437, 381, 276, 159, 346);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (438, 455, 84, 451, 254);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (439, 162, 48, 237, 163);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (440, 461, 135, 304, 293);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (441, 385, 126, 378, 149);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (442, 180, 107, 373, 187);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (443, 302, 287, 102, 386);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (444, 372, 130, 248, 188);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (445, 277, 214, 330, 362);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (446, 505, 300, 276, 291);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (447, 124, 188, 325, 220);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (448, 488, 131, 468, 147);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (449, 457, 107, 364, 336);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (450, 247, 218, 331, 498);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (451, 273, 245, 138, 426);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (452, 314, 99, 430, 148);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (453, 357, 204, 472, 165);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (454, 246, 175, 471, 448);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (455, 510, 168, 363, 148);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (456, 467, 42, 304, 115);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (457, 208, 241, 165, 361);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (458, 339, 98, 268, 368);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (459, 284, 111, 474, 185);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (460, 449, 237, 438, 397);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (461, 425, 128, 354, 327);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (462, 334, 245, 413, 348);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (463, 112, 167, 481, 265);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (464, 419, 194, 428, 242);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (465, 171, 193, 417, 434);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (466, 188, 115, 181, 412);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (467, 153, 252, 402, 322);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (468, 174, 201, 200, 271);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (469, 342, 215, 479, 498);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (470, 180, 107, 116, 198);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (471, 381, 276, 137, 169);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (472, 119, 216, 282, 155);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (473, 134, 242, 487, 250);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (474, 285, 179, 299, 228);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (475, 361, 230, 148, 374);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (476, 244, 125, 479, 288);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (477, 424, 282, 481, 214);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (478, 352, 237, 225, 386);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (479, 223, 232, 125, 337);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (480, 298, 69, 145, 263);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (481, 342, 215, 474, 182);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (482, 275, 199, 280, 392);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (483, 439, 162, 470, 362);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (484, 367, 114, 465, 146);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (485, 246, 175, 324, 489);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (486, 173, 76, 413, 280);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (487, 399, 247, 165, 131);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (488, 245, 253, 323, 153);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (489, 296, 41, 409, 487);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (490, 160, 119, 414, 466);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (491, 179, 175, 254, 385);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (492, 410, 206, 182, 325);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (493, 235, 184, 303, 219);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (494, 123, 172, 186, 231);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (495, 327, 292, 111, 193);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (496, 203, 65, 356, 198);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (497, 354, 83, 253, 100);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (498, 297, 109, 424, 190);
insert into SCHEDULES (scheduleid, theaterid, availableseats, movieid, dateid)
values (499, 428, 57, 120, 228);
commit;
prompt 400 records loaded
prompt Loading SUBSCRIBERS...
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (100, 50, to_date('24-01-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (101, 20, to_date('04-07-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (102, 20, to_date('16-04-2030', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (103, 30, to_date('16-11-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (104, 10, to_date('08-07-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (105, 40, to_date('01-06-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (106, 20, to_date('24-10-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (107, 20, to_date('23-02-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (108, 40, to_date('14-09-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (109, 40, to_date('15-08-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (110, 20, to_date('30-11-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (111, 20, to_date('11-01-2030', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (112, 50, to_date('08-09-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (113, 30, to_date('28-08-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (114, 40, to_date('22-03-2030', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (115, 30, to_date('15-05-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (116, 20, to_date('12-09-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (117, 50, to_date('04-04-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (118, 40, to_date('24-12-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (119, 10, to_date('20-08-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (120, 30, to_date('26-01-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (121, 40, to_date('09-11-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (122, 30, to_date('18-04-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (123, 10, to_date('24-04-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (124, 40, to_date('13-11-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (125, 20, to_date('14-08-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (126, 50, to_date('22-05-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (127, 10, to_date('10-07-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (128, 10, to_date('05-12-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (129, 30, to_date('20-08-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (130, 50, to_date('12-08-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (131, 40, to_date('09-10-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (132, 30, to_date('11-05-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (133, 30, to_date('26-10-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (134, 20, to_date('27-03-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (135, 20, to_date('24-06-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (136, 10, to_date('26-04-2030', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (137, 30, to_date('28-09-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (138, 20, to_date('12-10-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (139, 20, to_date('23-11-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (140, 10, to_date('08-01-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (141, 40, to_date('14-07-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (142, 30, to_date('03-02-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (143, 30, to_date('17-01-2030', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (144, 20, to_date('15-04-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (145, 10, to_date('23-07-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (146, 30, to_date('26-12-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (147, 40, to_date('25-08-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (148, 30, to_date('28-06-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (149, 40, to_date('19-03-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (150, 50, to_date('04-05-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (151, 40, to_date('24-03-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (152, 20, to_date('23-05-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (153, 10, to_date('09-08-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (154, 20, to_date('04-10-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (155, 30, to_date('11-01-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (156, 10, to_date('06-08-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (157, 40, to_date('07-09-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (158, 10, to_date('07-10-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (159, 50, to_date('20-01-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (160, 30, to_date('11-06-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (161, 30, to_date('23-05-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (162, 10, to_date('19-02-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (163, 20, to_date('15-10-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (164, 10, to_date('05-05-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (165, 10, to_date('20-01-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (166, 40, to_date('30-07-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (167, 20, to_date('11-04-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (168, 20, to_date('13-11-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (169, 50, to_date('27-02-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (170, 30, to_date('07-04-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (171, 40, to_date('26-10-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (172, 20, to_date('08-01-2030', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (173, 10, to_date('23-02-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (174, 50, to_date('21-02-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (175, 20, to_date('11-02-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (176, 30, to_date('05-10-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (177, 20, to_date('02-02-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (178, 30, to_date('22-11-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (179, 10, to_date('25-10-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (180, 40, to_date('21-05-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (181, 20, to_date('23-04-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (182, 30, to_date('16-02-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (183, 50, to_date('26-05-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (184, 40, to_date('26-03-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (185, 30, to_date('17-10-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (186, 40, to_date('07-05-2030', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (187, 20, to_date('05-10-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (188, 10, to_date('10-12-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (189, 20, to_date('30-03-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (190, 40, to_date('12-05-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (191, 20, to_date('09-04-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (192, 30, to_date('29-12-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (193, 20, to_date('17-03-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (194, 40, to_date('12-02-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (195, 10, to_date('27-05-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (196, 50, to_date('22-10-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (197, 40, to_date('01-01-2030', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (198, 30, to_date('08-05-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (199, 10, to_date('07-07-2029', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (200, 40, to_date('04-12-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (201, 30, to_date('02-08-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (202, 10, to_date('27-07-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (203, 40, to_date('08-04-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (204, 40, to_date('16-10-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (205, 20, to_date('09-02-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (206, 40, to_date('27-11-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (207, 30, to_date('15-10-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (208, 20, to_date('07-11-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (209, 50, to_date('16-07-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (210, 10, to_date('09-01-2030', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (211, 20, to_date('30-01-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (212, 40, to_date('08-05-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (213, 50, to_date('06-03-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (214, 50, to_date('14-09-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (215, 50, to_date('02-11-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (216, 30, to_date('29-02-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (217, 10, to_date('12-08-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (218, 40, to_date('24-09-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (219, 40, to_date('07-02-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (220, 10, to_date('26-03-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (221, 10, to_date('20-07-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (222, 10, to_date('26-07-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (223, 30, to_date('06-05-2030', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (224, 40, to_date('29-10-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (225, 40, to_date('29-09-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (226, 30, to_date('28-06-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (227, 20, to_date('04-12-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (228, 50, to_date('01-01-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (229, 50, to_date('11-04-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (230, 20, to_date('17-08-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (231, 40, to_date('21-03-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (232, 20, to_date('02-10-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (233, 20, to_date('12-12-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (234, 20, to_date('07-05-2030', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (235, 10, to_date('10-10-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (236, 20, to_date('02-12-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (237, 30, to_date('07-01-2030', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (238, 20, to_date('25-05-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (239, 10, to_date('30-05-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (240, 20, to_date('11-03-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (241, 40, to_date('18-05-2030', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (242, 50, to_date('31-12-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (243, 50, to_date('11-11-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (244, 30, to_date('16-08-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (245, 10, to_date('28-01-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (246, 20, to_date('27-12-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (247, 40, to_date('23-10-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (248, 50, to_date('08-10-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (249, 50, to_date('07-12-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (250, 50, to_date('13-07-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (251, 10, to_date('30-12-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (252, 40, to_date('30-05-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (253, 20, to_date('05-12-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (254, 40, to_date('12-10-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (255, 50, to_date('21-11-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (256, 20, to_date('19-03-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (257, 30, to_date('27-04-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (258, 10, to_date('22-06-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (259, 30, to_date('01-06-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (260, 10, to_date('08-10-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (261, 10, to_date('03-10-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (262, 40, to_date('13-04-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (263, 10, to_date('13-03-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (264, 50, to_date('06-09-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (265, 10, to_date('15-01-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (266, 10, to_date('09-06-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (267, 40, to_date('14-10-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (268, 30, to_date('09-12-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (269, 20, to_date('29-07-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (270, 50, to_date('22-01-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (271, 50, to_date('29-03-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (272, 50, to_date('13-05-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (273, 50, to_date('07-09-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (274, 50, to_date('25-04-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (275, 10, to_date('17-09-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (276, 10, to_date('07-04-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (277, 20, to_date('04-02-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (278, 10, to_date('09-04-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (279, 20, to_date('29-01-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (280, 40, to_date('28-04-2030', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (281, 30, to_date('12-09-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (282, 20, to_date('18-01-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (283, 50, to_date('12-12-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (284, 30, to_date('01-12-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (285, 40, to_date('10-03-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (286, 50, to_date('08-12-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (287, 30, to_date('08-06-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (288, 50, to_date('21-11-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (289, 30, to_date('17-05-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (290, 20, to_date('07-09-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (291, 20, to_date('14-04-2030', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (292, 10, to_date('16-10-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (293, 20, to_date('18-07-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (294, 30, to_date('23-04-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (295, 10, to_date('26-05-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (296, 40, to_date('05-05-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (297, 10, to_date('08-10-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (298, 40, to_date('18-10-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (299, 30, to_date('02-01-2027', 'dd-mm-yyyy'));
commit;
prompt 200 records committed...
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (300, 30, to_date('25-08-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (301, 10, to_date('31-03-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (302, 20, to_date('22-10-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (303, 10, to_date('12-08-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (304, 50, to_date('05-09-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (305, 40, to_date('10-01-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (306, 40, to_date('02-03-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (307, 50, to_date('08-09-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (308, 30, to_date('04-08-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (309, 50, to_date('04-05-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (310, 20, to_date('23-01-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (311, 20, to_date('03-07-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (312, 50, to_date('15-06-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (313, 20, to_date('13-01-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (314, 50, to_date('27-04-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (315, 50, to_date('31-01-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (316, 20, to_date('02-06-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (317, 40, to_date('02-06-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (318, 10, to_date('21-07-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (319, 10, to_date('13-08-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (320, 40, to_date('23-08-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (321, 10, to_date('03-03-2030', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (322, 40, to_date('07-03-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (323, 30, to_date('12-01-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (324, 10, to_date('31-12-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (325, 10, to_date('20-12-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (326, 10, to_date('29-05-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (327, 30, to_date('13-05-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (328, 30, to_date('25-10-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (329, 40, to_date('18-03-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (330, 40, to_date('26-10-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (331, 40, to_date('14-04-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (332, 10, to_date('10-05-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (333, 50, to_date('12-06-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (334, 30, to_date('30-04-2030', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (335, 50, to_date('30-05-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (336, 30, to_date('12-04-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (337, 20, to_date('08-09-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (338, 20, to_date('09-02-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (339, 40, to_date('29-03-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (340, 50, to_date('30-05-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (341, 30, to_date('29-01-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (342, 40, to_date('17-04-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (343, 30, to_date('06-05-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (344, 20, to_date('29-08-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (345, 40, to_date('10-07-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (346, 40, to_date('05-11-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (347, 20, to_date('29-07-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (348, 20, to_date('30-01-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (349, 10, to_date('22-09-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (350, 50, to_date('02-02-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (351, 40, to_date('16-07-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (352, 10, to_date('30-06-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (353, 40, to_date('18-10-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (354, 10, to_date('01-08-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (355, 30, to_date('26-04-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (356, 30, to_date('18-09-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (357, 40, to_date('06-12-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (358, 50, to_date('11-05-2030', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (359, 20, to_date('18-06-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (360, 30, to_date('09-07-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (361, 30, to_date('22-06-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (362, 10, to_date('21-02-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (363, 50, to_date('12-04-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (364, 50, to_date('14-07-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (365, 10, to_date('30-07-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (366, 40, to_date('04-04-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (367, 10, to_date('04-02-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (368, 30, to_date('30-10-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (369, 10, to_date('14-08-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (370, 30, to_date('11-12-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (371, 10, to_date('08-04-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (372, 40, to_date('23-02-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (373, 50, to_date('01-08-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (374, 40, to_date('14-09-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (375, 40, to_date('17-10-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (376, 50, to_date('09-04-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (377, 20, to_date('09-08-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (378, 40, to_date('02-10-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (379, 40, to_date('04-12-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (380, 50, to_date('16-05-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (381, 40, to_date('18-09-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (382, 20, to_date('04-08-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (383, 20, to_date('30-09-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (384, 30, to_date('19-12-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (385, 20, to_date('24-06-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (386, 20, to_date('12-06-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (387, 10, to_date('06-05-2030', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (388, 30, to_date('20-09-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (389, 40, to_date('26-06-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (390, 20, to_date('19-07-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (391, 20, to_date('28-09-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (392, 20, to_date('17-01-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (393, 40, to_date('29-12-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (394, 10, to_date('08-02-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (395, 50, to_date('31-12-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (396, 20, to_date('06-03-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (397, 10, to_date('18-04-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (398, 20, to_date('15-08-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (399, 40, to_date('25-02-2029', 'dd-mm-yyyy'));
commit;
prompt 300 records committed...
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (400, 10, to_date('15-06-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (401, 30, to_date('30-01-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (402, 10, to_date('16-02-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (403, 40, to_date('06-10-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (404, 40, to_date('26-07-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (405, 20, to_date('16-05-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (406, 40, to_date('23-09-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (407, 40, to_date('09-07-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (408, 50, to_date('22-06-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (409, 30, to_date('06-03-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (410, 30, to_date('29-01-2030', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (411, 30, to_date('05-09-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (412, 20, to_date('31-08-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (413, 20, to_date('01-10-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (414, 30, to_date('22-06-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (415, 20, to_date('15-01-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (416, 10, to_date('18-10-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (417, 50, to_date('16-04-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (418, 20, to_date('02-10-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (419, 20, to_date('04-09-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (420, 10, to_date('11-09-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (421, 20, to_date('07-11-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (422, 50, to_date('04-09-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (423, 30, to_date('21-06-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (424, 50, to_date('13-10-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (425, 10, to_date('28-07-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (426, 40, to_date('08-08-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (427, 20, to_date('13-10-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (428, 50, to_date('14-06-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (429, 10, to_date('21-11-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (430, 50, to_date('25-02-2030', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (431, 30, to_date('31-03-2030', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (432, 30, to_date('19-01-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (433, 10, to_date('14-09-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (434, 40, to_date('16-09-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (435, 50, to_date('24-05-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (436, 10, to_date('29-06-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (437, 40, to_date('18-12-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (438, 40, to_date('09-02-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (439, 40, to_date('14-01-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (440, 30, to_date('23-01-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (441, 50, to_date('03-09-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (442, 30, to_date('05-11-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (443, 50, to_date('26-10-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (444, 50, to_date('28-06-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (445, 50, to_date('22-12-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (446, 40, to_date('29-09-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (447, 30, to_date('27-06-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (448, 30, to_date('23-10-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (449, 40, to_date('04-12-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (450, 30, to_date('16-08-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (451, 20, to_date('19-11-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (452, 50, to_date('21-02-2030', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (453, 40, to_date('30-10-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (454, 50, to_date('25-03-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (455, 10, to_date('17-08-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (456, 10, to_date('01-12-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (457, 20, to_date('07-08-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (458, 20, to_date('30-06-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (459, 50, to_date('06-05-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (460, 10, to_date('10-06-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (461, 40, to_date('29-12-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (462, 20, to_date('30-08-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (463, 50, to_date('24-05-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (464, 20, to_date('24-01-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (465, 40, to_date('04-09-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (466, 50, to_date('15-02-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (467, 30, to_date('29-10-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (468, 40, to_date('31-10-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (469, 30, to_date('15-12-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (470, 20, to_date('01-10-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (471, 20, to_date('08-01-2030', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (472, 30, to_date('29-09-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (473, 10, to_date('12-03-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (474, 40, to_date('30-01-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (475, 50, to_date('04-08-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (476, 20, to_date('12-04-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (477, 50, to_date('12-11-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (478, 10, to_date('25-08-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (479, 50, to_date('07-06-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (480, 30, to_date('25-07-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (481, 20, to_date('12-04-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (482, 50, to_date('05-05-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (483, 20, to_date('21-07-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (484, 30, to_date('10-10-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (485, 40, to_date('23-02-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (486, 40, to_date('28-10-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (487, 10, to_date('16-01-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (488, 10, to_date('19-09-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (489, 10, to_date('20-01-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (490, 40, to_date('15-04-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (491, 40, to_date('04-05-2028', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (492, 40, to_date('04-07-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (493, 40, to_date('03-11-2026', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (494, 30, to_date('02-10-2027', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (495, 50, to_date('22-10-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (496, 20, to_date('17-10-2029', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (497, 20, to_date('03-12-2025', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (498, 10, to_date('29-08-2024', 'dd-mm-yyyy'));
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (499, 40, to_date('21-10-2026', 'dd-mm-yyyy'));
commit;
prompt 400 records committed...
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (500, 10, to_date('15-03-2026', 'dd-mm-yyyy'));
commit;
prompt 401 records loaded
prompt Loading TICKETSALES...
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (100, 27.42, 'N', 181, 279);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (101, 141.32, 'N', 130, 291);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (102, 143.23, 'N', 164, 449);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (103, 111.34, 'N', 119, 111);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (104, 103.86, 'N', 401, 184);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (105, 116.52, 'N', 127, 304);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (106, 146.34, 'N', 177, 499);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (107, 115.38, 'N', 280, 185);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (108, 26.2, 'N', 327, 284);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (109, 103.22, 'N', 185, 310);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (110, 56.69, 'N', 440, 413);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (111, 148.51, 'N', 125, 437);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (112, 141.64, 'N', 461, 163);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (113, 47.27, 'N', 476, 215);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (114, 116.48, 'N', 121, 375);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (115, 25.64, 'N', 152, 204);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (116, 97.3, 'N', 195, 121);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (117, 20.59, 'N', 470, 410);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (118, 58.17, 'N', 379, 119);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (119, 138.68, 'N', 445, 350);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (120, 66.48, 'N', 198, 452);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (121, 83.04, 'N', 307, 247);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (122, 136.42, 'N', 138, 217);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (123, 148.39, 'N', 447, 137);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (124, 90.62, 'N', 195, 314);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (125, 144.28, 'N', 178, 116);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (126, 79.88, 'N', 264, 139);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (127, 146.32, 'N', 337, 100);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (128, 71.08, 'N', 338, 213);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (129, 85.68, 'N', 494, 318);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (130, 123.13, 'N', 139, 338);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (131, 126.62, 'N', 403, 124);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (132, 21.11, 'N', 180, 469);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (133, 142.16, 'N', 464, 340);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (134, 88.53, 'N', 237, 321);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (135, 107.94, 'N', 418, 317);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (136, 57.66, 'N', 457, 495);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (137, 114.09, 'N', 268, 129);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (138, 28.09, 'N', 294, 327);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (139, 125.33, 'N', 215, 286);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (140, 133.29, 'N', 457, 472);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (141, 139.14, 'N', 434, 171);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (142, 85.37, 'N', 292, 198);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (143, 92.08, 'N', 261, 412);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (144, 28, 'N', 194, 223);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (145, 34.19, 'N', 413, 362);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (146, 97.32, 'N', 227, 259);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (147, 51.6, 'N', 232, 324);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (148, 121.16, 'N', 188, 492);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (149, 67.16, 'N', 353, 484);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (150, 106.19, 'N', 284, 185);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (151, 39.31, 'N', 393, 176);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (152, 83.37, 'N', 438, 208);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (153, 38.93, 'N', 473, 279);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (154, 91.38, 'N', 218, 286);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (155, 74.5, 'N', 162, 321);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (156, 38.3, 'N', 195, 176);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (157, 55.19, 'N', 442, 329);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (158, 91.31, 'N', 321, 375);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (159, 22.22, 'N', 299, 185);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (160, 34.61, 'N', 138, 339);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (161, 128.3, 'N', 347, 123);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (162, 65.34, 'N', 404, 245);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (163, 105.15, 'N', 268, 342);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (164, 37.79, 'N', 152, 258);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (165, 39.22, 'N', 477, 141);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (166, 145.58, 'N', 368, 144);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (167, 115.46, 'N', 420, 191);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (168, 52.06, 'N', 299, 388);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (169, 109.31, 'N', 290, 321);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (170, 108.81, 'N', 380, 452);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (171, 56.71, 'N', 167, 432);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (172, 112.25, 'N', 193, 148);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (173, 22.28, 'N', 192, 137);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (174, 148.36, 'N', 247, 149);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (175, 135.69, 'N', 154, 333);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (176, 145.63, 'N', 380, 406);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (177, 116.01, 'N', 112, 278);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (178, 85.95, 'N', 394, 103);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (179, 104.34, 'N', 436, 216);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (180, 93.83, 'N', 106, 341);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (181, 74.45, 'N', 476, 315);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (182, 143.58, 'N', 435, 330);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (183, 31.6, 'N', 254, 326);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (184, 34.71, 'N', 299, 327);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (185, 89.48, 'N', 382, 382);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (186, 25.43, 'N', 152, 480);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (187, 35.27, 'N', 207, 105);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (188, 44.22, 'N', 137, 408);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (189, 72.8, 'N', 175, 451);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (190, 79.68, 'N', 466, 306);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (191, 143.91, 'N', 429, 270);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (192, 58.28, 'N', 428, 368);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (193, 37.82, 'N', 423, 402);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (194, 120.44, 'N', 416, 141);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (195, 28.72, 'N', 366, 487);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (196, 124.64, 'N', 185, 207);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (197, 91.48, 'N', 491, 104);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (198, 69.61, 'N', 131, 176);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (199, 35.39, 'N', 147, 244);
commit;
prompt 100 records committed...
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (200, 134.79, 'N', 397, 222);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (201, 36.17, 'N', 316, 288);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (202, 78.74, 'N', 205, 129);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (203, 135.98, 'N', 359, 131);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (204, 75.82, 'N', 209, 275);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (205, 141.62, 'N', 182, 218);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (206, 130.9, 'N', 275, 125);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (207, 50.82, 'N', 228, 310);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (208, 22.27, 'N', 291, 269);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (209, 96.72, 'N', 496, 172);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (210, 32.59, 'N', 393, 367);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (211, 20.36, 'N', 185, 191);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (212, 128.04, 'N', 221, 229);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (213, 41.43, 'N', 362, 313);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (214, 55.58, 'N', 402, 415);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (215, 147.03, 'N', 451, 109);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (216, 98.26, 'N', 253, 368);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (217, 38.65, 'N', 156, 366);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (218, 148.79, 'N', 111, 459);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (219, 127.18, 'N', 402, 198);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (220, 91.12, 'N', 293, 369);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (221, 66.11, 'N', 102, 492);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (222, 60.2, 'N', 271, 191);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (223, 22.87, 'N', 351, 466);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (224, 59.83, 'N', 479, 257);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (225, 138.21, 'N', 445, 163);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (226, 108.68, 'N', 346, 488);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (227, 123.81, 'N', 121, 468);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (228, 134.4, 'N', 150, 475);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (229, 37.92, 'N', 428, 240);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (230, 135.87, 'N', 296, 278);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (231, 29.21, 'N', 419, 184);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (232, 93.58, 'N', 424, 358);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (233, 88.66, 'N', 468, 240);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (234, 148.11, 'N', 342, 222);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (235, 69.65, 'N', 212, 495);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (236, 136.73, 'N', 374, 209);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (237, 106.14, 'N', 325, 423);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (238, 48.22, 'N', 349, 385);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (239, 128.97, 'N', 103, 452);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (240, 95.66, 'N', 400, 174);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (241, 40.29, 'N', 486, 253);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (242, 147.48, 'N', 397, 310);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (243, 26.13, 'N', 101, 156);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (244, 76.53, 'N', 405, 315);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (245, 97.08, 'N', 331, 487);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (246, 117.41, 'N', 158, 299);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (247, 27.1, 'N', 205, 434);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (248, 61.73, 'N', 371, 288);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (249, 80.44, 'N', 316, 439);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (250, 21.71, 'N', 268, 280);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (251, 56.71, 'N', 169, 109);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (252, 31.74, 'N', 136, 217);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (253, 34.09, 'N', 142, 462);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (254, 48.12, 'N', 107, 290);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (255, 80.57, 'N', 485, 481);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (256, 86.99, 'N', 363, 367);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (257, 103.46, 'N', 133, 417);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (258, 110.27, 'N', 367, 142);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (259, 96.89, 'N', 154, 194);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (260, 49.8, 'N', 319, 420);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (261, 137.54, 'N', 210, 155);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (262, 99.59, 'N', 435, 309);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (263, 128.4, 'N', 460, 121);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (264, 106.17, 'N', 453, 354);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (265, 70.74, 'N', 467, 387);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (266, 137.14, 'N', 162, 389);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (267, 84.18, 'N', 349, 231);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (268, 147.72, 'N', 162, 111);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (269, 44.83, 'N', 144, 360);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (270, 45.55, 'N', 440, 388);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (271, 141.61, 'N', 201, 468);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (272, 23.54, 'N', 377, 479);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (273, 140.72, 'N', 203, 331);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (274, 120.84, 'N', 178, 392);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (275, 88.15, 'N', 406, 422);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (276, 52.04, 'N', 128, 360);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (277, 110.4, 'N', 306, 446);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (278, 84.31, 'N', 474, 241);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (279, 93.28, 'N', 338, 210);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (280, 102.87, 'N', 327, 450);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (281, 148.82, 'N', 185, 411);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (282, 114.42, 'N', 395, 406);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (283, 50.37, 'N', 131, 148);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (284, 108.79, 'N', 337, 113);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (285, 105.73, 'N', 219, 368);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (286, 58.67, 'N', 346, 462);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (287, 88.51, 'N', 454, 425);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (288, 57.51, 'N', 151, 256);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (289, 127.56, 'N', 411, 171);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (290, 75.47, 'N', 250, 366);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (291, 44.46, 'N', 286, 376);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (292, 113.58, 'N', 165, 203);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (293, 129.31, 'N', 159, 260);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (294, 105.99, 'N', 121, 127);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (295, 104.44, 'N', 291, 164);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (296, 90.3, 'N', 153, 170);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (297, 46.42, 'N', 436, 137);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (298, 126.09, 'N', 238, 288);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (299, 146.07, 'N', 191, 450);
commit;
prompt 200 records committed...
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (300, 91.53, 'N', 244, 141);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (301, 86.67, 'N', 360, 439);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (302, 138.14, 'N', 121, 394);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (303, 120.23, 'N', 145, 467);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (304, 113.63, 'N', 295, 344);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (305, 71.98, 'N', 171, 214);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (306, 32.92, 'N', 306, 271);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (307, 42.89, 'N', 121, 497);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (308, 37.28, 'N', 464, 120);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (309, 80.37, 'N', 209, 200);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (310, 101.52, 'N', 123, 100);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (311, 117.06, 'N', 472, 348);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (312, 139.41, 'N', 191, 410);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (313, 47.79, 'N', 285, 492);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (314, 117.16, 'N', 262, 494);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (315, 74.62, 'N', 108, 224);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (316, 45.03, 'N', 368, 216);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (317, 20.01, 'N', 255, 222);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (318, 107.09, 'N', 161, 166);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (319, 78.18, 'N', 279, 407);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (320, 149.11, 'N', 316, 285);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (321, 144.48, 'N', 200, 437);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (322, 84.49, 'N', 168, 416);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (323, 63, 'N', 340, 122);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (324, 48.48, 'N', 359, 383);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (325, 142.22, 'N', 197, 165);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (326, 40.32, 'N', 125, 393);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (327, 118.83, 'N', 333, 424);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (328, 93.69, 'N', 399, 165);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (329, 79.68, 'N', 496, 100);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (330, 65.17, 'N', 340, 380);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (331, 91.81, 'N', 360, 261);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (332, 80.88, 'N', 493, 458);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (333, 100.64, 'N', 495, 270);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (334, 81.2, 'N', 162, 262);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (335, 96.31, 'N', 357, 158);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (336, 23.67, 'N', 225, 127);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (337, 28.06, 'N', 111, 113);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (338, 93.96, 'N', 155, 408);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (339, 116.84, 'N', 269, 291);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (340, 145.01, 'N', 484, 158);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (341, 135.97, 'N', 362, 158);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (342, 54.28, 'N', 275, 137);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (343, 129.93, 'N', 228, 155);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (344, 89.09, 'N', 436, 129);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (345, 101.33, 'N', 336, 490);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (346, 110.15, 'N', 443, 203);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (347, 95.95, 'N', 324, 247);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (348, 83.18, 'N', 102, 285);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (349, 35.92, 'N', 170, 433);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (350, 78.61, 'N', 322, 463);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (351, 81.05, 'N', 382, 136);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (352, 149.52, 'N', 130, 413);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (353, 88.22, 'N', 421, 222);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (354, 87.59, 'N', 291, 353);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (355, 118.99, 'N', 137, 142);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (356, 97.22, 'N', 373, 318);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (357, 45.25, 'N', 245, 279);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (358, 47.8, 'N', 419, 165);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (359, 73.04, 'N', 210, 207);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (360, 34.08, 'N', 461, 299);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (361, 104.49, 'N', 370, 486);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (362, 34.63, 'N', 242, 323);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (363, 147.86, 'N', 278, 373);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (364, 98.51, 'N', 379, 420);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (365, 85.73, 'N', 470, 262);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (366, 149.98, 'N', 137, 252);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (367, 101.33, 'N', 458, 454);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (368, 61.39, 'N', 240, 189);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (369, 72.95, 'N', 144, 238);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (370, 124.17, 'N', 296, 461);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (371, 146.49, 'N', 272, 114);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (372, 97.95, 'N', 459, 232);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (373, 146.18, 'N', 286, 329);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (374, 87.81, 'N', 104, 210);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (375, 33.36, 'N', 430, 142);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (376, 129.63, 'N', 333, 368);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (377, 113.42, 'N', 462, 215);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (378, 43.64, 'N', 309, 395);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (379, 80.85, 'N', 200, 125);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (380, 75.97, 'N', 209, 481);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (381, 22.45, 'N', 287, 209);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (382, 118.46, 'N', 403, 411);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (383, 128.61, 'N', 386, 123);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (384, 106.49, 'N', 464, 199);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (385, 22.75, 'N', 397, 137);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (386, 34.99, 'N', 393, 236);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (387, 48.92, 'N', 300, 346);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (388, 112.54, 'N', 478, 169);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (389, 97.39, 'N', 225, 210);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (390, 143.68, 'N', 175, 104);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (391, 128.57, 'N', 342, 426);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (392, 89.21, 'N', 411, 130);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (393, 54.85, 'N', 178, 303);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (394, 114.7, 'N', 115, 177);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (395, 20.72, 'N', 167, 295);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (396, 127.16, 'N', 175, 187);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (397, 40.93, 'N', 209, 425);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (398, 99.72, 'N', 417, 222);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (399, 36.79, 'N', 469, 260);
commit;
prompt 300 records committed...
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (400, 144.54, 'N', 411, 489);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (401, 140.63, 'N', 393, 396);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (402, 73.81, 'N', 101, 489);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (403, 98.32, 'N', 351, 275);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (404, 138.84, 'N', 263, 100);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (405, 110, 'N', 303, 324);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (406, 87.34, 'N', 380, 179);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (407, 118.85, 'N', 298, 419);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (408, 48.78, 'N', 354, 283);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (409, 148.04, 'N', 384, 277);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (410, 127.85, 'N', 432, 327);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (411, 125.8, 'N', 357, 169);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (412, 136.15, 'N', 162, 160);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (413, 108.57, 'N', 128, 361);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (414, 111.89, 'N', 375, 269);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (415, 122.34, 'N', 311, 477);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (416, 67.75, 'N', 190, 403);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (417, 142.07, 'N', 249, 391);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (418, 136.92, 'N', 244, 125);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (419, 79.27, 'N', 250, 241);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (420, 77.18, 'N', 147, 496);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (421, 37.63, 'N', 460, 370);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (422, 83.19, 'N', 165, 469);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (423, 56.89, 'N', 351, 387);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (424, 46.81, 'N', 322, 420);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (425, 124.74, 'N', 444, 162);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (426, 125.62, 'N', 131, 402);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (427, 66.88, 'N', 249, 337);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (428, 149.55, 'N', 153, 320);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (429, 95.22, 'N', 433, 368);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (430, 75.63, 'N', 173, 434);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (431, 64.17, 'N', 414, 488);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (432, 60.84, 'N', 410, 185);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (433, 35.08, 'N', 180, 398);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (434, 23.09, 'N', 142, 152);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (435, 68.81, 'N', 328, 283);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (436, 120.41, 'N', 166, 324);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (437, 26.4, 'N', 336, 150);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (438, 68.13, 'N', 277, 303);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (439, 27.87, 'N', 254, 294);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (440, 24.26, 'N', 172, 235);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (441, 139.19, 'N', 224, 485);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (442, 53.03, 'N', 183, 459);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (443, 67.28, 'N', 219, 287);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (444, 116.45, 'N', 232, 285);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (445, 33.27, 'N', 414, 497);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (446, 74.11, 'N', 209, 298);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (447, 93.73, 'N', 181, 105);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (448, 81.02, 'N', 180, 182);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (449, 120.16, 'N', 100, 393);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (450, 83.62, 'N', 417, 479);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (451, 46.52, 'N', 210, 138);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (452, 103.87, 'N', 452, 256);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (453, 124.94, 'N', 471, 366);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (454, 141.56, 'N', 361, 317);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (455, 149.49, 'N', 260, 202);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (456, 84.61, 'N', 264, 325);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (457, 118.14, 'N', 488, 271);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (458, 147.61, 'N', 461, 256);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (459, 122.81, 'N', 345, 409);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (460, 148.43, 'N', 184, 176);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (461, 117.58, 'N', 263, 500);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (462, 92.97, 'N', 178, 344);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (463, 84.95, 'N', 314, 445);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (464, 118.02, 'N', 309, 439);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (465, 80.3, 'N', 425, 453);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (466, 52.27, 'N', 190, 311);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (467, 24.46, 'N', 425, 448);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (468, 25.4, 'N', 441, 261);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (469, 24.37, 'N', 305, 218);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (470, 45.39, 'N', 165, 442);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (471, 51.92, 'N', 321, 276);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (472, 103.82, 'N', 257, 183);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (473, 20.84, 'N', 103, 248);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (474, 29.4, 'N', 135, 450);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (475, 131.79, 'N', 405, 390);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (476, 129.6, 'N', 292, 213);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (477, 55.53, 'N', 268, 226);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (478, 20.38, 'N', 278, 355);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (479, 74.26, 'N', 416, 320);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (480, 64.06, 'N', 106, 299);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (481, 20.99, 'N', 471, 352);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (482, 85.32, 'N', 284, 157);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (483, 47.17, 'N', 400, 348);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (484, 45.35, 'N', 465, 411);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (485, 98.32, 'N', 179, 208);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (486, 74.02, 'N', 334, 310);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (487, 47.85, 'N', 490, 380);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (488, 120.35, 'N', 311, 206);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (489, 99.03, 'N', 434, 441);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (490, 130.92, 'N', 478, 199);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (491, 25.01, 'N', 278, 419);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (492, 106.53, 'N', 141, 316);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (493, 107, 'N', 421, 430);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (494, 36.97, 'N', 404, 214);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (495, 130.61, 'N', 190, 242);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (496, 103.83, 'N', 180, 409);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (497, 80.25, 'N', 452, 369);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (498, 111.56, 'N', 418, 224);
insert into TICKETSALES (ticketid, price, issold, scheduleid, subscriberid)
values (499, 61.73, 'N', 464, 278);
commit;
prompt 400 records loaded
prompt Enabling foreign key constraints for SCHEDULES...
alter table SCHEDULES enable constraint SYS_C007227;
alter table SCHEDULES enable constraint SYS_C007228;
alter table SCHEDULES enable constraint SYS_C007229;
prompt Enabling foreign key constraints for TICKETSALES...
alter table TICKETSALES enable constraint SYS_C007237;
alter table TICKETSALES enable constraint SYS_C007238;
prompt Enabling triggers for DATES...
alter table DATES enable all triggers;
prompt Enabling triggers for MOVIES...
alter table MOVIES enable all triggers;
prompt Enabling triggers for THEATERS...
alter table THEATERS enable all triggers;
prompt Enabling triggers for SCHEDULES...
alter table SCHEDULES enable all triggers;
prompt Enabling triggers for SUBSCRIBERS...
alter table SUBSCRIBERS enable all triggers;
prompt Enabling triggers for TICKETSALES...
alter table TICKETSALES enable all triggers;
set feedback on
set define on
prompt Done.
