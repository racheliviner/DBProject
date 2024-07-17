prompt PL/SQL Developer import file
prompt Created on יום ראשון 14 יולי 2024 by naama
set feedback off
set define off
prompt Creating CATEGORYS...
create table CATEGORYS
(
  category_id   NUMBER(3) not null,
  category_name VARCHAR2(15) not null
)
;
alter table CATEGORYS
  add primary key (CATEGORY_ID);

prompt Creating PERSON...
create table PERSON
(
  pid   NUMBER(3) not null,
  pname VARCHAR2(150)
)
;
alter table PERSON
  add primary key (PID);

prompt Creating CLIENT...
create table CLIENT
(
  client_id NUMBER(3) not null
)
;
alter table CLIENT
  add primary key (CLIENT_ID);
alter table CLIENT
  add constraint FK_CL foreign key (CLIENT_ID)
  references PERSON (PID);

prompt Creating DATES...
create table DATES
(
  dateid NUMBER(3) not null,
  hourh  VARCHAR2(100) not null,
  dayd   VARCHAR2(100) not null,
  dated  DATE not null
)
;
alter table DATES
  add primary key (DATEID);

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
;
alter table MOVIES
  add primary key (MOVIEID);

prompt Creating ORDERS...
create table ORDERS
(
  order_id       NUMBER(3) not null,
  order_date     DATE not null,
  dellivery_date DATE not null
)
;
alter table ORDERS
  add primary key (ORDER_ID);

prompt Creating PRODUCTS...
create table PRODUCTS
(
  product_id    NUMBER(3) not null,
  product_name  VARCHAR2(15),
  quantity      NUMBER(3) not null,
  product_price NUMBER(3) not null,
  category_id   NUMBER(3) not null
)
;
alter table PRODUCTS
  add primary key (PRODUCT_ID);
alter table PRODUCTS
  add foreign key (CATEGORY_ID)
  references CATEGORYS (CATEGORY_ID);
alter table PRODUCTS
  add constraint CHK_QUANTITY2
  check (Quantity >= 0);

prompt Creating STOREPRODUCTS...
create table STOREPRODUCTS
(
  storeproduct_id NUMBER(3) not null
)
;
alter table STOREPRODUCTS
  add primary key (STOREPRODUCT_ID);
alter table STOREPRODUCTS
  add foreign key (STOREPRODUCT_ID)
  references PRODUCTS (PRODUCT_ID);

prompt Creating ORDER_PRODUCT...
create table ORDER_PRODUCT
(
  product_id NUMBER(3) not null,
  order_id   NUMBER(3) not null
)
;
alter table ORDER_PRODUCT
  add primary key (PRODUCT_ID, ORDER_ID);
alter table ORDER_PRODUCT
  add constraint FK_OP foreign key (PRODUCT_ID)
  references STOREPRODUCTS (STOREPRODUCT_ID);
alter table ORDER_PRODUCT
  add foreign key (ORDER_ID)
  references ORDERS (ORDER_ID);

prompt Creating SUPPLIER...
create table SUPPLIER
(
  supplier_id NUMBER(3) not null,
  region      VARCHAR2(15) not null
)
;
alter table SUPPLIER
  add primary key (SUPPLIER_ID);
alter table SUPPLIER
  add constraint FK_SP foreign key (SUPPLIER_ID)
  references PERSON (PID);

prompt Creating ORDER_SUPPLIER...
create table ORDER_SUPPLIER
(
  supplier_id NUMBER(3) not null,
  order_id    NUMBER(3) not null
)
;
alter table ORDER_SUPPLIER
  add primary key (SUPPLIER_ID, ORDER_ID);
alter table ORDER_SUPPLIER
  add foreign key (SUPPLIER_ID)
  references SUPPLIER (SUPPLIER_ID);
alter table ORDER_SUPPLIER
  add foreign key (ORDER_ID)
  references ORDERS (ORDER_ID);

prompt Creating WORKER...
create table WORKER
(
  worker_id          NUMBER(3) not null,
  start_of_work_date DATE not null
)
;
alter table WORKER
  add primary key (WORKER_ID);
alter table WORKER
  add constraint FK_WR foreign key (WORKER_ID)
  references PERSON (PID);

prompt Creating ORDER_WORKER...
create table ORDER_WORKER
(
  worker_id NUMBER(3) not null,
  order_id  NUMBER(3) not null
)
;
alter table ORDER_WORKER
  add primary key (WORKER_ID, ORDER_ID);
alter table ORDER_WORKER
  add foreign key (WORKER_ID)
  references WORKER (WORKER_ID);
alter table ORDER_WORKER
  add foreign key (ORDER_ID)
  references ORDERS (ORDER_ID);

prompt Creating PURCHASE...
create table PURCHASE
(
  purchase_id    NUMBER(3) not null,
  purchase_date  DATE not null,
  dellivery_date DATE not null
)
;
alter table PURCHASE
  add primary key (PURCHASE_ID);

prompt Creating PURCHASE_CLIENT...
create table PURCHASE_CLIENT
(
  client_id   NUMBER(3) not null,
  purchase_id NUMBER(3) not null
)
;
alter table PURCHASE_CLIENT
  add primary key (CLIENT_ID, PURCHASE_ID);
alter table PURCHASE_CLIENT
  add foreign key (CLIENT_ID)
  references CLIENT (CLIENT_ID);
alter table PURCHASE_CLIENT
  add foreign key (PURCHASE_ID)
  references PURCHASE (PURCHASE_ID);

prompt Creating PURCHASE_PRODUCT...
create table PURCHASE_PRODUCT
(
  product_id  NUMBER(3) not null,
  purchase_id NUMBER(3) not null
)
;
alter table PURCHASE_PRODUCT
  add primary key (PRODUCT_ID, PURCHASE_ID);
alter table PURCHASE_PRODUCT
  add foreign key (PRODUCT_ID)
  references PRODUCTS (PRODUCT_ID);
alter table PURCHASE_PRODUCT
  add foreign key (PURCHASE_ID)
  references PURCHASE (PURCHASE_ID);

prompt Creating PURCHASE_WORKER...
create table PURCHASE_WORKER
(
  worker_id   NUMBER(3) not null,
  purchase_id NUMBER(3) not null
)
;
alter table PURCHASE_WORKER
  add primary key (WORKER_ID, PURCHASE_ID);
alter table PURCHASE_WORKER
  add foreign key (WORKER_ID)
  references WORKER (WORKER_ID);
alter table PURCHASE_WORKER
  add foreign key (PURCHASE_ID)
  references PURCHASE (PURCHASE_ID);

prompt Creating SUBSCRIBERS...
create table SUBSCRIBERS
(
  subscriberid     NUMBER(3) not null,
  discountpercents INTEGER,
  expirationdate   DATE
)
;
alter table SUBSCRIBERS
  add primary key (SUBSCRIBERID);
alter table SUBSCRIBERS
  add constraint FK_SB foreign key (SUBSCRIBERID)
  references CLIENT (CLIENT_ID);

prompt Creating THEATERS...
create table THEATERS
(
  theaterid   NUMBER(3) not null,
  theatername VARCHAR2(100) not null,
  capacity    INTEGER not null
)
;
alter table THEATERS
  add primary key (THEATERID);

prompt Creating TICKETS...
create table TICKETS
(
  ticket_id NUMBER(3) not null,
  theaterid NUMBER(3),
  movieid   NUMBER(3),
  dateid    NUMBER(3)
)
;
alter table TICKETS
  add primary key (TICKET_ID);
alter table TICKETS
  add foreign key (TICKET_ID)
  references PRODUCTS (PRODUCT_ID);
alter table TICKETS
  add foreign key (MOVIEID)
  references MOVIES (MOVIEID);
alter table TICKETS
  add foreign key (THEATERID)
  references THEATERS (THEATERID);
alter table TICKETS
  add foreign key (DATEID)
  references DATES (DATEID);

prompt Disabling triggers for CATEGORYS...
alter table CATEGORYS disable all triggers;
prompt Disabling triggers for PERSON...
alter table PERSON disable all triggers;
prompt Disabling triggers for CLIENT...
alter table CLIENT disable all triggers;
prompt Disabling triggers for DATES...
alter table DATES disable all triggers;
prompt Disabling triggers for MOVIES...
alter table MOVIES disable all triggers;
prompt Disabling triggers for ORDERS...
alter table ORDERS disable all triggers;
prompt Disabling triggers for PRODUCTS...
alter table PRODUCTS disable all triggers;
prompt Disabling triggers for STOREPRODUCTS...
alter table STOREPRODUCTS disable all triggers;
prompt Disabling triggers for ORDER_PRODUCT...
alter table ORDER_PRODUCT disable all triggers;
prompt Disabling triggers for SUPPLIER...
alter table SUPPLIER disable all triggers;
prompt Disabling triggers for ORDER_SUPPLIER...
alter table ORDER_SUPPLIER disable all triggers;
prompt Disabling triggers for WORKER...
alter table WORKER disable all triggers;
prompt Disabling triggers for ORDER_WORKER...
alter table ORDER_WORKER disable all triggers;
prompt Disabling triggers for PURCHASE...
alter table PURCHASE disable all triggers;
prompt Disabling triggers for PURCHASE_CLIENT...
alter table PURCHASE_CLIENT disable all triggers;
prompt Disabling triggers for PURCHASE_PRODUCT...
alter table PURCHASE_PRODUCT disable all triggers;
prompt Disabling triggers for PURCHASE_WORKER...
alter table PURCHASE_WORKER disable all triggers;
prompt Disabling triggers for SUBSCRIBERS...
alter table SUBSCRIBERS disable all triggers;
prompt Disabling triggers for THEATERS...
alter table THEATERS disable all triggers;
prompt Disabling triggers for TICKETS...
alter table TICKETS disable all triggers;
prompt Disabling foreign key constraints for CLIENT...
alter table CLIENT disable constraint FK_CL;
prompt Disabling foreign key constraints for PRODUCTS...
alter table PRODUCTS disable constraint SYS_C008017;
prompt Disabling foreign key constraints for STOREPRODUCTS...
alter table STOREPRODUCTS disable constraint SYS_C008035;
prompt Disabling foreign key constraints for ORDER_PRODUCT...
alter table ORDER_PRODUCT disable constraint FK_OP;
alter table ORDER_PRODUCT disable constraint SYS_C008022;
prompt Disabling foreign key constraints for SUPPLIER...
alter table SUPPLIER disable constraint FK_SP;
prompt Disabling foreign key constraints for ORDER_SUPPLIER...
alter table ORDER_SUPPLIER disable constraint SYS_C007994;
alter table ORDER_SUPPLIER disable constraint SYS_C007995;
prompt Disabling foreign key constraints for WORKER...
alter table WORKER disable constraint FK_WR;
prompt Disabling foreign key constraints for ORDER_WORKER...
alter table ORDER_WORKER disable constraint SYS_C007999;
alter table ORDER_WORKER disable constraint SYS_C008000;
prompt Disabling foreign key constraints for PURCHASE_CLIENT...
alter table PURCHASE_CLIENT disable constraint SYS_C008009;
alter table PURCHASE_CLIENT disable constraint SYS_C008010;
prompt Disabling foreign key constraints for PURCHASE_PRODUCT...
alter table PURCHASE_PRODUCT disable constraint SYS_C008026;
alter table PURCHASE_PRODUCT disable constraint SYS_C008027;
prompt Disabling foreign key constraints for PURCHASE_WORKER...
alter table PURCHASE_WORKER disable constraint SYS_C008004;
alter table PURCHASE_WORKER disable constraint SYS_C008005;
prompt Disabling foreign key constraints for SUBSCRIBERS...
alter table SUBSCRIBERS disable constraint FK_SB;
prompt Disabling foreign key constraints for TICKETS...
alter table TICKETS disable constraint SYS_C008037;
alter table TICKETS disable constraint SYS_C008038;
alter table TICKETS disable constraint SYS_C008039;
alter table TICKETS disable constraint SYS_C008040;
prompt Deleting TICKETS...
delete from TICKETS;
commit;
prompt Deleting THEATERS...
delete from THEATERS;
commit;
prompt Deleting SUBSCRIBERS...
delete from SUBSCRIBERS;
commit;
prompt Deleting PURCHASE_WORKER...
delete from PURCHASE_WORKER;
commit;
prompt Deleting PURCHASE_PRODUCT...
delete from PURCHASE_PRODUCT;
commit;
prompt Deleting PURCHASE_CLIENT...
delete from PURCHASE_CLIENT;
commit;
prompt Deleting PURCHASE...
delete from PURCHASE;
commit;
prompt Deleting ORDER_WORKER...
delete from ORDER_WORKER;
commit;
prompt Deleting WORKER...
delete from WORKER;
commit;
prompt Deleting ORDER_SUPPLIER...
delete from ORDER_SUPPLIER;
commit;
prompt Deleting SUPPLIER...
delete from SUPPLIER;
commit;
prompt Deleting ORDER_PRODUCT...
delete from ORDER_PRODUCT;
commit;
prompt Deleting STOREPRODUCTS...
delete from STOREPRODUCTS;
commit;
prompt Deleting PRODUCTS...
delete from PRODUCTS;
commit;
prompt Deleting ORDERS...
delete from ORDERS;
commit;
prompt Deleting MOVIES...
delete from MOVIES;
commit;
prompt Deleting DATES...
delete from DATES;
commit;
prompt Deleting CLIENT...
delete from CLIENT;
commit;
prompt Deleting PERSON...
delete from PERSON;
commit;
prompt Deleting CATEGORYS...
delete from CATEGORYS;
commit;
prompt Loading CATEGORYS...
insert into CATEGORYS (category_id, category_name)
values (100, 'irure ipsum do.');
insert into CATEGORYS (category_id, category_name)
values (101, 'rerum sit. ');
insert into CATEGORYS (category_id, category_name)
values (102, 'officiis. ');
insert into CATEGORYS (category_id, category_name)
values (103, 'cum proident. ');
insert into CATEGORYS (category_id, category_name)
values (105, 'dolor. ');
insert into CATEGORYS (category_id, category_name)
values (104, 'est' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (107, 'in' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (110, 'mollit' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (111, 'distinctio' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (112, 'et' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (115, 'et' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (117, 'ut' || chr(10) || 'non' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (118, 'qui' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (109, 'ducimus' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (113, 'sed' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (114, 'sint' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (116, 'id' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (120, 'ut' || chr(10) || 'harum' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (121, 'sint' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (123, 'sint' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (124, 'quas' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (126, 'enim' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (127, 'elit' || chr(10) || 'at' || chr(10) || 'ea' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (128, 'non' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (129, 'rerum' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (130, 'iusto' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (131, 'culpa' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (132, 'duis' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (133, 'et' || chr(10) || 'earum' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (135, 'cillum' || chr(10) || 'ea' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (136, 'et' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (139, 'odio' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (140, 'ullamco' || chr(10) || 'in' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (141, 'dolor' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (142, 'pariatur' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (143, 'a' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (144, 'amet' || chr(10) || 'et' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (145, 'non' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (147, 'est' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (148, 'et' || chr(10) || 'et' || chr(10) || 'et' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (153, 'odio' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (156, 'ea' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (157, 'rerum' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (159, 'culpa' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (163, 'voluptatum' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (164, 'ut' || chr(10) || 'a' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (166, 'non' || chr(10) || 'est' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (167, 'rerum' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (171, 'autem' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (172, 'tempore' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (174, 'ut' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (177, 'quis' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (178, 'et' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (182, 'amet' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (183, 'libero' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (184, 'amet' || chr(10) || 'aute' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (188, 'id' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (191, 'do' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (192, 'non' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (195, 'quod' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (196, 'sunt' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (199, 'minus' || chr(10) || 'at' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (200, 'ut' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (201, 'ut' || chr(10) || 'et' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (203, 'recusandae' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (205, 'sunt' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (206, 'sed' || chr(10) || 'est' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (208, 'perferendis' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (210, 'blanditiis' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (211, 'impedit' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (212, 'in' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (213, 'a' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (216, 'tempore' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (217, 'sed' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (218, 'et' || chr(10) || 'laborum' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (220, 'alias' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (224, 'qui' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (226, 'maiores' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (227, 'est' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (229, 'amet' || chr(10) || 'aut' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (230, 'esse' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (232, 'aut' || chr(10) || 'qui' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (234, 'tempore' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (235, 'fuga' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (237, 'vero' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (242, 'dignissimos' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (244, 'id' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (245, 'laboris' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (247, 'est' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (204, 'animi' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (209, 'et' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (214, 'a' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (215, 'voluptas' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (221, 'quas' || chr(10) || 'odio' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (222, 'officia' || chr(10) || 'et' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (223, 'occaecati' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (202, 'a' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (207, 'nobis' || chr(10) || 'ut' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (219, 'laboris' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (225, 'ut' || chr(10) || 'et' || chr(10) || '');
commit;
prompt 100 records committed...
insert into CATEGORYS (category_id, category_name)
values (231, 'possimus' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (233, 'adipisicing' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (238, 'id' || chr(10) || 'et' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (241, 'harum' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (243, 'rerum' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (246, 'ut' || chr(10) || 'cum' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (251, 'in' || chr(10) || 'est' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (253, 'doloribus' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (255, 'mollit' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (256, 'laborum' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (257, 'enim' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (258, 'aut' || chr(10) || 'eu' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (259, 'aut' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (262, 'aut' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (265, 'quo' || chr(10) || 'id' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (268, 'repudiandae' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (269, 'eos' || chr(10) || 'aut' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (270, 'et' || chr(10) || 'et' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (272, 'itaque' || chr(10) || 'sint' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (273, 'delectus' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (274, 'ad' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (275, 'et' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (276, 'fugiat' || chr(10) || 'est' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (280, 'eu' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (281, 'quod' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (282, 'reiciendis' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (284, 'rerum' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (285, 'et' || chr(10) || 'vero' || chr(10) || 'qui' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (286, 'id' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (288, 'ut' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (289, 'sunt' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (292, 'facilis' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (294, 'non' || chr(10) || 'libero' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (298, 'culpa' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (300, 'fugiat' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (302, 'ut' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (304, 'aut' || chr(10) || 'soluta' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (305, 'cum' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (306, 'non' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (308, 'et' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (309, 'sapiente' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (310, 'mollitia' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (315, 'saepe' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (316, 'qui' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (317, 'molestiae' || chr(10) || 'a' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (321, 'quidem' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (323, 'sint' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (326, 'quos' || chr(10) || 'amet' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (327, 'dolor' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (329, 'dolor' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (332, 'maiores' || chr(10) || 'ut' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (333, 'dolor' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (334, 'et' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (336, 'nulla' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (341, 'maxime' || chr(10) || 'et' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (346, 'et' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (347, 'ut' || chr(10) || 'dolor' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (348, 'in' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (349, 'corrupti' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (351, 'at' || chr(10) || 'cumque' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (352, 'eos' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (354, 'maiores' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (356, 'dolores' || chr(10) || 'et' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (358, 'et' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (360, 'odio' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (362, 'eligendi' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (363, 'dolore' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (365, 'cupidatat' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (368, 'odio' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (370, 'tenetur' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (372, 'a' || chr(10) || 'commodo' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (373, 'commodo' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (376, 'tempor' || chr(10) || 'eu' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (378, 'omnis' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (380, 'repudiandae' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (382, 'est' || chr(10) || 'ex' || chr(10) || 'ea' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (384, 'et' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (387, 'proident' || chr(10) || 'ut' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (390, 'in' || chr(10) || 'qui' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (391, 'earum' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (392, 'vero' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (393, 'saepe' || chr(10) || 'in' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (394, 'qui' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (395, 'possimus' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (397, 'laborum' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (303, 'culpa' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (312, 'non' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (313, 'recusandae' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (314, 'impedit' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (318, 'do' || chr(10) || 'dolor' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (320, 'in' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (322, 'officia' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (328, 'soluta' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (331, 'ut' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (339, 'qui' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (340, 'veniam' || chr(10) || 'est' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (345, 'rerum' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (350, 'harum' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (359, 'in' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (364, 'vero' || chr(10) || '');
commit;
prompt 200 records committed...
insert into CATEGORYS (category_id, category_name)
values (371, 'ea' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (374, 'dolor' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (379, 'dolor' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (381, 'nostrud' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (383, 'do' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (385, 'anim' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (386, 'nostrud' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (389, 'delectus' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (400, 'dolore' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (403, 'nisi' || chr(10) || 'sit' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (405, 'ex' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (407, 'omnis' || chr(10) || 'facere' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (409, 'officia' || chr(10) || 'ad' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (410, 'sit' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (414, 'autem' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (415, 'id' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (416, 'eiusmod' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (417, 'iusto' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (418, 'possimus' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (419, 'esse' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (420, 'consequat' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (423, 'aliquip' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (425, 'repudiandae' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (428, 'ut' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (429, 'tempor' || chr(10) || 'et' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (430, 'libero' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (431, 'cumque' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (432, 'id' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (433, 'sapiente' || chr(10) || 'in' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (434, 'aut' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (435, 'aut' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (441, 'ducimus' || chr(10) || 'eu' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (442, 'lorem' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (443, 'omnis' || chr(10) || 'in' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (444, 'omnis' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (447, 'sint' || chr(10) || 'et' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (450, 'quo' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (451, 'velit' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (452, 'et' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (453, 'et' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (454, 'debitis' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (456, 'quis' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (458, 'sit' || chr(10) || 'eveniet' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (459, 'et' || chr(10) || 'sunt' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (460, 'cupiditate' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (461, 'quos' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (462, 'elit' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (463, 'et' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (464, 'culpa' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (465, 'soluta' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (467, 'ut' || chr(10) || 'in' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (469, 'eiusmod' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (470, 'dolor' || chr(10) || 'et' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (471, 'et' || chr(10) || 'non' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (472, 'quis' || chr(10) || 'non' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (475, 'excepteur' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (476, 'incididunt' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (478, 'qui' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (480, 'mollitia' || chr(10) || 'ad' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (481, 'atque' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (482, 'hic' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (484, 'elit' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (486, 'lorem' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (487, 'anim' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (489, 'optio' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (494, 'ut' || chr(10) || 'culpa' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (495, 'ducimus' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (496, 'dolores' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (498, 'ut' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (499, 'amet' || chr(10) || 'do' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (301, 'aute' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (311, 'et' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (319, 'voluptate' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (324, 'nulla' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (325, 'est' || chr(10) || 'facilis' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (330, 'et' || chr(10) || 'molestias' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (335, 'proident' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (338, 'elit' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (342, 'qui' || chr(10) || 'esse' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (343, 'quod' || chr(10) || 'id' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (344, 'impedit' || chr(10) || 'ut' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (353, 'rerum' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (355, 'officia' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (357, 'et' || chr(10) || 'in' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (361, 'nulla' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (366, 'ut' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (369, 'quas' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (375, 'quis' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (377, 'sit' || chr(10) || 'nisi' || chr(10) || 'et' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (388, 'vero' || chr(10) || 'ut' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (396, 'id' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (399, 'alias' || chr(10) || 'aut' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (401, 'distinctio' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (402, 'aute' || chr(10) || 'do' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (408, 'culpa' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (411, 'a' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (413, 'cum' || chr(10) || 'non' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (421, 'ad' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (422, 'quo' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (424, 'optio' || chr(10) || '');
commit;
prompt 300 records committed...
insert into CATEGORYS (category_id, category_name)
values (427, 'harum' || chr(10) || 'harum' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (436, 'est' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (438, 'anim' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (439, 'animi' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (440, 'est' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (445, 'corrupti' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (448, 'qui' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (449, 'eu' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (457, 'voluptas' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (468, 'dolorum' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (473, 'itaque' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (483, 'cumque' || chr(10) || 'sint' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (490, 'non' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (491, 'aut' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (492, 'maiores' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (493, 'id' || chr(10) || 'et' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (337, 'omnis' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (367, 'doloribus' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (412, 'et' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (426, 'consequat' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (437, 'eu' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (466, 'non' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (474, 'odio' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (479, 'itaque' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (485, 'quis' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (488, 'sint' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (406, 'animi' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (446, 'aute' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (455, 'a' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (477, 'tempor' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (497, 'ex' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (404, 'deserunt' || chr(10) || '');
insert into CATEGORYS (category_id, category_name)
values (500, 'Redford');
insert into CATEGORYS (category_id, category_name)
values (501, 'Alston');
insert into CATEGORYS (category_id, category_name)
values (502, 'Orbit');
insert into CATEGORYS (category_id, category_name)
values (503, 'Vassar');
insert into CATEGORYS (category_id, category_name)
values (504, 'Lapointe');
insert into CATEGORYS (category_id, category_name)
values (505, 'Aiken');
insert into CATEGORYS (category_id, category_name)
values (506, 'McFerrin');
insert into CATEGORYS (category_id, category_name)
values (507, 'McKellen');
insert into CATEGORYS (category_id, category_name)
values (508, 'Crow');
insert into CATEGORYS (category_id, category_name)
values (509, 'Coburn');
insert into CATEGORYS (category_id, category_name)
values (510, 'Shepherd');
insert into CATEGORYS (category_id, category_name)
values (511, 'Thurman');
insert into CATEGORYS (category_id, category_name)
values (512, 'Minogue');
insert into CATEGORYS (category_id, category_name)
values (513, 'Morse');
insert into CATEGORYS (category_id, category_name)
values (514, 'Geldof');
insert into CATEGORYS (category_id, category_name)
values (515, 'Nivola');
insert into CATEGORYS (category_id, category_name)
values (516, 'Rhames');
insert into CATEGORYS (category_id, category_name)
values (517, 'Taylor');
insert into CATEGORYS (category_id, category_name)
values (518, 'McCann');
insert into CATEGORYS (category_id, category_name)
values (519, 'Skaggs');
insert into CATEGORYS (category_id, category_name)
values (520, 'McCain');
insert into CATEGORYS (category_id, category_name)
values (521, 'Lunch');
insert into CATEGORYS (category_id, category_name)
values (522, 'Brolin');
insert into CATEGORYS (category_id, category_name)
values (523, 'Brown');
insert into CATEGORYS (category_id, category_name)
values (524, 'Ricci');
insert into CATEGORYS (category_id, category_name)
values (525, 'Dalton');
insert into CATEGORYS (category_id, category_name)
values (526, 'Gershon');
insert into CATEGORYS (category_id, category_name)
values (527, 'Negbaur');
insert into CATEGORYS (category_id, category_name)
values (528, 'Rosas');
insert into CATEGORYS (category_id, category_name)
values (529, 'Gibbons');
insert into CATEGORYS (category_id, category_name)
values (530, 'Diesel');
insert into CATEGORYS (category_id, category_name)
values (531, 'Reinhold');
insert into CATEGORYS (category_id, category_name)
values (532, 'von Sydow');
insert into CATEGORYS (category_id, category_name)
values (533, 'Gosdin');
insert into CATEGORYS (category_id, category_name)
values (534, 'Conroy');
insert into CATEGORYS (category_id, category_name)
values (535, 'Eckhart');
insert into CATEGORYS (category_id, category_name)
values (536, 'Birch');
insert into CATEGORYS (category_id, category_name)
values (537, 'Gary');
insert into CATEGORYS (category_id, category_name)
values (538, 'David');
insert into CATEGORYS (category_id, category_name)
values (539, 'Mattea');
insert into CATEGORYS (category_id, category_name)
values (540, 'Vaughan');
insert into CATEGORYS (category_id, category_name)
values (541, 'Hanley');
insert into CATEGORYS (category_id, category_name)
values (542, 'Stevenson');
insert into CATEGORYS (category_id, category_name)
values (543, 'Winans');
insert into CATEGORYS (category_id, category_name)
values (544, 'Presley');
insert into CATEGORYS (category_id, category_name)
values (545, 'Checker');
insert into CATEGORYS (category_id, category_name)
values (546, 'Puckett');
insert into CATEGORYS (category_id, category_name)
values (547, 'Overstreet');
insert into CATEGORYS (category_id, category_name)
values (548, 'Bruce');
insert into CATEGORYS (category_id, category_name)
values (549, 'Garber');
insert into CATEGORYS (category_id, category_name)
values (550, 'Pleasure');
insert into CATEGORYS (category_id, category_name)
values (551, 'Levert');
insert into CATEGORYS (category_id, category_name)
values (552, 'Nightingale');
insert into CATEGORYS (category_id, category_name)
values (553, 'Wiest');
insert into CATEGORYS (category_id, category_name)
values (554, 'Renfro');
insert into CATEGORYS (category_id, category_name)
values (555, 'Frampton');
insert into CATEGORYS (category_id, category_name)
values (556, 'Pitney');
insert into CATEGORYS (category_id, category_name)
values (557, 'Yorn');
insert into CATEGORYS (category_id, category_name)
values (558, 'Danger');
insert into CATEGORYS (category_id, category_name)
values (559, 'Khan');
insert into CATEGORYS (category_id, category_name)
values (560, 'Wen');
insert into CATEGORYS (category_id, category_name)
values (561, 'Evans');
insert into CATEGORYS (category_id, category_name)
values (562, 'Gough');
insert into CATEGORYS (category_id, category_name)
values (563, 'Bacon');
insert into CATEGORYS (category_id, category_name)
values (564, 'Garber');
insert into CATEGORYS (category_id, category_name)
values (565, 'Collins');
insert into CATEGORYS (category_id, category_name)
values (566, 'Matheson');
insert into CATEGORYS (category_id, category_name)
values (567, 'Morton');
commit;
prompt 400 records committed...
insert into CATEGORYS (category_id, category_name)
values (568, 'Sinise');
insert into CATEGORYS (category_id, category_name)
values (569, 'Cummings');
insert into CATEGORYS (category_id, category_name)
values (570, 'Gambon');
insert into CATEGORYS (category_id, category_name)
values (571, 'Ribisi');
insert into CATEGORYS (category_id, category_name)
values (572, 'Paul');
insert into CATEGORYS (category_id, category_name)
values (573, 'Macht');
insert into CATEGORYS (category_id, category_name)
values (574, 'Vaughan');
insert into CATEGORYS (category_id, category_name)
values (575, 'Hirsch');
insert into CATEGORYS (category_id, category_name)
values (576, 'Pearce');
insert into CATEGORYS (category_id, category_name)
values (577, 'Hamilton');
insert into CATEGORYS (category_id, category_name)
values (578, 'Miller');
insert into CATEGORYS (category_id, category_name)
values (579, 'Beck');
insert into CATEGORYS (category_id, category_name)
values (580, 'Parish');
insert into CATEGORYS (category_id, category_name)
values (581, 'Burns');
insert into CATEGORYS (category_id, category_name)
values (582, 'Lennix');
insert into CATEGORYS (category_id, category_name)
values (583, 'Hackman');
insert into CATEGORYS (category_id, category_name)
values (584, 'Osmond');
insert into CATEGORYS (category_id, category_name)
values (585, 'Heatherly');
insert into CATEGORYS (category_id, category_name)
values (586, 'McCann');
insert into CATEGORYS (category_id, category_name)
values (587, 'Hartnett');
insert into CATEGORYS (category_id, category_name)
values (588, 'Scorsese');
insert into CATEGORYS (category_id, category_name)
values (589, 'Caldwell');
insert into CATEGORYS (category_id, category_name)
values (590, 'Lauper');
insert into CATEGORYS (category_id, category_name)
values (591, 'Richter');
insert into CATEGORYS (category_id, category_name)
values (592, 'Kahn');
insert into CATEGORYS (category_id, category_name)
values (593, 'Stevens');
insert into CATEGORYS (category_id, category_name)
values (594, 'Branagh');
insert into CATEGORYS (category_id, category_name)
values (595, 'Kimball');
insert into CATEGORYS (category_id, category_name)
values (596, 'Stuermer');
insert into CATEGORYS (category_id, category_name)
values (597, 'Owen');
insert into CATEGORYS (category_id, category_name)
values (598, 'Sarandon');
insert into CATEGORYS (category_id, category_name)
values (599, 'Chappelle');
insert into CATEGORYS (category_id, category_name)
values (600, 'Hawn');
insert into CATEGORYS (category_id, category_name)
values (601, 'Vincent');
insert into CATEGORYS (category_id, category_name)
values (602, 'Goldwyn');
insert into CATEGORYS (category_id, category_name)
values (603, 'Paymer');
insert into CATEGORYS (category_id, category_name)
values (604, 'Ammons');
insert into CATEGORYS (category_id, category_name)
values (605, 'Savage');
insert into CATEGORYS (category_id, category_name)
values (606, 'Lofgren');
insert into CATEGORYS (category_id, category_name)
values (607, 'Brody');
insert into CATEGORYS (category_id, category_name)
values (608, 'Strong');
insert into CATEGORYS (category_id, category_name)
values (609, 'Kattan');
insert into CATEGORYS (category_id, category_name)
values (610, 'Oldman');
insert into CATEGORYS (category_id, category_name)
values (611, 'Levin');
insert into CATEGORYS (category_id, category_name)
values (612, 'Zane');
insert into CATEGORYS (category_id, category_name)
values (613, 'Cetera');
insert into CATEGORYS (category_id, category_name)
values (614, 'Holmes');
insert into CATEGORYS (category_id, category_name)
values (615, 'Vaughn');
insert into CATEGORYS (category_id, category_name)
values (616, 'Channing');
insert into CATEGORYS (category_id, category_name)
values (617, 'Phifer');
insert into CATEGORYS (category_id, category_name)
values (618, 'Stevens');
insert into CATEGORYS (category_id, category_name)
values (619, 'Brody');
insert into CATEGORYS (category_id, category_name)
values (620, 'Twilley');
insert into CATEGORYS (category_id, category_name)
values (621, 'Clooney');
insert into CATEGORYS (category_id, category_name)
values (622, 'Vassar');
insert into CATEGORYS (category_id, category_name)
values (623, 'Lucas');
insert into CATEGORYS (category_id, category_name)
values (624, 'Farina');
insert into CATEGORYS (category_id, category_name)
values (625, 'Marshall');
insert into CATEGORYS (category_id, category_name)
values (626, 'Pitney');
insert into CATEGORYS (category_id, category_name)
values (627, 'Scaggs');
insert into CATEGORYS (category_id, category_name)
values (628, 'Cattrall');
insert into CATEGORYS (category_id, category_name)
values (629, 'Whitley');
insert into CATEGORYS (category_id, category_name)
values (630, 'Dunst');
insert into CATEGORYS (category_id, category_name)
values (631, 'DeLuise');
insert into CATEGORYS (category_id, category_name)
values (632, 'Nicholson');
insert into CATEGORYS (category_id, category_name)
values (633, 'Kingsley');
insert into CATEGORYS (category_id, category_name)
values (634, 'Van Damme');
insert into CATEGORYS (category_id, category_name)
values (635, 'Trevino');
insert into CATEGORYS (category_id, category_name)
values (636, 'Lucas');
insert into CATEGORYS (category_id, category_name)
values (637, 'Numan');
insert into CATEGORYS (category_id, category_name)
values (638, 'Caldwell');
insert into CATEGORYS (category_id, category_name)
values (639, 'Perry');
insert into CATEGORYS (category_id, category_name)
values (640, 'Keith');
insert into CATEGORYS (category_id, category_name)
values (641, 'Pollak');
insert into CATEGORYS (category_id, category_name)
values (642, 'Donelly');
insert into CATEGORYS (category_id, category_name)
values (643, 'Flatts');
insert into CATEGORYS (category_id, category_name)
values (644, 'Carter');
insert into CATEGORYS (category_id, category_name)
values (645, 'Def');
insert into CATEGORYS (category_id, category_name)
values (646, 'Forrest');
insert into CATEGORYS (category_id, category_name)
values (647, 'Yankovic');
insert into CATEGORYS (category_id, category_name)
values (648, 'Thomson');
insert into CATEGORYS (category_id, category_name)
values (649, 'Herrmann');
insert into CATEGORYS (category_id, category_name)
values (650, 'Brolin');
insert into CATEGORYS (category_id, category_name)
values (651, 'Dukakis');
insert into CATEGORYS (category_id, category_name)
values (652, 'Walker');
insert into CATEGORYS (category_id, category_name)
values (653, 'Botti');
insert into CATEGORYS (category_id, category_name)
values (654, 'Cotton');
insert into CATEGORYS (category_id, category_name)
values (655, 'McLachlan');
insert into CATEGORYS (category_id, category_name)
values (656, 'Field');
insert into CATEGORYS (category_id, category_name)
values (657, 'Ali');
insert into CATEGORYS (category_id, category_name)
values (658, 'Costner');
insert into CATEGORYS (category_id, category_name)
values (659, 'Ellis');
insert into CATEGORYS (category_id, category_name)
values (660, 'Dean');
insert into CATEGORYS (category_id, category_name)
values (661, 'Beckham');
insert into CATEGORYS (category_id, category_name)
values (662, 'Shearer');
insert into CATEGORYS (category_id, category_name)
values (663, 'Malone');
insert into CATEGORYS (category_id, category_name)
values (664, 'Soda');
insert into CATEGORYS (category_id, category_name)
values (665, 'Holiday');
insert into CATEGORYS (category_id, category_name)
values (666, 'Tarantino');
insert into CATEGORYS (category_id, category_name)
values (667, 'Adkins');
commit;
prompt 500 records committed...
insert into CATEGORYS (category_id, category_name)
values (668, 'Wilder');
insert into CATEGORYS (category_id, category_name)
values (669, 'Andrews');
insert into CATEGORYS (category_id, category_name)
values (670, 'Bullock');
insert into CATEGORYS (category_id, category_name)
values (671, 'Neil');
insert into CATEGORYS (category_id, category_name)
values (672, 'Kimball');
insert into CATEGORYS (category_id, category_name)
values (673, 'Marsden');
insert into CATEGORYS (category_id, category_name)
values (674, 'Jenkins');
insert into CATEGORYS (category_id, category_name)
values (675, 'Cornell');
insert into CATEGORYS (category_id, category_name)
values (676, 'Rhys-Davies');
insert into CATEGORYS (category_id, category_name)
values (677, 'Bergen');
insert into CATEGORYS (category_id, category_name)
values (678, 'Lofgren');
insert into CATEGORYS (category_id, category_name)
values (679, 'Mellencamp');
insert into CATEGORYS (category_id, category_name)
values (680, 'Briscoe');
insert into CATEGORYS (category_id, category_name)
values (681, 'Osborne');
insert into CATEGORYS (category_id, category_name)
values (682, 'Wells');
insert into CATEGORYS (category_id, category_name)
values (683, 'Phifer');
insert into CATEGORYS (category_id, category_name)
values (684, 'Sylvian');
insert into CATEGORYS (category_id, category_name)
values (685, 'Detmer');
insert into CATEGORYS (category_id, category_name)
values (686, 'Tippe');
insert into CATEGORYS (category_id, category_name)
values (687, 'Law');
insert into CATEGORYS (category_id, category_name)
values (688, 'Coleman');
insert into CATEGORYS (category_id, category_name)
values (689, 'Wariner');
insert into CATEGORYS (category_id, category_name)
values (690, 'Curfman');
insert into CATEGORYS (category_id, category_name)
values (691, 'Nunn');
insert into CATEGORYS (category_id, category_name)
values (692, 'Soul');
insert into CATEGORYS (category_id, category_name)
values (693, 'Sedaka');
insert into CATEGORYS (category_id, category_name)
values (694, 'Sawa');
insert into CATEGORYS (category_id, category_name)
values (695, 'Biel');
insert into CATEGORYS (category_id, category_name)
values (696, 'Marley');
insert into CATEGORYS (category_id, category_name)
values (697, 'Woodard');
insert into CATEGORYS (category_id, category_name)
values (698, 'Evans');
insert into CATEGORYS (category_id, category_name)
values (699, 'Lorenz');
insert into CATEGORYS (category_id, category_name)
values (700, 'Movie');
commit;
prompt 533 records loaded
prompt Loading PERSON...
insert into PERSON (pid, pname)
values (627, 'Rosanne');
insert into PERSON (pid, pname)
values (496, 'Gwyneth');
insert into PERSON (pid, pname)
values (818, 'Larry');
insert into PERSON (pid, pname)
values (206, 'Joey');
insert into PERSON (pid, pname)
values (563, 'Eliza');
insert into PERSON (pid, pname)
values (126, 'Robin');
insert into PERSON (pid, pname)
values (615, 'Gina');
insert into PERSON (pid, pname)
values (551, 'Nastassja');
insert into PERSON (pid, pname)
values (592, 'Angela');
insert into PERSON (pid, pname)
values (898, 'Domingo');
insert into PERSON (pid, pname)
values (700, 'Adam');
insert into PERSON (pid, pname)
values (727, 'Simon');
insert into PERSON (pid, pname)
values (115, 'Leon');
insert into PERSON (pid, pname)
values (349, 'Anita');
insert into PERSON (pid, pname)
values (244, 'Lauren');
insert into PERSON (pid, pname)
values (487, 'Henry');
insert into PERSON (pid, pname)
values (685, 'Famke');
insert into PERSON (pid, pname)
values (462, 'Mia');
insert into PERSON (pid, pname)
values (544, 'Celia');
insert into PERSON (pid, pname)
values (193, 'Kevn');
insert into PERSON (pid, pname)
values (951, 'Jack');
insert into PERSON (pid, pname)
values (611, 'Willem');
insert into PERSON (pid, pname)
values (217, 'Murray');
insert into PERSON (pid, pname)
values (459, 'Louise');
insert into PERSON (pid, pname)
values (597, 'Judge');
insert into PERSON (pid, pname)
values (504, 'Hal');
insert into PERSON (pid, pname)
values (536, 'Rascal');
insert into PERSON (pid, pname)
values (312, 'Rade');
insert into PERSON (pid, pname)
values (308, 'Bryan');
insert into PERSON (pid, pname)
values (791, 'Henry');
insert into PERSON (pid, pname)
values (373, 'Tim');
insert into PERSON (pid, pname)
values (513, 'Lupe');
insert into PERSON (pid, pname)
values (291, 'Kurtwood');
insert into PERSON (pid, pname)
values (868, 'Geoffrey');
insert into PERSON (pid, pname)
values (975, 'Jared');
insert into PERSON (pid, pname)
values (928, 'Jeremy');
insert into PERSON (pid, pname)
values (147, 'Orlando');
insert into PERSON (pid, pname)
values (896, 'Viggo');
insert into PERSON (pid, pname)
values (489, 'Collective');
insert into PERSON (pid, pname)
values (832, 'Dustin');
insert into PERSON (pid, pname)
values (368, 'Kathleen');
insert into PERSON (pid, pname)
values (830, 'Melanie');
insert into PERSON (pid, pname)
values (701, 'Leon');
insert into PERSON (pid, pname)
values (492, 'Jason');
insert into PERSON (pid, pname)
values (581, 'Mary Beth');
insert into PERSON (pid, pname)
values (301, 'Elle');
insert into PERSON (pid, pname)
values (978, 'Tyrone');
insert into PERSON (pid, pname)
values (764, 'Maria');
insert into PERSON (pid, pname)
values (704, 'Wayman');
insert into PERSON (pid, pname)
values (728, 'Louise');
insert into PERSON (pid, pname)
values (512, 'Lynette');
insert into PERSON (pid, pname)
values (400, 'Roberta');
insert into PERSON (pid, pname)
values (555, 'Ed');
insert into PERSON (pid, pname)
values (423, 'Kenneth');
insert into PERSON (pid, pname)
values (837, 'Balthazar');
insert into PERSON (pid, pname)
values (935, 'Rebecca');
insert into PERSON (pid, pname)
values (730, 'Samuel');
insert into PERSON (pid, pname)
values (805, 'Rebeka');
insert into PERSON (pid, pname)
values (630, 'Lonnie');
insert into PERSON (pid, pname)
values (388, 'Elvis');
insert into PERSON (pid, pname)
values (924, 'Joaquim');
insert into PERSON (pid, pname)
values (348, 'Thin');
insert into PERSON (pid, pname)
values (550, 'Carol');
insert into PERSON (pid, pname)
values (998, 'Tyrone');
insert into PERSON (pid, pname)
values (327, 'Max');
insert into PERSON (pid, pname)
values (608, 'Roberta');
insert into PERSON (pid, pname)
values (772, 'Treat');
insert into PERSON (pid, pname)
values (251, 'Jared');
insert into PERSON (pid, pname)
values (405, 'Hector');
insert into PERSON (pid, pname)
values (955, 'Noah');
insert into PERSON (pid, pname)
values (834, 'Caroline');
insert into PERSON (pid, pname)
values (360, 'Wes');
insert into PERSON (pid, pname)
values (296, 'Busta');
insert into PERSON (pid, pname)
values (920, 'Stanley');
insert into PERSON (pid, pname)
values (501, 'Geoffrey');
insert into PERSON (pid, pname)
values (932, 'Ernie');
insert into PERSON (pid, pname)
values (305, 'Armand');
insert into PERSON (pid, pname)
values (142, 'Chloe');
insert into PERSON (pid, pname)
values (377, 'Azucar');
insert into PERSON (pid, pname)
values (200, 'Denise');
insert into PERSON (pid, pname)
values (1, 'Franco');
insert into PERSON (pid, pname)
values (2, 'Chazz');
insert into PERSON (pid, pname)
values (3, 'Rita');
insert into PERSON (pid, pname)
values (4, 'Gilberto');
insert into PERSON (pid, pname)
values (5, 'Gabrielle');
insert into PERSON (pid, pname)
values (6, 'Arturo');
insert into PERSON (pid, pname)
values (7, 'Sona');
insert into PERSON (pid, pname)
values (8, 'Kylie');
insert into PERSON (pid, pname)
values (9, 'Lila');
insert into PERSON (pid, pname)
values (10, 'Herbie');
insert into PERSON (pid, pname)
values (11, 'Grant');
insert into PERSON (pid, pname)
values (12, 'Sinead');
insert into PERSON (pid, pname)
values (13, 'Sinead');
insert into PERSON (pid, pname)
values (14, 'Edie');
insert into PERSON (pid, pname)
values (15, 'Fats');
insert into PERSON (pid, pname)
values (16, 'Blair');
insert into PERSON (pid, pname)
values (17, 'Austin');
insert into PERSON (pid, pname)
values (18, 'Hal');
insert into PERSON (pid, pname)
values (19, 'Sheryl');
insert into PERSON (pid, pname)
values (20, 'Gaby');
commit;
prompt 100 records committed...
insert into PERSON (pid, pname)
values (21, 'Charlize');
insert into PERSON (pid, pname)
values (22, 'Tommy');
insert into PERSON (pid, pname)
values (23, 'Charles');
insert into PERSON (pid, pname)
values (24, 'Johnnie');
insert into PERSON (pid, pname)
values (25, 'Candice');
insert into PERSON (pid, pname)
values (26, 'Shelby');
insert into PERSON (pid, pname)
values (27, 'Hikaru');
insert into PERSON (pid, pname)
values (28, 'Kenneth');
insert into PERSON (pid, pname)
values (29, 'Dermot');
insert into PERSON (pid, pname)
values (30, 'Steve');
insert into PERSON (pid, pname)
values (31, 'Solomon');
insert into PERSON (pid, pname)
values (32, 'Zooey');
insert into PERSON (pid, pname)
values (33, 'Tzi');
insert into PERSON (pid, pname)
values (34, 'Penelope');
insert into PERSON (pid, pname)
values (35, 'Gordie');
insert into PERSON (pid, pname)
values (36, 'Julianna');
insert into PERSON (pid, pname)
values (37, 'Gavin');
insert into PERSON (pid, pname)
values (38, 'Keith');
insert into PERSON (pid, pname)
values (39, 'Alessandro');
insert into PERSON (pid, pname)
values (40, 'Christopher');
insert into PERSON (pid, pname)
values (41, 'Bobbi');
insert into PERSON (pid, pname)
values (42, 'Talvin');
insert into PERSON (pid, pname)
values (43, 'Alice');
insert into PERSON (pid, pname)
values (44, 'Jared');
insert into PERSON (pid, pname)
values (45, 'Cherry');
insert into PERSON (pid, pname)
values (46, 'Nelly');
insert into PERSON (pid, pname)
values (47, 'Maureen');
insert into PERSON (pid, pname)
values (48, 'Linda');
insert into PERSON (pid, pname)
values (49, 'Rory');
insert into PERSON (pid, pname)
values (50, 'Curtis');
insert into PERSON (pid, pname)
values (51, 'Sheryl');
insert into PERSON (pid, pname)
values (52, 'Lin');
insert into PERSON (pid, pname)
values (53, 'Jarvis');
insert into PERSON (pid, pname)
values (54, 'Randy');
insert into PERSON (pid, pname)
values (55, 'Peabo');
insert into PERSON (pid, pname)
values (56, 'Scott');
insert into PERSON (pid, pname)
values (57, 'Mekhi');
insert into PERSON (pid, pname)
values (58, 'Jackie');
insert into PERSON (pid, pname)
values (59, 'Avril');
insert into PERSON (pid, pname)
values (60, 'Curt');
insert into PERSON (pid, pname)
values (61, 'Edward');
insert into PERSON (pid, pname)
values (62, 'Jeanne');
insert into PERSON (pid, pname)
values (63, 'Raul');
insert into PERSON (pid, pname)
values (64, 'Mia');
insert into PERSON (pid, pname)
values (65, 'Miki');
insert into PERSON (pid, pname)
values (66, 'Chloe');
insert into PERSON (pid, pname)
values (67, 'Stewart');
insert into PERSON (pid, pname)
values (68, 'Kylie');
insert into PERSON (pid, pname)
values (69, 'Michelle');
insert into PERSON (pid, pname)
values (70, 'Nigel');
insert into PERSON (pid, pname)
values (71, 'Walter');
insert into PERSON (pid, pname)
values (72, 'Keith');
insert into PERSON (pid, pname)
values (73, 'Beverley');
insert into PERSON (pid, pname)
values (74, 'Ruth');
insert into PERSON (pid, pname)
values (75, 'Corey');
insert into PERSON (pid, pname)
values (76, 'Nelly');
insert into PERSON (pid, pname)
values (77, 'Sarah');
insert into PERSON (pid, pname)
values (78, 'Saul');
insert into PERSON (pid, pname)
values (79, 'Stewart');
insert into PERSON (pid, pname)
values (80, 'Sarah');
insert into PERSON (pid, pname)
values (81, 'Lydia');
insert into PERSON (pid, pname)
values (82, 'Lili');
insert into PERSON (pid, pname)
values (83, 'Rita');
insert into PERSON (pid, pname)
values (84, 'Matthew');
insert into PERSON (pid, pname)
values (85, 'Seann');
insert into PERSON (pid, pname)
values (86, 'Gena');
insert into PERSON (pid, pname)
values (87, 'Powers');
insert into PERSON (pid, pname)
values (88, 'Stephen');
insert into PERSON (pid, pname)
values (89, 'Seth');
insert into PERSON (pid, pname)
values (90, 'Carrie');
insert into PERSON (pid, pname)
values (91, 'Wesley');
insert into PERSON (pid, pname)
values (92, 'Annie');
insert into PERSON (pid, pname)
values (93, 'Rueben');
insert into PERSON (pid, pname)
values (94, 'Olympia');
insert into PERSON (pid, pname)
values (95, 'Vivica');
insert into PERSON (pid, pname)
values (96, 'Leo');
insert into PERSON (pid, pname)
values (97, 'Sylvester');
insert into PERSON (pid, pname)
values (98, 'Stevie');
insert into PERSON (pid, pname)
values (99, 'Solomon');
insert into PERSON (pid, pname)
values (100, 'Guy');
insert into PERSON (pid, pname)
values (101, 'Kurtwood');
insert into PERSON (pid, pname)
values (102, 'Miriam');
insert into PERSON (pid, pname)
values (103, 'Kelly');
insert into PERSON (pid, pname)
values (104, 'Juliana');
insert into PERSON (pid, pname)
values (105, 'Lili');
insert into PERSON (pid, pname)
values (106, 'Philip');
insert into PERSON (pid, pname)
values (107, 'Taylor');
insert into PERSON (pid, pname)
values (108, 'Melba');
insert into PERSON (pid, pname)
values (109, 'Ralph');
insert into PERSON (pid, pname)
values (110, 'Rowan');
insert into PERSON (pid, pname)
values (111, 'Holland');
insert into PERSON (pid, pname)
values (112, 'Ted');
insert into PERSON (pid, pname)
values (113, 'Wally');
insert into PERSON (pid, pname)
values (114, 'Brenda');
insert into PERSON (pid, pname)
values (116, 'Kenneth');
insert into PERSON (pid, pname)
values (117, 'Roddy');
insert into PERSON (pid, pname)
values (118, 'Rawlins');
insert into PERSON (pid, pname)
values (119, 'Bebe');
insert into PERSON (pid, pname)
values (120, 'Machine');
insert into PERSON (pid, pname)
values (121, 'Todd');
commit;
prompt 200 records committed...
insert into PERSON (pid, pname)
values (122, 'Neneh');
insert into PERSON (pid, pname)
values (123, 'Gabriel');
insert into PERSON (pid, pname)
values (124, 'Ceili');
insert into PERSON (pid, pname)
values (125, 'Shannon');
insert into PERSON (pid, pname)
values (127, 'Terence');
insert into PERSON (pid, pname)
values (128, 'Rose');
insert into PERSON (pid, pname)
values (129, 'Harvey');
insert into PERSON (pid, pname)
values (130, 'Mykelti');
insert into PERSON (pid, pname)
values (131, 'Angelina');
insert into PERSON (pid, pname)
values (132, 'Carla');
insert into PERSON (pid, pname)
values (133, 'Joey');
insert into PERSON (pid, pname)
values (134, 'Natasha');
insert into PERSON (pid, pname)
values (135, 'Maury');
insert into PERSON (pid, pname)
values (136, 'Elijah');
insert into PERSON (pid, pname)
values (137, 'Rosario');
insert into PERSON (pid, pname)
values (138, 'Joe');
insert into PERSON (pid, pname)
values (139, 'Joely');
insert into PERSON (pid, pname)
values (140, 'Jody');
insert into PERSON (pid, pname)
values (141, 'Vendetta');
insert into PERSON (pid, pname)
values (143, 'Nick');
insert into PERSON (pid, pname)
values (144, 'Wayman');
insert into PERSON (pid, pname)
values (145, 'Rich');
insert into PERSON (pid, pname)
values (146, 'Mika');
insert into PERSON (pid, pname)
values (148, 'Juice');
insert into PERSON (pid, pname)
values (149, 'Talvin');
insert into PERSON (pid, pname)
values (150, 'Kate');
insert into PERSON (pid, pname)
values (151, 'Rod');
insert into PERSON (pid, pname)
values (152, 'Fisher');
insert into PERSON (pid, pname)
values (153, 'Donald');
insert into PERSON (pid, pname)
values (154, 'Ashley');
insert into PERSON (pid, pname)
values (155, 'Joseph');
insert into PERSON (pid, pname)
values (156, 'Ricky');
insert into PERSON (pid, pname)
values (157, 'Kurtwood');
insert into PERSON (pid, pname)
values (158, 'Meredith');
insert into PERSON (pid, pname)
values (159, 'Faye');
insert into PERSON (pid, pname)
values (160, 'Ronnie');
insert into PERSON (pid, pname)
values (161, 'Armin');
insert into PERSON (pid, pname)
values (162, 'Larnelle');
insert into PERSON (pid, pname)
values (163, 'Goldie');
insert into PERSON (pid, pname)
values (164, 'Connie');
insert into PERSON (pid, pname)
values (165, 'Cloris');
insert into PERSON (pid, pname)
values (166, 'Eugene');
insert into PERSON (pid, pname)
values (167, 'Luis');
insert into PERSON (pid, pname)
values (168, 'Elvis');
insert into PERSON (pid, pname)
values (169, 'Halle');
insert into PERSON (pid, pname)
values (170, 'Alice');
insert into PERSON (pid, pname)
values (171, 'Hilton');
insert into PERSON (pid, pname)
values (172, 'Mae');
insert into PERSON (pid, pname)
values (173, 'Norm');
insert into PERSON (pid, pname)
values (174, 'Scarlett');
insert into PERSON (pid, pname)
values (175, 'Meredith');
insert into PERSON (pid, pname)
values (176, 'Laura');
insert into PERSON (pid, pname)
values (177, 'Cary');
insert into PERSON (pid, pname)
values (178, 'Harvey');
insert into PERSON (pid, pname)
values (179, 'Jodie');
insert into PERSON (pid, pname)
values (180, 'Balthazar');
insert into PERSON (pid, pname)
values (181, 'Yaphet');
insert into PERSON (pid, pname)
values (182, 'Claire');
insert into PERSON (pid, pname)
values (183, 'Greg');
insert into PERSON (pid, pname)
values (184, 'Kurtwood');
insert into PERSON (pid, pname)
values (185, 'Johnnie');
insert into PERSON (pid, pname)
values (186, 'Howie');
insert into PERSON (pid, pname)
values (187, 'Carla');
insert into PERSON (pid, pname)
values (188, 'Madeleine');
insert into PERSON (pid, pname)
values (189, 'Ellen');
insert into PERSON (pid, pname)
values (190, 'Joe');
insert into PERSON (pid, pname)
values (191, 'Barbara');
insert into PERSON (pid, pname)
values (192, 'Celia');
insert into PERSON (pid, pname)
values (194, 'Noah');
insert into PERSON (pid, pname)
values (195, 'Anthony');
insert into PERSON (pid, pname)
values (196, 'Davey');
insert into PERSON (pid, pname)
values (197, 'Mos');
insert into PERSON (pid, pname)
values (198, 'Drew');
insert into PERSON (pid, pname)
values (199, 'Sylvester');
insert into PERSON (pid, pname)
values (201, 'Walter');
insert into PERSON (pid, pname)
values (202, 'Percy');
insert into PERSON (pid, pname)
values (203, 'Joshua');
insert into PERSON (pid, pname)
values (204, 'Red');
insert into PERSON (pid, pname)
values (205, 'Maria');
insert into PERSON (pid, pname)
values (207, 'Emmylou');
insert into PERSON (pid, pname)
values (208, 'Gerald');
insert into PERSON (pid, pname)
values (209, 'Gary');
insert into PERSON (pid, pname)
values (210, 'Matt');
insert into PERSON (pid, pname)
values (211, 'Maura');
insert into PERSON (pid, pname)
values (212, 'Alan');
insert into PERSON (pid, pname)
values (213, 'Darren');
insert into PERSON (pid, pname)
values (214, 'Nancy');
insert into PERSON (pid, pname)
values (215, 'Gran');
insert into PERSON (pid, pname)
values (216, 'Bonnie');
insert into PERSON (pid, pname)
values (218, 'Chazz');
insert into PERSON (pid, pname)
values (219, 'Christina');
insert into PERSON (pid, pname)
values (220, 'Henry');
insert into PERSON (pid, pname)
values (221, 'Rascal');
insert into PERSON (pid, pname)
values (222, 'Hilary');
insert into PERSON (pid, pname)
values (223, 'Jack');
insert into PERSON (pid, pname)
values (224, 'Merrilee');
insert into PERSON (pid, pname)
values (225, 'Boyd');
insert into PERSON (pid, pname)
values (226, 'Nick');
insert into PERSON (pid, pname)
values (227, 'Lynn');
insert into PERSON (pid, pname)
values (228, 'Blair');
commit;
prompt 300 records committed...
insert into PERSON (pid, pname)
values (229, 'Cyndi');
insert into PERSON (pid, pname)
values (230, 'Marc');
insert into PERSON (pid, pname)
values (231, 'Frank');
insert into PERSON (pid, pname)
values (232, 'Sylvester');
insert into PERSON (pid, pname)
values (233, 'Mint');
insert into PERSON (pid, pname)
values (234, 'Cyndi');
insert into PERSON (pid, pname)
values (235, 'Ralph');
insert into PERSON (pid, pname)
values (236, 'Tommy');
insert into PERSON (pid, pname)
values (237, 'Jennifer');
insert into PERSON (pid, pname)
values (238, 'Kenneth');
insert into PERSON (pid, pname)
values (239, 'Ty');
insert into PERSON (pid, pname)
values (240, 'Gil');
insert into PERSON (pid, pname)
values (241, 'Viggo');
insert into PERSON (pid, pname)
values (242, 'Angela');
insert into PERSON (pid, pname)
values (243, 'Devon');
insert into PERSON (pid, pname)
values (245, 'Tcheky');
insert into PERSON (pid, pname)
values (246, 'Dabney');
insert into PERSON (pid, pname)
values (247, 'Naomi');
insert into PERSON (pid, pname)
values (248, 'Alec');
insert into PERSON (pid, pname)
values (249, 'Jane');
insert into PERSON (pid, pname)
values (250, 'Aida');
insert into PERSON (pid, pname)
values (252, 'Dave');
insert into PERSON (pid, pname)
values (253, 'Trick');
insert into PERSON (pid, pname)
values (254, 'Merle');
insert into PERSON (pid, pname)
values (255, 'Regina');
insert into PERSON (pid, pname)
values (256, 'Jimmy');
insert into PERSON (pid, pname)
values (257, 'Martha');
insert into PERSON (pid, pname)
values (258, 'Don');
insert into PERSON (pid, pname)
values (259, 'Ozzy');
insert into PERSON (pid, pname)
values (260, 'Tony');
insert into PERSON (pid, pname)
values (261, 'Denzel');
insert into PERSON (pid, pname)
values (262, 'Mel');
insert into PERSON (pid, pname)
values (263, 'Rowan');
insert into PERSON (pid, pname)
values (264, 'Maggie');
insert into PERSON (pid, pname)
values (265, 'Olga');
insert into PERSON (pid, pname)
values (266, 'Connie');
insert into PERSON (pid, pname)
values (267, 'Latin');
insert into PERSON (pid, pname)
values (268, 'Elijah');
insert into PERSON (pid, pname)
values (269, 'Doug');
insert into PERSON (pid, pname)
values (270, 'Olympia');
insert into PERSON (pid, pname)
values (271, 'Cuba');
insert into PERSON (pid, pname)
values (272, 'Rhett');
insert into PERSON (pid, pname)
values (273, 'Spencer');
insert into PERSON (pid, pname)
values (274, 'Jonny Lee');
insert into PERSON (pid, pname)
values (275, 'CeCe');
insert into PERSON (pid, pname)
values (276, 'Fred');
insert into PERSON (pid, pname)
values (277, 'Nikki');
insert into PERSON (pid, pname)
values (278, 'Carole');
insert into PERSON (pid, pname)
values (279, 'Johnny');
insert into PERSON (pid, pname)
values (280, 'Malcolm');
insert into PERSON (pid, pname)
values (281, 'Nicole');
insert into PERSON (pid, pname)
values (282, 'Swoosie');
insert into PERSON (pid, pname)
values (283, 'Goldie');
insert into PERSON (pid, pname)
values (284, 'Janeane');
insert into PERSON (pid, pname)
values (285, 'Wally');
insert into PERSON (pid, pname)
values (286, 'Nick');
insert into PERSON (pid, pname)
values (287, 'Sheryl');
insert into PERSON (pid, pname)
values (288, 'Temuera');
insert into PERSON (pid, pname)
values (289, 'Natasha');
insert into PERSON (pid, pname)
values (290, 'Gordie');
insert into PERSON (pid, pname)
values (292, 'Christian');
insert into PERSON (pid, pname)
values (293, 'Kieran');
insert into PERSON (pid, pname)
values (294, 'Simon');
insert into PERSON (pid, pname)
values (295, 'Nora');
insert into PERSON (pid, pname)
values (297, 'Michael');
insert into PERSON (pid, pname)
values (298, 'Reese');
insert into PERSON (pid, pname)
values (299, 'Gladys');
insert into PERSON (pid, pname)
values (300, 'Dick');
insert into PERSON (pid, pname)
values (302, 'Lennie');
insert into PERSON (pid, pname)
values (303, 'Scott');
insert into PERSON (pid, pname)
values (304, 'Christina');
insert into PERSON (pid, pname)
values (306, 'Azucar');
insert into PERSON (pid, pname)
values (307, 'Jamie');
insert into PERSON (pid, pname)
values (309, 'Jude');
insert into PERSON (pid, pname)
values (310, 'Buddy');
insert into PERSON (pid, pname)
values (311, 'Bobby');
insert into PERSON (pid, pname)
values (313, 'Wallace');
insert into PERSON (pid, pname)
values (314, 'Albert');
insert into PERSON (pid, pname)
values (315, 'Liquid');
insert into PERSON (pid, pname)
values (316, 'Loreena');
insert into PERSON (pid, pname)
values (317, 'Ewan');
insert into PERSON (pid, pname)
values (318, 'Elijah');
insert into PERSON (pid, pname)
values (319, 'Marina');
insert into PERSON (pid, pname)
values (320, 'Mekhi');
insert into PERSON (pid, pname)
values (321, 'Keanu');
insert into PERSON (pid, pname)
values (322, 'Elizabeth');
insert into PERSON (pid, pname)
values (323, 'Stephanie');
insert into PERSON (pid, pname)
values (324, 'Ice');
insert into PERSON (pid, pname)
values (325, 'Arnold');
insert into PERSON (pid, pname)
values (326, 'Bob');
insert into PERSON (pid, pname)
values (328, 'Terrence');
insert into PERSON (pid, pname)
values (329, 'Denzel');
insert into PERSON (pid, pname)
values (330, 'Emilio');
insert into PERSON (pid, pname)
values (331, 'Vince');
insert into PERSON (pid, pname)
values (332, 'Lena');
insert into PERSON (pid, pname)
values (333, 'Frankie');
insert into PERSON (pid, pname)
values (334, 'Scarlett');
insert into PERSON (pid, pname)
values (335, 'Willie');
insert into PERSON (pid, pname)
values (336, 'Cyndi');
insert into PERSON (pid, pname)
values (337, 'Cary');
commit;
prompt 400 records committed...
insert into PERSON (pid, pname)
values (338, 'Coley');
insert into PERSON (pid, pname)
values (339, 'Jennifer');
insert into PERSON (pid, pname)
values (340, 'Kenneth');
insert into PERSON (pid, pname)
values (341, 'Gerald');
insert into PERSON (pid, pname)
values (342, 'Avril');
insert into PERSON (pid, pname)
values (343, 'Clive');
insert into PERSON (pid, pname)
values (344, 'Denis');
insert into PERSON (pid, pname)
values (345, 'Carolyn');
insert into PERSON (pid, pname)
values (346, 'Rhona');
insert into PERSON (pid, pname)
values (347, 'Gladys');
insert into PERSON (pid, pname)
values (350, 'Garry');
insert into PERSON (pid, pname)
values (351, 'Dean');
insert into PERSON (pid, pname)
values (352, 'Judge');
insert into PERSON (pid, pname)
values (353, 'Kyra');
insert into PERSON (pid, pname)
values (354, 'Kasey');
insert into PERSON (pid, pname)
values (355, 'Mandy');
insert into PERSON (pid, pname)
values (356, 'Laura');
insert into PERSON (pid, pname)
values (357, 'Benjamin');
insert into PERSON (pid, pname)
values (358, 'Freddie');
insert into PERSON (pid, pname)
values (359, 'Simon');
insert into PERSON (pid, pname)
values (361, 'Julianne');
insert into PERSON (pid, pname)
values (362, 'Doug');
insert into PERSON (pid, pname)
values (363, 'Jeffrey');
insert into PERSON (pid, pname)
values (364, 'Cheech');
insert into PERSON (pid, pname)
values (365, 'Taylor');
insert into PERSON (pid, pname)
values (366, 'Nils');
insert into PERSON (pid, pname)
values (367, 'Thora');
insert into PERSON (pid, pname)
values (369, 'Hikaru');
insert into PERSON (pid, pname)
values (370, 'Joanna');
insert into PERSON (pid, pname)
values (371, 'Rip');
insert into PERSON (pid, pname)
values (372, 'Kiefer');
insert into PERSON (pid, pname)
values (374, 'Ceili');
insert into PERSON (pid, pname)
values (375, 'Mary');
insert into PERSON (pid, pname)
values (376, 'Bret');
insert into PERSON (pid, pname)
values (378, 'Ted');
insert into PERSON (pid, pname)
values (379, 'Saffron');
insert into PERSON (pid, pname)
values (380, 'Gene');
insert into PERSON (pid, pname)
values (381, 'Phoebe');
insert into PERSON (pid, pname)
values (382, 'Beth');
insert into PERSON (pid, pname)
values (383, 'Carlos');
insert into PERSON (pid, pname)
values (384, 'Leon');
insert into PERSON (pid, pname)
values (385, 'Judd');
insert into PERSON (pid, pname)
values (386, 'Renee');
insert into PERSON (pid, pname)
values (387, 'Frederic');
insert into PERSON (pid, pname)
values (389, 'Ben');
insert into PERSON (pid, pname)
values (390, 'Ruth');
insert into PERSON (pid, pname)
values (391, 'Tamala');
insert into PERSON (pid, pname)
values (392, 'Juan');
insert into PERSON (pid, pname)
values (393, 'Neneh');
insert into PERSON (pid, pname)
values (394, 'Kelli');
insert into PERSON (pid, pname)
values (395, 'Antonio');
insert into PERSON (pid, pname)
values (396, 'Dianne');
insert into PERSON (pid, pname)
values (397, 'Darius');
insert into PERSON (pid, pname)
values (398, 'Josh');
insert into PERSON (pid, pname)
values (399, 'Debi');
insert into PERSON (pid, pname)
values (401, null);
insert into PERSON (pid, pname)
values (402, null);
insert into PERSON (pid, pname)
values (403, null);
insert into PERSON (pid, pname)
values (404, null);
insert into PERSON (pid, pname)
values (406, null);
insert into PERSON (pid, pname)
values (407, null);
insert into PERSON (pid, pname)
values (408, null);
insert into PERSON (pid, pname)
values (409, null);
insert into PERSON (pid, pname)
values (410, null);
insert into PERSON (pid, pname)
values (411, null);
insert into PERSON (pid, pname)
values (412, null);
insert into PERSON (pid, pname)
values (413, null);
insert into PERSON (pid, pname)
values (414, null);
insert into PERSON (pid, pname)
values (415, null);
insert into PERSON (pid, pname)
values (416, null);
insert into PERSON (pid, pname)
values (417, null);
insert into PERSON (pid, pname)
values (418, null);
insert into PERSON (pid, pname)
values (419, null);
insert into PERSON (pid, pname)
values (420, null);
insert into PERSON (pid, pname)
values (421, null);
insert into PERSON (pid, pname)
values (422, null);
insert into PERSON (pid, pname)
values (424, null);
insert into PERSON (pid, pname)
values (425, null);
insert into PERSON (pid, pname)
values (426, null);
insert into PERSON (pid, pname)
values (427, null);
insert into PERSON (pid, pname)
values (428, null);
insert into PERSON (pid, pname)
values (429, null);
insert into PERSON (pid, pname)
values (430, null);
insert into PERSON (pid, pname)
values (431, null);
insert into PERSON (pid, pname)
values (432, null);
insert into PERSON (pid, pname)
values (433, null);
insert into PERSON (pid, pname)
values (434, null);
insert into PERSON (pid, pname)
values (435, null);
insert into PERSON (pid, pname)
values (436, null);
insert into PERSON (pid, pname)
values (437, null);
insert into PERSON (pid, pname)
values (438, null);
insert into PERSON (pid, pname)
values (439, null);
insert into PERSON (pid, pname)
values (440, null);
insert into PERSON (pid, pname)
values (441, null);
insert into PERSON (pid, pname)
values (442, null);
insert into PERSON (pid, pname)
values (443, null);
insert into PERSON (pid, pname)
values (444, null);
insert into PERSON (pid, pname)
values (445, null);
insert into PERSON (pid, pname)
values (446, null);
insert into PERSON (pid, pname)
values (447, null);
commit;
prompt 500 records committed...
insert into PERSON (pid, pname)
values (448, null);
insert into PERSON (pid, pname)
values (449, null);
insert into PERSON (pid, pname)
values (450, null);
insert into PERSON (pid, pname)
values (451, null);
insert into PERSON (pid, pname)
values (452, null);
insert into PERSON (pid, pname)
values (453, null);
insert into PERSON (pid, pname)
values (454, null);
insert into PERSON (pid, pname)
values (455, null);
insert into PERSON (pid, pname)
values (456, null);
insert into PERSON (pid, pname)
values (457, null);
insert into PERSON (pid, pname)
values (458, null);
insert into PERSON (pid, pname)
values (460, null);
insert into PERSON (pid, pname)
values (461, null);
insert into PERSON (pid, pname)
values (463, null);
insert into PERSON (pid, pname)
values (464, null);
insert into PERSON (pid, pname)
values (465, null);
insert into PERSON (pid, pname)
values (466, null);
insert into PERSON (pid, pname)
values (467, null);
insert into PERSON (pid, pname)
values (468, null);
insert into PERSON (pid, pname)
values (469, null);
insert into PERSON (pid, pname)
values (470, null);
insert into PERSON (pid, pname)
values (471, null);
insert into PERSON (pid, pname)
values (472, null);
insert into PERSON (pid, pname)
values (473, null);
insert into PERSON (pid, pname)
values (474, null);
insert into PERSON (pid, pname)
values (475, null);
insert into PERSON (pid, pname)
values (476, null);
insert into PERSON (pid, pname)
values (477, null);
insert into PERSON (pid, pname)
values (478, null);
insert into PERSON (pid, pname)
values (479, null);
insert into PERSON (pid, pname)
values (480, null);
insert into PERSON (pid, pname)
values (481, null);
insert into PERSON (pid, pname)
values (482, null);
insert into PERSON (pid, pname)
values (483, null);
insert into PERSON (pid, pname)
values (484, null);
insert into PERSON (pid, pname)
values (485, null);
insert into PERSON (pid, pname)
values (486, null);
insert into PERSON (pid, pname)
values (488, null);
insert into PERSON (pid, pname)
values (490, null);
insert into PERSON (pid, pname)
values (491, null);
insert into PERSON (pid, pname)
values (493, null);
insert into PERSON (pid, pname)
values (494, null);
insert into PERSON (pid, pname)
values (495, null);
insert into PERSON (pid, pname)
values (497, null);
insert into PERSON (pid, pname)
values (498, null);
insert into PERSON (pid, pname)
values (499, null);
insert into PERSON (pid, pname)
values (500, null);
insert into PERSON (pid, pname)
values (657, 'puxetLwKiI');
insert into PERSON (pid, pname)
values (794, 'CQdRtxWwse');
insert into PERSON (pid, pname)
values (640, 'fBQlCbHYDF');
insert into PERSON (pid, pname)
values (651, 'qHyXvQubmi');
insert into PERSON (pid, pname)
values (541, 'XSMzHonvPn');
insert into PERSON (pid, pname)
values (844, 'yBETYoLSLE');
insert into PERSON (pid, pname)
values (705, 'jYbNUuafyx');
insert into PERSON (pid, pname)
values (807, 'DfaqtdNerj');
insert into PERSON (pid, pname)
values (855, 'LXlZoEKAZT');
insert into PERSON (pid, pname)
values (744, 'LEolmByKar');
insert into PERSON (pid, pname)
values (938, 'LMHneGcjSs');
insert into PERSON (pid, pname)
values (591, 'oTFsXBdyST');
insert into PERSON (pid, pname)
values (666, 'sGjuiFIfkw');
insert into PERSON (pid, pname)
values (790, 'LeJxgaFhLR');
insert into PERSON (pid, pname)
values (835, 'TLwiJwTUge');
insert into PERSON (pid, pname)
values (616, 'ncrsBoTani');
insert into PERSON (pid, pname)
values (739, 'YuIQQgwssZ');
insert into PERSON (pid, pname)
values (643, 'RwMOElWpzo');
insert into PERSON (pid, pname)
values (944, 'RzzphUKGOv');
insert into PERSON (pid, pname)
values (518, 'jnguVFOEtx');
insert into PERSON (pid, pname)
values (618, 'FQsmAmfyvD');
insert into PERSON (pid, pname)
values (695, 'HcrrvVRAsK');
insert into PERSON (pid, pname)
values (564, 'GPhhxdywyH');
insert into PERSON (pid, pname)
values (992, 'rrUKELHOmX');
insert into PERSON (pid, pname)
values (514, 'vscBzCJjhH');
insert into PERSON (pid, pname)
values (966, 'NFrUypuGIQ');
insert into PERSON (pid, pname)
values (509, 'BfgZhqoTRV');
insert into PERSON (pid, pname)
values (737, 'FHpIWhjFjl');
insert into PERSON (pid, pname)
values (799, 'vVZtBQpAGw');
insert into PERSON (pid, pname)
values (839, 'fltgPPdjum');
insert into PERSON (pid, pname)
values (722, 'MEvYixIQWe');
insert into PERSON (pid, pname)
values (786, 'rAmOYjywKP');
insert into PERSON (pid, pname)
values (902, 'SZjwqdciFI');
insert into PERSON (pid, pname)
values (761, 'lGFyPlPsRG');
insert into PERSON (pid, pname)
values (879, 'codRbqqYuN');
insert into PERSON (pid, pname)
values (575, 'qruxnykGWc');
insert into PERSON (pid, pname)
values (585, 'YmDIgNmBcw');
insert into PERSON (pid, pname)
values (815, 'SCvaQeERbD');
insert into PERSON (pid, pname)
values (670, 'dWWIqoKpjE');
insert into PERSON (pid, pname)
values (574, 'HOHhFUxEHB');
insert into PERSON (pid, pname)
values (847, 'TVHLheyXqX');
insert into PERSON (pid, pname)
values (548, 'eLwpVykqww');
insert into PERSON (pid, pname)
values (974, 'NVYGusCsjP');
insert into PERSON (pid, pname)
values (578, 'GZKOMaScCY');
insert into PERSON (pid, pname)
values (614, 'PBBEGmSCOB');
insert into PERSON (pid, pname)
values (781, 'WAWgDvppVd');
insert into PERSON (pid, pname)
values (873, 'hphoKSGmAk');
insert into PERSON (pid, pname)
values (594, 'ARHuiDAUhy');
insert into PERSON (pid, pname)
values (552, 'uoawxjqsNz');
insert into PERSON (pid, pname)
values (843, 'wemmTSPkiR');
insert into PERSON (pid, pname)
values (664, 'KYmRsfrGld');
insert into PERSON (pid, pname)
values (680, 'wHBIlfAkDm');
insert into PERSON (pid, pname)
values (756, 'ZgexKJaCbi');
commit;
prompt 600 records committed...
insert into PERSON (pid, pname)
values (816, 'aALtGIqGdO');
insert into PERSON (pid, pname)
values (960, 'hEyeQGJNkO');
insert into PERSON (pid, pname)
values (908, 'ZAgpomQoGE');
insert into PERSON (pid, pname)
values (593, 'DOMuCnwvjX');
insert into PERSON (pid, pname)
values (961, 'NYgHjHUFRi');
insert into PERSON (pid, pname)
values (751, 'dqJNkZSipS');
insert into PERSON (pid, pname)
values (673, 'isNugTcYpW');
insert into PERSON (pid, pname)
values (842, 'bSxSbsSiWX');
insert into PERSON (pid, pname)
values (692, 'CVtVQwmyri');
insert into PERSON (pid, pname)
values (793, 'HJfNUjHqLo');
insert into PERSON (pid, pname)
values (546, 'PUvCSORgHq');
insert into PERSON (pid, pname)
values (635, 'xxfJedYTul');
insert into PERSON (pid, pname)
values (721, 'RrmFpWuYLG');
insert into PERSON (pid, pname)
values (516, 'nvHYJlEaMB');
insert into PERSON (pid, pname)
values (661, 'tsvNSDLayw');
insert into PERSON (pid, pname)
values (586, 'UnWlRDNrqm');
insert into PERSON (pid, pname)
values (503, 'fxUlOQOJbv');
insert into PERSON (pid, pname)
values (590, 'hTFNNKRAVg');
insert into PERSON (pid, pname)
values (613, 'qsrpJdGOqW');
insert into PERSON (pid, pname)
values (572, 'NQBmodNtGp');
insert into PERSON (pid, pname)
values (678, 'WSIMDgjnMW');
insert into PERSON (pid, pname)
values (802, 'oHWpEQZeSd');
insert into PERSON (pid, pname)
values (599, 'BCcCAXPqLU');
insert into PERSON (pid, pname)
values (943, 'RyyMLFfxLN');
insert into PERSON (pid, pname)
values (526, 'ZXaPBIzSmb');
insert into PERSON (pid, pname)
values (890, 'USzxGxVRxi');
insert into PERSON (pid, pname)
values (525, 'OcbcoQkncN');
insert into PERSON (pid, pname)
values (762, 'bWhuRaSsZe');
insert into PERSON (pid, pname)
values (649, 'JOnOeRTZDB');
insert into PERSON (pid, pname)
values (531, 'LeSqRmgoLA');
insert into PERSON (pid, pname)
values (773, 'gVPRaKQNMi');
insert into PERSON (pid, pname)
values (610, 'jQPrMyyAGB');
insert into PERSON (pid, pname)
values (505, 'pJQjwCZhmT');
insert into PERSON (pid, pname)
values (862, 'dnYVGnZOdw');
insert into PERSON (pid, pname)
values (861, 'umYgbqAlzH');
insert into PERSON (pid, pname)
values (749, 'KpfvCiryEX');
insert into PERSON (pid, pname)
values (694, 'cthCWnSBrJ');
insert into PERSON (pid, pname)
values (561, 'MziCLbIJtF');
insert into PERSON (pid, pname)
values (579, 'FbslAStfJv');
insert into PERSON (pid, pname)
values (557, 'EqAGrWFpHc');
insert into PERSON (pid, pname)
values (836, 'OKsowRYIIT');
insert into PERSON (pid, pname)
values (688, 'IMPMuBpyai');
insert into PERSON (pid, pname)
values (963, 'iLWtmiLRUX');
insert into PERSON (pid, pname)
values (859, 'FzyDrDpeMW');
insert into PERSON (pid, pname)
values (900, 'weRUOGvujg');
insert into PERSON (pid, pname)
values (909, 'xSxBrgiPfY');
insert into PERSON (pid, pname)
values (959, 'kNHnaiCLst');
insert into PERSON (pid, pname)
values (691, 'qHizOqkflh');
insert into PERSON (pid, pname)
values (948, 'FbGIuJIwbk');
insert into PERSON (pid, pname)
values (502, 'ZIiNddfhQg');
insert into PERSON (pid, pname)
values (852, 'RCCAnXZmgL');
insert into PERSON (pid, pname)
values (939, 'dyadIbfMPa');
insert into PERSON (pid, pname)
values (778, 'sRrExnGarx');
insert into PERSON (pid, pname)
values (746, 'FZAFkjqExk');
insert into PERSON (pid, pname)
values (621, 'UffJuTFzez');
insert into PERSON (pid, pname)
values (542, 'VIzasGLQKc');
insert into PERSON (pid, pname)
values (865, 'uICuuuhNQc');
insert into PERSON (pid, pname)
values (880, 'hQTchgrSsd');
insert into PERSON (pid, pname)
values (648, 'OnprdqiHdZ');
insert into PERSON (pid, pname)
values (527, 'wYRoebsBmO');
insert into PERSON (pid, pname)
values (797, 'RaEIooRNTv');
insert into PERSON (pid, pname)
values (783, 'sQyHNOkOAx');
insert into PERSON (pid, pname)
values (973, 'pcQXSmNsIS');
insert into PERSON (pid, pname)
values (984, 'VAupsYeBSP');
insert into PERSON (pid, pname)
values (731, 'TqaEtIUBMr');
insert into PERSON (pid, pname)
values (820, 'FwqREOEbHB');
insert into PERSON (pid, pname)
values (570, 'iCZQtasDnR');
insert into PERSON (pid, pname)
values (671, 'RcqJyPJUSz');
insert into PERSON (pid, pname)
values (993, 'vjOCDGjkfA');
insert into PERSON (pid, pname)
values (822, 'TbYwEvKcQu');
insert into PERSON (pid, pname)
values (774, 'GmIxAvmOiU');
insert into PERSON (pid, pname)
values (826, 'ifugbOEigW');
insert into PERSON (pid, pname)
values (860, 'CGzDUvMlUq');
insert into PERSON (pid, pname)
values (632, 'wgPiCijuQk');
insert into PERSON (pid, pname)
values (660, 'nxFnRIxuvT');
insert into PERSON (pid, pname)
values (972, 'UAyALXiRuT');
insert into PERSON (pid, pname)
values (698, 'FqlVWSEVgk');
insert into PERSON (pid, pname)
values (848, 'KWHzBzlZvy');
insert into PERSON (pid, pname)
values (582, 'GvoWmWaACM');
insert into PERSON (pid, pname)
values (715, 'syhqtGVqBs');
insert into PERSON (pid, pname)
values (965, 'lEaUEirSgH');
insert into PERSON (pid, pname)
values (674, 'sfSYMjLJVK');
insert into PERSON (pid, pname)
values (523, 'OHAsJTUllv');
insert into PERSON (pid, pname)
values (813, 'knNnkqbBFP');
insert into PERSON (pid, pname)
values (833, 'OfzvUBtYZg');
insert into PERSON (pid, pname)
values (662, 'XIhPdKycLs');
insert into PERSON (pid, pname)
values (934, 'WXnbuXKZMo');
insert into PERSON (pid, pname)
values (911, 'hiiubliGmA');
insert into PERSON (pid, pname)
values (945, 'xhsOaFYgyU');
insert into PERSON (pid, pname)
values (804, 'cXsWgtJtdt');
insert into PERSON (pid, pname)
values (522, 'FeSxaxMVwN');
insert into PERSON (pid, pname)
values (577, 'brtbDLtBbN');
insert into PERSON (pid, pname)
values (888, 'TpIcIJAzEB');
insert into PERSON (pid, pname)
values (904, 'oJKrbwdDHU');
insert into PERSON (pid, pname)
values (775, 'RZcWsJweyh');
insert into PERSON (pid, pname)
values (584, 'UrxjDcmrTY');
insert into PERSON (pid, pname)
values (782, 'efDTzAjmqD');
insert into PERSON (pid, pname)
values (748, 'QyqvtEMruL');
insert into PERSON (pid, pname)
values (543, 'QKtVzADvHt');
insert into PERSON (pid, pname)
values (641, 'BmnNufUmIT');
commit;
prompt 700 records committed...
insert into PERSON (pid, pname)
values (747, 'UbTbmzCieH');
insert into PERSON (pid, pname)
values (600, 'TtwzHfISeu');
insert into PERSON (pid, pname)
values (598, 'QrPrNYAEen');
insert into PERSON (pid, pname)
values (736, 'QuNOzREOhE');
insert into PERSON (pid, pname)
values (947, 'PhrixWJyeh');
insert into PERSON (pid, pname)
values (970, 'zqelSjRGSB');
insert into PERSON (pid, pname)
values (741, 'IXuaLKrcSo');
insert into PERSON (pid, pname)
values (765, 'EnGaScHpCx');
insert into PERSON (pid, pname)
values (637, 'KDZgWCjHbS');
insert into PERSON (pid, pname)
values (515, 'rrbGzRVXku');
insert into PERSON (pid, pname)
values (913, 'ZGKDkcuPxS');
insert into PERSON (pid, pname)
values (742, 'firzFaNnYd');
insert into PERSON (pid, pname)
values (520, 'eLxdBvWCxm');
insert into PERSON (pid, pname)
values (596, 'HWOJTxtNRv');
insert into PERSON (pid, pname)
values (682, 'SRqLgxwxxn');
insert into PERSON (pid, pname)
values (710, 'tQUtAyoMZB');
insert into PERSON (pid, pname)
values (625, 'IDAYkulHNy');
insert into PERSON (pid, pname)
values (940, 'LhgoLbOfIV');
insert into PERSON (pid, pname)
values (539, 'WvnDFqAZrt');
insert into PERSON (pid, pname)
values (982, 'qbmUPyTRzs');
insert into PERSON (pid, pname)
values (821, 'CsnfFUArFg');
insert into PERSON (pid, pname)
values (917, 'pdLLmFMKSH');
insert into PERSON (pid, pname)
values (937, 'bstWkVLVHi');
insert into PERSON (pid, pname)
values (976, 'viIsSmbMFE');
insert into PERSON (pid, pname)
values (952, 'GpuzYjcLME');
insert into PERSON (pid, pname)
values (510, 'jMcqyjFKLx');
insert into PERSON (pid, pname)
values (994, 'NINvtwoKhT');
insert into PERSON (pid, pname)
values (979, 'SjTIcxolgQ');
insert into PERSON (pid, pname)
values (931, 'gVWcktNcMH');
insert into PERSON (pid, pname)
values (876, 'uwqDTuKhbL');
insert into PERSON (pid, pname)
values (941, 'JemHIYlftw');
insert into PERSON (pid, pname)
values (545, 'puBwUvfjAx');
insert into PERSON (pid, pname)
values (877, 'BezaMMddgw');
insert into PERSON (pid, pname)
values (803, 'TmOuzxqMaY');
insert into PERSON (pid, pname)
values (656, 'CJtmfwkwER');
insert into PERSON (pid, pname)
values (779, 'fllQFAcUQM');
insert into PERSON (pid, pname)
values (603, 'fZpyYpUaXa');
insert into PERSON (pid, pname)
values (726, 'hHuAORJJvd');
insert into PERSON (pid, pname)
values (667, 'hMecbzuxnX');
insert into PERSON (pid, pname)
values (684, 'RqWEhAXaIE');
insert into PERSON (pid, pname)
values (675, 'tzTnMAWJJI');
insert into PERSON (pid, pname)
values (589, 'qFYpZgCyfj');
insert into PERSON (pid, pname)
values (642, 'yUIQqQShIp');
insert into PERSON (pid, pname)
values (566, 'gZLwAGpmEm');
insert into PERSON (pid, pname)
values (679, 'EQyYHZuIAw');
insert into PERSON (pid, pname)
values (776, 'JLpCIIqWcJ');
insert into PERSON (pid, pname)
values (729, 'dIOJYVKNgg');
insert into PERSON (pid, pname)
values (629, 'kopRCBozNj');
insert into PERSON (pid, pname)
values (919, 'sqazLFeZbP');
insert into PERSON (pid, pname)
values (996, 'eWjmfjmjId');
insert into PERSON (pid, pname)
values (681, 'hCrCpVypWm');
insert into PERSON (pid, pname)
values (789, 'XhdFnsdjZc');
insert into PERSON (pid, pname)
values (665, 'KnuMvDhkzs');
insert into PERSON (pid, pname)
values (533, 'KlCJysTzAv');
insert into PERSON (pid, pname)
values (933, 'xdoRUunoVY');
insert into PERSON (pid, pname)
values (601, 'CNNYXCcIYr');
insert into PERSON (pid, pname)
values (936, 'HRCEhpZxLA');
insert into PERSON (pid, pname)
values (883, 'kLHprvgStz');
insert into PERSON (pid, pname)
values (788, 'TjYxavemQK');
insert into PERSON (pid, pname)
values (668, 'zFqlqZcWmf');
insert into PERSON (pid, pname)
values (588, 'wQPFuNUcCp');
insert into PERSON (pid, pname)
values (863, 'xRHfRYISnb');
insert into PERSON (pid, pname)
values (808, 'ZJhduUEgru');
insert into PERSON (pid, pname)
values (801, 'KXyLVaIzdT');
insert into PERSON (pid, pname)
values (912, 'muQGsUzfNJ');
insert into PERSON (pid, pname)
values (950, 'FeXngcUVpB');
insert into PERSON (pid, pname)
values (619, 'uasjdPjaAm');
insert into PERSON (pid, pname)
values (645, 'DLOFDqWhXw');
insert into PERSON (pid, pname)
values (604, 'iiybbjmAho');
insert into PERSON (pid, pname)
values (989, 'gXQqzZwtHF');
insert into PERSON (pid, pname)
values (758, 'arXyKkUuJU');
insert into PERSON (pid, pname)
values (606, 'QfrOVyFzmi');
insert into PERSON (pid, pname)
values (733, 'dxvrpnMMda');
insert into PERSON (pid, pname)
values (757, 'yVEJokyoUl');
insert into PERSON (pid, pname)
values (750, 'GONWfnmJYj');
insert into PERSON (pid, pname)
values (719, 'sZSpmLtkfW');
insert into PERSON (pid, pname)
values (792, 'UIKbTLptjk');
insert into PERSON (pid, pname)
values (874, 'aCoXaEuzlK');
insert into PERSON (pid, pname)
values (745, 'DBDtzFhuti');
insert into PERSON (pid, pname)
values (624, 'LiljHwojYI');
insert into PERSON (pid, pname)
values (538, 'ePrzmiqjJF');
insert into PERSON (pid, pname)
values (703, 'ryDFPJNxdY');
insert into PERSON (pid, pname)
values (565, 'nXEUPBJQyF');
insert into PERSON (pid, pname)
values (949, 'ATgOCyXgvc');
insert into PERSON (pid, pname)
values (990, 'mLushwbwrl');
insert into PERSON (pid, pname)
values (519, 'WYPvvheqbG');
insert into PERSON (pid, pname)
values (732, 'mGolgZtDvE');
insert into PERSON (pid, pname)
values (850, 'nsHRXTnKck');
insert into PERSON (pid, pname)
values (766, 'tmkTYvstjJ');
insert into PERSON (pid, pname)
values (867, 'xAaHEKmFfU');
insert into PERSON (pid, pname)
values (983, 'pPuQvFkZAO');
insert into PERSON (pid, pname)
values (568, 'AqexZbzHHf');
insert into PERSON (pid, pname)
values (549, 'TobsLJfEsw');
insert into PERSON (pid, pname)
values (506, 'Michael');
insert into PERSON (pid, pname)
values (507, 'Dick');
insert into PERSON (pid, pname)
values (508, 'Edgar');
insert into PERSON (pid, pname)
values (511, 'Toni');
insert into PERSON (pid, pname)
values (517, 'Woody');
insert into PERSON (pid, pname)
values (521, 'Phil');
insert into PERSON (pid, pname)
values (524, 'Illeana');
commit;
prompt 800 records committed...
insert into PERSON (pid, pname)
values (528, 'Fisher');
insert into PERSON (pid, pname)
values (529, 'Coley');
insert into PERSON (pid, pname)
values (530, 'Adina');
insert into PERSON (pid, pname)
values (532, 'Loren');
insert into PERSON (pid, pname)
values (534, 'Adam');
insert into PERSON (pid, pname)
values (535, 'Jimmy');
insert into PERSON (pid, pname)
values (537, 'Cameron');
insert into PERSON (pid, pname)
values (540, 'Maceo');
insert into PERSON (pid, pname)
values (547, 'Neneh');
insert into PERSON (pid, pname)
values (553, 'Jake');
insert into PERSON (pid, pname)
values (554, 'Dave');
insert into PERSON (pid, pname)
values (556, 'Desmond');
insert into PERSON (pid, pname)
values (559, 'Madeleine');
insert into PERSON (pid, pname)
values (560, 'Benicio');
insert into PERSON (pid, pname)
values (562, 'Mae');
insert into PERSON (pid, pname)
values (567, 'Whoopi');
insert into PERSON (pid, pname)
values (569, 'Laura');
insert into PERSON (pid, pname)
values (571, 'Judge');
insert into PERSON (pid, pname)
values (573, 'Julie');
insert into PERSON (pid, pname)
values (576, 'Suzy');
insert into PERSON (pid, pname)
values (580, 'Warren');
insert into PERSON (pid, pname)
values (583, 'Cuba');
insert into PERSON (pid, pname)
values (587, 'Isaac');
insert into PERSON (pid, pname)
values (595, 'Benicio');
insert into PERSON (pid, pname)
values (602, 'Gabriel');
insert into PERSON (pid, pname)
values (605, 'Lin');
insert into PERSON (pid, pname)
values (609, 'Rick');
insert into PERSON (pid, pname)
values (612, 'Jeff');
insert into PERSON (pid, pname)
values (617, 'Kirk');
insert into PERSON (pid, pname)
values (620, 'Carrie');
insert into PERSON (pid, pname)
values (622, 'Gil');
insert into PERSON (pid, pname)
values (623, 'Armin');
insert into PERSON (pid, pname)
values (626, 'Steven');
insert into PERSON (pid, pname)
values (628, 'Dar');
insert into PERSON (pid, pname)
values (631, 'Stellan');
insert into PERSON (pid, pname)
values (633, 'Taye');
insert into PERSON (pid, pname)
values (634, 'Halle');
insert into PERSON (pid, pname)
values (636, 'Steve');
insert into PERSON (pid, pname)
values (638, 'Daryl');
insert into PERSON (pid, pname)
values (639, 'Lena');
insert into PERSON (pid, pname)
values (644, 'Crispin');
insert into PERSON (pid, pname)
values (646, 'Robby');
insert into PERSON (pid, pname)
values (647, 'Merrill');
insert into PERSON (pid, pname)
values (650, 'Lizzy');
insert into PERSON (pid, pname)
values (652, 'Kitty');
insert into PERSON (pid, pname)
values (653, 'Robin');
insert into PERSON (pid, pname)
values (654, 'Ahmad');
insert into PERSON (pid, pname)
values (655, 'Wayne');
insert into PERSON (pid, pname)
values (658, 'Thin');
insert into PERSON (pid, pname)
values (659, 'Teri');
insert into PERSON (pid, pname)
values (663, 'Cate');
insert into PERSON (pid, pname)
values (669, 'Glenn');
insert into PERSON (pid, pname)
values (672, 'Christmas');
insert into PERSON (pid, pname)
values (676, 'Harold');
insert into PERSON (pid, pname)
values (683, 'Vivica');
insert into PERSON (pid, pname)
values (686, 'Ceili');
insert into PERSON (pid, pname)
values (687, 'Donna');
insert into PERSON (pid, pname)
values (689, 'Cliff');
insert into PERSON (pid, pname)
values (690, 'Laurie');
insert into PERSON (pid, pname)
values (693, 'Ron');
insert into PERSON (pid, pname)
values (696, 'Harold');
insert into PERSON (pid, pname)
values (697, 'Joaquim');
insert into PERSON (pid, pname)
values (699, 'Todd');
insert into PERSON (pid, pname)
values (999, 'JOMNB');
commit;
prompt 864 records loaded
prompt Loading CLIENT...
insert into CLIENT (client_id)
values (627);
insert into CLIENT (client_id)
values (496);
insert into CLIENT (client_id)
values (818);
insert into CLIENT (client_id)
values (206);
insert into CLIENT (client_id)
values (563);
insert into CLIENT (client_id)
values (126);
insert into CLIENT (client_id)
values (615);
insert into CLIENT (client_id)
values (551);
insert into CLIENT (client_id)
values (592);
insert into CLIENT (client_id)
values (898);
insert into CLIENT (client_id)
values (700);
insert into CLIENT (client_id)
values (727);
insert into CLIENT (client_id)
values (115);
insert into CLIENT (client_id)
values (349);
insert into CLIENT (client_id)
values (244);
insert into CLIENT (client_id)
values (487);
insert into CLIENT (client_id)
values (685);
insert into CLIENT (client_id)
values (462);
insert into CLIENT (client_id)
values (544);
insert into CLIENT (client_id)
values (193);
insert into CLIENT (client_id)
values (951);
insert into CLIENT (client_id)
values (611);
insert into CLIENT (client_id)
values (217);
insert into CLIENT (client_id)
values (459);
insert into CLIENT (client_id)
values (597);
insert into CLIENT (client_id)
values (504);
insert into CLIENT (client_id)
values (536);
insert into CLIENT (client_id)
values (312);
insert into CLIENT (client_id)
values (308);
insert into CLIENT (client_id)
values (791);
insert into CLIENT (client_id)
values (373);
insert into CLIENT (client_id)
values (513);
insert into CLIENT (client_id)
values (291);
insert into CLIENT (client_id)
values (868);
insert into CLIENT (client_id)
values (975);
insert into CLIENT (client_id)
values (928);
insert into CLIENT (client_id)
values (147);
insert into CLIENT (client_id)
values (896);
insert into CLIENT (client_id)
values (489);
insert into CLIENT (client_id)
values (832);
insert into CLIENT (client_id)
values (368);
insert into CLIENT (client_id)
values (830);
insert into CLIENT (client_id)
values (701);
insert into CLIENT (client_id)
values (492);
insert into CLIENT (client_id)
values (581);
insert into CLIENT (client_id)
values (301);
insert into CLIENT (client_id)
values (978);
insert into CLIENT (client_id)
values (764);
insert into CLIENT (client_id)
values (704);
insert into CLIENT (client_id)
values (728);
insert into CLIENT (client_id)
values (512);
insert into CLIENT (client_id)
values (400);
insert into CLIENT (client_id)
values (555);
insert into CLIENT (client_id)
values (423);
insert into CLIENT (client_id)
values (837);
insert into CLIENT (client_id)
values (935);
insert into CLIENT (client_id)
values (730);
insert into CLIENT (client_id)
values (805);
insert into CLIENT (client_id)
values (630);
insert into CLIENT (client_id)
values (388);
insert into CLIENT (client_id)
values (924);
insert into CLIENT (client_id)
values (348);
insert into CLIENT (client_id)
values (550);
insert into CLIENT (client_id)
values (998);
insert into CLIENT (client_id)
values (327);
insert into CLIENT (client_id)
values (608);
insert into CLIENT (client_id)
values (772);
insert into CLIENT (client_id)
values (251);
insert into CLIENT (client_id)
values (405);
insert into CLIENT (client_id)
values (955);
insert into CLIENT (client_id)
values (834);
insert into CLIENT (client_id)
values (360);
insert into CLIENT (client_id)
values (296);
insert into CLIENT (client_id)
values (920);
insert into CLIENT (client_id)
values (501);
insert into CLIENT (client_id)
values (932);
insert into CLIENT (client_id)
values (305);
insert into CLIENT (client_id)
values (142);
insert into CLIENT (client_id)
values (377);
insert into CLIENT (client_id)
values (200);
insert into CLIENT (client_id)
values (1);
insert into CLIENT (client_id)
values (2);
insert into CLIENT (client_id)
values (3);
insert into CLIENT (client_id)
values (4);
insert into CLIENT (client_id)
values (5);
insert into CLIENT (client_id)
values (6);
insert into CLIENT (client_id)
values (7);
insert into CLIENT (client_id)
values (8);
insert into CLIENT (client_id)
values (9);
insert into CLIENT (client_id)
values (10);
insert into CLIENT (client_id)
values (11);
insert into CLIENT (client_id)
values (12);
insert into CLIENT (client_id)
values (13);
insert into CLIENT (client_id)
values (14);
insert into CLIENT (client_id)
values (15);
insert into CLIENT (client_id)
values (16);
insert into CLIENT (client_id)
values (17);
insert into CLIENT (client_id)
values (18);
insert into CLIENT (client_id)
values (19);
insert into CLIENT (client_id)
values (20);
commit;
prompt 100 records committed...
insert into CLIENT (client_id)
values (21);
insert into CLIENT (client_id)
values (22);
insert into CLIENT (client_id)
values (23);
insert into CLIENT (client_id)
values (24);
insert into CLIENT (client_id)
values (25);
insert into CLIENT (client_id)
values (26);
insert into CLIENT (client_id)
values (27);
insert into CLIENT (client_id)
values (28);
insert into CLIENT (client_id)
values (29);
insert into CLIENT (client_id)
values (30);
insert into CLIENT (client_id)
values (31);
insert into CLIENT (client_id)
values (32);
insert into CLIENT (client_id)
values (33);
insert into CLIENT (client_id)
values (34);
insert into CLIENT (client_id)
values (35);
insert into CLIENT (client_id)
values (36);
insert into CLIENT (client_id)
values (37);
insert into CLIENT (client_id)
values (38);
insert into CLIENT (client_id)
values (39);
insert into CLIENT (client_id)
values (40);
insert into CLIENT (client_id)
values (41);
insert into CLIENT (client_id)
values (42);
insert into CLIENT (client_id)
values (43);
insert into CLIENT (client_id)
values (44);
insert into CLIENT (client_id)
values (45);
insert into CLIENT (client_id)
values (46);
insert into CLIENT (client_id)
values (47);
insert into CLIENT (client_id)
values (48);
insert into CLIENT (client_id)
values (49);
insert into CLIENT (client_id)
values (50);
insert into CLIENT (client_id)
values (51);
insert into CLIENT (client_id)
values (52);
insert into CLIENT (client_id)
values (53);
insert into CLIENT (client_id)
values (54);
insert into CLIENT (client_id)
values (55);
insert into CLIENT (client_id)
values (56);
insert into CLIENT (client_id)
values (57);
insert into CLIENT (client_id)
values (58);
insert into CLIENT (client_id)
values (59);
insert into CLIENT (client_id)
values (60);
insert into CLIENT (client_id)
values (61);
insert into CLIENT (client_id)
values (62);
insert into CLIENT (client_id)
values (63);
insert into CLIENT (client_id)
values (64);
insert into CLIENT (client_id)
values (65);
insert into CLIENT (client_id)
values (66);
insert into CLIENT (client_id)
values (67);
insert into CLIENT (client_id)
values (68);
insert into CLIENT (client_id)
values (69);
insert into CLIENT (client_id)
values (70);
insert into CLIENT (client_id)
values (71);
insert into CLIENT (client_id)
values (72);
insert into CLIENT (client_id)
values (73);
insert into CLIENT (client_id)
values (74);
insert into CLIENT (client_id)
values (75);
insert into CLIENT (client_id)
values (76);
insert into CLIENT (client_id)
values (77);
insert into CLIENT (client_id)
values (78);
insert into CLIENT (client_id)
values (79);
insert into CLIENT (client_id)
values (80);
insert into CLIENT (client_id)
values (81);
insert into CLIENT (client_id)
values (82);
insert into CLIENT (client_id)
values (83);
insert into CLIENT (client_id)
values (84);
insert into CLIENT (client_id)
values (85);
insert into CLIENT (client_id)
values (86);
insert into CLIENT (client_id)
values (87);
insert into CLIENT (client_id)
values (88);
insert into CLIENT (client_id)
values (89);
insert into CLIENT (client_id)
values (90);
insert into CLIENT (client_id)
values (91);
insert into CLIENT (client_id)
values (92);
insert into CLIENT (client_id)
values (93);
insert into CLIENT (client_id)
values (94);
insert into CLIENT (client_id)
values (95);
insert into CLIENT (client_id)
values (96);
insert into CLIENT (client_id)
values (97);
insert into CLIENT (client_id)
values (98);
insert into CLIENT (client_id)
values (99);
insert into CLIENT (client_id)
values (100);
insert into CLIENT (client_id)
values (101);
insert into CLIENT (client_id)
values (102);
insert into CLIENT (client_id)
values (103);
insert into CLIENT (client_id)
values (104);
insert into CLIENT (client_id)
values (105);
insert into CLIENT (client_id)
values (106);
insert into CLIENT (client_id)
values (107);
insert into CLIENT (client_id)
values (108);
insert into CLIENT (client_id)
values (109);
insert into CLIENT (client_id)
values (110);
insert into CLIENT (client_id)
values (111);
insert into CLIENT (client_id)
values (112);
insert into CLIENT (client_id)
values (113);
insert into CLIENT (client_id)
values (114);
insert into CLIENT (client_id)
values (116);
insert into CLIENT (client_id)
values (117);
insert into CLIENT (client_id)
values (118);
insert into CLIENT (client_id)
values (119);
insert into CLIENT (client_id)
values (120);
insert into CLIENT (client_id)
values (121);
commit;
prompt 200 records committed...
insert into CLIENT (client_id)
values (122);
insert into CLIENT (client_id)
values (123);
insert into CLIENT (client_id)
values (124);
insert into CLIENT (client_id)
values (125);
insert into CLIENT (client_id)
values (127);
insert into CLIENT (client_id)
values (128);
insert into CLIENT (client_id)
values (129);
insert into CLIENT (client_id)
values (130);
insert into CLIENT (client_id)
values (131);
insert into CLIENT (client_id)
values (132);
insert into CLIENT (client_id)
values (133);
insert into CLIENT (client_id)
values (134);
insert into CLIENT (client_id)
values (135);
insert into CLIENT (client_id)
values (136);
insert into CLIENT (client_id)
values (137);
insert into CLIENT (client_id)
values (138);
insert into CLIENT (client_id)
values (139);
insert into CLIENT (client_id)
values (140);
insert into CLIENT (client_id)
values (141);
insert into CLIENT (client_id)
values (143);
insert into CLIENT (client_id)
values (144);
insert into CLIENT (client_id)
values (145);
insert into CLIENT (client_id)
values (146);
insert into CLIENT (client_id)
values (148);
insert into CLIENT (client_id)
values (149);
insert into CLIENT (client_id)
values (150);
insert into CLIENT (client_id)
values (151);
insert into CLIENT (client_id)
values (152);
insert into CLIENT (client_id)
values (153);
insert into CLIENT (client_id)
values (154);
insert into CLIENT (client_id)
values (155);
insert into CLIENT (client_id)
values (156);
insert into CLIENT (client_id)
values (157);
insert into CLIENT (client_id)
values (158);
insert into CLIENT (client_id)
values (159);
insert into CLIENT (client_id)
values (160);
insert into CLIENT (client_id)
values (161);
insert into CLIENT (client_id)
values (162);
insert into CLIENT (client_id)
values (163);
insert into CLIENT (client_id)
values (164);
insert into CLIENT (client_id)
values (165);
insert into CLIENT (client_id)
values (166);
insert into CLIENT (client_id)
values (167);
insert into CLIENT (client_id)
values (168);
insert into CLIENT (client_id)
values (169);
insert into CLIENT (client_id)
values (170);
insert into CLIENT (client_id)
values (171);
insert into CLIENT (client_id)
values (172);
insert into CLIENT (client_id)
values (173);
insert into CLIENT (client_id)
values (174);
insert into CLIENT (client_id)
values (175);
insert into CLIENT (client_id)
values (176);
insert into CLIENT (client_id)
values (177);
insert into CLIENT (client_id)
values (178);
insert into CLIENT (client_id)
values (179);
insert into CLIENT (client_id)
values (180);
insert into CLIENT (client_id)
values (181);
insert into CLIENT (client_id)
values (182);
insert into CLIENT (client_id)
values (183);
insert into CLIENT (client_id)
values (184);
insert into CLIENT (client_id)
values (185);
insert into CLIENT (client_id)
values (186);
insert into CLIENT (client_id)
values (187);
insert into CLIENT (client_id)
values (188);
insert into CLIENT (client_id)
values (189);
insert into CLIENT (client_id)
values (190);
insert into CLIENT (client_id)
values (191);
insert into CLIENT (client_id)
values (192);
insert into CLIENT (client_id)
values (194);
insert into CLIENT (client_id)
values (195);
insert into CLIENT (client_id)
values (196);
insert into CLIENT (client_id)
values (197);
insert into CLIENT (client_id)
values (198);
insert into CLIENT (client_id)
values (199);
insert into CLIENT (client_id)
values (201);
insert into CLIENT (client_id)
values (202);
insert into CLIENT (client_id)
values (203);
insert into CLIENT (client_id)
values (204);
insert into CLIENT (client_id)
values (205);
insert into CLIENT (client_id)
values (207);
insert into CLIENT (client_id)
values (208);
insert into CLIENT (client_id)
values (209);
insert into CLIENT (client_id)
values (210);
insert into CLIENT (client_id)
values (211);
insert into CLIENT (client_id)
values (212);
insert into CLIENT (client_id)
values (213);
insert into CLIENT (client_id)
values (214);
insert into CLIENT (client_id)
values (215);
insert into CLIENT (client_id)
values (216);
insert into CLIENT (client_id)
values (218);
insert into CLIENT (client_id)
values (219);
insert into CLIENT (client_id)
values (220);
insert into CLIENT (client_id)
values (221);
insert into CLIENT (client_id)
values (222);
insert into CLIENT (client_id)
values (223);
insert into CLIENT (client_id)
values (224);
insert into CLIENT (client_id)
values (225);
insert into CLIENT (client_id)
values (226);
insert into CLIENT (client_id)
values (227);
insert into CLIENT (client_id)
values (228);
commit;
prompt 300 records committed...
insert into CLIENT (client_id)
values (229);
insert into CLIENT (client_id)
values (230);
insert into CLIENT (client_id)
values (231);
insert into CLIENT (client_id)
values (232);
insert into CLIENT (client_id)
values (233);
insert into CLIENT (client_id)
values (234);
insert into CLIENT (client_id)
values (235);
insert into CLIENT (client_id)
values (236);
insert into CLIENT (client_id)
values (237);
insert into CLIENT (client_id)
values (238);
insert into CLIENT (client_id)
values (239);
insert into CLIENT (client_id)
values (240);
insert into CLIENT (client_id)
values (241);
insert into CLIENT (client_id)
values (242);
insert into CLIENT (client_id)
values (243);
insert into CLIENT (client_id)
values (245);
insert into CLIENT (client_id)
values (246);
insert into CLIENT (client_id)
values (247);
insert into CLIENT (client_id)
values (248);
insert into CLIENT (client_id)
values (249);
insert into CLIENT (client_id)
values (250);
insert into CLIENT (client_id)
values (252);
insert into CLIENT (client_id)
values (253);
insert into CLIENT (client_id)
values (254);
insert into CLIENT (client_id)
values (255);
insert into CLIENT (client_id)
values (256);
insert into CLIENT (client_id)
values (257);
insert into CLIENT (client_id)
values (258);
insert into CLIENT (client_id)
values (259);
insert into CLIENT (client_id)
values (260);
insert into CLIENT (client_id)
values (261);
insert into CLIENT (client_id)
values (262);
insert into CLIENT (client_id)
values (263);
insert into CLIENT (client_id)
values (264);
insert into CLIENT (client_id)
values (265);
insert into CLIENT (client_id)
values (266);
insert into CLIENT (client_id)
values (267);
insert into CLIENT (client_id)
values (268);
insert into CLIENT (client_id)
values (269);
insert into CLIENT (client_id)
values (270);
insert into CLIENT (client_id)
values (271);
insert into CLIENT (client_id)
values (272);
insert into CLIENT (client_id)
values (273);
insert into CLIENT (client_id)
values (274);
insert into CLIENT (client_id)
values (275);
insert into CLIENT (client_id)
values (276);
insert into CLIENT (client_id)
values (277);
insert into CLIENT (client_id)
values (278);
insert into CLIENT (client_id)
values (279);
insert into CLIENT (client_id)
values (280);
insert into CLIENT (client_id)
values (281);
insert into CLIENT (client_id)
values (282);
insert into CLIENT (client_id)
values (283);
insert into CLIENT (client_id)
values (284);
insert into CLIENT (client_id)
values (285);
insert into CLIENT (client_id)
values (286);
insert into CLIENT (client_id)
values (287);
insert into CLIENT (client_id)
values (288);
insert into CLIENT (client_id)
values (289);
insert into CLIENT (client_id)
values (290);
insert into CLIENT (client_id)
values (292);
insert into CLIENT (client_id)
values (293);
insert into CLIENT (client_id)
values (294);
insert into CLIENT (client_id)
values (295);
insert into CLIENT (client_id)
values (297);
insert into CLIENT (client_id)
values (298);
insert into CLIENT (client_id)
values (299);
insert into CLIENT (client_id)
values (300);
insert into CLIENT (client_id)
values (302);
insert into CLIENT (client_id)
values (303);
insert into CLIENT (client_id)
values (304);
insert into CLIENT (client_id)
values (306);
insert into CLIENT (client_id)
values (307);
insert into CLIENT (client_id)
values (309);
insert into CLIENT (client_id)
values (310);
insert into CLIENT (client_id)
values (311);
insert into CLIENT (client_id)
values (313);
insert into CLIENT (client_id)
values (314);
insert into CLIENT (client_id)
values (315);
insert into CLIENT (client_id)
values (316);
insert into CLIENT (client_id)
values (317);
insert into CLIENT (client_id)
values (318);
insert into CLIENT (client_id)
values (319);
insert into CLIENT (client_id)
values (320);
insert into CLIENT (client_id)
values (321);
insert into CLIENT (client_id)
values (322);
insert into CLIENT (client_id)
values (323);
insert into CLIENT (client_id)
values (324);
insert into CLIENT (client_id)
values (325);
insert into CLIENT (client_id)
values (326);
insert into CLIENT (client_id)
values (328);
insert into CLIENT (client_id)
values (329);
insert into CLIENT (client_id)
values (330);
insert into CLIENT (client_id)
values (331);
insert into CLIENT (client_id)
values (332);
insert into CLIENT (client_id)
values (333);
insert into CLIENT (client_id)
values (334);
insert into CLIENT (client_id)
values (335);
insert into CLIENT (client_id)
values (336);
insert into CLIENT (client_id)
values (337);
commit;
prompt 400 records committed...
insert into CLIENT (client_id)
values (338);
insert into CLIENT (client_id)
values (339);
insert into CLIENT (client_id)
values (340);
insert into CLIENT (client_id)
values (341);
insert into CLIENT (client_id)
values (342);
insert into CLIENT (client_id)
values (343);
insert into CLIENT (client_id)
values (344);
insert into CLIENT (client_id)
values (345);
insert into CLIENT (client_id)
values (346);
insert into CLIENT (client_id)
values (347);
insert into CLIENT (client_id)
values (350);
insert into CLIENT (client_id)
values (351);
insert into CLIENT (client_id)
values (352);
insert into CLIENT (client_id)
values (353);
insert into CLIENT (client_id)
values (354);
insert into CLIENT (client_id)
values (355);
insert into CLIENT (client_id)
values (356);
insert into CLIENT (client_id)
values (357);
insert into CLIENT (client_id)
values (358);
insert into CLIENT (client_id)
values (359);
insert into CLIENT (client_id)
values (361);
insert into CLIENT (client_id)
values (362);
insert into CLIENT (client_id)
values (363);
insert into CLIENT (client_id)
values (364);
insert into CLIENT (client_id)
values (365);
insert into CLIENT (client_id)
values (366);
insert into CLIENT (client_id)
values (367);
insert into CLIENT (client_id)
values (369);
insert into CLIENT (client_id)
values (370);
insert into CLIENT (client_id)
values (371);
insert into CLIENT (client_id)
values (372);
insert into CLIENT (client_id)
values (374);
insert into CLIENT (client_id)
values (375);
insert into CLIENT (client_id)
values (376);
insert into CLIENT (client_id)
values (378);
insert into CLIENT (client_id)
values (379);
insert into CLIENT (client_id)
values (380);
insert into CLIENT (client_id)
values (381);
insert into CLIENT (client_id)
values (382);
insert into CLIENT (client_id)
values (383);
insert into CLIENT (client_id)
values (384);
insert into CLIENT (client_id)
values (385);
insert into CLIENT (client_id)
values (386);
insert into CLIENT (client_id)
values (387);
insert into CLIENT (client_id)
values (389);
insert into CLIENT (client_id)
values (390);
insert into CLIENT (client_id)
values (391);
insert into CLIENT (client_id)
values (392);
insert into CLIENT (client_id)
values (393);
insert into CLIENT (client_id)
values (394);
insert into CLIENT (client_id)
values (395);
insert into CLIENT (client_id)
values (396);
insert into CLIENT (client_id)
values (397);
insert into CLIENT (client_id)
values (398);
insert into CLIENT (client_id)
values (399);
insert into CLIENT (client_id)
values (401);
insert into CLIENT (client_id)
values (402);
insert into CLIENT (client_id)
values (403);
insert into CLIENT (client_id)
values (404);
insert into CLIENT (client_id)
values (406);
insert into CLIENT (client_id)
values (407);
insert into CLIENT (client_id)
values (408);
insert into CLIENT (client_id)
values (409);
insert into CLIENT (client_id)
values (410);
insert into CLIENT (client_id)
values (411);
insert into CLIENT (client_id)
values (412);
insert into CLIENT (client_id)
values (413);
insert into CLIENT (client_id)
values (414);
insert into CLIENT (client_id)
values (415);
insert into CLIENT (client_id)
values (416);
insert into CLIENT (client_id)
values (417);
insert into CLIENT (client_id)
values (418);
insert into CLIENT (client_id)
values (419);
insert into CLIENT (client_id)
values (420);
insert into CLIENT (client_id)
values (421);
insert into CLIENT (client_id)
values (422);
insert into CLIENT (client_id)
values (424);
insert into CLIENT (client_id)
values (425);
insert into CLIENT (client_id)
values (426);
insert into CLIENT (client_id)
values (427);
insert into CLIENT (client_id)
values (428);
insert into CLIENT (client_id)
values (429);
insert into CLIENT (client_id)
values (430);
insert into CLIENT (client_id)
values (431);
insert into CLIENT (client_id)
values (432);
insert into CLIENT (client_id)
values (433);
insert into CLIENT (client_id)
values (434);
insert into CLIENT (client_id)
values (435);
insert into CLIENT (client_id)
values (436);
insert into CLIENT (client_id)
values (437);
insert into CLIENT (client_id)
values (438);
insert into CLIENT (client_id)
values (439);
insert into CLIENT (client_id)
values (440);
insert into CLIENT (client_id)
values (441);
insert into CLIENT (client_id)
values (442);
insert into CLIENT (client_id)
values (443);
insert into CLIENT (client_id)
values (444);
insert into CLIENT (client_id)
values (445);
insert into CLIENT (client_id)
values (446);
insert into CLIENT (client_id)
values (447);
commit;
prompt 500 records committed...
insert into CLIENT (client_id)
values (448);
insert into CLIENT (client_id)
values (449);
insert into CLIENT (client_id)
values (450);
insert into CLIENT (client_id)
values (451);
insert into CLIENT (client_id)
values (452);
insert into CLIENT (client_id)
values (453);
insert into CLIENT (client_id)
values (454);
insert into CLIENT (client_id)
values (455);
insert into CLIENT (client_id)
values (456);
insert into CLIENT (client_id)
values (457);
insert into CLIENT (client_id)
values (458);
insert into CLIENT (client_id)
values (460);
insert into CLIENT (client_id)
values (461);
insert into CLIENT (client_id)
values (463);
insert into CLIENT (client_id)
values (464);
insert into CLIENT (client_id)
values (465);
insert into CLIENT (client_id)
values (466);
insert into CLIENT (client_id)
values (467);
insert into CLIENT (client_id)
values (468);
insert into CLIENT (client_id)
values (469);
insert into CLIENT (client_id)
values (470);
insert into CLIENT (client_id)
values (471);
insert into CLIENT (client_id)
values (472);
insert into CLIENT (client_id)
values (473);
insert into CLIENT (client_id)
values (474);
insert into CLIENT (client_id)
values (475);
insert into CLIENT (client_id)
values (476);
insert into CLIENT (client_id)
values (477);
insert into CLIENT (client_id)
values (478);
insert into CLIENT (client_id)
values (479);
insert into CLIENT (client_id)
values (480);
insert into CLIENT (client_id)
values (481);
insert into CLIENT (client_id)
values (482);
insert into CLIENT (client_id)
values (483);
insert into CLIENT (client_id)
values (484);
insert into CLIENT (client_id)
values (485);
insert into CLIENT (client_id)
values (486);
insert into CLIENT (client_id)
values (488);
insert into CLIENT (client_id)
values (490);
insert into CLIENT (client_id)
values (491);
insert into CLIENT (client_id)
values (493);
insert into CLIENT (client_id)
values (494);
insert into CLIENT (client_id)
values (495);
insert into CLIENT (client_id)
values (497);
insert into CLIENT (client_id)
values (498);
insert into CLIENT (client_id)
values (499);
insert into CLIENT (client_id)
values (500);
commit;
prompt 547 records loaded
prompt Loading DATES...
insert into DATES (dateid, hourh, dayd, dated)
values (100, '14:00', 'SAT', to_date('01-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (101, '17:00', 'SAT', to_date('01-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (102, '20:00', 'SAT', to_date('01-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (103, '23:00', 'SAT', to_date('01-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (104, '14:00', 'SUN', to_date('02-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (105, '17:00', 'SUN', to_date('02-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (106, '20:00', 'SUN', to_date('02-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (107, '23:00', 'SUN', to_date('02-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (108, '14:00', 'MON', to_date('03-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (109, '17:00', 'MON', to_date('03-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (110, '20:00', 'MON', to_date('03-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (111, '23:00', 'MON', to_date('03-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (112, '14:00', 'TUE', to_date('04-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (113, '17:00', 'TUE', to_date('04-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (114, '20:00', 'TUE', to_date('04-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (115, '23:00', 'TUE', to_date('04-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (116, '14:00', 'WED', to_date('05-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (117, '17:00', 'WED', to_date('05-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (118, '20:00', 'WED', to_date('05-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (119, '23:00', 'WED', to_date('05-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (120, '14:00', 'THU', to_date('06-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (121, '17:00', 'THU', to_date('06-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (122, '20:00', 'THU', to_date('06-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (123, '23:00', 'THU', to_date('06-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (124, '14:00', 'FRI', to_date('07-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (125, '17:00', 'FRI', to_date('07-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (126, '20:00', 'FRI', to_date('07-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (127, '23:00', 'FRI', to_date('07-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (128, '14:00', 'SAT', to_date('08-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (129, '17:00', 'SAT', to_date('08-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (130, '20:00', 'SAT', to_date('08-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (131, '23:00', 'SAT', to_date('08-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (132, '14:00', 'SUN', to_date('09-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (133, '17:00', 'SUN', to_date('09-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (134, '20:00', 'SUN', to_date('09-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (135, '23:00', 'SUN', to_date('09-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (136, '14:00', 'MON', to_date('10-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (137, '17:00', 'MON', to_date('10-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (138, '20:00', 'MON', to_date('10-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (139, '23:00', 'MON', to_date('10-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (140, '14:00', 'TUE', to_date('11-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (141, '17:00', 'TUE', to_date('11-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (142, '20:00', 'TUE', to_date('11-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (143, '23:00', 'TUE', to_date('11-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (144, '14:00', 'WED', to_date('12-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (145, '17:00', 'WED', to_date('12-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (146, '20:00', 'WED', to_date('12-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (147, '23:00', 'WED', to_date('12-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (148, '14:00', 'THU', to_date('13-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (149, '17:00', 'THU', to_date('13-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (150, '20:00', 'THU', to_date('13-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (151, '23:00', 'THU', to_date('13-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (152, '14:00', 'FRI', to_date('14-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (153, '17:00', 'FRI', to_date('14-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (154, '20:00', 'FRI', to_date('14-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (155, '23:00', 'FRI', to_date('14-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (156, '14:00', 'SAT', to_date('15-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (157, '17:00', 'SAT', to_date('15-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (158, '20:00', 'SAT', to_date('15-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (159, '23:00', 'SAT', to_date('15-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (160, '14:00', 'SUN', to_date('16-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (161, '17:00', 'SUN', to_date('16-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (162, '20:00', 'SUN', to_date('16-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (163, '23:00', 'SUN', to_date('16-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (164, '14:00', 'MON', to_date('17-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (165, '17:00', 'MON', to_date('17-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (166, '20:00', 'MON', to_date('17-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (167, '23:00', 'MON', to_date('17-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (168, '14:00', 'TUE', to_date('18-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (169, '17:00', 'TUE', to_date('18-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (170, '20:00', 'TUE', to_date('18-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (171, '23:00', 'TUE', to_date('18-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (172, '14:00', 'WED', to_date('19-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (173, '17:00', 'WED', to_date('19-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (174, '20:00', 'WED', to_date('19-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (175, '23:00', 'WED', to_date('19-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (176, '14:00', 'THU', to_date('20-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (177, '17:00', 'THU', to_date('20-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (178, '20:00', 'THU', to_date('20-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (179, '23:00', 'THU', to_date('20-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (180, '14:00', 'FRI', to_date('21-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (181, '17:00', 'FRI', to_date('21-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (182, '20:00', 'FRI', to_date('21-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (183, '23:00', 'FRI', to_date('21-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (184, '14:00', 'SAT', to_date('22-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (185, '17:00', 'SAT', to_date('22-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (186, '20:00', 'SAT', to_date('22-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (187, '23:00', 'SAT', to_date('22-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (188, '14:00', 'SUN', to_date('23-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (189, '17:00', 'SUN', to_date('23-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (190, '20:00', 'SUN', to_date('23-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (191, '23:00', 'SUN', to_date('23-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (192, '14:00', 'MON', to_date('24-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (193, '17:00', 'MON', to_date('24-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (194, '20:00', 'MON', to_date('24-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (195, '23:00', 'MON', to_date('24-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (196, '14:00', 'TUE', to_date('25-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (197, '17:00', 'TUE', to_date('25-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (198, '20:00', 'TUE', to_date('25-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (199, '23:00', 'TUE', to_date('25-06-2024', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into DATES (dateid, hourh, dayd, dated)
values (200, '14:00', 'WED', to_date('26-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (201, '17:00', 'WED', to_date('26-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (202, '20:00', 'WED', to_date('26-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (203, '23:00', 'WED', to_date('26-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (204, '14:00', 'THU', to_date('27-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (205, '17:00', 'THU', to_date('27-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (206, '20:00', 'THU', to_date('27-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (207, '23:00', 'THU', to_date('27-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (208, '14:00', 'FRI', to_date('28-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (209, '17:00', 'FRI', to_date('28-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (210, '20:00', 'FRI', to_date('28-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (211, '23:00', 'FRI', to_date('28-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (212, '14:00', 'SAT', to_date('29-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (213, '17:00', 'SAT', to_date('29-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (214, '20:00', 'SAT', to_date('29-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (215, '23:00', 'SAT', to_date('29-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (216, '14:00', 'SUN', to_date('30-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (217, '17:00', 'SUN', to_date('30-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (218, '20:00', 'SUN', to_date('30-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (219, '23:00', 'SUN', to_date('30-06-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (220, '14:00', 'MON', to_date('01-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (221, '17:00', 'MON', to_date('01-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (222, '20:00', 'MON', to_date('01-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (223, '23:00', 'MON', to_date('01-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (224, '14:00', 'TUE', to_date('02-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (225, '17:00', 'TUE', to_date('02-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (226, '20:00', 'TUE', to_date('02-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (227, '23:00', 'TUE', to_date('02-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (228, '14:00', 'WED', to_date('03-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (229, '17:00', 'WED', to_date('03-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (230, '20:00', 'WED', to_date('03-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (231, '23:00', 'WED', to_date('03-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (232, '14:00', 'THU', to_date('04-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (233, '17:00', 'THU', to_date('04-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (234, '20:00', 'THU', to_date('04-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (235, '23:00', 'THU', to_date('04-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (236, '14:00', 'FRI', to_date('05-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (237, '17:00', 'FRI', to_date('05-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (238, '20:00', 'FRI', to_date('05-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (239, '23:00', 'FRI', to_date('05-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (240, '14:00', 'SAT', to_date('06-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (241, '17:00', 'SAT', to_date('06-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (242, '20:00', 'SAT', to_date('06-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (243, '23:00', 'SAT', to_date('06-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (244, '14:00', 'SUN', to_date('07-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (245, '17:00', 'SUN', to_date('07-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (246, '20:00', 'SUN', to_date('07-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (247, '23:00', 'SUN', to_date('07-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (248, '14:00', 'MON', to_date('08-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (249, '17:00', 'MON', to_date('08-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (250, '20:00', 'MON', to_date('08-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (251, '23:00', 'MON', to_date('08-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (252, '14:00', 'TUE', to_date('09-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (253, '17:00', 'TUE', to_date('09-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (254, '20:00', 'TUE', to_date('09-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (255, '23:00', 'TUE', to_date('09-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (256, '14:00', 'WED', to_date('10-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (257, '17:00', 'WED', to_date('10-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (258, '20:00', 'WED', to_date('10-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (259, '23:00', 'WED', to_date('10-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (260, '14:00', 'THU', to_date('11-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (261, '17:00', 'THU', to_date('11-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (262, '20:00', 'THU', to_date('11-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (263, '23:00', 'THU', to_date('11-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (264, '14:00', 'FRI', to_date('12-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (265, '17:00', 'FRI', to_date('12-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (266, '20:00', 'FRI', to_date('12-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (267, '23:00', 'FRI', to_date('12-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (268, '14:00', 'SAT', to_date('13-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (269, '17:00', 'SAT', to_date('13-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (270, '20:00', 'SAT', to_date('13-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (271, '23:00', 'SAT', to_date('13-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (272, '14:00', 'SUN', to_date('14-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (273, '17:00', 'SUN', to_date('14-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (274, '20:00', 'SUN', to_date('14-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (275, '23:00', 'SUN', to_date('14-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (276, '14:00', 'MON', to_date('15-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (277, '17:00', 'MON', to_date('15-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (278, '20:00', 'MON', to_date('15-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (279, '23:00', 'MON', to_date('15-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (280, '14:00', 'TUE', to_date('16-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (281, '17:00', 'TUE', to_date('16-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (282, '20:00', 'TUE', to_date('16-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (283, '23:00', 'TUE', to_date('16-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (284, '14:00', 'WED', to_date('17-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (285, '17:00', 'WED', to_date('17-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (286, '20:00', 'WED', to_date('17-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (287, '23:00', 'WED', to_date('17-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (288, '14:00', 'THU', to_date('18-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (289, '17:00', 'THU', to_date('18-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (290, '20:00', 'THU', to_date('18-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (291, '23:00', 'THU', to_date('18-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (292, '14:00', 'FRI', to_date('19-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (293, '17:00', 'FRI', to_date('19-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (294, '20:00', 'FRI', to_date('19-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (295, '23:00', 'FRI', to_date('19-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (296, '14:00', 'SAT', to_date('20-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (297, '17:00', 'SAT', to_date('20-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (298, '20:00', 'SAT', to_date('20-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (299, '23:00', 'SAT', to_date('20-07-2024', 'dd-mm-yyyy'));
commit;
prompt 200 records committed...
insert into DATES (dateid, hourh, dayd, dated)
values (300, '14:00', 'SUN', to_date('21-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (301, '17:00', 'SUN', to_date('21-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (302, '20:00', 'SUN', to_date('21-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (303, '23:00', 'SUN', to_date('21-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (304, '14:00', 'MON', to_date('22-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (305, '17:00', 'MON', to_date('22-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (306, '20:00', 'MON', to_date('22-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (307, '23:00', 'MON', to_date('22-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (308, '14:00', 'TUE', to_date('23-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (309, '17:00', 'TUE', to_date('23-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (310, '20:00', 'TUE', to_date('23-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (311, '23:00', 'TUE', to_date('23-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (312, '14:00', 'WED', to_date('24-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (313, '17:00', 'WED', to_date('24-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (314, '20:00', 'WED', to_date('24-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (315, '23:00', 'WED', to_date('24-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (316, '14:00', 'THU', to_date('25-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (317, '17:00', 'THU', to_date('25-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (318, '20:00', 'THU', to_date('25-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (319, '23:00', 'THU', to_date('25-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (320, '14:00', 'FRI', to_date('26-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (321, '17:00', 'FRI', to_date('26-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (322, '20:00', 'FRI', to_date('26-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (323, '23:00', 'FRI', to_date('26-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (324, '14:00', 'SAT', to_date('27-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (325, '17:00', 'SAT', to_date('27-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (326, '20:00', 'SAT', to_date('27-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (327, '23:00', 'SAT', to_date('27-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (328, '14:00', 'SUN', to_date('28-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (329, '17:00', 'SUN', to_date('28-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (330, '20:00', 'SUN', to_date('28-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (331, '23:00', 'SUN', to_date('28-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (332, '14:00', 'MON', to_date('29-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (333, '17:00', 'MON', to_date('29-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (334, '20:00', 'MON', to_date('29-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (335, '23:00', 'MON', to_date('29-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (336, '14:00', 'TUE', to_date('30-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (337, '17:00', 'TUE', to_date('30-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (338, '20:00', 'TUE', to_date('30-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (339, '23:00', 'TUE', to_date('30-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (340, '14:00', 'WED', to_date('31-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (341, '17:00', 'WED', to_date('31-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (342, '20:00', 'WED', to_date('31-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (343, '23:00', 'WED', to_date('31-07-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (344, '14:00', 'THU', to_date('01-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (345, '17:00', 'THU', to_date('01-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (346, '20:00', 'THU', to_date('01-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (347, '23:00', 'THU', to_date('01-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (348, '14:00', 'FRI', to_date('02-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (349, '17:00', 'FRI', to_date('02-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (350, '20:00', 'FRI', to_date('02-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (351, '23:00', 'FRI', to_date('02-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (352, '14:00', 'SAT', to_date('03-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (353, '17:00', 'SAT', to_date('03-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (354, '20:00', 'SAT', to_date('03-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (355, '23:00', 'SAT', to_date('03-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (356, '14:00', 'SUN', to_date('04-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (357, '17:00', 'SUN', to_date('04-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (358, '20:00', 'SUN', to_date('04-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (359, '23:00', 'SUN', to_date('04-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (360, '14:00', 'MON', to_date('05-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (361, '17:00', 'MON', to_date('05-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (362, '20:00', 'MON', to_date('05-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (363, '23:00', 'MON', to_date('05-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (364, '14:00', 'TUE', to_date('06-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (365, '17:00', 'TUE', to_date('06-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (366, '20:00', 'TUE', to_date('06-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (367, '23:00', 'TUE', to_date('06-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (368, '14:00', 'WED', to_date('07-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (369, '17:00', 'WED', to_date('07-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (370, '20:00', 'WED', to_date('07-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (371, '23:00', 'WED', to_date('07-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (372, '14:00', 'THU', to_date('08-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (373, '17:00', 'THU', to_date('08-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (374, '20:00', 'THU', to_date('08-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (375, '23:00', 'THU', to_date('08-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (376, '14:00', 'FRI', to_date('09-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (377, '17:00', 'FRI', to_date('09-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (378, '20:00', 'FRI', to_date('09-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (379, '23:00', 'FRI', to_date('09-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (380, '14:00', 'SAT', to_date('10-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (381, '17:00', 'SAT', to_date('10-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (382, '20:00', 'SAT', to_date('10-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (383, '23:00', 'SAT', to_date('10-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (384, '14:00', 'SUN', to_date('11-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (385, '17:00', 'SUN', to_date('11-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (386, '20:00', 'SUN', to_date('11-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (387, '23:00', 'SUN', to_date('11-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (388, '14:00', 'MON', to_date('12-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (389, '17:00', 'MON', to_date('12-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (390, '20:00', 'MON', to_date('12-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (391, '23:00', 'MON', to_date('12-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (392, '14:00', 'TUE', to_date('13-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (393, '17:00', 'TUE', to_date('13-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (394, '20:00', 'TUE', to_date('13-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (395, '23:00', 'TUE', to_date('13-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (396, '14:00', 'WED', to_date('14-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (397, '17:00', 'WED', to_date('14-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (398, '20:00', 'WED', to_date('14-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (399, '23:00', 'WED', to_date('14-08-2024', 'dd-mm-yyyy'));
commit;
prompt 300 records committed...
insert into DATES (dateid, hourh, dayd, dated)
values (400, '14:00', 'THU', to_date('15-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (401, '17:00', 'THU', to_date('15-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (402, '20:00', 'THU', to_date('15-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (403, '23:00', 'THU', to_date('15-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (404, '14:00', 'FRI', to_date('16-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (405, '17:00', 'FRI', to_date('16-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (406, '20:00', 'FRI', to_date('16-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (407, '23:00', 'FRI', to_date('16-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (408, '14:00', 'SAT', to_date('17-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (409, '17:00', 'SAT', to_date('17-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (410, '20:00', 'SAT', to_date('17-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (411, '23:00', 'SAT', to_date('17-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (412, '14:00', 'SUN', to_date('18-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (413, '17:00', 'SUN', to_date('18-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (414, '20:00', 'SUN', to_date('18-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (415, '23:00', 'SUN', to_date('18-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (416, '14:00', 'MON', to_date('19-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (417, '17:00', 'MON', to_date('19-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (418, '20:00', 'MON', to_date('19-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (419, '23:00', 'MON', to_date('19-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (420, '14:00', 'TUE', to_date('20-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (421, '17:00', 'TUE', to_date('20-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (422, '20:00', 'TUE', to_date('20-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (423, '23:00', 'TUE', to_date('20-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (424, '14:00', 'WED', to_date('21-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (425, '17:00', 'WED', to_date('21-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (426, '20:00', 'WED', to_date('21-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (427, '23:00', 'WED', to_date('21-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (428, '14:00', 'THU', to_date('22-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (429, '17:00', 'THU', to_date('22-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (430, '20:00', 'THU', to_date('22-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (431, '23:00', 'THU', to_date('22-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (432, '14:00', 'FRI', to_date('23-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (433, '17:00', 'FRI', to_date('23-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (434, '20:00', 'FRI', to_date('23-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (435, '23:00', 'FRI', to_date('23-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (436, '14:00', 'SAT', to_date('24-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (437, '17:00', 'SAT', to_date('24-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (438, '20:00', 'SAT', to_date('24-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (439, '23:00', 'SAT', to_date('24-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (440, '14:00', 'SUN', to_date('25-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (441, '17:00', 'SUN', to_date('25-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (442, '20:00', 'SUN', to_date('25-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (443, '23:00', 'SUN', to_date('25-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (444, '14:00', 'MON', to_date('26-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (445, '17:00', 'MON', to_date('26-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (446, '20:00', 'MON', to_date('26-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (447, '23:00', 'MON', to_date('26-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (448, '14:00', 'TUE', to_date('27-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (449, '17:00', 'TUE', to_date('27-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (450, '20:00', 'TUE', to_date('27-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (451, '23:00', 'TUE', to_date('27-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (452, '14:00', 'WED', to_date('28-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (453, '17:00', 'WED', to_date('28-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (454, '20:00', 'WED', to_date('28-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (455, '23:00', 'WED', to_date('28-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (456, '14:00', 'THU', to_date('29-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (457, '17:00', 'THU', to_date('29-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (458, '20:00', 'THU', to_date('29-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (459, '23:00', 'THU', to_date('29-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (460, '14:00', 'FRI', to_date('30-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (461, '17:00', 'FRI', to_date('30-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (462, '20:00', 'FRI', to_date('30-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (463, '23:00', 'FRI', to_date('30-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (464, '14:00', 'SAT', to_date('31-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (465, '17:00', 'SAT', to_date('31-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (466, '20:00', 'SAT', to_date('31-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (467, '23:00', 'SAT', to_date('31-08-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (468, '14:00', 'SUN', to_date('01-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (469, '17:00', 'SUN', to_date('01-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (470, '20:00', 'SUN', to_date('01-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (471, '23:00', 'SUN', to_date('01-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (472, '14:00', 'MON', to_date('02-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (473, '17:00', 'MON', to_date('02-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (474, '20:00', 'MON', to_date('02-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (475, '23:00', 'MON', to_date('02-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (476, '14:00', 'TUE', to_date('03-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (477, '17:00', 'TUE', to_date('03-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (478, '20:00', 'TUE', to_date('03-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (479, '23:00', 'TUE', to_date('03-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (480, '14:00', 'WED', to_date('04-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (481, '17:00', 'WED', to_date('04-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (482, '20:00', 'WED', to_date('04-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (483, '23:00', 'WED', to_date('04-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (484, '14:00', 'THU', to_date('05-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (485, '17:00', 'THU', to_date('05-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (486, '20:00', 'THU', to_date('05-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (487, '23:00', 'THU', to_date('05-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (488, '14:00', 'FRI', to_date('06-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (489, '17:00', 'FRI', to_date('06-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (490, '20:00', 'FRI', to_date('06-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (491, '23:00', 'FRI', to_date('06-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (492, '14:00', 'SAT', to_date('07-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (493, '17:00', 'SAT', to_date('07-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (494, '20:00', 'SAT', to_date('07-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (495, '23:00', 'SAT', to_date('07-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (496, '14:00', 'SUN', to_date('08-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (497, '17:00', 'SUN', to_date('08-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (498, '20:00', 'SUN', to_date('08-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (499, '23:00', 'SUN', to_date('08-09-2024', 'dd-mm-yyyy'));
commit;
prompt 400 records committed...
insert into DATES (dateid, hourh, dayd, dated)
values (500, '14:00', 'MON', to_date('09-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (501, '17:00', 'MON', to_date('09-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (502, '20:00', 'MON', to_date('09-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (503, '23:00', 'MON', to_date('09-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (504, '14:00', 'TUE', to_date('10-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (505, '17:00', 'TUE', to_date('10-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (506, '20:00', 'TUE', to_date('10-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (507, '23:00', 'TUE', to_date('10-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (508, '14:00', 'WED', to_date('11-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (509, '17:00', 'WED', to_date('11-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (510, '20:00', 'WED', to_date('11-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (511, '23:00', 'WED', to_date('11-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (512, '14:00', 'THU', to_date('12-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (513, '17:00', 'THU', to_date('12-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (514, '20:00', 'THU', to_date('12-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (515, '23:00', 'THU', to_date('12-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (516, '14:00', 'FRI', to_date('13-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (517, '17:00', 'FRI', to_date('13-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (518, '20:00', 'FRI', to_date('13-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (519, '23:00', 'FRI', to_date('13-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (520, '14:00', 'SAT', to_date('14-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (521, '17:00', 'SAT', to_date('14-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (522, '20:00', 'SAT', to_date('14-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (523, '23:00', 'SAT', to_date('14-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (524, '14:00', 'SUN', to_date('15-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (525, '17:00', 'SUN', to_date('15-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (526, '20:00', 'SUN', to_date('15-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (527, '23:00', 'SUN', to_date('15-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (528, '14:00', 'MON', to_date('16-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (529, '17:00', 'MON', to_date('16-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (530, '20:00', 'MON', to_date('16-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (531, '23:00', 'MON', to_date('16-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (532, '14:00', 'TUE', to_date('17-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (533, '17:00', 'TUE', to_date('17-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (534, '20:00', 'TUE', to_date('17-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (535, '23:00', 'TUE', to_date('17-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (536, '14:00', 'WED', to_date('18-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (537, '17:00', 'WED', to_date('18-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (538, '20:00', 'WED', to_date('18-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (539, '23:00', 'WED', to_date('18-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (540, '14:00', 'THU', to_date('19-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (541, '17:00', 'THU', to_date('19-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (542, '20:00', 'THU', to_date('19-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (543, '23:00', 'THU', to_date('19-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (544, '14:00', 'FRI', to_date('20-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (545, '17:00', 'FRI', to_date('20-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (546, '20:00', 'FRI', to_date('20-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (547, '23:00', 'FRI', to_date('20-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (548, '14:00', 'SAT', to_date('21-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (549, '17:00', 'SAT', to_date('21-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (550, '20:00', 'SAT', to_date('21-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (551, '23:00', 'SAT', to_date('21-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (552, '14:00', 'SUN', to_date('22-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (553, '17:00', 'SUN', to_date('22-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (554, '20:00', 'SUN', to_date('22-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (555, '23:00', 'SUN', to_date('22-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (556, '14:00', 'MON', to_date('23-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (557, '17:00', 'MON', to_date('23-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (558, '20:00', 'MON', to_date('23-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (559, '23:00', 'MON', to_date('23-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (560, '14:00', 'TUE', to_date('24-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (561, '17:00', 'TUE', to_date('24-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (562, '20:00', 'TUE', to_date('24-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (563, '23:00', 'TUE', to_date('24-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (564, '14:00', 'WED', to_date('25-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (565, '17:00', 'WED', to_date('25-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (566, '20:00', 'WED', to_date('25-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (567, '23:00', 'WED', to_date('25-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (568, '14:00', 'THU', to_date('26-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (569, '17:00', 'THU', to_date('26-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (570, '20:00', 'THU', to_date('26-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (571, '23:00', 'THU', to_date('26-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (572, '14:00', 'FRI', to_date('27-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (573, '17:00', 'FRI', to_date('27-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (574, '20:00', 'FRI', to_date('27-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (575, '23:00', 'FRI', to_date('27-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (576, '14:00', 'SAT', to_date('28-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (577, '17:00', 'SAT', to_date('28-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (578, '20:00', 'SAT', to_date('28-09-2024', 'dd-mm-yyyy'));
insert into DATES (dateid, hourh, dayd, dated)
values (579, '23:00', 'SAT', to_date('28-09-2024', 'dd-mm-yyyy'));
commit;
prompt 480 records loaded
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
prompt Loading ORDERS...
insert into ORDERS (order_id, order_date, dellivery_date)
values (493, to_date('25-03-2025', 'dd-mm-yyyy'), to_date('03-06-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (377, to_date('04-02-2026', 'dd-mm-yyyy'), to_date('23-05-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (323, to_date('12-06-2026', 'dd-mm-yyyy'), to_date('10-04-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (703, to_date('12-08-2025', 'dd-mm-yyyy'), to_date('24-12-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (350, to_date('08-04-2025', 'dd-mm-yyyy'), to_date('14-11-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (991, to_date('10-04-2026', 'dd-mm-yyyy'), to_date('25-09-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (641, to_date('25-07-2026', 'dd-mm-yyyy'), to_date('27-09-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (490, to_date('07-10-2030', 'dd-mm-yyyy'), to_date('30-03-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (174, to_date('20-01-2028', 'dd-mm-yyyy'), to_date('15-06-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (261, to_date('11-07-2030', 'dd-mm-yyyy'), to_date('24-02-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (352, to_date('22-08-2029', 'dd-mm-yyyy'), to_date('09-10-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (910, to_date('03-04-2030', 'dd-mm-yyyy'), to_date('20-06-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (947, to_date('12-06-2026', 'dd-mm-yyyy'), to_date('25-06-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (553, to_date('18-10-2028', 'dd-mm-yyyy'), to_date('19-02-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (120, to_date('28-09-2026', 'dd-mm-yyyy'), to_date('21-11-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (473, to_date('04-01-2029', 'dd-mm-yyyy'), to_date('23-10-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (702, to_date('29-11-2028', 'dd-mm-yyyy'), to_date('21-12-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (984, to_date('09-11-2024', 'dd-mm-yyyy'), to_date('13-04-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (567, to_date('14-11-2029', 'dd-mm-yyyy'), to_date('24-01-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (309, to_date('26-02-2025', 'dd-mm-yyyy'), to_date('20-04-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (577, to_date('10-03-2028', 'dd-mm-yyyy'), to_date('19-10-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (890, to_date('25-09-2030', 'dd-mm-yyyy'), to_date('28-07-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (889, to_date('06-03-2027', 'dd-mm-yyyy'), to_date('01-05-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (945, to_date('12-11-2024', 'dd-mm-yyyy'), to_date('22-05-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (388, to_date('12-10-2024', 'dd-mm-yyyy'), to_date('12-12-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (201, to_date('18-02-2026', 'dd-mm-yyyy'), to_date('08-11-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (610, to_date('04-04-2025', 'dd-mm-yyyy'), to_date('21-11-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (692, to_date('04-02-2025', 'dd-mm-yyyy'), to_date('21-12-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (572, to_date('07-05-2027', 'dd-mm-yyyy'), to_date('06-03-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (185, to_date('26-12-2029', 'dd-mm-yyyy'), to_date('01-09-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (835, to_date('17-12-2027', 'dd-mm-yyyy'), to_date('12-10-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (611, to_date('01-12-2030', 'dd-mm-yyyy'), to_date('18-05-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (320, to_date('04-01-2024', 'dd-mm-yyyy'), to_date('02-05-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (381, to_date('23-03-2027', 'dd-mm-yyyy'), to_date('21-06-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (514, to_date('21-05-2028', 'dd-mm-yyyy'), to_date('13-12-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (361, to_date('02-07-2027', 'dd-mm-yyyy'), to_date('09-12-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (892, to_date('29-10-2028', 'dd-mm-yyyy'), to_date('24-12-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (246, to_date('11-08-2026', 'dd-mm-yyyy'), to_date('20-07-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (181, to_date('16-08-2030', 'dd-mm-yyyy'), to_date('22-01-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (191, to_date('08-09-2030', 'dd-mm-yyyy'), to_date('03-05-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (432, to_date('11-10-2028', 'dd-mm-yyyy'), to_date('13-10-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (998, to_date('14-01-2027', 'dd-mm-yyyy'), to_date('17-10-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (124, to_date('17-01-2027', 'dd-mm-yyyy'), to_date('19-06-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (561, to_date('14-03-2025', 'dd-mm-yyyy'), to_date('31-08-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (657, to_date('25-12-2025', 'dd-mm-yyyy'), to_date('19-04-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (233, to_date('06-09-2030', 'dd-mm-yyyy'), to_date('12-04-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (540, to_date('18-01-2029', 'dd-mm-yyyy'), to_date('12-04-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (734, to_date('26-02-2030', 'dd-mm-yyyy'), to_date('19-01-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (178, to_date('19-06-2028', 'dd-mm-yyyy'), to_date('14-11-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (961, to_date('08-12-2030', 'dd-mm-yyyy'), to_date('21-05-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (877, to_date('12-01-2025', 'dd-mm-yyyy'), to_date('07-11-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (302, to_date('19-12-2027', 'dd-mm-yyyy'), to_date('02-01-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (502, to_date('13-01-2028', 'dd-mm-yyyy'), to_date('12-12-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (249, to_date('22-11-2025', 'dd-mm-yyyy'), to_date('11-03-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (665, to_date('17-06-2030', 'dd-mm-yyyy'), to_date('16-10-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (299, to_date('04-08-2027', 'dd-mm-yyyy'), to_date('15-03-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (565, to_date('14-01-2024', 'dd-mm-yyyy'), to_date('12-04-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (897, to_date('19-12-2024', 'dd-mm-yyyy'), to_date('07-07-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (272, to_date('16-02-2024', 'dd-mm-yyyy'), to_date('31-03-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (723, to_date('09-08-2026', 'dd-mm-yyyy'), to_date('22-01-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (331, to_date('29-04-2025', 'dd-mm-yyyy'), to_date('25-03-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (902, to_date('03-05-2024', 'dd-mm-yyyy'), to_date('22-10-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (422, to_date('19-09-2030', 'dd-mm-yyyy'), to_date('04-12-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (186, to_date('09-08-2026', 'dd-mm-yyyy'), to_date('28-03-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (656, to_date('27-11-2027', 'dd-mm-yyyy'), to_date('30-03-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (626, to_date('23-02-2027', 'dd-mm-yyyy'), to_date('20-12-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (557, to_date('06-04-2028', 'dd-mm-yyyy'), to_date('12-03-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (667, to_date('19-10-2025', 'dd-mm-yyyy'), to_date('13-07-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (737, to_date('28-05-2024', 'dd-mm-yyyy'), to_date('24-07-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (159, to_date('14-07-2030', 'dd-mm-yyyy'), to_date('28-03-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (704, to_date('04-02-2027', 'dd-mm-yyyy'), to_date('31-01-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (597, to_date('12-11-2030', 'dd-mm-yyyy'), to_date('29-03-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (175, to_date('10-04-2025', 'dd-mm-yyyy'), to_date('01-11-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (827, to_date('03-07-2029', 'dd-mm-yyyy'), to_date('25-09-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (354, to_date('22-11-2026', 'dd-mm-yyyy'), to_date('04-11-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (479, to_date('17-12-2025', 'dd-mm-yyyy'), to_date('26-12-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (555, to_date('20-03-2024', 'dd-mm-yyyy'), to_date('22-04-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (893, to_date('28-08-2026', 'dd-mm-yyyy'), to_date('14-08-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (927, to_date('10-08-2027', 'dd-mm-yyyy'), to_date('16-07-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (601, to_date('08-10-2024', 'dd-mm-yyyy'), to_date('04-08-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (130, to_date('05-05-2024', 'dd-mm-yyyy'), to_date('18-02-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (444, to_date('24-07-2025', 'dd-mm-yyyy'), to_date('11-08-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (318, to_date('30-09-2029', 'dd-mm-yyyy'), to_date('03-06-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (139, to_date('14-03-2029', 'dd-mm-yyyy'), to_date('25-01-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (764, to_date('27-04-2030', 'dd-mm-yyyy'), to_date('08-02-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (996, to_date('12-08-2026', 'dd-mm-yyyy'), to_date('09-10-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (362, to_date('13-02-2025', 'dd-mm-yyyy'), to_date('15-12-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (154, to_date('22-06-2024', 'dd-mm-yyyy'), to_date('29-04-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (110, to_date('23-08-2027', 'dd-mm-yyyy'), to_date('11-11-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (211, to_date('02-10-2029', 'dd-mm-yyyy'), to_date('10-12-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (946, to_date('21-09-2025', 'dd-mm-yyyy'), to_date('07-06-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (198, to_date('30-05-2025', 'dd-mm-yyyy'), to_date('13-12-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (859, to_date('14-12-2028', 'dd-mm-yyyy'), to_date('29-10-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (495, to_date('22-11-2024', 'dd-mm-yyyy'), to_date('24-04-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (418, to_date('03-05-2027', 'dd-mm-yyyy'), to_date('23-10-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (617, to_date('18-02-2024', 'dd-mm-yyyy'), to_date('27-02-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (804, to_date('13-09-2027', 'dd-mm-yyyy'), to_date('18-06-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (833, to_date('15-05-2025', 'dd-mm-yyyy'), to_date('10-12-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (786, to_date('24-03-2025', 'dd-mm-yyyy'), to_date('02-02-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (142, to_date('26-06-2026', 'dd-mm-yyyy'), to_date('03-02-2025', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into ORDERS (order_id, order_date, dellivery_date)
values (145, to_date('31-08-2024', 'dd-mm-yyyy'), to_date('22-04-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (571, to_date('21-12-2029', 'dd-mm-yyyy'), to_date('01-02-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (642, to_date('31-01-2024', 'dd-mm-yyyy'), to_date('02-04-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (808, to_date('07-01-2026', 'dd-mm-yyyy'), to_date('15-02-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (390, to_date('08-09-2030', 'dd-mm-yyyy'), to_date('21-11-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (599, to_date('11-10-2029', 'dd-mm-yyyy'), to_date('28-03-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (630, to_date('08-07-2028', 'dd-mm-yyyy'), to_date('09-02-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (471, to_date('16-10-2029', 'dd-mm-yyyy'), to_date('08-04-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (438, to_date('23-09-2027', 'dd-mm-yyyy'), to_date('06-12-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (795, to_date('15-05-2030', 'dd-mm-yyyy'), to_date('26-12-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (821, to_date('05-11-2027', 'dd-mm-yyyy'), to_date('09-06-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (148, to_date('13-10-2028', 'dd-mm-yyyy'), to_date('28-11-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (644, to_date('07-06-2024', 'dd-mm-yyyy'), to_date('20-05-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (632, to_date('04-12-2024', 'dd-mm-yyyy'), to_date('01-06-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (164, to_date('29-02-2024', 'dd-mm-yyyy'), to_date('29-12-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (861, to_date('08-08-2028', 'dd-mm-yyyy'), to_date('28-05-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (904, to_date('30-06-2026', 'dd-mm-yyyy'), to_date('03-03-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (823, to_date('14-03-2025', 'dd-mm-yyyy'), to_date('06-05-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (909, to_date('19-09-2030', 'dd-mm-yyyy'), to_date('27-09-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (541, to_date('21-07-2030', 'dd-mm-yyyy'), to_date('18-03-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (433, to_date('06-08-2027', 'dd-mm-yyyy'), to_date('03-09-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (921, to_date('04-09-2030', 'dd-mm-yyyy'), to_date('01-08-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (281, to_date('09-04-2030', 'dd-mm-yyyy'), to_date('14-06-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (177, to_date('06-06-2029', 'dd-mm-yyyy'), to_date('19-02-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (615, to_date('10-01-2030', 'dd-mm-yyyy'), to_date('08-02-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (105, to_date('13-11-2028', 'dd-mm-yyyy'), to_date('24-04-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (170, to_date('15-08-2027', 'dd-mm-yyyy'), to_date('07-04-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (822, to_date('04-11-2026', 'dd-mm-yyyy'), to_date('04-04-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (531, to_date('15-08-2026', 'dd-mm-yyyy'), to_date('06-01-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (819, to_date('25-11-2027', 'dd-mm-yyyy'), to_date('08-05-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (321, to_date('05-07-2024', 'dd-mm-yyyy'), to_date('28-11-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (366, to_date('23-10-2026', 'dd-mm-yyyy'), to_date('23-02-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (404, to_date('16-10-2024', 'dd-mm-yyyy'), to_date('20-03-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (847, to_date('03-09-2030', 'dd-mm-yyyy'), to_date('01-07-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (383, to_date('02-06-2027', 'dd-mm-yyyy'), to_date('21-03-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (535, to_date('19-01-2030', 'dd-mm-yyyy'), to_date('22-02-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (428, to_date('30-12-2028', 'dd-mm-yyyy'), to_date('10-09-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (633, to_date('03-02-2030', 'dd-mm-yyyy'), to_date('02-07-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (343, to_date('06-09-2025', 'dd-mm-yyyy'), to_date('15-07-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (828, to_date('27-12-2026', 'dd-mm-yyyy'), to_date('07-07-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (922, to_date('29-05-2030', 'dd-mm-yyyy'), to_date('12-11-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (461, to_date('06-02-2026', 'dd-mm-yyyy'), to_date('26-12-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (592, to_date('13-01-2028', 'dd-mm-yyyy'), to_date('26-09-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (720, to_date('05-10-2027', 'dd-mm-yyyy'), to_date('26-07-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (651, to_date('07-10-2026', 'dd-mm-yyyy'), to_date('31-05-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (417, to_date('22-02-2024', 'dd-mm-yyyy'), to_date('16-03-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (574, to_date('10-08-2027', 'dd-mm-yyyy'), to_date('15-10-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (332, to_date('03-04-2028', 'dd-mm-yyyy'), to_date('26-08-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (439, to_date('08-07-2025', 'dd-mm-yyyy'), to_date('09-09-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (269, to_date('10-07-2030', 'dd-mm-yyyy'), to_date('15-12-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (138, to_date('17-05-2028', 'dd-mm-yyyy'), to_date('11-04-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (287, to_date('16-10-2026', 'dd-mm-yyyy'), to_date('13-03-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (721, to_date('27-05-2026', 'dd-mm-yyyy'), to_date('14-06-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (956, to_date('29-07-2025', 'dd-mm-yyyy'), to_date('19-11-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (367, to_date('28-09-2024', 'dd-mm-yyyy'), to_date('13-06-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (391, to_date('12-05-2027', 'dd-mm-yyyy'), to_date('26-03-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (886, to_date('22-11-2030', 'dd-mm-yyyy'), to_date('05-01-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (414, to_date('07-10-2026', 'dd-mm-yyyy'), to_date('20-07-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (815, to_date('15-05-2026', 'dd-mm-yyyy'), to_date('02-06-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (442, to_date('01-01-2030', 'dd-mm-yyyy'), to_date('12-07-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (590, to_date('15-03-2030', 'dd-mm-yyyy'), to_date('02-10-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (691, to_date('07-10-2026', 'dd-mm-yyyy'), to_date('21-03-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (445, to_date('08-04-2024', 'dd-mm-yyyy'), to_date('07-07-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (997, to_date('03-05-2027', 'dd-mm-yyyy'), to_date('01-11-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (265, to_date('30-06-2029', 'dd-mm-yyyy'), to_date('13-11-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (675, to_date('06-07-2027', 'dd-mm-yyyy'), to_date('06-05-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (166, to_date('23-09-2028', 'dd-mm-yyyy'), to_date('10-02-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (791, to_date('13-11-2028', 'dd-mm-yyyy'), to_date('11-07-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (271, to_date('12-08-2029', 'dd-mm-yyyy'), to_date('28-12-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (730, to_date('01-04-2028', 'dd-mm-yyyy'), to_date('30-10-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (208, to_date('10-08-2025', 'dd-mm-yyyy'), to_date('16-09-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (206, to_date('22-09-2029', 'dd-mm-yyyy'), to_date('07-10-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (221, to_date('29-11-2030', 'dd-mm-yyyy'), to_date('16-08-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (923, to_date('22-01-2025', 'dd-mm-yyyy'), to_date('18-02-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (371, to_date('12-02-2029', 'dd-mm-yyyy'), to_date('01-08-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (593, to_date('03-04-2027', 'dd-mm-yyyy'), to_date('16-02-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (549, to_date('10-08-2029', 'dd-mm-yyyy'), to_date('18-08-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (256, to_date('28-07-2028', 'dd-mm-yyyy'), to_date('03-03-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (908, to_date('27-03-2025', 'dd-mm-yyyy'), to_date('23-09-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (983, to_date('13-11-2029', 'dd-mm-yyyy'), to_date('11-02-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (396, to_date('15-11-2026', 'dd-mm-yyyy'), to_date('18-02-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (131, to_date('07-12-2030', 'dd-mm-yyyy'), to_date('06-12-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (727, to_date('01-04-2028', 'dd-mm-yyyy'), to_date('12-09-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (763, to_date('31-12-2028', 'dd-mm-yyyy'), to_date('26-06-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (436, to_date('29-06-2030', 'dd-mm-yyyy'), to_date('27-11-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (776, to_date('30-04-2026', 'dd-mm-yyyy'), to_date('12-08-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (635, to_date('24-09-2027', 'dd-mm-yyyy'), to_date('06-12-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (300, to_date('01-01-2027', 'dd-mm-yyyy'), to_date('11-08-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (560, to_date('25-09-2024', 'dd-mm-yyyy'), to_date('21-05-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (266, to_date('23-11-2030', 'dd-mm-yyyy'), to_date('22-05-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (194, to_date('29-03-2030', 'dd-mm-yyyy'), to_date('21-05-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (147, to_date('15-08-2029', 'dd-mm-yyyy'), to_date('28-07-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (515, to_date('18-08-2024', 'dd-mm-yyyy'), to_date('29-07-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (212, to_date('10-01-2025', 'dd-mm-yyyy'), to_date('24-01-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (504, to_date('27-09-2027', 'dd-mm-yyyy'), to_date('31-10-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (739, to_date('15-08-2028', 'dd-mm-yyyy'), to_date('04-07-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (547, to_date('02-07-2027', 'dd-mm-yyyy'), to_date('19-02-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (778, to_date('07-11-2027', 'dd-mm-yyyy'), to_date('11-04-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (724, to_date('10-09-2028', 'dd-mm-yyyy'), to_date('17-05-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (943, to_date('02-03-2030', 'dd-mm-yyyy'), to_date('12-06-2030', 'dd-mm-yyyy'));
commit;
prompt 200 records committed...
insert into ORDERS (order_id, order_date, dellivery_date)
values (687, to_date('01-01-2026', 'dd-mm-yyyy'), to_date('25-05-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (386, to_date('07-03-2029', 'dd-mm-yyyy'), to_date('04-08-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (802, to_date('08-02-2025', 'dd-mm-yyyy'), to_date('03-10-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (918, to_date('15-02-2027', 'dd-mm-yyyy'), to_date('05-07-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (772, to_date('13-03-2027', 'dd-mm-yyyy'), to_date('16-09-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (986, to_date('24-06-2026', 'dd-mm-yyyy'), to_date('20-11-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (389, to_date('19-06-2025', 'dd-mm-yyyy'), to_date('03-03-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (406, to_date('07-11-2025', 'dd-mm-yyyy'), to_date('02-01-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (885, to_date('16-06-2027', 'dd-mm-yyyy'), to_date('26-03-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (411, to_date('29-12-2026', 'dd-mm-yyyy'), to_date('11-02-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (334, to_date('31-12-2026', 'dd-mm-yyyy'), to_date('17-07-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (342, to_date('06-05-2026', 'dd-mm-yyyy'), to_date('03-09-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (351, to_date('12-10-2025', 'dd-mm-yyyy'), to_date('22-02-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (474, to_date('09-09-2030', 'dd-mm-yyyy'), to_date('01-08-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (385, to_date('18-08-2029', 'dd-mm-yyyy'), to_date('26-06-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (942, to_date('28-08-2024', 'dd-mm-yyyy'), to_date('16-10-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (579, to_date('17-02-2028', 'dd-mm-yyyy'), to_date('18-06-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (653, to_date('15-05-2030', 'dd-mm-yyyy'), to_date('23-12-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (792, to_date('28-12-2028', 'dd-mm-yyyy'), to_date('20-11-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (277, to_date('10-08-2024', 'dd-mm-yyyy'), to_date('20-05-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (989, to_date('06-09-2027', 'dd-mm-yyyy'), to_date('18-01-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (842, to_date('03-07-2027', 'dd-mm-yyyy'), to_date('17-02-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (525, to_date('07-10-2024', 'dd-mm-yyyy'), to_date('25-12-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (279, to_date('16-06-2026', 'dd-mm-yyyy'), to_date('21-08-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (403, to_date('11-06-2030', 'dd-mm-yyyy'), to_date('08-12-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (307, to_date('20-03-2028', 'dd-mm-yyyy'), to_date('18-07-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (668, to_date('31-01-2026', 'dd-mm-yyyy'), to_date('04-10-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (275, to_date('17-12-2024', 'dd-mm-yyyy'), to_date('21-05-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (780, to_date('18-09-2028', 'dd-mm-yyyy'), to_date('11-04-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (491, to_date('03-03-2026', 'dd-mm-yyyy'), to_date('16-07-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (950, to_date('20-06-2024', 'dd-mm-yyyy'), to_date('13-05-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (603, to_date('28-01-2024', 'dd-mm-yyyy'), to_date('15-12-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (907, to_date('11-10-2027', 'dd-mm-yyyy'), to_date('22-02-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (330, to_date('27-06-2024', 'dd-mm-yyyy'), to_date('22-07-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (824, to_date('09-07-2025', 'dd-mm-yyyy'), to_date('24-10-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (775, to_date('21-05-2026', 'dd-mm-yyyy'), to_date('03-07-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (582, to_date('22-08-2025', 'dd-mm-yyyy'), to_date('20-12-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (933, to_date('10-04-2030', 'dd-mm-yyyy'), to_date('26-06-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (755, to_date('22-06-2027', 'dd-mm-yyyy'), to_date('04-12-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (167, to_date('12-02-2027', 'dd-mm-yyyy'), to_date('25-09-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (883, to_date('11-11-2028', 'dd-mm-yyyy'), to_date('06-05-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (475, to_date('16-02-2028', 'dd-mm-yyyy'), to_date('08-06-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (762, to_date('11-03-2026', 'dd-mm-yyyy'), to_date('16-06-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (584, to_date('04-02-2026', 'dd-mm-yyyy'), to_date('26-01-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (259, to_date('24-04-2029', 'dd-mm-yyyy'), to_date('28-09-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (311, to_date('21-06-2024', 'dd-mm-yyyy'), to_date('30-01-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (313, to_date('19-10-2024', 'dd-mm-yyyy'), to_date('21-08-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (232, to_date('10-10-2027', 'dd-mm-yyyy'), to_date('19-11-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (220, to_date('14-12-2027', 'dd-mm-yyyy'), to_date('13-03-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (505, to_date('28-08-2026', 'dd-mm-yyyy'), to_date('03-09-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (870, to_date('27-05-2029', 'dd-mm-yyyy'), to_date('15-08-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (210, to_date('15-05-2030', 'dd-mm-yyyy'), to_date('08-10-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (638, to_date('23-03-2028', 'dd-mm-yyyy'), to_date('15-12-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (643, to_date('01-01-2028', 'dd-mm-yyyy'), to_date('13-10-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (676, to_date('14-02-2026', 'dd-mm-yyyy'), to_date('23-08-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (234, to_date('20-04-2030', 'dd-mm-yyyy'), to_date('15-12-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (423, to_date('08-07-2027', 'dd-mm-yyyy'), to_date('28-05-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (978, to_date('10-02-2026', 'dd-mm-yyyy'), to_date('27-11-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (747, to_date('03-11-2027', 'dd-mm-yyyy'), to_date('31-08-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (533, to_date('25-09-2029', 'dd-mm-yyyy'), to_date('24-06-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (470, to_date('19-08-2029', 'dd-mm-yyyy'), to_date('14-04-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (420, to_date('07-04-2025', 'dd-mm-yyyy'), to_date('31-03-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (750, to_date('09-01-2029', 'dd-mm-yyyy'), to_date('29-12-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (180, to_date('27-07-2030', 'dd-mm-yyyy'), to_date('19-03-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (122, to_date('29-07-2025', 'dd-mm-yyyy'), to_date('31-12-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (696, to_date('16-08-2026', 'dd-mm-yyyy'), to_date('06-10-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (112, to_date('03-06-2025', 'dd-mm-yyyy'), to_date('24-04-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (619, to_date('02-11-2029', 'dd-mm-yyyy'), to_date('18-10-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (710, to_date('24-06-2025', 'dd-mm-yyyy'), to_date('01-08-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (880, to_date('06-07-2028', 'dd-mm-yyyy'), to_date('19-11-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (508, to_date('09-04-2030', 'dd-mm-yyyy'), to_date('07-11-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (322, to_date('02-04-2028', 'dd-mm-yyyy'), to_date('18-01-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (757, to_date('03-12-2026', 'dd-mm-yyyy'), to_date('08-02-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (782, to_date('18-02-2030', 'dd-mm-yyyy'), to_date('27-05-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (450, to_date('15-09-2028', 'dd-mm-yyyy'), to_date('04-09-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (543, to_date('11-08-2028', 'dd-mm-yyyy'), to_date('12-03-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (783, to_date('11-11-2024', 'dd-mm-yyyy'), to_date('20-09-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (111, to_date('08-05-2027', 'dd-mm-yyyy'), to_date('20-09-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (928, to_date('07-04-2024', 'dd-mm-yyyy'), to_date('17-02-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (817, to_date('06-12-2030', 'dd-mm-yyyy'), to_date('06-02-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (335, to_date('23-01-2024', 'dd-mm-yyyy'), to_date('27-03-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (580, to_date('28-05-2026', 'dd-mm-yyyy'), to_date('10-07-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (620, to_date('24-08-2025', 'dd-mm-yyyy'), to_date('12-02-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (912, to_date('01-10-2024', 'dd-mm-yyyy'), to_date('11-03-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (219, to_date('13-03-2030', 'dd-mm-yyyy'), to_date('03-09-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (213, to_date('17-11-2026', 'dd-mm-yyyy'), to_date('13-05-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (301, to_date('23-07-2027', 'dd-mm-yyyy'), to_date('24-01-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (679, to_date('05-06-2029', 'dd-mm-yyyy'), to_date('20-12-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (754, to_date('05-01-2024', 'dd-mm-yyyy'), to_date('22-06-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (106, to_date('13-09-2026', 'dd-mm-yyyy'), to_date('06-04-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (729, to_date('07-09-2028', 'dd-mm-yyyy'), to_date('06-07-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (230, to_date('22-01-2028', 'dd-mm-yyyy'), to_date('15-05-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (845, to_date('16-02-2027', 'dd-mm-yyyy'), to_date('21-07-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (865, to_date('08-10-2027', 'dd-mm-yyyy'), to_date('27-08-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (973, to_date('06-10-2027', 'dd-mm-yyyy'), to_date('27-10-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (340, to_date('14-06-2026', 'dd-mm-yyyy'), to_date('30-01-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (929, to_date('09-10-2028', 'dd-mm-yyyy'), to_date('08-02-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (830, to_date('19-10-2024', 'dd-mm-yyyy'), to_date('28-05-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (876, to_date('22-07-2026', 'dd-mm-yyyy'), to_date('21-05-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (853, to_date('21-04-2026', 'dd-mm-yyyy'), to_date('10-01-2027', 'dd-mm-yyyy'));
commit;
prompt 300 records committed...
insert into ORDERS (order_id, order_date, dellivery_date)
values (875, to_date('30-08-2025', 'dd-mm-yyyy'), to_date('26-12-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (708, to_date('20-11-2026', 'dd-mm-yyyy'), to_date('31-12-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (183, to_date('12-12-2024', 'dd-mm-yyyy'), to_date('10-08-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (766, to_date('04-06-2027', 'dd-mm-yyyy'), to_date('15-08-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (806, to_date('19-04-2030', 'dd-mm-yyyy'), to_date('06-10-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (500, to_date('20-05-2025', 'dd-mm-yyyy'), to_date('20-01-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (200, to_date('28-02-2027', 'dd-mm-yyyy'), to_date('02-06-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (589, to_date('24-03-2026', 'dd-mm-yyyy'), to_date('29-08-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (327, to_date('25-02-2029', 'dd-mm-yyyy'), to_date('23-03-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (393, to_date('21-05-2024', 'dd-mm-yyyy'), to_date('09-12-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (891, to_date('12-05-2026', 'dd-mm-yyyy'), to_date('15-08-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (238, to_date('02-02-2027', 'dd-mm-yyyy'), to_date('27-07-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (848, to_date('10-06-2026', 'dd-mm-yyyy'), to_date('14-03-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (609, to_date('14-06-2024', 'dd-mm-yyyy'), to_date('17-05-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (878, to_date('13-08-2029', 'dd-mm-yyyy'), to_date('13-07-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (316, to_date('06-02-2024', 'dd-mm-yyyy'), to_date('04-08-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (437, to_date('30-07-2030', 'dd-mm-yyyy'), to_date('08-11-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (966, to_date('02-05-2030', 'dd-mm-yyyy'), to_date('17-05-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (192, to_date('24-04-2030', 'dd-mm-yyyy'), to_date('23-11-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (429, to_date('09-05-2029', 'dd-mm-yyyy'), to_date('14-12-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (604, to_date('10-10-2030', 'dd-mm-yyyy'), to_date('06-01-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (295, to_date('05-03-2029', 'dd-mm-yyyy'), to_date('13-11-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (336, to_date('04-06-2028', 'dd-mm-yyyy'), to_date('22-03-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (622, to_date('28-02-2026', 'dd-mm-yyyy'), to_date('24-11-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (225, to_date('29-03-2029', 'dd-mm-yyyy'), to_date('15-03-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (476, to_date('05-05-2027', 'dd-mm-yyyy'), to_date('15-12-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (982, to_date('03-09-2028', 'dd-mm-yyyy'), to_date('15-01-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (162, to_date('19-08-2025', 'dd-mm-yyyy'), to_date('24-05-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (965, to_date('17-01-2028', 'dd-mm-yyyy'), to_date('14-09-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (748, to_date('11-06-2024', 'dd-mm-yyyy'), to_date('22-02-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (224, to_date('03-03-2028', 'dd-mm-yyyy'), to_date('26-09-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (736, to_date('18-08-2029', 'dd-mm-yyyy'), to_date('07-11-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (628, to_date('14-09-2029', 'dd-mm-yyyy'), to_date('22-06-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (395, to_date('20-09-2024', 'dd-mm-yyyy'), to_date('28-10-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (264, to_date('30-12-2026', 'dd-mm-yyyy'), to_date('20-08-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (134, to_date('16-04-2028', 'dd-mm-yyyy'), to_date('15-01-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (977, to_date('08-03-2024', 'dd-mm-yyyy'), to_date('11-10-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (135, to_date('15-04-2024', 'dd-mm-yyyy'), to_date('21-08-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (359, to_date('01-02-2030', 'dd-mm-yyyy'), to_date('02-08-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (992, to_date('08-10-2030', 'dd-mm-yyyy'), to_date('29-08-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (409, to_date('04-04-2024', 'dd-mm-yyyy'), to_date('19-03-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (137, to_date('21-11-2030', 'dd-mm-yyyy'), to_date('03-07-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (937, to_date('17-08-2026', 'dd-mm-yyyy'), to_date('23-03-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (732, to_date('13-08-2024', 'dd-mm-yyyy'), to_date('20-05-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (979, to_date('17-02-2027', 'dd-mm-yyyy'), to_date('02-04-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (293, to_date('25-05-2030', 'dd-mm-yyyy'), to_date('28-10-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (421, to_date('20-03-2025', 'dd-mm-yyyy'), to_date('13-06-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (425, to_date('20-09-2024', 'dd-mm-yyyy'), to_date('08-10-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (163, to_date('27-05-2024', 'dd-mm-yyyy'), to_date('19-12-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (868, to_date('20-10-2025', 'dd-mm-yyyy'), to_date('14-09-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (378, to_date('22-06-2025', 'dd-mm-yyyy'), to_date('25-12-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (468, to_date('01-05-2030', 'dd-mm-yyyy'), to_date('24-02-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (963, to_date('01-01-2026', 'dd-mm-yyyy'), to_date('07-08-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (990, to_date('11-05-2027', 'dd-mm-yyyy'), to_date('29-05-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (852, to_date('08-05-2026', 'dd-mm-yyyy'), to_date('25-06-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (814, to_date('13-10-2030', 'dd-mm-yyyy'), to_date('01-03-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (749, to_date('25-08-2027', 'dd-mm-yyyy'), to_date('22-07-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (756, to_date('10-10-2029', 'dd-mm-yyyy'), to_date('14-01-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (133, to_date('09-01-2028', 'dd-mm-yyyy'), to_date('13-06-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (681, to_date('14-10-2026', 'dd-mm-yyyy'), to_date('15-10-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (310, to_date('23-11-2026', 'dd-mm-yyyy'), to_date('11-03-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (101, to_date('06-07-2027', 'dd-mm-yyyy'), to_date('03-07-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (204, to_date('05-07-2029', 'dd-mm-yyyy'), to_date('15-10-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (701, to_date('24-03-2030', 'dd-mm-yyyy'), to_date('13-11-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (305, to_date('17-03-2027', 'dd-mm-yyyy'), to_date('19-11-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (315, to_date('22-10-2027', 'dd-mm-yyyy'), to_date('11-08-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (683, to_date('07-09-2026', 'dd-mm-yyyy'), to_date('05-11-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (744, to_date('16-05-2028', 'dd-mm-yyyy'), to_date('18-07-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (496, to_date('23-02-2028', 'dd-mm-yyyy'), to_date('23-02-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (627, to_date('20-01-2026', 'dd-mm-yyyy'), to_date('10-02-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (777, to_date('18-06-2028', 'dd-mm-yyyy'), to_date('26-03-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (410, to_date('08-11-2030', 'dd-mm-yyyy'), to_date('16-03-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (158, to_date('11-08-2027', 'dd-mm-yyyy'), to_date('18-09-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (844, to_date('04-11-2024', 'dd-mm-yyyy'), to_date('08-09-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (339, to_date('23-10-2025', 'dd-mm-yyyy'), to_date('23-11-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (440, to_date('20-02-2024', 'dd-mm-yyyy'), to_date('09-08-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (326, to_date('15-09-2027', 'dd-mm-yyyy'), to_date('07-11-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (836, to_date('12-07-2028', 'dd-mm-yyyy'), to_date('20-04-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (706, to_date('31-05-2025', 'dd-mm-yyyy'), to_date('08-05-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (270, to_date('05-06-2029', 'dd-mm-yyyy'), to_date('16-11-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (647, to_date('05-09-2025', 'dd-mm-yyyy'), to_date('17-05-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (854, to_date('27-07-2028', 'dd-mm-yyyy'), to_date('12-01-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (104, to_date('19-10-2028', 'dd-mm-yyyy'), to_date('07-11-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (497, to_date('11-06-2030', 'dd-mm-yyyy'), to_date('26-06-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (569, to_date('27-11-2030', 'dd-mm-yyyy'), to_date('29-03-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (753, to_date('22-10-2030', 'dd-mm-yyyy'), to_date('01-01-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (894, to_date('28-09-2030', 'dd-mm-yyyy'), to_date('13-09-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (109, to_date('01-05-2026', 'dd-mm-yyyy'), to_date('29-01-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (700, to_date('04-10-2025', 'dd-mm-yyyy'), to_date('09-02-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (813, to_date('10-03-2026', 'dd-mm-yyyy'), to_date('26-03-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (304, to_date('15-10-2027', 'dd-mm-yyyy'), to_date('16-03-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (826, to_date('02-03-2026', 'dd-mm-yyyy'), to_date('02-02-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (725, to_date('13-10-2029', 'dd-mm-yyyy'), to_date('29-01-2030', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (849, to_date('12-06-2024', 'dd-mm-yyyy'), to_date('12-06-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (462, to_date('21-03-2026', 'dd-mm-yyyy'), to_date('17-04-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (273, to_date('28-05-2025', 'dd-mm-yyyy'), to_date('24-03-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (645, to_date('03-08-2026', 'dd-mm-yyyy'), to_date('03-06-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (478, to_date('26-05-2028', 'dd-mm-yyyy'), to_date('18-05-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (798, to_date('16-04-2030', 'dd-mm-yyyy'), to_date('21-03-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (745, to_date('19-10-2030', 'dd-mm-yyyy'), to_date('12-12-2027', 'dd-mm-yyyy'));
commit;
prompt 400 records committed...
insert into ORDERS (order_id, order_date, dellivery_date)
values (914, to_date('08-06-2027', 'dd-mm-yyyy'), to_date('11-09-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (387, to_date('21-07-2026', 'dd-mm-yyyy'), to_date('31-07-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (608, to_date('03-03-2026', 'dd-mm-yyyy'), to_date('02-06-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (959, to_date('24-06-2026', 'dd-mm-yyyy'), to_date('26-07-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (537, to_date('26-11-2028', 'dd-mm-yyyy'), to_date('24-08-2024', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (670, to_date('04-04-2029', 'dd-mm-yyyy'), to_date('17-07-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (867, to_date('01-11-2026', 'dd-mm-yyyy'), to_date('25-06-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (650, to_date('25-05-2030', 'dd-mm-yyyy'), to_date('16-01-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (678, to_date('19-07-2026', 'dd-mm-yyyy'), to_date('29-01-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (536, to_date('09-07-2027', 'dd-mm-yyyy'), to_date('25-03-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (714, to_date('08-09-2028', 'dd-mm-yyyy'), to_date('03-09-2029', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (556, to_date('26-06-2029', 'dd-mm-yyyy'), to_date('07-05-2028', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (831, to_date('26-03-2027', 'dd-mm-yyyy'), to_date('28-06-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (716, to_date('30-12-2030', 'dd-mm-yyyy'), to_date('15-07-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (640, to_date('31-08-2024', 'dd-mm-yyyy'), to_date('19-08-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (931, to_date('29-12-2027', 'dd-mm-yyyy'), to_date('04-12-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (607, to_date('20-11-2027', 'dd-mm-yyyy'), to_date('16-09-2025', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (944, to_date('04-08-2028', 'dd-mm-yyyy'), to_date('17-12-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (144, to_date('29-10-2027', 'dd-mm-yyyy'), to_date('19-05-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (400, to_date('03-07-2028', 'dd-mm-yyyy'), to_date('28-02-2027', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (260, to_date('04-09-2027', 'dd-mm-yyyy'), to_date('25-07-2026', 'dd-mm-yyyy'));
insert into ORDERS (order_id, order_date, dellivery_date)
values (197, to_date('04-01-2025', 'dd-mm-yyyy'), to_date('25-11-2026', 'dd-mm-yyyy'));
commit;
prompt 422 records loaded
prompt Loading PRODUCTS...
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (100, 'Alden Systems', 0, 0, 100);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (101, 'Montpelier Plas', 1, 1, 101);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (102, 'Quality Assured', 2, 2, 102);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (103, 'DaimlerChrysler', 3, 3, 103);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (104, 'Parksite', 4, 4, 104);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (105, 'SSCI', 5, 5, 105);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (107, 'Dancor', 7, 7, 107);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (109, 'Aloha NY System', 9, 9, 109);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (110, 'Larkin Enterpri', 10, 10, 110);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (111, 'AOL Time Warner', 11, 11, 111);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (112, 'SafeHome Securi', 12, 12, 112);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (113, 'Green Mountain ', 13, 13, 113);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (114, 'Mission Control', 14, 14, 114);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (115, 'KSJ & Associate', 15, 15, 115);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (116, 'Enterprise Comp', 16, 16, 116);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (117, 'Toyota Motor Co', 17, 17, 117);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (118, 'First American ', 18, 18, 118);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (120, 'Kitba Consultin', 20, 20, 120);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (121, 'Hat World', 21, 21, 121);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (123, 'Kimberly-Clark ', 23, 23, 123);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (124, 'Clorox Co.', 24, 24, 124);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (126, 'Prometheus Labo', 26, 26, 126);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (127, 'AC Technologies', 27, 27, 127);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (128, 'Connected', 28, 28, 128);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (129, 'Conquest System', 29, 29, 129);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (130, 'Procter & Gambl', 30, 30, 130);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (131, 'Oakleaf Waste M', 31, 31, 131);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (132, 'Benecon Group', 32, 32, 132);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (133, 'FSF Financial', 33, 33, 133);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (135, 'Veri-Tek Intern', 35, 35, 135);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (136, 'Hi-Tech Pharmac', 36, 36, 136);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (139, 'Terra Firma', 39, 39, 139);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (140, 'Virtual Meeting', 40, 40, 140);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (141, 'First American ', 41, 41, 141);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (142, 'Gillette Co.', 42, 42, 142);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (143, 'Ford Motor Co.', 43, 43, 143);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (144, 'SCI', 44, 44, 144);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (145, 'Spenser Communi', 45, 45, 145);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (147, 'Simply Certific', 47, 47, 147);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (148, 'Procurement Cen', 48, 48, 148);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (153, 'Global Domains ', 53, 53, 153);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (156, 'American Pan & ', 56, 56, 156);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (157, 'Advantage Credi', 57, 57, 157);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (159, 'Adolph Coors Co', 59, 59, 159);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (163, 'Access Systems', 63, 63, 163);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (164, 'httprint', 64, 64, 164);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (166, 'SSCI', 66, 66, 166);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (167, 'Merck & Co.', 67, 67, 167);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (171, 'WAV', 71, 71, 171);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (172, 'ZonePerfect Nut', 72, 72, 172);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (174, 'Unilever', 74, 74, 174);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (177, 'NoBrainerBlinds', 77, 77, 177);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (178, 'Softworld', 78, 78, 178);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (182, 'Spenser Communi', 82, 82, 182);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (183, 'Unger Technolog', 83, 83, 183);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (184, 'Glacier Bancorp', 84, 84, 184);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (188, 'TruSecure', 88, 88, 188);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (191, 'New Horizons Co', 91, 91, 191);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (192, 'Typhoon', 92, 92, 192);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (195, 'Dankoff Solar P', 95, 95, 195);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (196, 'Topics Entertai', 96, 96, 196);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (199, 'Apex Systems', 99, 99, 199);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (200, 'Manhattan Assoc', 0, 0, 100);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (201, 'Novartis', 1, 1, 101);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (202, 'Unica', 2, 2, 102);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (203, 'CapTech Venture', 3, 3, 103);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (204, 'Gap Inc.', 4, 4, 104);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (205, 'Capital Automot', 5, 5, 105);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (207, 'Legacy Financia', 7, 7, 107);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (209, 'Berkshire Hatha', 9, 9, 109);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (210, 'American Pan & ', 10, 10, 110);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (211, 'Heritage Microf', 11, 11, 111);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (212, '3t Systems', 12, 12, 112);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (213, 'Gillette Co.', 13, 13, 113);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (214, 'MQ Software', 14, 14, 114);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (215, 'SurModics', 15, 15, 115);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (216, 'Catamount Const', 16, 16, 116);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (217, 'Integrated Deci', 17, 17, 117);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (218, 'Venoco', 18, 18, 118);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (220, 'Megha Systems', 20, 20, 120);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (221, 'Capella Educati', 21, 21, 121);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (223, 'FlavorX', 23, 23, 123);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (224, 'Lindin Consulti', 24, 24, 124);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (226, 'Analytics Opera', 26, 26, 126);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (227, 'Virbac', 27, 27, 127);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (228, 'Eze Castle Soft', 28, 28, 128);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (229, 'CLT Meetings In', 29, 29, 129);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (230, 'Best Buy Co.', 30, 30, 130);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (231, 'EPIQ Systems', 31, 31, 131);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (232, 'Integra Telecom', 32, 32, 132);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (233, 'Spectrum Commun', 33, 33, 133);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (235, 'Innovate E-Comm', 35, 35, 135);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (236, 'Sprint Corp.', 36, 36, 136);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (239, 'Freedom Medical', 39, 39, 139);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (240, 'Greenwich Techn', 40, 40, 140);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (241, 'Bristol-Myers S', 41, 41, 141);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (242, 'Brandt Informat', 42, 42, 142);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (243, 'Kingston', 43, 43, 143);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (244, 'Pearl Law Group', 44, 44, 144);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (245, 'Auction Systems', 45, 45, 145);
commit;
prompt 100 records committed...
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (247, 'Global Domains ', 47, 47, 147);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (248, 'Solution Builde', 48, 48, 148);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (253, 'Outsource Group', 53, 53, 153);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (256, 'Lindin Consulti', 56, 56, 156);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (257, 'Anheuser-Busch ', 57, 57, 157);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (259, 'North American ', 59, 59, 159);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (263, 'Myricom', 63, 63, 163);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (264, 'MRE Consulting', 64, 64, 164);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (266, 'Kingston', 66, 66, 166);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (267, 'Boldtech System', 67, 67, 167);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (271, 'Asta Funding', 71, 71, 171);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (272, 'Terra Firma', 72, 72, 172);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (274, 'National Herita', 74, 74, 174);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (277, 'Typhoon', 77, 77, 177);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (278, 'Bradley Pharmac', 78, 78, 178);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (282, 'Inspiration Sof', 82, 82, 182);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (283, 'J.C. Malone Ass', 83, 83, 183);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (284, 'U.S Physical Th', 84, 84, 184);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (288, 'One Source Prin', 88, 88, 188);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (291, 'Summit Energy', 91, 91, 191);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (292, 'SYS-CON Media', 92, 92, 192);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (295, 'Clover Technolo', 95, 95, 195);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (296, 'Extra Mile Tran', 96, 96, 196);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (299, 'Capital Crossin', 99, 99, 199);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (300, 'Street Glow', 0, 0, 100);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (301, 'Studio B Produc', 1, 1, 101);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (302, 'Maverick Techno', 2, 2, 102);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (303, 'Network Display', 3, 3, 103);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (304, 'Commercial Ener', 4, 4, 104);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (305, 'Pulaski Financi', 5, 5, 105);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (307, 'Unicru', 7, 7, 107);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (309, 'Phoenix Rehabil', 9, 9, 109);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (310, 'Extra Mile Tran', 10, 10, 110);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (311, 'Extreme Pizza', 11, 11, 111);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (312, 'Progressive Des', 12, 12, 112);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (313, 'NoBrainerBlinds', 13, 13, 113);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (314, 'Keller Williams', 14, 14, 114);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (315, 'Formatech', 15, 15, 115);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (316, 'Cowlitz Bancorp', 16, 16, 116);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (317, 'CyberThink', 17, 17, 117);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (318, 'Granite Systems', 18, 18, 118);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (320, 'PepsiCo', 20, 20, 120);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (321, 'Gentra Systems', 21, 21, 121);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (323, 'InsurMark', 23, 23, 123);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (324, 'Eze Castle Soft', 24, 24, 124);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (326, 'Pioneer Mortgag', 26, 26, 126);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (327, 'TLS Service Bur', 27, 27, 127);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (328, 'Vivendi Univers', 28, 28, 128);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (329, 'Synhrgy HR Tech', 29, 29, 129);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (330, 'GCI', 30, 30, 130);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (331, 'Miracle Softwar', 31, 31, 131);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (332, 'Abdon Callais O', 32, 32, 132);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (333, 'Arkidata', 33, 33, 133);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (335, 'Commercial Ener', 35, 35, 135);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (336, 'McKee Wallwork ', 36, 36, 136);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (339, 'httprint', 39, 39, 139);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (340, 'North Coast Ene', 40, 40, 140);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (341, 'Pulaski Financi', 41, 41, 141);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (342, 'PrintingForLess', 42, 42, 142);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (343, 'Floorgraphics', 43, 43, 143);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (344, 'Columbia Bancor', 44, 44, 144);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (345, 'Mission Control', 45, 45, 145);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (347, 'Cima Consulting', 47, 47, 147);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (348, 'American Servic', 48, 48, 148);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (353, 'Deutsche Teleko', 53, 53, 153);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (356, 'St. Mary Land &', 56, 56, 156);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (357, 'American Megaco', 57, 57, 157);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (359, 'Clorox Co.', 59, 59, 159);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (363, 'Commercial Ener', 63, 63, 163);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (364, 'Cima Labs', 64, 64, 164);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (366, 'Taycor Financia', 66, 66, 166);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (367, 'Tracer Technolo', 67, 67, 167);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (371, 'Vertex Solution', 71, 71, 171);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (372, 'Conquest System', 72, 72, 172);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (374, 'Restaurant Part', 74, 74, 174);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (377, 'McKee Wallwork ', 77, 77, 177);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (378, 'Advanced Vision', 78, 78, 178);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (382, 'Advanced Intern', 82, 82, 182);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (383, 'Global Domains ', 83, 83, 183);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (384, 'Blue Ocean Soft', 84, 84, 184);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (388, 'SimStar Interne', 88, 88, 188);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (391, 'Investors Title', 91, 91, 191);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (392, 'General Mills', 92, 92, 192);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (395, 'CREDO Petroleum', 95, 95, 195);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (396, 'Urstadt Biddle ', 96, 96, 196);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (399, 'Evergreen Resou', 99, 99, 199);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (400, 'General Motors ', 0, 0, 100);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (401, 'Myricom', 1, 1, 101);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (402, 'SM Consulting', 2, 2, 102);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (403, 'Kramont Realty ', 3, 3, 103);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (404, 'QSS Group', 4, 4, 104);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (405, 'Kingston', 5, 5, 105);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (407, 'Magnet Communic', 7, 7, 107);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (409, 'Merit Medical S', 9, 9, 109);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (410, 'Lydian Trust', 10, 10, 110);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (411, 'Laboratory Mana', 11, 11, 111);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (412, 'L.E.M. Products', 12, 12, 112);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (413, 'Virtual Financi', 13, 13, 113);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (414, 'Clorox Co.', 14, 14, 114);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (415, 'Philip Morris C', 15, 15, 115);
commit;
prompt 200 records committed...
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (416, 'Liners Direct', 16, 16, 116);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (417, 'ProSys Informat', 17, 17, 117);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (418, 'Morgan Stanley ', 18, 18, 118);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (420, 'Staff One', 20, 20, 120);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (421, 'Joseph Sheairs ', 21, 21, 121);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (423, 'Monitronics Int', 23, 23, 123);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (424, 'Capella Educati', 24, 24, 124);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (426, 'MHF Logistical ', 26, 26, 126);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (427, 'Hilton Hotels C', 27, 27, 127);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (428, 'Newton Interact', 28, 28, 128);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (429, 'Universal Solut', 29, 29, 129);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (430, 'Client Network ', 30, 30, 130);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (431, 'Coca-Cola Co.', 31, 31, 131);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (432, 'Arkidata', 32, 32, 132);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (433, 'Homebuilders Fi', 33, 33, 133);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (435, 'Investors Title', 35, 35, 135);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (436, 'Process Plus', 36, 36, 136);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (439, 'Mosaic', 39, 39, 139);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (440, 'Quantum Loyalty', 40, 40, 140);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (441, 'Advertising Ven', 41, 41, 141);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (442, 'Computer Source', 42, 42, 142);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (443, 'Saks Inc.', 43, 43, 143);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (444, 'Legacy Financia', 44, 44, 144);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (445, 'Data Company', 45, 45, 145);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (447, 'Cambridge Home ', 47, 47, 147);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (448, 'U.S. Government', 48, 48, 148);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (453, 'U.S. Government', 53, 53, 153);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (456, 'FFLC Bancorp', 56, 56, 156);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (457, 'May Department ', 57, 57, 157);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (459, 'Greenwich Techn', 59, 59, 159);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (463, 'Access Systems', 63, 63, 163);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (464, 'Sony Corp.', 64, 64, 164);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (466, 'Quantum Loyalty', 66, 66, 166);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (467, 'Unica', 67, 67, 167);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (471, 'One Source Prin', 71, 71, 171);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (472, 'Ogio Internatio', 72, 72, 172);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (474, 'Newton Interact', 74, 74, 174);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (477, 'Atlantic.Net', 77, 77, 177);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (478, 'Heartlab', 78, 78, 178);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (482, 'Bashen Consulti', 82, 82, 182);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (483, 'Kellogg Co.', 83, 83, 183);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (484, 'Mattel', 84, 84, 184);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (488, 'United Asset Co', 88, 88, 188);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (491, 'DC Group', 91, 91, 191);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (492, 'Morgan Stanley ', 92, 92, 192);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (495, 'Terra Firma', 95, 95, 195);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (496, 'Marriott Intern', 96, 96, 196);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (499, 'Hospital Soluti', 99, 99, 199);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (500, 'Safeway', 0, 0, 100);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (501, 'InfoVision Cons', 1, 1, 101);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (502, 'Limited Brands', 2, 2, 102);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (503, 'Infinity Softwa', 3, 3, 103);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (504, 'Scott Pipitone ', 4, 4, 104);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (505, 'SM Consulting', 5, 5, 105);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (507, 'Catamount Const', 7, 7, 107);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (509, 'Vitacost.com', 9, 9, 109);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (510, 'Allegiant Banco', 10, 10, 110);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (511, 'Joseph Sheairs ', 11, 11, 111);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (512, 'Commercial Ener', 12, 12, 112);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (513, 'Gray Hawk Syste', 13, 13, 113);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (514, 'Portage Environ', 14, 14, 114);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (515, 'Procter & Gambl', 15, 15, 115);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (516, 'Coca-Cola Co.', 16, 16, 116);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (517, 'G.A. Beck Artis', 17, 17, 117);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (518, 'Bristol-Myers S', 18, 18, 118);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (520, 'Diamond Pharmac', 20, 20, 120);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (521, 'American Expres', 21, 21, 121);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (523, 'Envision Teleph', 23, 23, 123);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (524, 'Banfe Products', 24, 24, 124);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (526, 'Advanced Intern', 26, 26, 126);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (527, 'ProSys Informat', 27, 27, 127);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (528, 'Uniserve Facili', 28, 28, 128);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (529, 'Commercial Ener', 29, 29, 129);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (530, 'Newton Interact', 30, 30, 130);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (531, 'ComGlobal Syste', 31, 31, 131);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (532, 'Prosoft Technol', 32, 32, 132);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (533, 'Bluff City Stee', 33, 33, 133);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (535, 'PowerLight', 35, 35, 135);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (536, 'Deutsche Teleko', 36, 36, 136);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (539, 'Cherokee Inform', 39, 39, 139);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (540, 'Scooter Store', 40, 40, 140);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (541, 'Myricom', 41, 41, 141);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (542, 'GRT', 42, 42, 142);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (543, 'One Source Prin', 43, 43, 143);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (544, 'Linksys', 44, 44, 144);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (545, 'Active Services', 45, 45, 145);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (547, 'Biosite', 47, 47, 147);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (548, 'Tarragon Realty', 48, 48, 148);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (553, 'ProfitLine', 53, 53, 153);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (556, 'Mathis, Earnest', 56, 56, 156);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (557, 'Kingland Compan', 57, 57, 157);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (559, 'Bashen Consulti', 59, 59, 159);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (563, 'Comnet Internat', 63, 63, 163);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (564, 'Evergreen Resou', 64, 64, 164);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (566, 'American Vangua', 66, 66, 166);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (567, 'Pacific Data De', 67, 67, 167);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (571, 'Trek Equipment', 71, 71, 171);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (572, 'Allegiant Banco', 72, 72, 172);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (574, 'America''s Choic', 74, 74, 174);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (577, 'Woronoco Bancor', 77, 77, 177);
commit;
prompt 300 records committed...
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (578, 'ScriptSave', 78, 78, 178);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (582, 'Trainersoft', 82, 82, 182);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (583, 'FlavorX', 83, 83, 183);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (584, 'All Star Consul', 84, 84, 184);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (588, 'Unica', 88, 88, 188);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (591, 'Socket Internet', 91, 91, 191);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (592, 'Inspiration Sof', 92, 92, 192);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (595, 'FSF Financial', 95, 95, 195);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (596, 'Partnership in ', 96, 96, 196);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (599, 'Miller Systems', 99, 99, 199);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (600, 'Novartis', 0, 0, 100);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (601, 'Bowman Consulti', 1, 1, 101);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (602, 'Strategic Produ', 2, 2, 102);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (603, 'BASE Consulting', 3, 3, 103);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (604, 'Total Entertain', 4, 4, 104);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (605, 'WAV', 5, 5, 105);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (607, 'Global Wireless', 7, 7, 107);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (609, 'Virtual Financi', 9, 9, 109);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (610, 'LogistiCare', 10, 10, 110);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (611, 'Visionary Syste', 11, 11, 111);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (612, 'GCI', 12, 12, 112);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (613, 'Verizon Communi', 13, 13, 113);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (614, 'Eze Castle Soft', 14, 14, 114);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (615, 'CIW Services', 15, 15, 115);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (616, 'AXSA Document S', 16, 16, 116);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (617, 'Joe Lombardo Pl', 17, 17, 117);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (618, 'Digital Motorwo', 18, 18, 118);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (620, 'Active Services', 20, 20, 120);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (621, 'Benecon Group', 21, 21, 121);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (623, 'Infinity Softwa', 23, 23, 123);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (624, 'Club One', 24, 24, 124);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (626, 'Envision Teleph', 26, 26, 126);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (627, 'GulfMark Offsho', 27, 27, 127);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (628, 'Peerless Manufa', 28, 28, 128);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (629, 'Tarragon Realty', 29, 29, 129);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (630, 'Viacom', 30, 30, 130);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (631, 'Pioneer Data Sy', 31, 31, 131);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (632, 'Network Hardwar', 32, 32, 132);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (633, 'Acsis', 33, 33, 133);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (635, 'Grant Harrison ', 35, 35, 135);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (636, 'Uniserve Facili', 36, 36, 136);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (639, 'CLT Meetings In', 39, 39, 139);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (640, 'httprint', 40, 40, 140);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (641, 'Apex Systems', 41, 41, 141);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (642, 'Marlabs', 42, 42, 142);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (643, 'EFC Bancorp', 43, 43, 143);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (644, 'Visa Internatio', 44, 44, 144);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (645, 'Client Network ', 45, 45, 145);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (647, 'Merck & Co.', 47, 47, 147);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (648, 'Solipsys', 48, 48, 148);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (653, 'Uniserve Facili', 53, 53, 153);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (656, 'Granite Systems', 56, 56, 156);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (657, 'Inspiration Sof', 57, 57, 157);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (659, 'Pyramid Digital', 59, 59, 159);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (663, 'Cardinal Cartri', 63, 63, 163);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (664, 'Travizon', 64, 64, 164);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (666, 'Genex Technolog', 66, 66, 166);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (667, 'Qestrel Cos.', 67, 67, 167);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (671, 'Teamstudio', 71, 71, 171);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (672, 'Saks Inc.', 72, 72, 172);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (674, 'Nike', 74, 74, 174);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (677, 'Creditors Inter', 77, 77, 177);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (678, 'CREDO Petroleum', 78, 78, 178);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (682, 'Cendant Corp.', 82, 82, 182);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (683, 'Kroger Co.', 83, 83, 183);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (684, 'Genghis Grill', 84, 84, 184);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (688, 'CREDO Petroleum', 88, 88, 188);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (691, 'Glacier Bancorp', 91, 91, 191);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (692, 'Virtual Financi', 92, 92, 192);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (695, 'USA Instruments', 95, 95, 195);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (696, 'STI Knowledge', 96, 96, 196);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (699, 'Ultimus', 99, 99, 199);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (606, 'GlaxoSmithKline', 6, 6, 206);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (608, 'Blue Ocean Soft', 8, 8, 208);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (619, 'Client Network ', 19, 19, 219);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (622, 'SHOT', 22, 22, 222);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (625, 'Span-America Me', 25, 25, 225);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (634, 'Sensor Technolo', 34, 34, 234);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (637, 'esoftsolutions', 37, 37, 237);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (638, 'Canterbury Park', 38, 38, 238);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (646, 'Capitol Bancorp', 46, 46, 246);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (651, 'DataTrend Infor', 51, 51, 251);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (655, 'Deutsche Teleko', 55, 55, 255);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (658, 'Priority Expres', 58, 58, 258);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (662, 'ELMCO', 62, 62, 262);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (665, 'Kellogg Co.', 65, 65, 265);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (668, 'Career Control ', 68, 68, 268);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (669, 'SYS-CON Media', 69, 69, 269);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (670, 'Cold Stone Crea', 70, 70, 270);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (673, 'InfoPros', 73, 73, 273);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (675, 'Max & Erma''s Re', 75, 75, 275);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (676, 'AT&T Corp.', 76, 76, 276);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (680, 'Integra Telecom', 80, 80, 280);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (681, 'Genghis Grill', 81, 81, 281);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (685, 'Staff One', 85, 85, 285);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (686, 'Call Henry', 86, 86, 286);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (689, 'Qestrel Cos.', 89, 89, 289);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (694, 'MindIQ', 94, 94, 294);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (698, 'Vitacost.com', 98, 98, 298);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (700, 'Nexxtworks', 0, 0, 300);
commit;
prompt 400 records committed...
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (701, 'Momentum Market', 1, 1, 301);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (702, 'Tilson Landscap', 2, 2, 302);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (703, 'Hat World', 3, 3, 303);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (704, 'Painted Word', 4, 4, 304);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (705, 'In Zone', 5, 5, 305);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (706, 'Integra Telecom', 6, 6, 306);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (708, 'Legacy Financia', 8, 8, 308);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (709, 'Component Graph', 9, 9, 309);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (710, 'Kingston', 10, 10, 310);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (711, 'Labrada Nutriti', 11, 11, 311);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (712, 'WorldCom', 12, 12, 312);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (713, 'Larkin Enterpri', 13, 13, 313);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (714, 'Peerless Manufa', 14, 14, 314);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (715, 'Franklin Americ', 15, 15, 315);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (716, 'esoftsolutions', 16, 16, 316);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (717, 'AT&T Corp.', 17, 17, 317);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (718, 'Prosperity Banc', 18, 18, 318);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (719, 'Wyeth', 19, 19, 319);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (720, 'Maverick Constr', 20, 20, 320);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (721, 'Mathis, Earnest', 21, 21, 321);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (722, 'Astute', 22, 22, 322);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (723, 'Bristol-Myers S', 23, 23, 323);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (724, 'Quality Assured', 24, 24, 324);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (725, 'PSC Info Group', 25, 25, 325);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (726, 'Southern Financ', 26, 26, 326);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (727, 'Horizon Consult', 27, 27, 327);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (728, 'Envision Teleph', 28, 28, 328);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (729, 'Investors Title', 29, 29, 329);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (730, 'ProSys Informat', 30, 30, 330);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (731, 'Apex Systems', 31, 31, 331);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (732, 'Gateway', 32, 32, 332);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (733, 'Fetch Logistics', 33, 33, 333);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (734, 'Quantum Loyalty', 34, 34, 334);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (735, 'WRG Services', 35, 35, 335);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (736, 'Unit', 36, 36, 336);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (737, 'FFLC Bancorp', 37, 37, 337);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (738, 'Synhrgy HR Tech', 38, 38, 338);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (739, 'Infinity Softwa', 39, 39, 339);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (740, 'CCF Holding', 40, 40, 340);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (741, 'Typhoon', 41, 41, 341);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (742, 'Advanced Techno', 42, 42, 342);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (743, 'Flow Management', 43, 43, 343);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (744, 'Alternative Tec', 44, 44, 344);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (745, 'Apex Systems', 45, 45, 345);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (746, 'Tigris Consulti', 46, 46, 346);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (747, 'Intel Corp.', 47, 47, 347);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (748, 'Comnet Internat', 48, 48, 348);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (749, 'Ford Motor Co.', 49, 49, 349);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (750, 'Advanced Intern', 50, 50, 350);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (751, 'GulfMark Offsho', 51, 51, 351);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (752, 'Staff One', 52, 52, 352);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (753, 'Blue Angel Tech', 53, 53, 353);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (754, 'HealthCare Fina', 54, 54, 354);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (755, 'Sandy Spring Ba', 55, 55, 355);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (756, 'TEOCO', 56, 56, 356);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (757, 'Dancor', 57, 57, 357);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (758, 'Cowlitz Bancorp', 58, 58, 358);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (759, 'DaimlerChrysler', 59, 59, 359);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (760, 'Web Group', 60, 60, 360);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (761, 'Diversitech', 61, 61, 361);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (762, 'WestNet Learnin', 62, 62, 362);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (763, 'North Highland', 63, 63, 363);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (764, 'Call Henry', 64, 64, 364);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (765, 'Network Display', 65, 65, 365);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (766, 'General Motors ', 66, 66, 366);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (767, 'Biosite', 67, 67, 367);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (768, 'Aquascape Desig', 68, 68, 368);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (769, 'Alliance of Pro', 69, 69, 369);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (770, 'Pacific Data De', 70, 70, 370);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (771, 'Kroger Co.', 71, 71, 371);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (772, 'WRG Services', 72, 72, 372);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (773, 'Exinom Technolo', 73, 73, 373);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (774, 'EPAM Systems', 74, 74, 374);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (775, 'Elite Medical', 75, 75, 375);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (776, 'Diamond Technol', 76, 76, 376);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (777, 'Enterprise Comp', 77, 77, 377);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (778, 'Travizon', 78, 78, 378);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (779, 'Heartland Payme', 79, 79, 379);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (780, 'esoftsolutions', 80, 80, 380);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (781, 'Maverick Techno', 81, 81, 381);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (782, 'Volkswagen', 82, 82, 382);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (783, 'Primus Software', 83, 83, 383);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (784, 'Glacier Bancorp', 84, 84, 384);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (785, 'Terra Firma', 85, 85, 385);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (786, 'Y2Marketing', 86, 86, 386);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (787, 'Joseph Sheairs ', 87, 87, 387);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (788, 'Creditors Inter', 88, 88, 388);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (789, 'Southern Financ', 89, 89, 389);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (790, 'Progressive Des', 90, 90, 390);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (791, 'Carteret Mortga', 91, 91, 391);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (792, 'Black Mountain ', 92, 92, 392);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (793, 'Network Hardwar', 93, 93, 393);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (794, 'Pioneer Mortgag', 94, 94, 394);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (795, 'KeyMark', 95, 95, 395);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (796, 'ProClarity', 96, 96, 396);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (797, 'Coadvantage Res', 97, 97, 397);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (799, 'Portosan', 99, 99, 399);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (800, 'Abdon Callais O', 0, 0, 400);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (801, 'TechRX', 1, 1, 401);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (802, 'STI Knowledge', 2, 2, 402);
commit;
prompt 500 records committed...
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (803, 'Adea Solutions', 3, 3, 403);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (804, 'ConAgra', 4, 4, 404);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (805, 'Parksite', 5, 5, 405);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (806, 'Gateway', 6, 6, 406);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (807, 'Navigator Syste', 7, 7, 407);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (808, 'Integrated Deci', 8, 8, 408);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (809, 'Quantum Loyalty', 9, 9, 409);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (810, 'Greenwich Techn', 10, 10, 410);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (811, 'Kimberly-Clark ', 11, 11, 411);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (812, 'Custom Solution', 12, 12, 412);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (813, 'Franklin Americ', 13, 13, 413);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (814, 'Comnet Internat', 14, 14, 414);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (815, 'Glacier Bancorp', 15, 15, 415);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (816, 'North Coast Ene', 16, 16, 416);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (818, 'New Media Commu', 18, 18, 418);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (819, 'Balchem', 19, 19, 419);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (820, 'Global Domains ', 20, 20, 420);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (821, 'IVCi', 21, 21, 421);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (822, 'Prosum', 22, 22, 422);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (823, 'Open Software S', 23, 23, 423);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (824, 'Blue Angel Tech', 24, 24, 424);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (825, 'Progressive Des', 25, 25, 425);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (826, 'Acsis', 26, 26, 426);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (827, 'Web Group', 27, 27, 427);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (828, 'CIW Services', 28, 28, 428);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (829, 'Unicru', 29, 29, 429);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (830, 'Shuffle Master', 30, 30, 430);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (831, 'Nestle', 31, 31, 431);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (832, 'TechRX', 32, 32, 432);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (833, 'G.A. Beck Artis', 33, 33, 433);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (834, 'Quaker City Ban', 34, 34, 434);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (835, 'Dataprise', 35, 35, 435);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (836, 'Restaurant Part', 36, 36, 436);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (837, 'Blue Angel Tech', 37, 37, 437);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (838, 'John Keeler & C', 38, 38, 438);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (839, 'Capital Bank', 39, 39, 439);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (840, 'Connected', 40, 40, 440);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (841, 'White Wave', 41, 41, 441);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (842, 'G.A. Beck Artis', 42, 42, 442);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (843, 'Synhrgy HR Tech', 43, 43, 443);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (844, 'Benecon Group', 44, 44, 444);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (845, 'Sara Lee Corp.', 45, 45, 445);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (846, 'Sprint Corp.', 46, 46, 446);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (847, 'Advanced Techno', 47, 47, 447);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (848, 'Asta Funding', 48, 48, 448);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (849, 'Printcafe Softw', 49, 49, 449);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (850, 'Data Warehouse', 50, 50, 450);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (851, 'Air Methods', 51, 51, 451);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (852, 'Market First', 52, 52, 452);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (853, 'Smartronix', 53, 53, 453);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (854, 'Pearl Law Group', 54, 54, 454);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (856, 'Tastefully Simp', 56, 56, 456);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (857, 'Hardwood Wholes', 57, 57, 457);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (858, 'Summit Energy', 58, 58, 458);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (859, 'Terra Firma', 59, 59, 459);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (860, 'Sony Corp.', 60, 60, 460);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (861, 'Adolph Coors Co', 61, 61, 461);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (862, 'Escalade', 62, 62, 462);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (863, 'Reckitt Benckis', 63, 63, 463);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (864, 'Questar Capital', 64, 64, 464);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (865, 'Hewlett-Packard', 65, 65, 465);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (866, 'Cold Stone Crea', 66, 66, 466);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (867, 'Innovative Ligh', 67, 67, 467);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (868, 'GHR Systems', 68, 68, 468);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (869, 'Astute', 69, 69, 469);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (870, 'Shirt Factory', 70, 70, 470);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (871, 'Arrow Financial', 71, 71, 471);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (872, 'Yum Brands', 72, 72, 472);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (873, 'Security Mortga', 73, 73, 473);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (874, 'Operational Tec', 74, 74, 474);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (875, 'ProClarity', 75, 75, 475);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (876, 'Bestever', 76, 76, 476);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (877, 'Dynacq Internat', 77, 77, 477);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (878, 'Virtual Meeting', 78, 78, 478);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (879, 'Great Lakes Med', 79, 79, 479);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (880, 'School Technolo', 80, 80, 480);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (881, 'Pacific Data De', 81, 81, 481);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (882, 'Genghis Grill', 82, 82, 482);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (883, 'Granite Systems', 83, 83, 483);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (884, 'Johnson & Johns', 84, 84, 484);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (885, 'Sterling Financ', 85, 85, 485);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (886, 'Integrated Deci', 86, 86, 486);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (887, 'Grant Harrison ', 87, 87, 487);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (888, 'Third Millenniu', 88, 88, 488);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (889, 'Herbeau Creatio', 89, 89, 489);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (890, 'Hershey Foods C', 90, 90, 490);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (891, 'Campbell Soup C', 91, 91, 491);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (892, 'MicroTek', 92, 92, 492);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (893, 'Keller Williams', 93, 93, 493);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (894, 'DataTrend Infor', 94, 94, 494);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (895, 'MoneyLine Lendi', 95, 95, 495);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (896, 'IntegraMed Amer', 96, 96, 496);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (897, 'Nike', 97, 97, 497);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (898, 'CIW Services', 98, 98, 498);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (899, 'CyberThink', 99, 99, 499);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (900, 'Navarro Researc', 1, 3, 351);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (901, 'Tigris Consulti', 2, 4, 286);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (902, 'Automated Licen', 3, 5, 302);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (165, null, 241, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (376, null, 69, 30, 700);
commit;
prompt 600 records committed...
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (390, null, 287, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (489, null, 56, 90, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (265, null, 164, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (476, null, 146, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (186, null, 50, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (280, null, 142, 50, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (190, null, 142, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (162, null, 55, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (481, null, 237, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (422, null, 237, 50, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (450, null, 163, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (380, null, 163, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (225, null, 163, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (125, null, 262, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (234, null, 241, 90, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (394, null, 241, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (469, null, 57, 50, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (473, null, 142, 90, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (281, null, 260, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (260, null, 92, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (176, null, 92, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (350, null, 142, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (322, null, 215, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (497, null, 295, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (255, null, 241, 90, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (480, null, 294, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (261, null, 294, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (361, null, 258, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (189, null, 258, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (346, null, 214, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (381, null, 161, 90, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (462, null, 277, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (219, null, 56, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (180, null, 161, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (308, null, 259, 50, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (222, null, 170, 50, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (498, null, 57, 50, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (352, null, 276, 50, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (452, null, 69, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (449, null, 69, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (354, null, 92, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (465, null, 240, 90, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (206, null, 240, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (375, null, 295, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (461, null, 262, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (169, null, 275, 50, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (338, null, 250, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (370, null, 137, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (285, null, 97, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (108, null, 188, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (490, null, 92, 90, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (187, null, 259, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (425, null, 50, 90, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (258, null, 192, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (276, null, 214, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (254, null, 214, 50, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (406, null, 98, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (468, null, 294, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (237, null, 171, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (387, null, 70, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (275, null, 93, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (408, null, 143, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (168, null, 187, 50, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (437, null, 50, 50, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (146, null, 188, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (319, null, 92, 90, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (373, null, 191, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (355, null, 191, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (289, null, 198, 50, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (360, null, 31, 90, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (193, null, 166, 50, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (397, null, 185, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (246, null, 185, 90, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (198, null, 185, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (106, null, 185, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (479, null, 120, 90, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (122, null, 120, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (175, null, 249, 90, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (150, null, 251, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (369, null, 241, 50, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (286, null, 31, 90, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (351, null, 56, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (385, null, 97, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (358, null, 97, 90, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (134, null, 97, 50, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (158, null, 259, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (161, null, 68, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (493, null, 215, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (368, null, 186, 50, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (458, null, 92, 50, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (119, null, 162, 50, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (389, null, 240, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (334, null, 142, 50, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (485, null, 292, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (337, null, 259, 50, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (293, null, 98, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (446, null, 277, 50, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (181, null, 57, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (438, null, 139, 90, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (173, null, 139, 90, 700);
commit;
prompt 700 records committed...
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (419, null, 167, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (208, null, 259, 50, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (487, null, 166, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (185, null, 166, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (194, null, 50, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (460, null, 147, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (137, null, 169, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (393, null, 187, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (154, null, 98, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (451, null, 261, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (290, null, 214, 90, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (294, null, 192, 90, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (379, null, 149, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (398, null, 214, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (455, null, 277, 90, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (494, null, 149, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (475, null, 277, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (138, null, 295, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (155, null, 147, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (268, null, 197, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (386, null, 167, 90, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (325, null, 240, 50, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (249, null, 259, 50, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (298, null, 215, 90, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (362, null, 146, 50, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (179, null, 146, 90, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (349, null, 294, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (273, null, 294, 90, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (151, null, 56, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (149, null, 56, 50, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (279, null, 257, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (434, null, 248, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (306, null, 248, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (170, null, 248, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (365, null, 97, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (238, null, 187, 50, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (251, null, 93, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (152, null, 49, 90, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (197, null, 261, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (297, null, 118, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (287, null, 118, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (262, null, 190, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (486, null, 68, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (269, null, 68, 30, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (470, null, 163, 90, 700);
insert into PRODUCTS (product_id, product_name, quantity, product_price, category_id)
values (454, null, 161, 30, 700);
commit;
prompt 746 records loaded
prompt Loading STOREPRODUCTS...
insert into STOREPRODUCTS (storeproduct_id)
values (100);
insert into STOREPRODUCTS (storeproduct_id)
values (101);
insert into STOREPRODUCTS (storeproduct_id)
values (102);
insert into STOREPRODUCTS (storeproduct_id)
values (103);
insert into STOREPRODUCTS (storeproduct_id)
values (104);
insert into STOREPRODUCTS (storeproduct_id)
values (105);
insert into STOREPRODUCTS (storeproduct_id)
values (107);
insert into STOREPRODUCTS (storeproduct_id)
values (109);
insert into STOREPRODUCTS (storeproduct_id)
values (110);
insert into STOREPRODUCTS (storeproduct_id)
values (111);
insert into STOREPRODUCTS (storeproduct_id)
values (112);
insert into STOREPRODUCTS (storeproduct_id)
values (113);
insert into STOREPRODUCTS (storeproduct_id)
values (114);
insert into STOREPRODUCTS (storeproduct_id)
values (115);
insert into STOREPRODUCTS (storeproduct_id)
values (116);
insert into STOREPRODUCTS (storeproduct_id)
values (117);
insert into STOREPRODUCTS (storeproduct_id)
values (118);
insert into STOREPRODUCTS (storeproduct_id)
values (120);
insert into STOREPRODUCTS (storeproduct_id)
values (121);
insert into STOREPRODUCTS (storeproduct_id)
values (123);
insert into STOREPRODUCTS (storeproduct_id)
values (124);
insert into STOREPRODUCTS (storeproduct_id)
values (126);
insert into STOREPRODUCTS (storeproduct_id)
values (127);
insert into STOREPRODUCTS (storeproduct_id)
values (128);
insert into STOREPRODUCTS (storeproduct_id)
values (129);
insert into STOREPRODUCTS (storeproduct_id)
values (130);
insert into STOREPRODUCTS (storeproduct_id)
values (131);
insert into STOREPRODUCTS (storeproduct_id)
values (132);
insert into STOREPRODUCTS (storeproduct_id)
values (133);
insert into STOREPRODUCTS (storeproduct_id)
values (135);
insert into STOREPRODUCTS (storeproduct_id)
values (136);
insert into STOREPRODUCTS (storeproduct_id)
values (139);
insert into STOREPRODUCTS (storeproduct_id)
values (140);
insert into STOREPRODUCTS (storeproduct_id)
values (141);
insert into STOREPRODUCTS (storeproduct_id)
values (142);
insert into STOREPRODUCTS (storeproduct_id)
values (143);
insert into STOREPRODUCTS (storeproduct_id)
values (144);
insert into STOREPRODUCTS (storeproduct_id)
values (145);
insert into STOREPRODUCTS (storeproduct_id)
values (147);
insert into STOREPRODUCTS (storeproduct_id)
values (148);
insert into STOREPRODUCTS (storeproduct_id)
values (153);
insert into STOREPRODUCTS (storeproduct_id)
values (156);
insert into STOREPRODUCTS (storeproduct_id)
values (157);
insert into STOREPRODUCTS (storeproduct_id)
values (159);
insert into STOREPRODUCTS (storeproduct_id)
values (163);
insert into STOREPRODUCTS (storeproduct_id)
values (164);
insert into STOREPRODUCTS (storeproduct_id)
values (166);
insert into STOREPRODUCTS (storeproduct_id)
values (167);
insert into STOREPRODUCTS (storeproduct_id)
values (171);
insert into STOREPRODUCTS (storeproduct_id)
values (172);
insert into STOREPRODUCTS (storeproduct_id)
values (174);
insert into STOREPRODUCTS (storeproduct_id)
values (177);
insert into STOREPRODUCTS (storeproduct_id)
values (178);
insert into STOREPRODUCTS (storeproduct_id)
values (182);
insert into STOREPRODUCTS (storeproduct_id)
values (183);
insert into STOREPRODUCTS (storeproduct_id)
values (184);
insert into STOREPRODUCTS (storeproduct_id)
values (188);
insert into STOREPRODUCTS (storeproduct_id)
values (191);
insert into STOREPRODUCTS (storeproduct_id)
values (192);
insert into STOREPRODUCTS (storeproduct_id)
values (195);
insert into STOREPRODUCTS (storeproduct_id)
values (196);
insert into STOREPRODUCTS (storeproduct_id)
values (199);
insert into STOREPRODUCTS (storeproduct_id)
values (200);
insert into STOREPRODUCTS (storeproduct_id)
values (201);
insert into STOREPRODUCTS (storeproduct_id)
values (202);
insert into STOREPRODUCTS (storeproduct_id)
values (203);
insert into STOREPRODUCTS (storeproduct_id)
values (204);
insert into STOREPRODUCTS (storeproduct_id)
values (205);
insert into STOREPRODUCTS (storeproduct_id)
values (207);
insert into STOREPRODUCTS (storeproduct_id)
values (209);
insert into STOREPRODUCTS (storeproduct_id)
values (210);
insert into STOREPRODUCTS (storeproduct_id)
values (211);
insert into STOREPRODUCTS (storeproduct_id)
values (212);
insert into STOREPRODUCTS (storeproduct_id)
values (213);
insert into STOREPRODUCTS (storeproduct_id)
values (214);
insert into STOREPRODUCTS (storeproduct_id)
values (215);
insert into STOREPRODUCTS (storeproduct_id)
values (216);
insert into STOREPRODUCTS (storeproduct_id)
values (217);
insert into STOREPRODUCTS (storeproduct_id)
values (218);
insert into STOREPRODUCTS (storeproduct_id)
values (220);
insert into STOREPRODUCTS (storeproduct_id)
values (221);
insert into STOREPRODUCTS (storeproduct_id)
values (223);
insert into STOREPRODUCTS (storeproduct_id)
values (224);
insert into STOREPRODUCTS (storeproduct_id)
values (226);
insert into STOREPRODUCTS (storeproduct_id)
values (227);
insert into STOREPRODUCTS (storeproduct_id)
values (228);
insert into STOREPRODUCTS (storeproduct_id)
values (229);
insert into STOREPRODUCTS (storeproduct_id)
values (230);
insert into STOREPRODUCTS (storeproduct_id)
values (231);
insert into STOREPRODUCTS (storeproduct_id)
values (232);
insert into STOREPRODUCTS (storeproduct_id)
values (233);
insert into STOREPRODUCTS (storeproduct_id)
values (235);
insert into STOREPRODUCTS (storeproduct_id)
values (236);
insert into STOREPRODUCTS (storeproduct_id)
values (239);
insert into STOREPRODUCTS (storeproduct_id)
values (240);
insert into STOREPRODUCTS (storeproduct_id)
values (241);
insert into STOREPRODUCTS (storeproduct_id)
values (242);
insert into STOREPRODUCTS (storeproduct_id)
values (243);
insert into STOREPRODUCTS (storeproduct_id)
values (244);
insert into STOREPRODUCTS (storeproduct_id)
values (245);
commit;
prompt 100 records committed...
insert into STOREPRODUCTS (storeproduct_id)
values (247);
insert into STOREPRODUCTS (storeproduct_id)
values (248);
insert into STOREPRODUCTS (storeproduct_id)
values (253);
insert into STOREPRODUCTS (storeproduct_id)
values (256);
insert into STOREPRODUCTS (storeproduct_id)
values (257);
insert into STOREPRODUCTS (storeproduct_id)
values (259);
insert into STOREPRODUCTS (storeproduct_id)
values (263);
insert into STOREPRODUCTS (storeproduct_id)
values (264);
insert into STOREPRODUCTS (storeproduct_id)
values (266);
insert into STOREPRODUCTS (storeproduct_id)
values (267);
insert into STOREPRODUCTS (storeproduct_id)
values (271);
insert into STOREPRODUCTS (storeproduct_id)
values (272);
insert into STOREPRODUCTS (storeproduct_id)
values (274);
insert into STOREPRODUCTS (storeproduct_id)
values (277);
insert into STOREPRODUCTS (storeproduct_id)
values (278);
insert into STOREPRODUCTS (storeproduct_id)
values (282);
insert into STOREPRODUCTS (storeproduct_id)
values (283);
insert into STOREPRODUCTS (storeproduct_id)
values (284);
insert into STOREPRODUCTS (storeproduct_id)
values (288);
insert into STOREPRODUCTS (storeproduct_id)
values (291);
insert into STOREPRODUCTS (storeproduct_id)
values (292);
insert into STOREPRODUCTS (storeproduct_id)
values (295);
insert into STOREPRODUCTS (storeproduct_id)
values (296);
insert into STOREPRODUCTS (storeproduct_id)
values (299);
insert into STOREPRODUCTS (storeproduct_id)
values (300);
insert into STOREPRODUCTS (storeproduct_id)
values (301);
insert into STOREPRODUCTS (storeproduct_id)
values (302);
insert into STOREPRODUCTS (storeproduct_id)
values (303);
insert into STOREPRODUCTS (storeproduct_id)
values (304);
insert into STOREPRODUCTS (storeproduct_id)
values (305);
insert into STOREPRODUCTS (storeproduct_id)
values (307);
insert into STOREPRODUCTS (storeproduct_id)
values (309);
insert into STOREPRODUCTS (storeproduct_id)
values (310);
insert into STOREPRODUCTS (storeproduct_id)
values (311);
insert into STOREPRODUCTS (storeproduct_id)
values (312);
insert into STOREPRODUCTS (storeproduct_id)
values (313);
insert into STOREPRODUCTS (storeproduct_id)
values (314);
insert into STOREPRODUCTS (storeproduct_id)
values (315);
insert into STOREPRODUCTS (storeproduct_id)
values (316);
insert into STOREPRODUCTS (storeproduct_id)
values (317);
insert into STOREPRODUCTS (storeproduct_id)
values (318);
insert into STOREPRODUCTS (storeproduct_id)
values (320);
insert into STOREPRODUCTS (storeproduct_id)
values (321);
insert into STOREPRODUCTS (storeproduct_id)
values (323);
insert into STOREPRODUCTS (storeproduct_id)
values (324);
insert into STOREPRODUCTS (storeproduct_id)
values (326);
insert into STOREPRODUCTS (storeproduct_id)
values (327);
insert into STOREPRODUCTS (storeproduct_id)
values (328);
insert into STOREPRODUCTS (storeproduct_id)
values (329);
insert into STOREPRODUCTS (storeproduct_id)
values (330);
insert into STOREPRODUCTS (storeproduct_id)
values (331);
insert into STOREPRODUCTS (storeproduct_id)
values (332);
insert into STOREPRODUCTS (storeproduct_id)
values (333);
insert into STOREPRODUCTS (storeproduct_id)
values (335);
insert into STOREPRODUCTS (storeproduct_id)
values (336);
insert into STOREPRODUCTS (storeproduct_id)
values (339);
insert into STOREPRODUCTS (storeproduct_id)
values (340);
insert into STOREPRODUCTS (storeproduct_id)
values (341);
insert into STOREPRODUCTS (storeproduct_id)
values (342);
insert into STOREPRODUCTS (storeproduct_id)
values (343);
insert into STOREPRODUCTS (storeproduct_id)
values (344);
insert into STOREPRODUCTS (storeproduct_id)
values (345);
insert into STOREPRODUCTS (storeproduct_id)
values (347);
insert into STOREPRODUCTS (storeproduct_id)
values (348);
insert into STOREPRODUCTS (storeproduct_id)
values (353);
insert into STOREPRODUCTS (storeproduct_id)
values (356);
insert into STOREPRODUCTS (storeproduct_id)
values (357);
insert into STOREPRODUCTS (storeproduct_id)
values (359);
insert into STOREPRODUCTS (storeproduct_id)
values (363);
insert into STOREPRODUCTS (storeproduct_id)
values (364);
insert into STOREPRODUCTS (storeproduct_id)
values (366);
insert into STOREPRODUCTS (storeproduct_id)
values (367);
insert into STOREPRODUCTS (storeproduct_id)
values (371);
insert into STOREPRODUCTS (storeproduct_id)
values (372);
insert into STOREPRODUCTS (storeproduct_id)
values (374);
insert into STOREPRODUCTS (storeproduct_id)
values (377);
insert into STOREPRODUCTS (storeproduct_id)
values (378);
insert into STOREPRODUCTS (storeproduct_id)
values (382);
insert into STOREPRODUCTS (storeproduct_id)
values (383);
insert into STOREPRODUCTS (storeproduct_id)
values (384);
insert into STOREPRODUCTS (storeproduct_id)
values (388);
insert into STOREPRODUCTS (storeproduct_id)
values (391);
insert into STOREPRODUCTS (storeproduct_id)
values (392);
insert into STOREPRODUCTS (storeproduct_id)
values (395);
insert into STOREPRODUCTS (storeproduct_id)
values (396);
insert into STOREPRODUCTS (storeproduct_id)
values (399);
insert into STOREPRODUCTS (storeproduct_id)
values (400);
insert into STOREPRODUCTS (storeproduct_id)
values (401);
insert into STOREPRODUCTS (storeproduct_id)
values (402);
insert into STOREPRODUCTS (storeproduct_id)
values (403);
insert into STOREPRODUCTS (storeproduct_id)
values (404);
insert into STOREPRODUCTS (storeproduct_id)
values (405);
insert into STOREPRODUCTS (storeproduct_id)
values (407);
insert into STOREPRODUCTS (storeproduct_id)
values (409);
insert into STOREPRODUCTS (storeproduct_id)
values (410);
insert into STOREPRODUCTS (storeproduct_id)
values (411);
insert into STOREPRODUCTS (storeproduct_id)
values (412);
insert into STOREPRODUCTS (storeproduct_id)
values (413);
insert into STOREPRODUCTS (storeproduct_id)
values (414);
insert into STOREPRODUCTS (storeproduct_id)
values (415);
commit;
prompt 200 records committed...
insert into STOREPRODUCTS (storeproduct_id)
values (416);
insert into STOREPRODUCTS (storeproduct_id)
values (417);
insert into STOREPRODUCTS (storeproduct_id)
values (418);
insert into STOREPRODUCTS (storeproduct_id)
values (420);
insert into STOREPRODUCTS (storeproduct_id)
values (421);
insert into STOREPRODUCTS (storeproduct_id)
values (423);
insert into STOREPRODUCTS (storeproduct_id)
values (424);
insert into STOREPRODUCTS (storeproduct_id)
values (426);
insert into STOREPRODUCTS (storeproduct_id)
values (427);
insert into STOREPRODUCTS (storeproduct_id)
values (428);
insert into STOREPRODUCTS (storeproduct_id)
values (429);
insert into STOREPRODUCTS (storeproduct_id)
values (430);
insert into STOREPRODUCTS (storeproduct_id)
values (431);
insert into STOREPRODUCTS (storeproduct_id)
values (432);
insert into STOREPRODUCTS (storeproduct_id)
values (433);
insert into STOREPRODUCTS (storeproduct_id)
values (435);
insert into STOREPRODUCTS (storeproduct_id)
values (436);
insert into STOREPRODUCTS (storeproduct_id)
values (439);
insert into STOREPRODUCTS (storeproduct_id)
values (440);
insert into STOREPRODUCTS (storeproduct_id)
values (441);
insert into STOREPRODUCTS (storeproduct_id)
values (442);
insert into STOREPRODUCTS (storeproduct_id)
values (443);
insert into STOREPRODUCTS (storeproduct_id)
values (444);
insert into STOREPRODUCTS (storeproduct_id)
values (445);
insert into STOREPRODUCTS (storeproduct_id)
values (447);
insert into STOREPRODUCTS (storeproduct_id)
values (448);
insert into STOREPRODUCTS (storeproduct_id)
values (453);
insert into STOREPRODUCTS (storeproduct_id)
values (456);
insert into STOREPRODUCTS (storeproduct_id)
values (457);
insert into STOREPRODUCTS (storeproduct_id)
values (459);
insert into STOREPRODUCTS (storeproduct_id)
values (463);
insert into STOREPRODUCTS (storeproduct_id)
values (464);
insert into STOREPRODUCTS (storeproduct_id)
values (466);
insert into STOREPRODUCTS (storeproduct_id)
values (467);
insert into STOREPRODUCTS (storeproduct_id)
values (471);
insert into STOREPRODUCTS (storeproduct_id)
values (472);
insert into STOREPRODUCTS (storeproduct_id)
values (474);
insert into STOREPRODUCTS (storeproduct_id)
values (477);
insert into STOREPRODUCTS (storeproduct_id)
values (478);
insert into STOREPRODUCTS (storeproduct_id)
values (482);
insert into STOREPRODUCTS (storeproduct_id)
values (483);
insert into STOREPRODUCTS (storeproduct_id)
values (484);
insert into STOREPRODUCTS (storeproduct_id)
values (488);
insert into STOREPRODUCTS (storeproduct_id)
values (491);
insert into STOREPRODUCTS (storeproduct_id)
values (492);
insert into STOREPRODUCTS (storeproduct_id)
values (495);
insert into STOREPRODUCTS (storeproduct_id)
values (496);
insert into STOREPRODUCTS (storeproduct_id)
values (499);
insert into STOREPRODUCTS (storeproduct_id)
values (500);
insert into STOREPRODUCTS (storeproduct_id)
values (501);
insert into STOREPRODUCTS (storeproduct_id)
values (502);
insert into STOREPRODUCTS (storeproduct_id)
values (503);
insert into STOREPRODUCTS (storeproduct_id)
values (504);
insert into STOREPRODUCTS (storeproduct_id)
values (505);
insert into STOREPRODUCTS (storeproduct_id)
values (507);
insert into STOREPRODUCTS (storeproduct_id)
values (509);
insert into STOREPRODUCTS (storeproduct_id)
values (510);
insert into STOREPRODUCTS (storeproduct_id)
values (511);
insert into STOREPRODUCTS (storeproduct_id)
values (512);
insert into STOREPRODUCTS (storeproduct_id)
values (513);
insert into STOREPRODUCTS (storeproduct_id)
values (514);
insert into STOREPRODUCTS (storeproduct_id)
values (515);
insert into STOREPRODUCTS (storeproduct_id)
values (516);
insert into STOREPRODUCTS (storeproduct_id)
values (517);
insert into STOREPRODUCTS (storeproduct_id)
values (518);
insert into STOREPRODUCTS (storeproduct_id)
values (520);
insert into STOREPRODUCTS (storeproduct_id)
values (521);
insert into STOREPRODUCTS (storeproduct_id)
values (523);
insert into STOREPRODUCTS (storeproduct_id)
values (524);
insert into STOREPRODUCTS (storeproduct_id)
values (526);
insert into STOREPRODUCTS (storeproduct_id)
values (527);
insert into STOREPRODUCTS (storeproduct_id)
values (528);
insert into STOREPRODUCTS (storeproduct_id)
values (529);
insert into STOREPRODUCTS (storeproduct_id)
values (530);
insert into STOREPRODUCTS (storeproduct_id)
values (531);
insert into STOREPRODUCTS (storeproduct_id)
values (532);
insert into STOREPRODUCTS (storeproduct_id)
values (533);
insert into STOREPRODUCTS (storeproduct_id)
values (535);
insert into STOREPRODUCTS (storeproduct_id)
values (536);
insert into STOREPRODUCTS (storeproduct_id)
values (539);
insert into STOREPRODUCTS (storeproduct_id)
values (540);
insert into STOREPRODUCTS (storeproduct_id)
values (541);
insert into STOREPRODUCTS (storeproduct_id)
values (542);
insert into STOREPRODUCTS (storeproduct_id)
values (543);
insert into STOREPRODUCTS (storeproduct_id)
values (544);
insert into STOREPRODUCTS (storeproduct_id)
values (545);
insert into STOREPRODUCTS (storeproduct_id)
values (547);
insert into STOREPRODUCTS (storeproduct_id)
values (548);
insert into STOREPRODUCTS (storeproduct_id)
values (553);
insert into STOREPRODUCTS (storeproduct_id)
values (556);
insert into STOREPRODUCTS (storeproduct_id)
values (557);
insert into STOREPRODUCTS (storeproduct_id)
values (559);
insert into STOREPRODUCTS (storeproduct_id)
values (563);
insert into STOREPRODUCTS (storeproduct_id)
values (564);
insert into STOREPRODUCTS (storeproduct_id)
values (566);
insert into STOREPRODUCTS (storeproduct_id)
values (567);
insert into STOREPRODUCTS (storeproduct_id)
values (571);
insert into STOREPRODUCTS (storeproduct_id)
values (572);
insert into STOREPRODUCTS (storeproduct_id)
values (574);
insert into STOREPRODUCTS (storeproduct_id)
values (577);
commit;
prompt 300 records committed...
insert into STOREPRODUCTS (storeproduct_id)
values (578);
insert into STOREPRODUCTS (storeproduct_id)
values (582);
insert into STOREPRODUCTS (storeproduct_id)
values (583);
insert into STOREPRODUCTS (storeproduct_id)
values (584);
insert into STOREPRODUCTS (storeproduct_id)
values (588);
insert into STOREPRODUCTS (storeproduct_id)
values (591);
insert into STOREPRODUCTS (storeproduct_id)
values (592);
insert into STOREPRODUCTS (storeproduct_id)
values (595);
insert into STOREPRODUCTS (storeproduct_id)
values (596);
insert into STOREPRODUCTS (storeproduct_id)
values (599);
insert into STOREPRODUCTS (storeproduct_id)
values (600);
insert into STOREPRODUCTS (storeproduct_id)
values (601);
insert into STOREPRODUCTS (storeproduct_id)
values (602);
insert into STOREPRODUCTS (storeproduct_id)
values (603);
insert into STOREPRODUCTS (storeproduct_id)
values (604);
insert into STOREPRODUCTS (storeproduct_id)
values (605);
insert into STOREPRODUCTS (storeproduct_id)
values (607);
insert into STOREPRODUCTS (storeproduct_id)
values (609);
insert into STOREPRODUCTS (storeproduct_id)
values (610);
insert into STOREPRODUCTS (storeproduct_id)
values (611);
insert into STOREPRODUCTS (storeproduct_id)
values (612);
insert into STOREPRODUCTS (storeproduct_id)
values (613);
insert into STOREPRODUCTS (storeproduct_id)
values (614);
insert into STOREPRODUCTS (storeproduct_id)
values (615);
insert into STOREPRODUCTS (storeproduct_id)
values (616);
insert into STOREPRODUCTS (storeproduct_id)
values (617);
insert into STOREPRODUCTS (storeproduct_id)
values (618);
insert into STOREPRODUCTS (storeproduct_id)
values (620);
insert into STOREPRODUCTS (storeproduct_id)
values (621);
insert into STOREPRODUCTS (storeproduct_id)
values (623);
insert into STOREPRODUCTS (storeproduct_id)
values (624);
insert into STOREPRODUCTS (storeproduct_id)
values (626);
insert into STOREPRODUCTS (storeproduct_id)
values (627);
insert into STOREPRODUCTS (storeproduct_id)
values (628);
insert into STOREPRODUCTS (storeproduct_id)
values (629);
insert into STOREPRODUCTS (storeproduct_id)
values (630);
insert into STOREPRODUCTS (storeproduct_id)
values (631);
insert into STOREPRODUCTS (storeproduct_id)
values (632);
insert into STOREPRODUCTS (storeproduct_id)
values (633);
insert into STOREPRODUCTS (storeproduct_id)
values (635);
insert into STOREPRODUCTS (storeproduct_id)
values (636);
insert into STOREPRODUCTS (storeproduct_id)
values (639);
insert into STOREPRODUCTS (storeproduct_id)
values (640);
insert into STOREPRODUCTS (storeproduct_id)
values (641);
insert into STOREPRODUCTS (storeproduct_id)
values (642);
insert into STOREPRODUCTS (storeproduct_id)
values (643);
insert into STOREPRODUCTS (storeproduct_id)
values (644);
insert into STOREPRODUCTS (storeproduct_id)
values (645);
insert into STOREPRODUCTS (storeproduct_id)
values (647);
insert into STOREPRODUCTS (storeproduct_id)
values (648);
insert into STOREPRODUCTS (storeproduct_id)
values (653);
insert into STOREPRODUCTS (storeproduct_id)
values (656);
insert into STOREPRODUCTS (storeproduct_id)
values (657);
insert into STOREPRODUCTS (storeproduct_id)
values (659);
insert into STOREPRODUCTS (storeproduct_id)
values (663);
insert into STOREPRODUCTS (storeproduct_id)
values (664);
insert into STOREPRODUCTS (storeproduct_id)
values (666);
insert into STOREPRODUCTS (storeproduct_id)
values (667);
insert into STOREPRODUCTS (storeproduct_id)
values (671);
insert into STOREPRODUCTS (storeproduct_id)
values (672);
insert into STOREPRODUCTS (storeproduct_id)
values (674);
insert into STOREPRODUCTS (storeproduct_id)
values (677);
insert into STOREPRODUCTS (storeproduct_id)
values (678);
insert into STOREPRODUCTS (storeproduct_id)
values (682);
insert into STOREPRODUCTS (storeproduct_id)
values (683);
insert into STOREPRODUCTS (storeproduct_id)
values (684);
insert into STOREPRODUCTS (storeproduct_id)
values (688);
insert into STOREPRODUCTS (storeproduct_id)
values (691);
insert into STOREPRODUCTS (storeproduct_id)
values (692);
insert into STOREPRODUCTS (storeproduct_id)
values (695);
insert into STOREPRODUCTS (storeproduct_id)
values (696);
insert into STOREPRODUCTS (storeproduct_id)
values (699);
insert into STOREPRODUCTS (storeproduct_id)
values (606);
insert into STOREPRODUCTS (storeproduct_id)
values (608);
insert into STOREPRODUCTS (storeproduct_id)
values (619);
insert into STOREPRODUCTS (storeproduct_id)
values (622);
insert into STOREPRODUCTS (storeproduct_id)
values (625);
insert into STOREPRODUCTS (storeproduct_id)
values (634);
insert into STOREPRODUCTS (storeproduct_id)
values (637);
insert into STOREPRODUCTS (storeproduct_id)
values (638);
insert into STOREPRODUCTS (storeproduct_id)
values (646);
insert into STOREPRODUCTS (storeproduct_id)
values (651);
insert into STOREPRODUCTS (storeproduct_id)
values (655);
insert into STOREPRODUCTS (storeproduct_id)
values (658);
insert into STOREPRODUCTS (storeproduct_id)
values (662);
insert into STOREPRODUCTS (storeproduct_id)
values (665);
insert into STOREPRODUCTS (storeproduct_id)
values (668);
insert into STOREPRODUCTS (storeproduct_id)
values (669);
insert into STOREPRODUCTS (storeproduct_id)
values (670);
insert into STOREPRODUCTS (storeproduct_id)
values (673);
insert into STOREPRODUCTS (storeproduct_id)
values (675);
insert into STOREPRODUCTS (storeproduct_id)
values (676);
insert into STOREPRODUCTS (storeproduct_id)
values (680);
insert into STOREPRODUCTS (storeproduct_id)
values (681);
insert into STOREPRODUCTS (storeproduct_id)
values (685);
insert into STOREPRODUCTS (storeproduct_id)
values (686);
insert into STOREPRODUCTS (storeproduct_id)
values (689);
insert into STOREPRODUCTS (storeproduct_id)
values (694);
insert into STOREPRODUCTS (storeproduct_id)
values (698);
insert into STOREPRODUCTS (storeproduct_id)
values (700);
commit;
prompt 400 records committed...
insert into STOREPRODUCTS (storeproduct_id)
values (701);
insert into STOREPRODUCTS (storeproduct_id)
values (702);
insert into STOREPRODUCTS (storeproduct_id)
values (703);
insert into STOREPRODUCTS (storeproduct_id)
values (704);
insert into STOREPRODUCTS (storeproduct_id)
values (705);
insert into STOREPRODUCTS (storeproduct_id)
values (706);
insert into STOREPRODUCTS (storeproduct_id)
values (708);
insert into STOREPRODUCTS (storeproduct_id)
values (709);
insert into STOREPRODUCTS (storeproduct_id)
values (710);
insert into STOREPRODUCTS (storeproduct_id)
values (711);
insert into STOREPRODUCTS (storeproduct_id)
values (712);
insert into STOREPRODUCTS (storeproduct_id)
values (713);
insert into STOREPRODUCTS (storeproduct_id)
values (714);
insert into STOREPRODUCTS (storeproduct_id)
values (715);
insert into STOREPRODUCTS (storeproduct_id)
values (716);
insert into STOREPRODUCTS (storeproduct_id)
values (717);
insert into STOREPRODUCTS (storeproduct_id)
values (718);
insert into STOREPRODUCTS (storeproduct_id)
values (719);
insert into STOREPRODUCTS (storeproduct_id)
values (720);
insert into STOREPRODUCTS (storeproduct_id)
values (721);
insert into STOREPRODUCTS (storeproduct_id)
values (722);
insert into STOREPRODUCTS (storeproduct_id)
values (723);
insert into STOREPRODUCTS (storeproduct_id)
values (724);
insert into STOREPRODUCTS (storeproduct_id)
values (725);
insert into STOREPRODUCTS (storeproduct_id)
values (726);
insert into STOREPRODUCTS (storeproduct_id)
values (727);
insert into STOREPRODUCTS (storeproduct_id)
values (728);
insert into STOREPRODUCTS (storeproduct_id)
values (729);
insert into STOREPRODUCTS (storeproduct_id)
values (730);
insert into STOREPRODUCTS (storeproduct_id)
values (731);
insert into STOREPRODUCTS (storeproduct_id)
values (732);
insert into STOREPRODUCTS (storeproduct_id)
values (733);
insert into STOREPRODUCTS (storeproduct_id)
values (734);
insert into STOREPRODUCTS (storeproduct_id)
values (735);
insert into STOREPRODUCTS (storeproduct_id)
values (736);
insert into STOREPRODUCTS (storeproduct_id)
values (737);
insert into STOREPRODUCTS (storeproduct_id)
values (738);
insert into STOREPRODUCTS (storeproduct_id)
values (739);
insert into STOREPRODUCTS (storeproduct_id)
values (740);
insert into STOREPRODUCTS (storeproduct_id)
values (741);
insert into STOREPRODUCTS (storeproduct_id)
values (742);
insert into STOREPRODUCTS (storeproduct_id)
values (743);
insert into STOREPRODUCTS (storeproduct_id)
values (744);
insert into STOREPRODUCTS (storeproduct_id)
values (745);
insert into STOREPRODUCTS (storeproduct_id)
values (746);
insert into STOREPRODUCTS (storeproduct_id)
values (747);
insert into STOREPRODUCTS (storeproduct_id)
values (748);
insert into STOREPRODUCTS (storeproduct_id)
values (749);
insert into STOREPRODUCTS (storeproduct_id)
values (750);
insert into STOREPRODUCTS (storeproduct_id)
values (751);
insert into STOREPRODUCTS (storeproduct_id)
values (752);
insert into STOREPRODUCTS (storeproduct_id)
values (753);
insert into STOREPRODUCTS (storeproduct_id)
values (754);
insert into STOREPRODUCTS (storeproduct_id)
values (755);
insert into STOREPRODUCTS (storeproduct_id)
values (756);
insert into STOREPRODUCTS (storeproduct_id)
values (757);
insert into STOREPRODUCTS (storeproduct_id)
values (758);
insert into STOREPRODUCTS (storeproduct_id)
values (759);
insert into STOREPRODUCTS (storeproduct_id)
values (760);
insert into STOREPRODUCTS (storeproduct_id)
values (761);
insert into STOREPRODUCTS (storeproduct_id)
values (762);
insert into STOREPRODUCTS (storeproduct_id)
values (763);
insert into STOREPRODUCTS (storeproduct_id)
values (764);
insert into STOREPRODUCTS (storeproduct_id)
values (765);
insert into STOREPRODUCTS (storeproduct_id)
values (766);
insert into STOREPRODUCTS (storeproduct_id)
values (767);
insert into STOREPRODUCTS (storeproduct_id)
values (768);
insert into STOREPRODUCTS (storeproduct_id)
values (769);
insert into STOREPRODUCTS (storeproduct_id)
values (770);
insert into STOREPRODUCTS (storeproduct_id)
values (771);
insert into STOREPRODUCTS (storeproduct_id)
values (772);
insert into STOREPRODUCTS (storeproduct_id)
values (773);
insert into STOREPRODUCTS (storeproduct_id)
values (774);
insert into STOREPRODUCTS (storeproduct_id)
values (775);
insert into STOREPRODUCTS (storeproduct_id)
values (776);
insert into STOREPRODUCTS (storeproduct_id)
values (777);
insert into STOREPRODUCTS (storeproduct_id)
values (778);
insert into STOREPRODUCTS (storeproduct_id)
values (779);
insert into STOREPRODUCTS (storeproduct_id)
values (780);
insert into STOREPRODUCTS (storeproduct_id)
values (781);
insert into STOREPRODUCTS (storeproduct_id)
values (782);
insert into STOREPRODUCTS (storeproduct_id)
values (783);
insert into STOREPRODUCTS (storeproduct_id)
values (784);
insert into STOREPRODUCTS (storeproduct_id)
values (785);
insert into STOREPRODUCTS (storeproduct_id)
values (786);
insert into STOREPRODUCTS (storeproduct_id)
values (787);
insert into STOREPRODUCTS (storeproduct_id)
values (788);
insert into STOREPRODUCTS (storeproduct_id)
values (789);
insert into STOREPRODUCTS (storeproduct_id)
values (790);
insert into STOREPRODUCTS (storeproduct_id)
values (791);
insert into STOREPRODUCTS (storeproduct_id)
values (792);
insert into STOREPRODUCTS (storeproduct_id)
values (793);
insert into STOREPRODUCTS (storeproduct_id)
values (794);
insert into STOREPRODUCTS (storeproduct_id)
values (795);
insert into STOREPRODUCTS (storeproduct_id)
values (796);
insert into STOREPRODUCTS (storeproduct_id)
values (797);
insert into STOREPRODUCTS (storeproduct_id)
values (799);
insert into STOREPRODUCTS (storeproduct_id)
values (800);
insert into STOREPRODUCTS (storeproduct_id)
values (801);
insert into STOREPRODUCTS (storeproduct_id)
values (802);
commit;
prompt 500 records committed...
insert into STOREPRODUCTS (storeproduct_id)
values (803);
insert into STOREPRODUCTS (storeproduct_id)
values (804);
insert into STOREPRODUCTS (storeproduct_id)
values (805);
insert into STOREPRODUCTS (storeproduct_id)
values (806);
insert into STOREPRODUCTS (storeproduct_id)
values (807);
insert into STOREPRODUCTS (storeproduct_id)
values (808);
insert into STOREPRODUCTS (storeproduct_id)
values (809);
insert into STOREPRODUCTS (storeproduct_id)
values (810);
insert into STOREPRODUCTS (storeproduct_id)
values (811);
insert into STOREPRODUCTS (storeproduct_id)
values (812);
insert into STOREPRODUCTS (storeproduct_id)
values (813);
insert into STOREPRODUCTS (storeproduct_id)
values (814);
insert into STOREPRODUCTS (storeproduct_id)
values (815);
insert into STOREPRODUCTS (storeproduct_id)
values (816);
insert into STOREPRODUCTS (storeproduct_id)
values (818);
insert into STOREPRODUCTS (storeproduct_id)
values (819);
insert into STOREPRODUCTS (storeproduct_id)
values (820);
insert into STOREPRODUCTS (storeproduct_id)
values (821);
insert into STOREPRODUCTS (storeproduct_id)
values (822);
insert into STOREPRODUCTS (storeproduct_id)
values (823);
insert into STOREPRODUCTS (storeproduct_id)
values (824);
insert into STOREPRODUCTS (storeproduct_id)
values (825);
insert into STOREPRODUCTS (storeproduct_id)
values (826);
insert into STOREPRODUCTS (storeproduct_id)
values (827);
insert into STOREPRODUCTS (storeproduct_id)
values (828);
insert into STOREPRODUCTS (storeproduct_id)
values (829);
insert into STOREPRODUCTS (storeproduct_id)
values (830);
insert into STOREPRODUCTS (storeproduct_id)
values (831);
insert into STOREPRODUCTS (storeproduct_id)
values (832);
insert into STOREPRODUCTS (storeproduct_id)
values (833);
insert into STOREPRODUCTS (storeproduct_id)
values (834);
insert into STOREPRODUCTS (storeproduct_id)
values (835);
insert into STOREPRODUCTS (storeproduct_id)
values (836);
insert into STOREPRODUCTS (storeproduct_id)
values (837);
insert into STOREPRODUCTS (storeproduct_id)
values (838);
insert into STOREPRODUCTS (storeproduct_id)
values (839);
insert into STOREPRODUCTS (storeproduct_id)
values (840);
insert into STOREPRODUCTS (storeproduct_id)
values (841);
insert into STOREPRODUCTS (storeproduct_id)
values (842);
insert into STOREPRODUCTS (storeproduct_id)
values (843);
insert into STOREPRODUCTS (storeproduct_id)
values (844);
insert into STOREPRODUCTS (storeproduct_id)
values (845);
insert into STOREPRODUCTS (storeproduct_id)
values (846);
insert into STOREPRODUCTS (storeproduct_id)
values (847);
insert into STOREPRODUCTS (storeproduct_id)
values (848);
insert into STOREPRODUCTS (storeproduct_id)
values (849);
insert into STOREPRODUCTS (storeproduct_id)
values (850);
insert into STOREPRODUCTS (storeproduct_id)
values (851);
insert into STOREPRODUCTS (storeproduct_id)
values (852);
insert into STOREPRODUCTS (storeproduct_id)
values (853);
insert into STOREPRODUCTS (storeproduct_id)
values (854);
insert into STOREPRODUCTS (storeproduct_id)
values (856);
insert into STOREPRODUCTS (storeproduct_id)
values (857);
insert into STOREPRODUCTS (storeproduct_id)
values (858);
insert into STOREPRODUCTS (storeproduct_id)
values (859);
insert into STOREPRODUCTS (storeproduct_id)
values (860);
insert into STOREPRODUCTS (storeproduct_id)
values (861);
insert into STOREPRODUCTS (storeproduct_id)
values (862);
insert into STOREPRODUCTS (storeproduct_id)
values (863);
insert into STOREPRODUCTS (storeproduct_id)
values (864);
insert into STOREPRODUCTS (storeproduct_id)
values (865);
insert into STOREPRODUCTS (storeproduct_id)
values (866);
insert into STOREPRODUCTS (storeproduct_id)
values (867);
insert into STOREPRODUCTS (storeproduct_id)
values (868);
insert into STOREPRODUCTS (storeproduct_id)
values (869);
insert into STOREPRODUCTS (storeproduct_id)
values (870);
insert into STOREPRODUCTS (storeproduct_id)
values (871);
insert into STOREPRODUCTS (storeproduct_id)
values (872);
insert into STOREPRODUCTS (storeproduct_id)
values (873);
insert into STOREPRODUCTS (storeproduct_id)
values (874);
insert into STOREPRODUCTS (storeproduct_id)
values (875);
insert into STOREPRODUCTS (storeproduct_id)
values (876);
insert into STOREPRODUCTS (storeproduct_id)
values (877);
insert into STOREPRODUCTS (storeproduct_id)
values (878);
insert into STOREPRODUCTS (storeproduct_id)
values (879);
insert into STOREPRODUCTS (storeproduct_id)
values (880);
insert into STOREPRODUCTS (storeproduct_id)
values (881);
insert into STOREPRODUCTS (storeproduct_id)
values (882);
insert into STOREPRODUCTS (storeproduct_id)
values (883);
insert into STOREPRODUCTS (storeproduct_id)
values (884);
insert into STOREPRODUCTS (storeproduct_id)
values (885);
insert into STOREPRODUCTS (storeproduct_id)
values (886);
insert into STOREPRODUCTS (storeproduct_id)
values (887);
insert into STOREPRODUCTS (storeproduct_id)
values (888);
insert into STOREPRODUCTS (storeproduct_id)
values (889);
insert into STOREPRODUCTS (storeproduct_id)
values (890);
insert into STOREPRODUCTS (storeproduct_id)
values (891);
insert into STOREPRODUCTS (storeproduct_id)
values (892);
insert into STOREPRODUCTS (storeproduct_id)
values (893);
insert into STOREPRODUCTS (storeproduct_id)
values (894);
insert into STOREPRODUCTS (storeproduct_id)
values (895);
insert into STOREPRODUCTS (storeproduct_id)
values (896);
insert into STOREPRODUCTS (storeproduct_id)
values (897);
insert into STOREPRODUCTS (storeproduct_id)
values (898);
insert into STOREPRODUCTS (storeproduct_id)
values (899);
insert into STOREPRODUCTS (storeproduct_id)
values (900);
insert into STOREPRODUCTS (storeproduct_id)
values (901);
insert into STOREPRODUCTS (storeproduct_id)
values (902);
commit;
prompt 598 records loaded
prompt Loading ORDER_PRODUCT...
insert into ORDER_PRODUCT (product_id, order_id)
values (101, 201);
insert into ORDER_PRODUCT (product_id, order_id)
values (101, 601);
insert into ORDER_PRODUCT (product_id, order_id)
values (102, 902);
insert into ORDER_PRODUCT (product_id, order_id)
values (104, 804);
insert into ORDER_PRODUCT (product_id, order_id)
values (110, 110);
insert into ORDER_PRODUCT (product_id, order_id)
values (110, 610);
insert into ORDER_PRODUCT (product_id, order_id)
values (110, 910);
insert into ORDER_PRODUCT (product_id, order_id)
values (111, 211);
insert into ORDER_PRODUCT (product_id, order_id)
values (111, 611);
insert into ORDER_PRODUCT (product_id, order_id)
values (117, 617);
insert into ORDER_PRODUCT (product_id, order_id)
values (120, 120);
insert into ORDER_PRODUCT (product_id, order_id)
values (124, 124);
insert into ORDER_PRODUCT (product_id, order_id)
values (126, 626);
insert into ORDER_PRODUCT (product_id, order_id)
values (127, 827);
insert into ORDER_PRODUCT (product_id, order_id)
values (127, 927);
insert into ORDER_PRODUCT (product_id, order_id)
values (130, 130);
insert into ORDER_PRODUCT (product_id, order_id)
values (133, 233);
insert into ORDER_PRODUCT (product_id, order_id)
values (133, 833);
insert into ORDER_PRODUCT (product_id, order_id)
values (135, 835);
insert into ORDER_PRODUCT (product_id, order_id)
values (139, 139);
insert into ORDER_PRODUCT (product_id, order_id)
values (141, 641);
insert into ORDER_PRODUCT (product_id, order_id)
values (142, 142);
insert into ORDER_PRODUCT (product_id, order_id)
values (145, 945);
insert into ORDER_PRODUCT (product_id, order_id)
values (147, 947);
insert into ORDER_PRODUCT (product_id, order_id)
values (156, 656);
insert into ORDER_PRODUCT (product_id, order_id)
values (157, 657);
insert into ORDER_PRODUCT (product_id, order_id)
values (159, 159);
insert into ORDER_PRODUCT (product_id, order_id)
values (159, 859);
insert into ORDER_PRODUCT (product_id, order_id)
values (167, 667);
insert into ORDER_PRODUCT (product_id, order_id)
values (172, 272);
insert into ORDER_PRODUCT (product_id, order_id)
values (174, 174);
insert into ORDER_PRODUCT (product_id, order_id)
values (177, 877);
insert into ORDER_PRODUCT (product_id, order_id)
values (178, 178);
insert into ORDER_PRODUCT (product_id, order_id)
values (184, 984);
insert into ORDER_PRODUCT (product_id, order_id)
values (191, 191);
insert into ORDER_PRODUCT (product_id, order_id)
values (191, 991);
insert into ORDER_PRODUCT (product_id, order_id)
values (192, 692);
insert into ORDER_PRODUCT (product_id, order_id)
values (192, 892);
insert into ORDER_PRODUCT (product_id, order_id)
values (196, 996);
insert into ORDER_PRODUCT (product_id, order_id)
values (199, 299);
insert into ORDER_PRODUCT (product_id, order_id)
values (201, 101);
insert into ORDER_PRODUCT (product_id, order_id)
values (201, 201);
insert into ORDER_PRODUCT (product_id, order_id)
values (201, 601);
insert into ORDER_PRODUCT (product_id, order_id)
values (202, 302);
insert into ORDER_PRODUCT (product_id, order_id)
values (202, 702);
insert into ORDER_PRODUCT (product_id, order_id)
values (202, 902);
insert into ORDER_PRODUCT (product_id, order_id)
values (203, 703);
insert into ORDER_PRODUCT (product_id, order_id)
values (204, 104);
insert into ORDER_PRODUCT (product_id, order_id)
values (204, 704);
insert into ORDER_PRODUCT (product_id, order_id)
values (205, 105);
insert into ORDER_PRODUCT (product_id, order_id)
values (209, 109);
insert into ORDER_PRODUCT (product_id, order_id)
values (209, 309);
insert into ORDER_PRODUCT (product_id, order_id)
values (210, 110);
insert into ORDER_PRODUCT (product_id, order_id)
values (210, 610);
insert into ORDER_PRODUCT (product_id, order_id)
values (210, 910);
insert into ORDER_PRODUCT (product_id, order_id)
values (211, 111);
insert into ORDER_PRODUCT (product_id, order_id)
values (211, 211);
insert into ORDER_PRODUCT (product_id, order_id)
values (211, 611);
insert into ORDER_PRODUCT (product_id, order_id)
values (212, 112);
insert into ORDER_PRODUCT (product_id, order_id)
values (217, 617);
insert into ORDER_PRODUCT (product_id, order_id)
values (218, 318);
insert into ORDER_PRODUCT (product_id, order_id)
values (220, 120);
insert into ORDER_PRODUCT (product_id, order_id)
values (220, 320);
insert into ORDER_PRODUCT (product_id, order_id)
values (223, 323);
insert into ORDER_PRODUCT (product_id, order_id)
values (223, 723);
insert into ORDER_PRODUCT (product_id, order_id)
values (224, 124);
insert into ORDER_PRODUCT (product_id, order_id)
values (226, 626);
insert into ORDER_PRODUCT (product_id, order_id)
values (227, 927);
insert into ORDER_PRODUCT (product_id, order_id)
values (230, 130);
insert into ORDER_PRODUCT (product_id, order_id)
values (231, 131);
insert into ORDER_PRODUCT (product_id, order_id)
values (231, 331);
insert into ORDER_PRODUCT (product_id, order_id)
values (233, 133);
insert into ORDER_PRODUCT (product_id, order_id)
values (233, 233);
insert into ORDER_PRODUCT (product_id, order_id)
values (235, 135);
insert into ORDER_PRODUCT (product_id, order_id)
values (239, 139);
insert into ORDER_PRODUCT (product_id, order_id)
values (241, 641);
insert into ORDER_PRODUCT (product_id, order_id)
values (242, 142);
insert into ORDER_PRODUCT (product_id, order_id)
values (244, 144);
insert into ORDER_PRODUCT (product_id, order_id)
values (245, 145);
insert into ORDER_PRODUCT (product_id, order_id)
values (245, 945);
insert into ORDER_PRODUCT (product_id, order_id)
values (247, 147);
insert into ORDER_PRODUCT (product_id, order_id)
values (247, 947);
insert into ORDER_PRODUCT (product_id, order_id)
values (248, 148);
insert into ORDER_PRODUCT (product_id, order_id)
values (256, 656);
insert into ORDER_PRODUCT (product_id, order_id)
values (257, 657);
insert into ORDER_PRODUCT (product_id, order_id)
values (259, 159);
insert into ORDER_PRODUCT (product_id, order_id)
values (263, 163);
insert into ORDER_PRODUCT (product_id, order_id)
values (264, 164);
insert into ORDER_PRODUCT (product_id, order_id)
values (264, 764);
insert into ORDER_PRODUCT (product_id, order_id)
values (266, 166);
insert into ORDER_PRODUCT (product_id, order_id)
values (267, 167);
insert into ORDER_PRODUCT (product_id, order_id)
values (267, 667);
insert into ORDER_PRODUCT (product_id, order_id)
values (272, 272);
insert into ORDER_PRODUCT (product_id, order_id)
values (274, 174);
insert into ORDER_PRODUCT (product_id, order_id)
values (277, 177);
insert into ORDER_PRODUCT (product_id, order_id)
values (277, 377);
insert into ORDER_PRODUCT (product_id, order_id)
values (278, 178);
insert into ORDER_PRODUCT (product_id, order_id)
values (283, 183);
insert into ORDER_PRODUCT (product_id, order_id)
values (284, 984);
insert into ORDER_PRODUCT (product_id, order_id)
values (288, 388);
commit;
prompt 100 records committed...
insert into ORDER_PRODUCT (product_id, order_id)
values (291, 191);
insert into ORDER_PRODUCT (product_id, order_id)
values (291, 991);
insert into ORDER_PRODUCT (product_id, order_id)
values (292, 192);
insert into ORDER_PRODUCT (product_id, order_id)
values (292, 692);
insert into ORDER_PRODUCT (product_id, order_id)
values (296, 996);
insert into ORDER_PRODUCT (product_id, order_id)
values (299, 299);
insert into ORDER_PRODUCT (product_id, order_id)
values (300, 200);
insert into ORDER_PRODUCT (product_id, order_id)
values (301, 201);
insert into ORDER_PRODUCT (product_id, order_id)
values (302, 302);
insert into ORDER_PRODUCT (product_id, order_id)
values (302, 702);
insert into ORDER_PRODUCT (product_id, order_id)
values (302, 902);
insert into ORDER_PRODUCT (product_id, order_id)
values (303, 703);
insert into ORDER_PRODUCT (product_id, order_id)
values (304, 204);
insert into ORDER_PRODUCT (product_id, order_id)
values (304, 704);
insert into ORDER_PRODUCT (product_id, order_id)
values (304, 804);
insert into ORDER_PRODUCT (product_id, order_id)
values (309, 309);
insert into ORDER_PRODUCT (product_id, order_id)
values (310, 110);
insert into ORDER_PRODUCT (product_id, order_id)
values (310, 210);
insert into ORDER_PRODUCT (product_id, order_id)
values (310, 910);
insert into ORDER_PRODUCT (product_id, order_id)
values (311, 211);
insert into ORDER_PRODUCT (product_id, order_id)
values (312, 212);
insert into ORDER_PRODUCT (product_id, order_id)
values (313, 213);
insert into ORDER_PRODUCT (product_id, order_id)
values (318, 318);
insert into ORDER_PRODUCT (product_id, order_id)
values (318, 418);
insert into ORDER_PRODUCT (product_id, order_id)
values (320, 120);
insert into ORDER_PRODUCT (product_id, order_id)
values (320, 220);
insert into ORDER_PRODUCT (product_id, order_id)
values (320, 320);
insert into ORDER_PRODUCT (product_id, order_id)
values (321, 221);
insert into ORDER_PRODUCT (product_id, order_id)
values (323, 323);
insert into ORDER_PRODUCT (product_id, order_id)
values (323, 723);
insert into ORDER_PRODUCT (product_id, order_id)
values (324, 124);
insert into ORDER_PRODUCT (product_id, order_id)
values (324, 224);
insert into ORDER_PRODUCT (product_id, order_id)
values (327, 827);
insert into ORDER_PRODUCT (product_id, order_id)
values (327, 927);
insert into ORDER_PRODUCT (product_id, order_id)
values (330, 130);
insert into ORDER_PRODUCT (product_id, order_id)
values (330, 230);
insert into ORDER_PRODUCT (product_id, order_id)
values (331, 331);
insert into ORDER_PRODUCT (product_id, order_id)
values (332, 232);
insert into ORDER_PRODUCT (product_id, order_id)
values (332, 432);
insert into ORDER_PRODUCT (product_id, order_id)
values (333, 233);
insert into ORDER_PRODUCT (product_id, order_id)
values (333, 833);
insert into ORDER_PRODUCT (product_id, order_id)
values (335, 835);
insert into ORDER_PRODUCT (product_id, order_id)
values (339, 139);
insert into ORDER_PRODUCT (product_id, order_id)
values (342, 142);
insert into ORDER_PRODUCT (product_id, order_id)
values (344, 444);
insert into ORDER_PRODUCT (product_id, order_id)
values (345, 945);
insert into ORDER_PRODUCT (product_id, order_id)
values (347, 947);
insert into ORDER_PRODUCT (product_id, order_id)
values (356, 256);
insert into ORDER_PRODUCT (product_id, order_id)
values (359, 159);
insert into ORDER_PRODUCT (product_id, order_id)
values (359, 259);
insert into ORDER_PRODUCT (product_id, order_id)
values (359, 859);
insert into ORDER_PRODUCT (product_id, order_id)
values (364, 264);
insert into ORDER_PRODUCT (product_id, order_id)
values (364, 764);
insert into ORDER_PRODUCT (product_id, order_id)
values (366, 266);
insert into ORDER_PRODUCT (product_id, order_id)
values (371, 271);
insert into ORDER_PRODUCT (product_id, order_id)
values (372, 272);
insert into ORDER_PRODUCT (product_id, order_id)
values (374, 174);
insert into ORDER_PRODUCT (product_id, order_id)
values (377, 277);
insert into ORDER_PRODUCT (product_id, order_id)
values (377, 377);
insert into ORDER_PRODUCT (product_id, order_id)
values (377, 877);
insert into ORDER_PRODUCT (product_id, order_id)
values (378, 178);
insert into ORDER_PRODUCT (product_id, order_id)
values (384, 984);
insert into ORDER_PRODUCT (product_id, order_id)
values (388, 388);
insert into ORDER_PRODUCT (product_id, order_id)
values (391, 191);
insert into ORDER_PRODUCT (product_id, order_id)
values (391, 991);
insert into ORDER_PRODUCT (product_id, order_id)
values (392, 892);
insert into ORDER_PRODUCT (product_id, order_id)
values (395, 295);
insert into ORDER_PRODUCT (product_id, order_id)
values (395, 495);
insert into ORDER_PRODUCT (product_id, order_id)
values (396, 996);
insert into ORDER_PRODUCT (product_id, order_id)
values (399, 299);
insert into ORDER_PRODUCT (product_id, order_id)
values (400, 300);
insert into ORDER_PRODUCT (product_id, order_id)
values (401, 301);
insert into ORDER_PRODUCT (product_id, order_id)
values (402, 302);
insert into ORDER_PRODUCT (product_id, order_id)
values (402, 902);
insert into ORDER_PRODUCT (product_id, order_id)
values (404, 304);
insert into ORDER_PRODUCT (product_id, order_id)
values (404, 804);
insert into ORDER_PRODUCT (product_id, order_id)
values (405, 305);
insert into ORDER_PRODUCT (product_id, order_id)
values (407, 307);
insert into ORDER_PRODUCT (product_id, order_id)
values (409, 309);
insert into ORDER_PRODUCT (product_id, order_id)
values (410, 110);
insert into ORDER_PRODUCT (product_id, order_id)
values (410, 310);
insert into ORDER_PRODUCT (product_id, order_id)
values (410, 910);
insert into ORDER_PRODUCT (product_id, order_id)
values (411, 311);
insert into ORDER_PRODUCT (product_id, order_id)
values (413, 313);
insert into ORDER_PRODUCT (product_id, order_id)
values (415, 315);
insert into ORDER_PRODUCT (product_id, order_id)
values (416, 316);
insert into ORDER_PRODUCT (product_id, order_id)
values (418, 318);
insert into ORDER_PRODUCT (product_id, order_id)
values (418, 418);
insert into ORDER_PRODUCT (product_id, order_id)
values (420, 120);
insert into ORDER_PRODUCT (product_id, order_id)
values (420, 320);
insert into ORDER_PRODUCT (product_id, order_id)
values (421, 321);
insert into ORDER_PRODUCT (product_id, order_id)
values (423, 323);
insert into ORDER_PRODUCT (product_id, order_id)
values (424, 124);
insert into ORDER_PRODUCT (product_id, order_id)
values (426, 326);
insert into ORDER_PRODUCT (product_id, order_id)
values (427, 327);
insert into ORDER_PRODUCT (product_id, order_id)
values (427, 827);
insert into ORDER_PRODUCT (product_id, order_id)
values (427, 927);
insert into ORDER_PRODUCT (product_id, order_id)
values (430, 130);
insert into ORDER_PRODUCT (product_id, order_id)
values (430, 330);
insert into ORDER_PRODUCT (product_id, order_id)
values (431, 331);
commit;
prompt 200 records committed...
insert into ORDER_PRODUCT (product_id, order_id)
values (432, 332);
insert into ORDER_PRODUCT (product_id, order_id)
values (432, 432);
insert into ORDER_PRODUCT (product_id, order_id)
values (433, 833);
insert into ORDER_PRODUCT (product_id, order_id)
values (435, 335);
insert into ORDER_PRODUCT (product_id, order_id)
values (435, 835);
insert into ORDER_PRODUCT (product_id, order_id)
values (436, 336);
insert into ORDER_PRODUCT (product_id, order_id)
values (439, 139);
insert into ORDER_PRODUCT (product_id, order_id)
values (439, 339);
insert into ORDER_PRODUCT (product_id, order_id)
values (440, 340);
insert into ORDER_PRODUCT (product_id, order_id)
values (442, 142);
insert into ORDER_PRODUCT (product_id, order_id)
values (442, 342);
insert into ORDER_PRODUCT (product_id, order_id)
values (443, 343);
insert into ORDER_PRODUCT (product_id, order_id)
values (444, 444);
insert into ORDER_PRODUCT (product_id, order_id)
values (445, 945);
insert into ORDER_PRODUCT (product_id, order_id)
values (447, 947);
insert into ORDER_PRODUCT (product_id, order_id)
values (459, 159);
insert into ORDER_PRODUCT (product_id, order_id)
values (459, 359);
insert into ORDER_PRODUCT (product_id, order_id)
values (459, 859);
insert into ORDER_PRODUCT (product_id, order_id)
values (466, 366);
insert into ORDER_PRODUCT (product_id, order_id)
values (467, 367);
insert into ORDER_PRODUCT (product_id, order_id)
values (471, 371);
insert into ORDER_PRODUCT (product_id, order_id)
values (474, 174);
insert into ORDER_PRODUCT (product_id, order_id)
values (477, 377);
insert into ORDER_PRODUCT (product_id, order_id)
values (477, 877);
insert into ORDER_PRODUCT (product_id, order_id)
values (478, 178);
insert into ORDER_PRODUCT (product_id, order_id)
values (478, 378);
insert into ORDER_PRODUCT (product_id, order_id)
values (483, 383);
insert into ORDER_PRODUCT (product_id, order_id)
values (484, 984);
insert into ORDER_PRODUCT (product_id, order_id)
values (488, 388);
insert into ORDER_PRODUCT (product_id, order_id)
values (491, 191);
insert into ORDER_PRODUCT (product_id, order_id)
values (491, 391);
insert into ORDER_PRODUCT (product_id, order_id)
values (491, 991);
insert into ORDER_PRODUCT (product_id, order_id)
values (492, 892);
insert into ORDER_PRODUCT (product_id, order_id)
values (495, 395);
insert into ORDER_PRODUCT (product_id, order_id)
values (495, 495);
insert into ORDER_PRODUCT (product_id, order_id)
values (496, 396);
insert into ORDER_PRODUCT (product_id, order_id)
values (496, 996);
insert into ORDER_PRODUCT (product_id, order_id)
values (500, 400);
insert into ORDER_PRODUCT (product_id, order_id)
values (501, 201);
insert into ORDER_PRODUCT (product_id, order_id)
values (502, 502);
insert into ORDER_PRODUCT (product_id, order_id)
values (502, 902);
insert into ORDER_PRODUCT (product_id, order_id)
values (503, 403);
insert into ORDER_PRODUCT (product_id, order_id)
values (504, 404);
insert into ORDER_PRODUCT (product_id, order_id)
values (509, 409);
insert into ORDER_PRODUCT (product_id, order_id)
values (510, 110);
insert into ORDER_PRODUCT (product_id, order_id)
values (510, 410);
insert into ORDER_PRODUCT (product_id, order_id)
values (510, 910);
insert into ORDER_PRODUCT (product_id, order_id)
values (511, 211);
insert into ORDER_PRODUCT (product_id, order_id)
values (511, 411);
insert into ORDER_PRODUCT (product_id, order_id)
values (514, 414);
insert into ORDER_PRODUCT (product_id, order_id)
values (514, 514);
insert into ORDER_PRODUCT (product_id, order_id)
values (517, 417);
insert into ORDER_PRODUCT (product_id, order_id)
values (518, 418);
insert into ORDER_PRODUCT (product_id, order_id)
values (520, 120);
insert into ORDER_PRODUCT (product_id, order_id)
values (520, 420);
insert into ORDER_PRODUCT (product_id, order_id)
values (521, 421);
insert into ORDER_PRODUCT (product_id, order_id)
values (523, 423);
insert into ORDER_PRODUCT (product_id, order_id)
values (524, 124);
insert into ORDER_PRODUCT (product_id, order_id)
values (527, 927);
insert into ORDER_PRODUCT (product_id, order_id)
values (528, 428);
insert into ORDER_PRODUCT (product_id, order_id)
values (529, 429);
insert into ORDER_PRODUCT (product_id, order_id)
values (530, 130);
insert into ORDER_PRODUCT (product_id, order_id)
values (532, 432);
insert into ORDER_PRODUCT (product_id, order_id)
values (533, 233);
insert into ORDER_PRODUCT (product_id, order_id)
values (533, 433);
insert into ORDER_PRODUCT (product_id, order_id)
values (536, 436);
insert into ORDER_PRODUCT (product_id, order_id)
values (539, 139);
insert into ORDER_PRODUCT (product_id, order_id)
values (539, 439);
insert into ORDER_PRODUCT (product_id, order_id)
values (540, 440);
insert into ORDER_PRODUCT (product_id, order_id)
values (540, 540);
insert into ORDER_PRODUCT (product_id, order_id)
values (542, 142);
insert into ORDER_PRODUCT (product_id, order_id)
values (542, 442);
insert into ORDER_PRODUCT (product_id, order_id)
values (544, 444);
insert into ORDER_PRODUCT (product_id, order_id)
values (545, 445);
insert into ORDER_PRODUCT (product_id, order_id)
values (545, 945);
insert into ORDER_PRODUCT (product_id, order_id)
values (547, 947);
insert into ORDER_PRODUCT (product_id, order_id)
values (553, 553);
insert into ORDER_PRODUCT (product_id, order_id)
values (557, 557);
insert into ORDER_PRODUCT (product_id, order_id)
values (559, 159);
insert into ORDER_PRODUCT (product_id, order_id)
values (567, 567);
insert into ORDER_PRODUCT (product_id, order_id)
values (571, 471);
insert into ORDER_PRODUCT (product_id, order_id)
values (572, 272);
insert into ORDER_PRODUCT (product_id, order_id)
values (572, 572);
insert into ORDER_PRODUCT (product_id, order_id)
values (574, 174);
insert into ORDER_PRODUCT (product_id, order_id)
values (574, 474);
insert into ORDER_PRODUCT (product_id, order_id)
values (577, 577);
insert into ORDER_PRODUCT (product_id, order_id)
values (578, 178);
insert into ORDER_PRODUCT (product_id, order_id)
values (578, 478);
insert into ORDER_PRODUCT (product_id, order_id)
values (584, 984);
insert into ORDER_PRODUCT (product_id, order_id)
values (591, 191);
insert into ORDER_PRODUCT (product_id, order_id)
values (591, 491);
insert into ORDER_PRODUCT (product_id, order_id)
values (591, 991);
insert into ORDER_PRODUCT (product_id, order_id)
values (595, 495);
insert into ORDER_PRODUCT (product_id, order_id)
values (596, 496);
insert into ORDER_PRODUCT (product_id, order_id)
values (596, 996);
insert into ORDER_PRODUCT (product_id, order_id)
values (599, 299);
insert into ORDER_PRODUCT (product_id, order_id)
values (600, 500);
insert into ORDER_PRODUCT (product_id, order_id)
values (601, 201);
insert into ORDER_PRODUCT (product_id, order_id)
values (601, 601);
insert into ORDER_PRODUCT (product_id, order_id)
values (602, 502);
commit;
prompt 300 records committed...
insert into ORDER_PRODUCT (product_id, order_id)
values (604, 504);
insert into ORDER_PRODUCT (product_id, order_id)
values (605, 505);
insert into ORDER_PRODUCT (product_id, order_id)
values (608, 508);
insert into ORDER_PRODUCT (product_id, order_id)
values (610, 610);
insert into ORDER_PRODUCT (product_id, order_id)
values (611, 211);
insert into ORDER_PRODUCT (product_id, order_id)
values (611, 611);
insert into ORDER_PRODUCT (product_id, order_id)
values (614, 514);
insert into ORDER_PRODUCT (product_id, order_id)
values (615, 515);
insert into ORDER_PRODUCT (product_id, order_id)
values (617, 617);
insert into ORDER_PRODUCT (product_id, order_id)
values (625, 525);
insert into ORDER_PRODUCT (product_id, order_id)
values (626, 626);
insert into ORDER_PRODUCT (product_id, order_id)
values (631, 531);
insert into ORDER_PRODUCT (product_id, order_id)
values (633, 233);
insert into ORDER_PRODUCT (product_id, order_id)
values (633, 533);
insert into ORDER_PRODUCT (product_id, order_id)
values (635, 535);
insert into ORDER_PRODUCT (product_id, order_id)
values (636, 536);
insert into ORDER_PRODUCT (product_id, order_id)
values (637, 537);
insert into ORDER_PRODUCT (product_id, order_id)
values (640, 540);
insert into ORDER_PRODUCT (product_id, order_id)
values (641, 541);
insert into ORDER_PRODUCT (product_id, order_id)
values (641, 641);
insert into ORDER_PRODUCT (product_id, order_id)
values (643, 543);
insert into ORDER_PRODUCT (product_id, order_id)
values (646, 246);
insert into ORDER_PRODUCT (product_id, order_id)
values (647, 547);
insert into ORDER_PRODUCT (product_id, order_id)
values (653, 553);
insert into ORDER_PRODUCT (product_id, order_id)
values (655, 555);
insert into ORDER_PRODUCT (product_id, order_id)
values (656, 556);
insert into ORDER_PRODUCT (product_id, order_id)
values (656, 656);
insert into ORDER_PRODUCT (product_id, order_id)
values (657, 557);
insert into ORDER_PRODUCT (product_id, order_id)
values (657, 657);
insert into ORDER_PRODUCT (product_id, order_id)
values (665, 565);
insert into ORDER_PRODUCT (product_id, order_id)
values (665, 665);
insert into ORDER_PRODUCT (product_id, order_id)
values (667, 567);
insert into ORDER_PRODUCT (product_id, order_id)
values (667, 667);
insert into ORDER_PRODUCT (product_id, order_id)
values (669, 569);
insert into ORDER_PRODUCT (product_id, order_id)
values (671, 571);
insert into ORDER_PRODUCT (product_id, order_id)
values (672, 272);
insert into ORDER_PRODUCT (product_id, order_id)
values (672, 572);
insert into ORDER_PRODUCT (product_id, order_id)
values (674, 574);
insert into ORDER_PRODUCT (product_id, order_id)
values (677, 577);
insert into ORDER_PRODUCT (product_id, order_id)
values (680, 580);
insert into ORDER_PRODUCT (product_id, order_id)
values (682, 582);
insert into ORDER_PRODUCT (product_id, order_id)
values (684, 584);
insert into ORDER_PRODUCT (product_id, order_id)
values (689, 589);
insert into ORDER_PRODUCT (product_id, order_id)
values (692, 592);
insert into ORDER_PRODUCT (product_id, order_id)
values (692, 692);
insert into ORDER_PRODUCT (product_id, order_id)
values (699, 299);
insert into ORDER_PRODUCT (product_id, order_id)
values (699, 599);
insert into ORDER_PRODUCT (product_id, order_id)
values (701, 201);
insert into ORDER_PRODUCT (product_id, order_id)
values (701, 601);
insert into ORDER_PRODUCT (product_id, order_id)
values (702, 302);
insert into ORDER_PRODUCT (product_id, order_id)
values (702, 502);
insert into ORDER_PRODUCT (product_id, order_id)
values (702, 702);
insert into ORDER_PRODUCT (product_id, order_id)
values (703, 603);
insert into ORDER_PRODUCT (product_id, order_id)
values (703, 703);
insert into ORDER_PRODUCT (product_id, order_id)
values (704, 604);
insert into ORDER_PRODUCT (product_id, order_id)
values (704, 704);
insert into ORDER_PRODUCT (product_id, order_id)
values (708, 608);
insert into ORDER_PRODUCT (product_id, order_id)
values (709, 309);
insert into ORDER_PRODUCT (product_id, order_id)
values (709, 609);
insert into ORDER_PRODUCT (product_id, order_id)
values (710, 610);
insert into ORDER_PRODUCT (product_id, order_id)
values (711, 211);
insert into ORDER_PRODUCT (product_id, order_id)
values (711, 611);
insert into ORDER_PRODUCT (product_id, order_id)
values (714, 514);
insert into ORDER_PRODUCT (product_id, order_id)
values (715, 615);
insert into ORDER_PRODUCT (product_id, order_id)
values (717, 617);
insert into ORDER_PRODUCT (product_id, order_id)
values (718, 318);
insert into ORDER_PRODUCT (product_id, order_id)
values (719, 619);
insert into ORDER_PRODUCT (product_id, order_id)
values (720, 320);
insert into ORDER_PRODUCT (product_id, order_id)
values (720, 620);
insert into ORDER_PRODUCT (product_id, order_id)
values (722, 622);
insert into ORDER_PRODUCT (product_id, order_id)
values (723, 323);
insert into ORDER_PRODUCT (product_id, order_id)
values (723, 723);
insert into ORDER_PRODUCT (product_id, order_id)
values (726, 626);
insert into ORDER_PRODUCT (product_id, order_id)
values (727, 627);
insert into ORDER_PRODUCT (product_id, order_id)
values (728, 628);
insert into ORDER_PRODUCT (product_id, order_id)
values (730, 630);
insert into ORDER_PRODUCT (product_id, order_id)
values (731, 331);
insert into ORDER_PRODUCT (product_id, order_id)
values (732, 632);
insert into ORDER_PRODUCT (product_id, order_id)
values (733, 233);
insert into ORDER_PRODUCT (product_id, order_id)
values (733, 633);
insert into ORDER_PRODUCT (product_id, order_id)
values (734, 734);
insert into ORDER_PRODUCT (product_id, order_id)
values (735, 635);
insert into ORDER_PRODUCT (product_id, order_id)
values (737, 737);
insert into ORDER_PRODUCT (product_id, order_id)
values (738, 638);
insert into ORDER_PRODUCT (product_id, order_id)
values (740, 540);
insert into ORDER_PRODUCT (product_id, order_id)
values (740, 640);
insert into ORDER_PRODUCT (product_id, order_id)
values (741, 641);
insert into ORDER_PRODUCT (product_id, order_id)
values (742, 642);
insert into ORDER_PRODUCT (product_id, order_id)
values (743, 643);
insert into ORDER_PRODUCT (product_id, order_id)
values (744, 644);
insert into ORDER_PRODUCT (product_id, order_id)
values (745, 645);
insert into ORDER_PRODUCT (product_id, order_id)
values (746, 246);
insert into ORDER_PRODUCT (product_id, order_id)
values (747, 647);
insert into ORDER_PRODUCT (product_id, order_id)
values (749, 249);
insert into ORDER_PRODUCT (product_id, order_id)
values (750, 350);
insert into ORDER_PRODUCT (product_id, order_id)
values (750, 650);
insert into ORDER_PRODUCT (product_id, order_id)
values (751, 651);
insert into ORDER_PRODUCT (product_id, order_id)
values (752, 352);
insert into ORDER_PRODUCT (product_id, order_id)
values (753, 553);
insert into ORDER_PRODUCT (product_id, order_id)
values (753, 653);
commit;
prompt 400 records committed...
insert into ORDER_PRODUCT (product_id, order_id)
values (754, 354);
insert into ORDER_PRODUCT (product_id, order_id)
values (755, 555);
insert into ORDER_PRODUCT (product_id, order_id)
values (756, 656);
insert into ORDER_PRODUCT (product_id, order_id)
values (757, 557);
insert into ORDER_PRODUCT (product_id, order_id)
values (757, 657);
insert into ORDER_PRODUCT (product_id, order_id)
values (761, 261);
insert into ORDER_PRODUCT (product_id, order_id)
values (761, 361);
insert into ORDER_PRODUCT (product_id, order_id)
values (761, 561);
insert into ORDER_PRODUCT (product_id, order_id)
values (762, 362);
insert into ORDER_PRODUCT (product_id, order_id)
values (764, 764);
insert into ORDER_PRODUCT (product_id, order_id)
values (765, 565);
insert into ORDER_PRODUCT (product_id, order_id)
values (765, 665);
insert into ORDER_PRODUCT (product_id, order_id)
values (767, 567);
insert into ORDER_PRODUCT (product_id, order_id)
values (767, 667);
insert into ORDER_PRODUCT (product_id, order_id)
values (768, 668);
insert into ORDER_PRODUCT (product_id, order_id)
values (770, 670);
insert into ORDER_PRODUCT (product_id, order_id)
values (772, 272);
insert into ORDER_PRODUCT (product_id, order_id)
values (772, 572);
insert into ORDER_PRODUCT (product_id, order_id)
values (775, 675);
insert into ORDER_PRODUCT (product_id, order_id)
values (776, 676);
insert into ORDER_PRODUCT (product_id, order_id)
values (777, 377);
insert into ORDER_PRODUCT (product_id, order_id)
values (777, 577);
insert into ORDER_PRODUCT (product_id, order_id)
values (778, 678);
insert into ORDER_PRODUCT (product_id, order_id)
values (779, 679);
insert into ORDER_PRODUCT (product_id, order_id)
values (781, 381);
insert into ORDER_PRODUCT (product_id, order_id)
values (781, 681);
insert into ORDER_PRODUCT (product_id, order_id)
values (783, 683);
insert into ORDER_PRODUCT (product_id, order_id)
values (786, 786);
insert into ORDER_PRODUCT (product_id, order_id)
values (787, 687);
insert into ORDER_PRODUCT (product_id, order_id)
values (788, 388);
insert into ORDER_PRODUCT (product_id, order_id)
values (791, 691);
insert into ORDER_PRODUCT (product_id, order_id)
values (792, 692);
insert into ORDER_PRODUCT (product_id, order_id)
values (796, 696);
insert into ORDER_PRODUCT (product_id, order_id)
values (797, 597);
insert into ORDER_PRODUCT (product_id, order_id)
values (799, 299);
insert into ORDER_PRODUCT (product_id, order_id)
values (800, 700);
insert into ORDER_PRODUCT (product_id, order_id)
values (801, 601);
insert into ORDER_PRODUCT (product_id, order_id)
values (801, 701);
insert into ORDER_PRODUCT (product_id, order_id)
values (802, 302);
insert into ORDER_PRODUCT (product_id, order_id)
values (802, 702);
insert into ORDER_PRODUCT (product_id, order_id)
values (803, 703);
insert into ORDER_PRODUCT (product_id, order_id)
values (804, 704);
insert into ORDER_PRODUCT (product_id, order_id)
values (804, 804);
insert into ORDER_PRODUCT (product_id, order_id)
values (806, 706);
insert into ORDER_PRODUCT (product_id, order_id)
values (808, 708);
insert into ORDER_PRODUCT (product_id, order_id)
values (809, 309);
insert into ORDER_PRODUCT (product_id, order_id)
values (810, 610);
insert into ORDER_PRODUCT (product_id, order_id)
values (810, 710);
insert into ORDER_PRODUCT (product_id, order_id)
values (811, 611);
insert into ORDER_PRODUCT (product_id, order_id)
values (814, 714);
insert into ORDER_PRODUCT (product_id, order_id)
values (816, 716);
insert into ORDER_PRODUCT (product_id, order_id)
values (818, 318);
insert into ORDER_PRODUCT (product_id, order_id)
values (820, 320);
insert into ORDER_PRODUCT (product_id, order_id)
values (820, 720);
insert into ORDER_PRODUCT (product_id, order_id)
values (821, 721);
insert into ORDER_PRODUCT (product_id, order_id)
values (823, 323);
insert into ORDER_PRODUCT (product_id, order_id)
values (823, 723);
insert into ORDER_PRODUCT (product_id, order_id)
values (824, 724);
insert into ORDER_PRODUCT (product_id, order_id)
values (825, 725);
insert into ORDER_PRODUCT (product_id, order_id)
values (826, 626);
insert into ORDER_PRODUCT (product_id, order_id)
values (827, 727);
insert into ORDER_PRODUCT (product_id, order_id)
values (827, 827);
insert into ORDER_PRODUCT (product_id, order_id)
values (829, 729);
insert into ORDER_PRODUCT (product_id, order_id)
values (830, 730);
insert into ORDER_PRODUCT (product_id, order_id)
values (831, 331);
insert into ORDER_PRODUCT (product_id, order_id)
values (832, 732);
insert into ORDER_PRODUCT (product_id, order_id)
values (833, 833);
insert into ORDER_PRODUCT (product_id, order_id)
values (834, 734);
insert into ORDER_PRODUCT (product_id, order_id)
values (835, 835);
insert into ORDER_PRODUCT (product_id, order_id)
values (836, 736);
insert into ORDER_PRODUCT (product_id, order_id)
values (837, 737);
insert into ORDER_PRODUCT (product_id, order_id)
values (839, 739);
insert into ORDER_PRODUCT (product_id, order_id)
values (841, 641);
insert into ORDER_PRODUCT (product_id, order_id)
values (844, 744);
insert into ORDER_PRODUCT (product_id, order_id)
values (845, 745);
insert into ORDER_PRODUCT (product_id, order_id)
values (847, 747);
insert into ORDER_PRODUCT (product_id, order_id)
values (848, 748);
insert into ORDER_PRODUCT (product_id, order_id)
values (849, 749);
insert into ORDER_PRODUCT (product_id, order_id)
values (850, 350);
insert into ORDER_PRODUCT (product_id, order_id)
values (850, 750);
insert into ORDER_PRODUCT (product_id, order_id)
values (852, 352);
insert into ORDER_PRODUCT (product_id, order_id)
values (853, 753);
insert into ORDER_PRODUCT (product_id, order_id)
values (854, 354);
insert into ORDER_PRODUCT (product_id, order_id)
values (854, 754);
insert into ORDER_PRODUCT (product_id, order_id)
values (856, 656);
insert into ORDER_PRODUCT (product_id, order_id)
values (856, 756);
insert into ORDER_PRODUCT (product_id, order_id)
values (857, 657);
insert into ORDER_PRODUCT (product_id, order_id)
values (857, 757);
insert into ORDER_PRODUCT (product_id, order_id)
values (859, 859);
insert into ORDER_PRODUCT (product_id, order_id)
values (861, 361);
insert into ORDER_PRODUCT (product_id, order_id)
values (862, 362);
insert into ORDER_PRODUCT (product_id, order_id)
values (862, 762);
insert into ORDER_PRODUCT (product_id, order_id)
values (863, 763);
insert into ORDER_PRODUCT (product_id, order_id)
values (864, 764);
insert into ORDER_PRODUCT (product_id, order_id)
values (865, 665);
insert into ORDER_PRODUCT (product_id, order_id)
values (866, 766);
insert into ORDER_PRODUCT (product_id, order_id)
values (867, 667);
insert into ORDER_PRODUCT (product_id, order_id)
values (872, 772);
insert into ORDER_PRODUCT (product_id, order_id)
values (875, 775);
insert into ORDER_PRODUCT (product_id, order_id)
values (876, 776);
commit;
prompt 500 records committed...
insert into ORDER_PRODUCT (product_id, order_id)
values (877, 377);
insert into ORDER_PRODUCT (product_id, order_id)
values (877, 777);
insert into ORDER_PRODUCT (product_id, order_id)
values (877, 877);
insert into ORDER_PRODUCT (product_id, order_id)
values (878, 778);
insert into ORDER_PRODUCT (product_id, order_id)
values (880, 780);
insert into ORDER_PRODUCT (product_id, order_id)
values (881, 381);
insert into ORDER_PRODUCT (product_id, order_id)
values (882, 782);
insert into ORDER_PRODUCT (product_id, order_id)
values (883, 783);
insert into ORDER_PRODUCT (product_id, order_id)
values (886, 786);
insert into ORDER_PRODUCT (product_id, order_id)
values (888, 388);
insert into ORDER_PRODUCT (product_id, order_id)
values (889, 889);
insert into ORDER_PRODUCT (product_id, order_id)
values (890, 890);
insert into ORDER_PRODUCT (product_id, order_id)
values (891, 791);
insert into ORDER_PRODUCT (product_id, order_id)
values (892, 692);
insert into ORDER_PRODUCT (product_id, order_id)
values (892, 792);
insert into ORDER_PRODUCT (product_id, order_id)
values (892, 892);
insert into ORDER_PRODUCT (product_id, order_id)
values (893, 893);
insert into ORDER_PRODUCT (product_id, order_id)
values (895, 795);
insert into ORDER_PRODUCT (product_id, order_id)
values (897, 897);
insert into ORDER_PRODUCT (product_id, order_id)
values (898, 798);
commit;
prompt 520 records loaded
prompt Loading SUPPLIER...
insert into SUPPLIER (supplier_id, region)
values (100, 'Maarssen');
insert into SUPPLIER (supplier_id, region)
values (101, 'Franklin');
insert into SUPPLIER (supplier_id, region)
values (102, 'Sorocaba');
insert into SUPPLIER (supplier_id, region)
values (103, 'Morioka');
insert into SUPPLIER (supplier_id, region)
values (104, 'Tlalpan');
insert into SUPPLIER (supplier_id, region)
values (105, 'Gummersbach');
insert into SUPPLIER (supplier_id, region)
values (106, 'Tokyo');
insert into SUPPLIER (supplier_id, region)
values (107, 'Springville');
insert into SUPPLIER (supplier_id, region)
values (108, 'Montreal');
insert into SUPPLIER (supplier_id, region)
values (109, 'Monroe');
insert into SUPPLIER (supplier_id, region)
values (110, 'Stanford');
insert into SUPPLIER (supplier_id, region)
values (111, 'Wakayama');
insert into SUPPLIER (supplier_id, region)
values (112, 'Chur');
insert into SUPPLIER (supplier_id, region)
values (113, 'Moreno Valley');
insert into SUPPLIER (supplier_id, region)
values (114, 'Palo Alto');
insert into SUPPLIER (supplier_id, region)
values (115, 'Pirapora bom Je');
insert into SUPPLIER (supplier_id, region)
values (116, 'Coslada');
insert into SUPPLIER (supplier_id, region)
values (118, 'Whittier');
insert into SUPPLIER (supplier_id, region)
values (119, 'High Wycombe');
insert into SUPPLIER (supplier_id, region)
values (120, 'Richmond');
insert into SUPPLIER (supplier_id, region)
values (121, 'Monterrey');
insert into SUPPLIER (supplier_id, region)
values (122, 'Olsztyn');
insert into SUPPLIER (supplier_id, region)
values (123, 'Monterrey');
insert into SUPPLIER (supplier_id, region)
values (124, 'Goiania');
insert into SUPPLIER (supplier_id, region)
values (125, 'Brisbane');
insert into SUPPLIER (supplier_id, region)
values (126, 'Lake worth');
insert into SUPPLIER (supplier_id, region)
values (127, 'Nizhnevartovsk');
insert into SUPPLIER (supplier_id, region)
values (128, 'Angers');
insert into SUPPLIER (supplier_id, region)
values (129, 'Des Plaines');
insert into SUPPLIER (supplier_id, region)
values (130, 'Storrington');
insert into SUPPLIER (supplier_id, region)
values (131, 'Kaohsiung');
insert into SUPPLIER (supplier_id, region)
values (132, 'Adamstown');
insert into SUPPLIER (supplier_id, region)
values (133, 'Lincoln');
insert into SUPPLIER (supplier_id, region)
values (134, 'Yamagata');
insert into SUPPLIER (supplier_id, region)
values (135, 'Oberwangen');
insert into SUPPLIER (supplier_id, region)
values (136, 'Adelaide');
insert into SUPPLIER (supplier_id, region)
values (138, 'West Chester');
insert into SUPPLIER (supplier_id, region)
values (139, 'Aberdeen');
insert into SUPPLIER (supplier_id, region)
values (140, 'Zurich');
insert into SUPPLIER (supplier_id, region)
values (141, 'Fukuoka');
insert into SUPPLIER (supplier_id, region)
values (142, 'Toledo');
insert into SUPPLIER (supplier_id, region)
values (143, 'Salvador');
insert into SUPPLIER (supplier_id, region)
values (144, 'Copenhagen');
insert into SUPPLIER (supplier_id, region)
values (145, 'Streamwood');
insert into SUPPLIER (supplier_id, region)
values (146, 'Utrecht');
insert into SUPPLIER (supplier_id, region)
values (147, 'Kevelaer');
insert into SUPPLIER (supplier_id, region)
values (148, 'Takapuna');
insert into SUPPLIER (supplier_id, region)
values (149, 'Leverkusen');
insert into SUPPLIER (supplier_id, region)
values (150, 'Bozeman');
insert into SUPPLIER (supplier_id, region)
values (151, 'Saint Paul');
insert into SUPPLIER (supplier_id, region)
values (152, 'Kaysville');
insert into SUPPLIER (supplier_id, region)
values (153, 'Terrasa');
insert into SUPPLIER (supplier_id, region)
values (154, 'Peine');
insert into SUPPLIER (supplier_id, region)
values (155, 'Suwon-city');
insert into SUPPLIER (supplier_id, region)
values (156, 'Vantaa');
insert into SUPPLIER (supplier_id, region)
values (157, 'Fort worth');
insert into SUPPLIER (supplier_id, region)
values (158, 'Sparrows Point');
insert into SUPPLIER (supplier_id, region)
values (159, 'Seatle');
insert into SUPPLIER (supplier_id, region)
values (160, 'Thame');
insert into SUPPLIER (supplier_id, region)
values (161, 'Longview');
insert into SUPPLIER (supplier_id, region)
values (162, 'Tadley');
insert into SUPPLIER (supplier_id, region)
values (163, 'West Sussex');
insert into SUPPLIER (supplier_id, region)
values (164, 'Macau');
insert into SUPPLIER (supplier_id, region)
values (165, 'Kungens kurva');
insert into SUPPLIER (supplier_id, region)
values (166, 'Anyang-si');
insert into SUPPLIER (supplier_id, region)
values (167, 'Paderborn');
insert into SUPPLIER (supplier_id, region)
values (168, 'Moreno Valley');
insert into SUPPLIER (supplier_id, region)
values (169, 'Spresiano');
insert into SUPPLIER (supplier_id, region)
values (170, 'Mechelen');
insert into SUPPLIER (supplier_id, region)
values (171, 'Snoqualmie');
insert into SUPPLIER (supplier_id, region)
values (172, 'Mumbai');
insert into SUPPLIER (supplier_id, region)
values (173, 'Tucson');
insert into SUPPLIER (supplier_id, region)
values (175, 'Gelsenkirchen');
insert into SUPPLIER (supplier_id, region)
values (176, 'Mount Laurel');
insert into SUPPLIER (supplier_id, region)
values (177, 'Stockholm');
insert into SUPPLIER (supplier_id, region)
values (178, 'Ferraz  vasconc');
insert into SUPPLIER (supplier_id, region)
values (179, 'Lenexa');
insert into SUPPLIER (supplier_id, region)
values (180, 'North bethesda');
insert into SUPPLIER (supplier_id, region)
values (181, 'San Ramon');
insert into SUPPLIER (supplier_id, region)
values (182, 'Coppell');
insert into SUPPLIER (supplier_id, region)
values (183, 'Pasadena');
insert into SUPPLIER (supplier_id, region)
values (184, 'Menlo Park');
insert into SUPPLIER (supplier_id, region)
values (185, 'Athens');
insert into SUPPLIER (supplier_id, region)
values (186, 'Niles');
insert into SUPPLIER (supplier_id, region)
values (187, 'Barueri');
insert into SUPPLIER (supplier_id, region)
values (188, 'Sorocaba');
insert into SUPPLIER (supplier_id, region)
values (189, 'Traralgon');
insert into SUPPLIER (supplier_id, region)
values (190, 'West Sussex');
insert into SUPPLIER (supplier_id, region)
values (191, 'Bekescsaba');
insert into SUPPLIER (supplier_id, region)
values (192, 'Kyoto');
insert into SUPPLIER (supplier_id, region)
values (193, 'Verwood');
insert into SUPPLIER (supplier_id, region)
values (194, 'Fairborn');
insert into SUPPLIER (supplier_id, region)
values (195, 'Kingston');
insert into SUPPLIER (supplier_id, region)
values (196, 'West Lafayette');
insert into SUPPLIER (supplier_id, region)
values (197, 'Zuerich');
insert into SUPPLIER (supplier_id, region)
values (198, 'San Ramon');
insert into SUPPLIER (supplier_id, region)
values (199, 'Charlottesville');
insert into SUPPLIER (supplier_id, region)
values (301, 'Pompeia');
insert into SUPPLIER (supplier_id, region)
values (302, 'Mablethorpe');
insert into SUPPLIER (supplier_id, region)
values (303, 'Fairfax');
commit;
prompt 100 records committed...
insert into SUPPLIER (supplier_id, region)
values (304, 'Geneve');
insert into SUPPLIER (supplier_id, region)
values (305, 'Columbus');
insert into SUPPLIER (supplier_id, region)
values (306, 'Ithaca');
insert into SUPPLIER (supplier_id, region)
values (307, 'Vallauris');
insert into SUPPLIER (supplier_id, region)
values (308, 'Glendale');
insert into SUPPLIER (supplier_id, region)
values (309, 'Venice');
insert into SUPPLIER (supplier_id, region)
values (310, 'Silver Spring');
insert into SUPPLIER (supplier_id, region)
values (311, 'Wavre');
insert into SUPPLIER (supplier_id, region)
values (312, 'Altamonte Sprin');
insert into SUPPLIER (supplier_id, region)
values (313, 'Billund');
insert into SUPPLIER (supplier_id, region)
values (314, 'Ft. Leavenworth');
insert into SUPPLIER (supplier_id, region)
values (315, 'Milsons Point');
insert into SUPPLIER (supplier_id, region)
values (316, 'Dorval');
insert into SUPPLIER (supplier_id, region)
values (317, 'Horb');
insert into SUPPLIER (supplier_id, region)
values (318, 'Tokushima');
insert into SUPPLIER (supplier_id, region)
values (319, 'Fuchstal-asch');
insert into SUPPLIER (supplier_id, region)
values (320, 'Berlin-Adlersho');
insert into SUPPLIER (supplier_id, region)
values (321, 'Monroe');
insert into SUPPLIER (supplier_id, region)
values (322, 'Maebashi');
insert into SUPPLIER (supplier_id, region)
values (323, 'Coldmeece');
insert into SUPPLIER (supplier_id, region)
values (324, 'Rua eteno');
insert into SUPPLIER (supplier_id, region)
values (325, 'Rosario');
insert into SUPPLIER (supplier_id, region)
values (326, 'Natal');
insert into SUPPLIER (supplier_id, region)
values (327, 'Koeln');
insert into SUPPLIER (supplier_id, region)
values (328, 'Irkutsk');
insert into SUPPLIER (supplier_id, region)
values (329, 'Duisburg');
insert into SUPPLIER (supplier_id, region)
values (330, 'Roanoke');
insert into SUPPLIER (supplier_id, region)
values (331, 'Brentwood');
insert into SUPPLIER (supplier_id, region)
values (332, 'Maryville');
insert into SUPPLIER (supplier_id, region)
values (333, 'Zwolle');
insert into SUPPLIER (supplier_id, region)
values (334, 'Schlieren');
insert into SUPPLIER (supplier_id, region)
values (335, 'Overland park');
insert into SUPPLIER (supplier_id, region)
values (336, 'Matsuyama');
insert into SUPPLIER (supplier_id, region)
values (337, 'Runcorn');
insert into SUPPLIER (supplier_id, region)
values (338, 'Wuerzburg');
insert into SUPPLIER (supplier_id, region)
values (339, 'Dearborn');
insert into SUPPLIER (supplier_id, region)
values (340, 'Leinfelden-Echt');
insert into SUPPLIER (supplier_id, region)
values (341, 'Appenzell');
insert into SUPPLIER (supplier_id, region)
values (342, 'Chicago');
insert into SUPPLIER (supplier_id, region)
values (343, 'Warrington');
insert into SUPPLIER (supplier_id, region)
values (344, 'Solikamsk');
insert into SUPPLIER (supplier_id, region)
values (345, 'Sao caetano do ');
insert into SUPPLIER (supplier_id, region)
values (346, 'Pandrup');
insert into SUPPLIER (supplier_id, region)
values (347, 'Tualatin');
insert into SUPPLIER (supplier_id, region)
values (348, 'Hermitage');
insert into SUPPLIER (supplier_id, region)
values (349, 'Kreuzau');
insert into SUPPLIER (supplier_id, region)
values (350, 'Takapuna');
insert into SUPPLIER (supplier_id, region)
values (351, 'Ricardson');
insert into SUPPLIER (supplier_id, region)
values (352, 'Hackensack');
insert into SUPPLIER (supplier_id, region)
values (353, 'Guadalajara');
insert into SUPPLIER (supplier_id, region)
values (354, 'Villata');
insert into SUPPLIER (supplier_id, region)
values (355, 'El Masnou');
insert into SUPPLIER (supplier_id, region)
values (356, 'Waalwijk');
insert into SUPPLIER (supplier_id, region)
values (358, 'Sorocaba');
insert into SUPPLIER (supplier_id, region)
values (359, 'Bedfordshire');
insert into SUPPLIER (supplier_id, region)
values (360, 'Lexington');
insert into SUPPLIER (supplier_id, region)
values (361, 'Huntsville');
insert into SUPPLIER (supplier_id, region)
values (362, 'Derwood');
insert into SUPPLIER (supplier_id, region)
values (363, 'Billerica');
insert into SUPPLIER (supplier_id, region)
values (364, 'Terrasa');
insert into SUPPLIER (supplier_id, region)
values (365, 'Guadalajara');
insert into SUPPLIER (supplier_id, region)
values (366, 'Los Angeles');
insert into SUPPLIER (supplier_id, region)
values (367, 'Franklin');
insert into SUPPLIER (supplier_id, region)
values (368, 'Edmonton');
insert into SUPPLIER (supplier_id, region)
values (369, 'Barcelona');
insert into SUPPLIER (supplier_id, region)
values (370, 'Yomgok-dong');
insert into SUPPLIER (supplier_id, region)
values (371, 'Matsue');
insert into SUPPLIER (supplier_id, region)
values (372, 'Sorocaba');
insert into SUPPLIER (supplier_id, region)
values (373, 'Lathrop');
insert into SUPPLIER (supplier_id, region)
values (374, 'Zurich');
insert into SUPPLIER (supplier_id, region)
values (375, 'Milwaukee');
insert into SUPPLIER (supplier_id, region)
values (376, 'Laguna Bbeach');
insert into SUPPLIER (supplier_id, region)
values (377, 'Hamburg');
insert into SUPPLIER (supplier_id, region)
values (378, 'Ettlingen');
insert into SUPPLIER (supplier_id, region)
values (379, 'Taoyuan');
insert into SUPPLIER (supplier_id, region)
values (380, 'Breda');
insert into SUPPLIER (supplier_id, region)
values (381, 'Monmouth');
insert into SUPPLIER (supplier_id, region)
values (382, 'Trieste');
insert into SUPPLIER (supplier_id, region)
values (383, 'Buenos Aires');
insert into SUPPLIER (supplier_id, region)
values (384, 'Birkenhead');
insert into SUPPLIER (supplier_id, region)
values (385, 'Naestved');
insert into SUPPLIER (supplier_id, region)
values (386, 'Essen');
insert into SUPPLIER (supplier_id, region)
values (387, 'Valladolid');
insert into SUPPLIER (supplier_id, region)
values (389, 'Zwolle');
insert into SUPPLIER (supplier_id, region)
values (390, 'Kreuzau');
insert into SUPPLIER (supplier_id, region)
values (391, 'Bellevue');
insert into SUPPLIER (supplier_id, region)
values (392, 'New orleans');
insert into SUPPLIER (supplier_id, region)
values (393, 'Shoreline');
insert into SUPPLIER (supplier_id, region)
values (394, 'Sainte-foy');
insert into SUPPLIER (supplier_id, region)
values (396, 'Parsippany');
insert into SUPPLIER (supplier_id, region)
values (397, 'San Francisco');
insert into SUPPLIER (supplier_id, region)
values (398, 'Mito');
insert into SUPPLIER (supplier_id, region)
values (399, 'Ohita');
insert into SUPPLIER (supplier_id, region)
values (400, 'Lake worth');
insert into SUPPLIER (supplier_id, region)
values (401, 'Farmington Hill');
insert into SUPPLIER (supplier_id, region)
values (402, 'San Jose');
insert into SUPPLIER (supplier_id, region)
values (404, 'Huntington');
insert into SUPPLIER (supplier_id, region)
values (405, 'Hayward');
insert into SUPPLIER (supplier_id, region)
values (406, 'Columbia');
insert into SUPPLIER (supplier_id, region)
values (407, 'Kuraby');
commit;
prompt 200 records committed...
insert into SUPPLIER (supplier_id, region)
values (409, 'Dalmine');
insert into SUPPLIER (supplier_id, region)
values (410, 'Debary');
insert into SUPPLIER (supplier_id, region)
values (411, 'Dortmund');
insert into SUPPLIER (supplier_id, region)
values (412, 'Mablethorpe');
insert into SUPPLIER (supplier_id, region)
values (413, 'Mountain View');
insert into SUPPLIER (supplier_id, region)
values (414, 'Karachi');
insert into SUPPLIER (supplier_id, region)
values (415, 'Tottori');
insert into SUPPLIER (supplier_id, region)
values (416, 'Edwardstown');
insert into SUPPLIER (supplier_id, region)
values (417, 'Curitiba');
insert into SUPPLIER (supplier_id, region)
values (418, 'Nuernberg');
insert into SUPPLIER (supplier_id, region)
values (419, 'Coppell');
insert into SUPPLIER (supplier_id, region)
values (420, 'Edison');
insert into SUPPLIER (supplier_id, region)
values (421, 'Huntington');
insert into SUPPLIER (supplier_id, region)
values (422, 'Santa Cruz');
insert into SUPPLIER (supplier_id, region)
values (423, 'Parsippany');
insert into SUPPLIER (supplier_id, region)
values (424, 'Franklin');
insert into SUPPLIER (supplier_id, region)
values (425, 'Alpharetta');
insert into SUPPLIER (supplier_id, region)
values (426, 'South Jordan');
insert into SUPPLIER (supplier_id, region)
values (427, 'Berlin-Adlersho');
insert into SUPPLIER (supplier_id, region)
values (428, 'Horsham');
insert into SUPPLIER (supplier_id, region)
values (429, 'Pacific Grove');
insert into SUPPLIER (supplier_id, region)
values (430, 'Barnegat');
insert into SUPPLIER (supplier_id, region)
values (431, 'Seoul');
insert into SUPPLIER (supplier_id, region)
values (432, 'Hochwald');
insert into SUPPLIER (supplier_id, region)
values (433, 'Neuquen');
insert into SUPPLIER (supplier_id, region)
values (434, 'Adamstown');
insert into SUPPLIER (supplier_id, region)
values (435, 'Mantova');
insert into SUPPLIER (supplier_id, region)
values (436, 'Szazhalombatta');
insert into SUPPLIER (supplier_id, region)
values (437, 'Greenville');
insert into SUPPLIER (supplier_id, region)
values (438, 'Bloomington');
insert into SUPPLIER (supplier_id, region)
values (439, 'Carlingford');
insert into SUPPLIER (supplier_id, region)
values (440, 'San Jose');
insert into SUPPLIER (supplier_id, region)
values (441, 'Edison');
insert into SUPPLIER (supplier_id, region)
values (442, 'Winnipeg');
insert into SUPPLIER (supplier_id, region)
values (443, 'Maintenon');
insert into SUPPLIER (supplier_id, region)
values (444, 'Silver Spring');
insert into SUPPLIER (supplier_id, region)
values (445, 'Netanya');
insert into SUPPLIER (supplier_id, region)
values (446, 'Sao caetano do ');
insert into SUPPLIER (supplier_id, region)
values (447, 'Somerset');
insert into SUPPLIER (supplier_id, region)
values (448, 'Lexington');
insert into SUPPLIER (supplier_id, region)
values (449, 'Helsingborg');
insert into SUPPLIER (supplier_id, region)
values (450, 'Green bay');
insert into SUPPLIER (supplier_id, region)
values (451, 'Rochester');
insert into SUPPLIER (supplier_id, region)
values (452, 'Newcastle upon ');
insert into SUPPLIER (supplier_id, region)
values (453, 'Santa Clarat');
insert into SUPPLIER (supplier_id, region)
values (454, 'Long Island Cit');
insert into SUPPLIER (supplier_id, region)
values (455, 'Ludbreg');
insert into SUPPLIER (supplier_id, region)
values (456, 'Key Biscayne');
insert into SUPPLIER (supplier_id, region)
values (457, 'Lake worth');
insert into SUPPLIER (supplier_id, region)
values (458, 'Herne');
insert into SUPPLIER (supplier_id, region)
values (459, 'Berlin-Adlersho');
insert into SUPPLIER (supplier_id, region)
values (460, 'N. ft. Myers');
insert into SUPPLIER (supplier_id, region)
values (461, 'Smyrna');
insert into SUPPLIER (supplier_id, region)
values (462, 'Boucherville');
insert into SUPPLIER (supplier_id, region)
values (463, 'Berkshire');
insert into SUPPLIER (supplier_id, region)
values (464, 'Zaandam');
insert into SUPPLIER (supplier_id, region)
values (465, 'Ricardson');
insert into SUPPLIER (supplier_id, region)
values (466, 'Lima');
insert into SUPPLIER (supplier_id, region)
values (467, 'Piacenza');
insert into SUPPLIER (supplier_id, region)
values (468, 'Chapeco');
insert into SUPPLIER (supplier_id, region)
values (469, 'Middleburg Heig');
insert into SUPPLIER (supplier_id, region)
values (470, 'Kuraby');
insert into SUPPLIER (supplier_id, region)
values (471, 'Cardiff');
insert into SUPPLIER (supplier_id, region)
values (472, 'Hilversum');
insert into SUPPLIER (supplier_id, region)
values (473, 'Gainesville');
insert into SUPPLIER (supplier_id, region)
values (474, 'Campana');
insert into SUPPLIER (supplier_id, region)
values (475, 'El Dorado Hills');
insert into SUPPLIER (supplier_id, region)
values (476, 'Ohtsu');
insert into SUPPLIER (supplier_id, region)
values (477, 'Lund');
insert into SUPPLIER (supplier_id, region)
values (478, 'Scottsdale');
insert into SUPPLIER (supplier_id, region)
values (479, 'Milford');
insert into SUPPLIER (supplier_id, region)
values (480, 'Vallauris');
insert into SUPPLIER (supplier_id, region)
values (481, 'Di Savigliano');
insert into SUPPLIER (supplier_id, region)
values (482, 'Sao caetano do ');
insert into SUPPLIER (supplier_id, region)
values (483, 'Burlington');
insert into SUPPLIER (supplier_id, region)
values (484, 'Cromwell');
insert into SUPPLIER (supplier_id, region)
values (485, 'Salisbury');
insert into SUPPLIER (supplier_id, region)
values (486, 'Sundsvall');
insert into SUPPLIER (supplier_id, region)
values (487, 'Buffalo Grove');
insert into SUPPLIER (supplier_id, region)
values (488, 'Utrecht');
insert into SUPPLIER (supplier_id, region)
values (489, 'Salt Lake City');
insert into SUPPLIER (supplier_id, region)
values (490, 'Bretzfeld-Waldb');
insert into SUPPLIER (supplier_id, region)
values (491, 'Aracruz');
insert into SUPPLIER (supplier_id, region)
values (492, 'Woodbridge');
insert into SUPPLIER (supplier_id, region)
values (494, 'Kozani');
insert into SUPPLIER (supplier_id, region)
values (495, 'Santa Clarita');
insert into SUPPLIER (supplier_id, region)
values (496, 'Boucherville');
insert into SUPPLIER (supplier_id, region)
values (497, 'Wilmington');
insert into SUPPLIER (supplier_id, region)
values (498, 'Joinville');
insert into SUPPLIER (supplier_id, region)
values (499, 'Vienna');
insert into SUPPLIER (supplier_id, region)
values (500, 'Chinnor');
insert into SUPPLIER (supplier_id, region)
values (501, 'Villata');
insert into SUPPLIER (supplier_id, region)
values (502, 'Bruneck');
insert into SUPPLIER (supplier_id, region)
values (503, 'Johor Bahru');
insert into SUPPLIER (supplier_id, region)
values (504, 'Bozeman');
insert into SUPPLIER (supplier_id, region)
values (505, 'Lake worth');
insert into SUPPLIER (supplier_id, region)
values (506, 'Golden');
insert into SUPPLIER (supplier_id, region)
values (507, 'Trieste');
insert into SUPPLIER (supplier_id, region)
values (508, 'Blacksburg');
insert into SUPPLIER (supplier_id, region)
values (509, 'Menlo Park');
commit;
prompt 300 records committed...
insert into SUPPLIER (supplier_id, region)
values (510, 'Traralgon');
insert into SUPPLIER (supplier_id, region)
values (511, 'Villata');
insert into SUPPLIER (supplier_id, region)
values (512, 'Dardilly');
insert into SUPPLIER (supplier_id, region)
values (513, 'Akita');
insert into SUPPLIER (supplier_id, region)
values (514, 'Guelph');
insert into SUPPLIER (supplier_id, region)
values (515, 'Philadelphia');
insert into SUPPLIER (supplier_id, region)
values (516, 'Ulm');
insert into SUPPLIER (supplier_id, region)
values (517, 'Turku');
insert into SUPPLIER (supplier_id, region)
values (518, 'Graz');
insert into SUPPLIER (supplier_id, region)
values (520, 'Abbotsford');
insert into SUPPLIER (supplier_id, region)
values (521, 'Campinas');
insert into SUPPLIER (supplier_id, region)
values (522, 'Kongserbg');
insert into SUPPLIER (supplier_id, region)
values (523, 'Kyunnam');
insert into SUPPLIER (supplier_id, region)
values (524, 'Zagreb');
insert into SUPPLIER (supplier_id, region)
values (525, 'Berwyn');
insert into SUPPLIER (supplier_id, region)
values (526, 'Salzburg');
insert into SUPPLIER (supplier_id, region)
values (527, 'Banbury');
insert into SUPPLIER (supplier_id, region)
values (528, 'Mayfield Villag');
insert into SUPPLIER (supplier_id, region)
values (529, 'Pomona');
insert into SUPPLIER (supplier_id, region)
values (530, 'Belo Horizonte');
insert into SUPPLIER (supplier_id, region)
values (531, 'Syracuse');
insert into SUPPLIER (supplier_id, region)
values (532, 'Boucherville');
insert into SUPPLIER (supplier_id, region)
values (533, 'Miami');
insert into SUPPLIER (supplier_id, region)
values (534, 'Mobile');
insert into SUPPLIER (supplier_id, region)
values (535, 'Campinas');
insert into SUPPLIER (supplier_id, region)
values (536, 'Alpharetta');
insert into SUPPLIER (supplier_id, region)
values (537, 'Conshohocken');
insert into SUPPLIER (supplier_id, region)
values (538, 'Glendale');
insert into SUPPLIER (supplier_id, region)
values (539, 'La Plata');
insert into SUPPLIER (supplier_id, region)
values (540, 'St Kilda');
insert into SUPPLIER (supplier_id, region)
values (541, 'Cardiff');
insert into SUPPLIER (supplier_id, region)
values (542, 'N. ft. Myers');
insert into SUPPLIER (supplier_id, region)
values (543, 'Melrose');
insert into SUPPLIER (supplier_id, region)
values (544, 'Matsuyama');
insert into SUPPLIER (supplier_id, region)
values (545, 'Warren');
insert into SUPPLIER (supplier_id, region)
values (546, 'Silver Spring');
insert into SUPPLIER (supplier_id, region)
values (547, 'London');
insert into SUPPLIER (supplier_id, region)
values (548, 'Firenze');
insert into SUPPLIER (supplier_id, region)
values (549, 'Szazhalombatta');
insert into SUPPLIER (supplier_id, region)
values (550, 'Linz');
insert into SUPPLIER (supplier_id, region)
values (551, 'Seatle');
insert into SUPPLIER (supplier_id, region)
values (552, 'Middleburg Heig');
insert into SUPPLIER (supplier_id, region)
values (553, 'Frederiksberg');
insert into SUPPLIER (supplier_id, region)
values (554, 'Kevelaer');
insert into SUPPLIER (supplier_id, region)
values (555, 'Saga');
insert into SUPPLIER (supplier_id, region)
values (556, 'Oak park');
insert into SUPPLIER (supplier_id, region)
values (557, 'Draper');
insert into SUPPLIER (supplier_id, region)
values (559, 'Horb');
insert into SUPPLIER (supplier_id, region)
values (560, 'O''fallon');
insert into SUPPLIER (supplier_id, region)
values (561, 'Fountain Hills');
insert into SUPPLIER (supplier_id, region)
values (562, 'Buffalo Grove');
insert into SUPPLIER (supplier_id, region)
values (563, 'Courbevoie');
insert into SUPPLIER (supplier_id, region)
values (564, 'Sugar Hill');
insert into SUPPLIER (supplier_id, region)
values (565, 'Tyne & Wear');
insert into SUPPLIER (supplier_id, region)
values (566, 'Cottbus');
insert into SUPPLIER (supplier_id, region)
values (567, 'Hyderabad');
insert into SUPPLIER (supplier_id, region)
values (568, 'Antwerpen');
insert into SUPPLIER (supplier_id, region)
values (569, 'Pirapora bom Je');
insert into SUPPLIER (supplier_id, region)
values (570, 'Harahan');
insert into SUPPLIER (supplier_id, region)
values (571, 'Nantes');
insert into SUPPLIER (supplier_id, region)
values (572, 'Saint-vincent-d');
insert into SUPPLIER (supplier_id, region)
values (573, 'Middletown');
insert into SUPPLIER (supplier_id, region)
values (574, 'Harrisburg');
insert into SUPPLIER (supplier_id, region)
values (575, 'Charlotte');
insert into SUPPLIER (supplier_id, region)
values (576, 'Tucson');
insert into SUPPLIER (supplier_id, region)
values (577, 'Oldwick');
insert into SUPPLIER (supplier_id, region)
values (578, 'Mountain View');
insert into SUPPLIER (supplier_id, region)
values (580, 'Akita');
insert into SUPPLIER (supplier_id, region)
values (581, 'Huntington');
insert into SUPPLIER (supplier_id, region)
values (582, 'Naha');
insert into SUPPLIER (supplier_id, region)
values (583, 'Leipzig');
insert into SUPPLIER (supplier_id, region)
values (584, 'Hearst');
insert into SUPPLIER (supplier_id, region)
values (585, 'East Peoria');
insert into SUPPLIER (supplier_id, region)
values (586, 'Fleet');
insert into SUPPLIER (supplier_id, region)
values (587, 'Sidney');
insert into SUPPLIER (supplier_id, region)
values (588, 'Mayfield Villag');
insert into SUPPLIER (supplier_id, region)
values (589, 'Ithaca');
insert into SUPPLIER (supplier_id, region)
values (590, 'Houma');
insert into SUPPLIER (supplier_id, region)
values (591, 'Eindhoven');
insert into SUPPLIER (supplier_id, region)
values (592, 'Sale');
insert into SUPPLIER (supplier_id, region)
values (593, 'Okayama');
insert into SUPPLIER (supplier_id, region)
values (595, 'Ellicott City');
insert into SUPPLIER (supplier_id, region)
values (596, 'Richardson');
insert into SUPPLIER (supplier_id, region)
values (597, 'Livermore');
insert into SUPPLIER (supplier_id, region)
values (598, 'Woodland Hills');
insert into SUPPLIER (supplier_id, region)
values (599, 'Kaiserslautern');
insert into SUPPLIER (supplier_id, region)
values (600, 'Cambridge');
insert into SUPPLIER (supplier_id, region)
values (601, 'Terrasa');
insert into SUPPLIER (supplier_id, region)
values (602, 'Athens');
insert into SUPPLIER (supplier_id, region)
values (603, 'Wageningen');
insert into SUPPLIER (supplier_id, region)
values (604, 'El Segundo');
insert into SUPPLIER (supplier_id, region)
values (605, 'Boulder');
insert into SUPPLIER (supplier_id, region)
values (606, 'Belgrad');
insert into SUPPLIER (supplier_id, region)
values (608, 'Bloemfontein');
insert into SUPPLIER (supplier_id, region)
values (609, 'Verwood');
insert into SUPPLIER (supplier_id, region)
values (610, 'Horsens');
insert into SUPPLIER (supplier_id, region)
values (611, 'Kuraby');
insert into SUPPLIER (supplier_id, region)
values (612, 'Goiania');
insert into SUPPLIER (supplier_id, region)
values (613, 'Stans');
insert into SUPPLIER (supplier_id, region)
values (614, 'Bellerose');
commit;
prompt 400 records committed...
insert into SUPPLIER (supplier_id, region)
values (615, 'Calcutta');
insert into SUPPLIER (supplier_id, region)
values (616, 'Spresiano');
insert into SUPPLIER (supplier_id, region)
values (617, 'Chiba');
insert into SUPPLIER (supplier_id, region)
values (618, 'Royersford');
insert into SUPPLIER (supplier_id, region)
values (619, 'Peine');
insert into SUPPLIER (supplier_id, region)
values (620, 'Kyunnam');
insert into SUPPLIER (supplier_id, region)
values (621, 'Hercules');
insert into SUPPLIER (supplier_id, region)
values (622, 'High Wycombe');
insert into SUPPLIER (supplier_id, region)
values (623, 'Ismaning');
insert into SUPPLIER (supplier_id, region)
values (624, 'Los Alamos');
insert into SUPPLIER (supplier_id, region)
values (625, 'Rome');
insert into SUPPLIER (supplier_id, region)
values (626, 'Debary');
insert into SUPPLIER (supplier_id, region)
values (627, 'New Delhi');
insert into SUPPLIER (supplier_id, region)
values (628, 'Freising');
insert into SUPPLIER (supplier_id, region)
values (629, 'Heubach');
insert into SUPPLIER (supplier_id, region)
values (630, 'Glasgow');
insert into SUPPLIER (supplier_id, region)
values (631, 'Fort Lewis');
insert into SUPPLIER (supplier_id, region)
values (632, 'Middletown');
insert into SUPPLIER (supplier_id, region)
values (633, 'Zwolle');
insert into SUPPLIER (supplier_id, region)
values (634, 'Treviso');
insert into SUPPLIER (supplier_id, region)
values (635, 'Annandale');
insert into SUPPLIER (supplier_id, region)
values (636, 'Schlieren');
insert into SUPPLIER (supplier_id, region)
values (637, 'Soest');
insert into SUPPLIER (supplier_id, region)
values (638, 'Macau');
insert into SUPPLIER (supplier_id, region)
values (639, 'Lodi');
insert into SUPPLIER (supplier_id, region)
values (640, 'Halfway house');
insert into SUPPLIER (supplier_id, region)
values (641, 'Hermitage');
insert into SUPPLIER (supplier_id, region)
values (642, 'Newnan');
insert into SUPPLIER (supplier_id, region)
values (643, 'London');
insert into SUPPLIER (supplier_id, region)
values (644, 'Nizhnevartovsk');
insert into SUPPLIER (supplier_id, region)
values (646, 'Edenbridge');
insert into SUPPLIER (supplier_id, region)
values (647, 'Seatle');
insert into SUPPLIER (supplier_id, region)
values (648, 'Kanata');
insert into SUPPLIER (supplier_id, region)
values (649, 'Stockholm');
insert into SUPPLIER (supplier_id, region)
values (650, 'Saint-vincent-d');
insert into SUPPLIER (supplier_id, region)
values (651, 'Madrid');
insert into SUPPLIER (supplier_id, region)
values (652, 'Jacksonville');
insert into SUPPLIER (supplier_id, region)
values (653, 'Bartlesville');
insert into SUPPLIER (supplier_id, region)
values (654, 'Geneve');
insert into SUPPLIER (supplier_id, region)
values (655, 'Oak Park');
insert into SUPPLIER (supplier_id, region)
values (656, 'Los Alamos');
insert into SUPPLIER (supplier_id, region)
values (657, 'Eschen');
insert into SUPPLIER (supplier_id, region)
values (658, 'Cheshire');
insert into SUPPLIER (supplier_id, region)
values (659, 'Glen Cove');
insert into SUPPLIER (supplier_id, region)
values (660, 'Wien');
insert into SUPPLIER (supplier_id, region)
values (661, 'Lakeville');
insert into SUPPLIER (supplier_id, region)
values (662, 'Erlangen');
insert into SUPPLIER (supplier_id, region)
values (663, 'Gliwice');
insert into SUPPLIER (supplier_id, region)
values (664, 'Clark');
insert into SUPPLIER (supplier_id, region)
values (665, 'San Dimas');
insert into SUPPLIER (supplier_id, region)
values (666, 'Maryville');
insert into SUPPLIER (supplier_id, region)
values (667, 'Annandale');
insert into SUPPLIER (supplier_id, region)
values (668, 'Runcorn');
insert into SUPPLIER (supplier_id, region)
values (669, 'Bartlesville');
insert into SUPPLIER (supplier_id, region)
values (670, 'Ferraz  vasconc');
insert into SUPPLIER (supplier_id, region)
values (671, 'Slough');
insert into SUPPLIER (supplier_id, region)
values (672, 'Leipzig');
insert into SUPPLIER (supplier_id, region)
values (673, 'Tsu');
insert into SUPPLIER (supplier_id, region)
values (674, 'Dearborn');
insert into SUPPLIER (supplier_id, region)
values (675, 'Ankara');
insert into SUPPLIER (supplier_id, region)
values (676, 'Balmoral');
insert into SUPPLIER (supplier_id, region)
values (678, 'Syracuse');
insert into SUPPLIER (supplier_id, region)
values (679, 'Casselberry');
insert into SUPPLIER (supplier_id, region)
values (680, 'El Paso');
insert into SUPPLIER (supplier_id, region)
values (681, 'Freiburg');
insert into SUPPLIER (supplier_id, region)
values (682, 'Spresiano');
insert into SUPPLIER (supplier_id, region)
values (683, 'Amsterdam');
insert into SUPPLIER (supplier_id, region)
values (684, 'Boston');
insert into SUPPLIER (supplier_id, region)
values (685, 'Zaandam');
insert into SUPPLIER (supplier_id, region)
values (686, 'Olivette');
insert into SUPPLIER (supplier_id, region)
values (687, 'Chemnitz');
insert into SUPPLIER (supplier_id, region)
values (688, 'Akita');
insert into SUPPLIER (supplier_id, region)
values (689, 'Luedenscheid');
insert into SUPPLIER (supplier_id, region)
values (690, 'Paris');
insert into SUPPLIER (supplier_id, region)
values (691, 'Salt Lake City');
insert into SUPPLIER (supplier_id, region)
values (693, 'Stony Point');
insert into SUPPLIER (supplier_id, region)
values (694, 'Hjallerup');
insert into SUPPLIER (supplier_id, region)
values (695, 'Sao jose rio pr');
insert into SUPPLIER (supplier_id, region)
values (696, 'Herdecke');
insert into SUPPLIER (supplier_id, region)
values (697, 'Yucca');
insert into SUPPLIER (supplier_id, region)
values (698, 'Cesena');
insert into SUPPLIER (supplier_id, region)
values (699, 'Udine');
insert into SUPPLIER (supplier_id, region)
values (999, 'ITALY');
insert into SUPPLIER (supplier_id, region)
values (998, 'Unknown');
insert into SUPPLIER (supplier_id, region)
values (98, 'Unknown');
commit;
prompt 485 records loaded
prompt Loading ORDER_SUPPLIER...
prompt Table is empty
prompt Loading WORKER...
insert into WORKER (worker_id, start_of_work_date)
values (158, to_date('22-01-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (657, to_date('16-11-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (794, to_date('22-02-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (640, to_date('10-08-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (131, to_date('09-02-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (381, to_date('03-01-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (651, to_date('28-06-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (269, to_date('25-01-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (172, to_date('03-02-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (289, to_date('23-09-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (541, to_date('21-03-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (844, to_date('12-02-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (705, to_date('11-10-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (807, to_date('06-08-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (105, to_date('29-06-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (855, to_date('22-10-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (744, to_date('24-10-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (280, to_date('31-08-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (361, to_date('14-11-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (113, to_date('28-11-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (938, to_date('14-02-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (209, to_date('19-06-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (591, to_date('19-12-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (666, to_date('07-05-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (355, to_date('24-07-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (790, to_date('13-08-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (835, to_date('16-07-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (616, to_date('16-09-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (739, to_date('13-11-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (643, to_date('04-06-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (944, to_date('16-09-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (518, to_date('13-10-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (188, to_date('03-05-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (136, to_date('12-05-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (618, to_date('17-11-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (494, to_date('22-11-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (695, to_date('27-03-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (564, to_date('01-04-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (357, to_date('06-09-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (992, to_date('13-05-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (514, to_date('20-10-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (419, to_date('05-10-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (367, to_date('07-04-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (966, to_date('30-10-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (509, to_date('28-02-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (978, to_date('08-04-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (737, to_date('02-02-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (799, to_date('23-07-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (279, to_date('01-07-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (839, to_date('14-12-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (722, to_date('08-10-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (630, to_date('27-09-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (786, to_date('01-01-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (180, to_date('09-11-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (902, to_date('16-03-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (761, to_date('07-07-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (454, to_date('18-01-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (928, to_date('16-08-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (278, to_date('21-02-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (323, to_date('15-08-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (340, to_date('08-12-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (879, to_date('08-10-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (575, to_date('14-05-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (512, to_date('25-05-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (585, to_date('05-02-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (332, to_date('13-06-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (256, to_date('13-11-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (932, to_date('26-12-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (955, to_date('03-12-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (815, to_date('25-09-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (670, to_date('22-03-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (137, to_date('29-10-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (574, to_date('17-06-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (847, to_date('12-11-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (108, to_date('15-09-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (548, to_date('20-02-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (974, to_date('21-05-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (578, to_date('06-02-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (614, to_date('02-05-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (254, to_date('19-06-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (781, to_date('13-04-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (193, to_date('07-02-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (873, to_date('25-04-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (594, to_date('13-09-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (552, to_date('04-05-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (365, to_date('21-01-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (120, to_date('27-09-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (304, to_date('03-06-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (843, to_date('04-10-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (664, to_date('16-06-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (487, to_date('28-02-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (680, to_date('28-11-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (756, to_date('16-06-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (816, to_date('28-11-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (960, to_date('13-12-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (908, to_date('26-05-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (593, to_date('08-02-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (252, to_date('07-06-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (154, to_date('02-09-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (961, to_date('30-01-2030', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into WORKER (worker_id, start_of_work_date)
values (445, to_date('28-10-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (106, to_date('01-10-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (751, to_date('21-09-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (171, to_date('15-04-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (673, to_date('29-01-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (842, to_date('24-02-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (472, to_date('31-08-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (692, to_date('20-11-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (196, to_date('02-04-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (793, to_date('11-05-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (303, to_date('15-08-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (546, to_date('17-01-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (635, to_date('28-12-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (129, to_date('05-10-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (721, to_date('30-09-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (868, to_date('19-04-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (920, to_date('05-12-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (592, to_date('31-03-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (516, to_date('15-09-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (661, to_date('03-05-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (586, to_date('24-08-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (124, to_date('12-08-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (503, to_date('06-04-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (590, to_date('15-09-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (613, to_date('15-08-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (422, to_date('04-06-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (272, to_date('06-06-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (572, to_date('03-11-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (257, to_date('12-05-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (678, to_date('27-02-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (802, to_date('23-05-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (599, to_date('14-07-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (943, to_date('15-09-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (526, to_date('11-09-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (890, to_date('28-02-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (832, to_date('16-01-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (525, to_date('01-06-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (762, to_date('23-12-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (649, to_date('10-12-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (531, to_date('07-03-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (935, to_date('14-09-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (773, to_date('27-05-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (429, to_date('14-05-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (353, to_date('23-03-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (898, to_date('18-09-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (259, to_date('15-03-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (610, to_date('20-04-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (294, to_date('07-06-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (505, to_date('28-03-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (121, to_date('20-06-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (109, to_date('12-06-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (223, to_date('27-02-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (862, to_date('24-01-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (861, to_date('17-03-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (749, to_date('28-09-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (202, to_date('27-10-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (694, to_date('12-07-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (561, to_date('17-11-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (579, to_date('18-01-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (207, to_date('04-07-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (406, to_date('13-02-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (557, to_date('01-11-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (836, to_date('23-08-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (688, to_date('22-06-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (359, to_date('22-06-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (442, to_date('01-10-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (963, to_date('10-05-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (394, to_date('24-07-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (859, to_date('29-04-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (457, to_date('23-07-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (611, to_date('23-12-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (900, to_date('06-04-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (177, to_date('19-12-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (268, to_date('12-03-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (140, to_date('09-09-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (909, to_date('21-02-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (335, to_date('04-12-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (218, to_date('19-03-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (468, to_date('08-01-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (959, to_date('06-05-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (691, to_date('17-12-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (476, to_date('01-04-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (948, to_date('14-03-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (199, to_date('13-06-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (791, to_date('07-07-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (502, to_date('13-11-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (247, to_date('07-12-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (245, to_date('22-01-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (852, to_date('01-09-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (939, to_date('01-01-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (837, to_date('05-01-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (250, to_date('06-12-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (341, to_date('02-03-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (184, to_date('18-01-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (498, to_date('26-08-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (778, to_date('15-11-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (127, to_date('17-03-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (329, to_date('16-08-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (746, to_date('25-04-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (130, to_date('05-11-2025', 'dd-mm-yyyy'));
commit;
prompt 200 records committed...
insert into WORKER (worker_id, start_of_work_date)
values (418, to_date('17-01-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (432, to_date('02-10-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (621, to_date('22-09-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (173, to_date('08-09-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (542, to_date('26-10-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (339, to_date('13-07-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (264, to_date('20-05-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (153, to_date('23-03-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (865, to_date('05-02-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (880, to_date('20-05-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (428, to_date('05-08-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (237, to_date('17-08-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (648, to_date('11-08-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (267, to_date('26-04-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (527, to_date('25-03-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (797, to_date('13-10-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (783, to_date('31-12-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (973, to_date('21-05-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (382, to_date('27-03-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (984, to_date('25-12-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (731, to_date('08-08-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (251, to_date('19-06-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (285, to_date('10-07-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (820, to_date('24-02-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (570, to_date('27-02-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (320, to_date('25-12-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (412, to_date('07-04-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (286, to_date('09-10-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (377, to_date('07-04-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (185, to_date('10-02-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (334, to_date('17-04-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (449, to_date('28-03-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (671, to_date('06-06-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (450, to_date('29-09-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (213, to_date('23-04-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (993, to_date('20-07-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (363, to_date('02-01-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (822, to_date('13-03-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (321, to_date('16-07-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (302, to_date('04-08-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (774, to_date('24-10-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (826, to_date('18-10-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (126, to_date('26-09-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (860, to_date('16-02-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (346, to_date('09-06-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (297, to_date('25-05-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (632, to_date('17-01-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (660, to_date('29-06-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (972, to_date('12-06-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (446, to_date('07-03-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (147, to_date('14-03-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (698, to_date('14-10-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (249, to_date('10-11-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (848, to_date('07-08-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (219, to_date('19-07-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (582, to_date('25-03-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (544, to_date('16-06-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (165, to_date('14-12-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (471, to_date('02-10-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (715, to_date('25-01-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (627, to_date('05-04-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (965, to_date('31-10-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (674, to_date('25-12-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (523, to_date('23-08-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (169, to_date('09-05-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (318, to_date('13-09-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (248, to_date('18-03-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (813, to_date('17-02-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (504, to_date('21-07-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (281, to_date('13-10-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (833, to_date('26-08-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (182, to_date('01-11-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (662, to_date('23-12-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (311, to_date('18-06-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (934, to_date('28-06-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (911, to_date('26-07-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (945, to_date('14-12-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (291, to_date('25-08-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (139, to_date('07-11-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (804, to_date('07-03-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (324, to_date('10-07-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (522, to_date('26-09-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (577, to_date('20-10-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (888, to_date('22-11-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (834, to_date('21-01-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (904, to_date('24-08-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (354, to_date('09-06-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (775, to_date('12-10-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (584, to_date('13-09-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (782, to_date('18-08-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (186, to_date('01-02-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (748, to_date('02-05-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (179, to_date('30-07-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (144, to_date('11-12-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (481, to_date('18-08-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (421, to_date('03-05-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (496, to_date('30-06-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (543, to_date('16-06-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (641, to_date('29-02-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (433, to_date('25-09-2028', 'dd-mm-yyyy'));
commit;
prompt 300 records committed...
insert into WORKER (worker_id, start_of_work_date)
values (212, to_date('04-12-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (747, to_date('09-05-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (600, to_date('19-09-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (598, to_date('07-07-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (736, to_date('30-03-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (947, to_date('25-07-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (216, to_date('23-07-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (164, to_date('24-02-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (700, to_date('03-01-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (501, to_date('16-11-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (970, to_date('15-07-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (441, to_date('16-05-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (203, to_date('25-11-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (741, to_date('13-10-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (765, to_date('10-07-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (637, to_date('30-09-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (407, to_date('04-12-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (296, to_date('05-09-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (515, to_date('31-07-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (913, to_date('19-04-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (489, to_date('02-06-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (366, to_date('13-09-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (478, to_date('23-06-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (438, to_date('23-03-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (742, to_date('23-10-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (103, to_date('02-05-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (347, to_date('03-04-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (520, to_date('07-04-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (292, to_date('03-11-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (152, to_date('24-07-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (596, to_date('14-11-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (234, to_date('30-09-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (244, to_date('26-01-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (352, to_date('29-12-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (239, to_date('10-10-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (682, to_date('07-07-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (710, to_date('08-03-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (227, to_date('02-10-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (625, to_date('25-07-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (118, to_date('26-10-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (128, to_date('22-12-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (393, to_date('10-06-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (940, to_date('14-06-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (283, to_date('01-12-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (288, to_date('21-11-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (497, to_date('28-10-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (539, to_date('15-07-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (982, to_date('14-01-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (821, to_date('20-08-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (917, to_date('13-07-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (455, to_date('12-03-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (937, to_date('03-01-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (358, to_date('30-03-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (976, to_date('14-12-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (551, to_date('04-06-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (952, to_date('10-02-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (191, to_date('18-01-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (401, to_date('20-09-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (146, to_date('24-05-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (510, to_date('12-06-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (994, to_date('07-05-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (434, to_date('07-04-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (414, to_date('22-01-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (979, to_date('08-04-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (931, to_date('09-02-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (392, to_date('23-07-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (469, to_date('21-04-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (876, to_date('14-05-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (941, to_date('19-05-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (545, to_date('23-04-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (877, to_date('29-10-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (134, to_date('04-09-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (306, to_date('15-09-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (803, to_date('19-06-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (924, to_date('14-02-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (348, to_date('02-06-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (123, to_date('14-09-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (205, to_date('29-11-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (322, to_date('19-05-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (190, to_date('24-07-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (656, to_date('04-10-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (779, to_date('06-02-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (603, to_date('03-06-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (270, to_date('25-02-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (726, to_date('30-03-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (667, to_date('25-08-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (369, to_date('02-12-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (116, to_date('16-05-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (409, to_date('17-09-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (408, to_date('11-03-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (104, to_date('14-01-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (684, to_date('20-10-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (675, to_date('14-05-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (142, to_date('09-02-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (513, to_date('07-05-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (589, to_date('24-06-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (111, to_date('31-01-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (642, to_date('22-10-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (566, to_date('05-01-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (331, to_date('29-06-2027', 'dd-mm-yyyy'));
commit;
prompt 400 records committed...
insert into WORKER (worker_id, start_of_work_date)
values (679, to_date('22-11-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (776, to_date('29-11-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (729, to_date('23-10-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (410, to_date('24-10-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (629, to_date('24-10-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (919, to_date('27-12-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (242, to_date('10-07-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (317, to_date('08-09-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (996, to_date('18-03-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (681, to_date('15-11-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (470, to_date('29-04-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (201, to_date('19-12-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (728, to_date('23-01-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (477, to_date('27-04-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (150, to_date('13-12-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (789, to_date('16-02-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (665, to_date('19-06-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (533, to_date('17-12-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (933, to_date('25-08-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (601, to_date('31-10-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (159, to_date('30-03-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (936, to_date('15-03-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (883, to_date('12-07-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (232, to_date('03-09-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (788, to_date('14-06-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (166, to_date('07-06-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (668, to_date('31-12-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (588, to_date('15-05-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (371, to_date('06-01-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (863, to_date('04-12-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (443, to_date('31-08-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (808, to_date('26-05-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (183, to_date('27-04-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (801, to_date('18-08-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (336, to_date('17-01-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (912, to_date('12-02-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (204, to_date('09-03-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (387, to_date('31-03-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (950, to_date('15-10-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (619, to_date('10-12-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (398, to_date('20-01-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (645, to_date('06-12-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (149, to_date('01-03-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (293, to_date('27-07-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (135, to_date('20-09-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (211, to_date('14-11-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (399, to_date('07-01-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (112, to_date('22-09-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (274, to_date('10-12-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (604, to_date('12-12-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (989, to_date('18-03-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (758, to_date('18-05-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (606, to_date('07-09-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (733, to_date('09-07-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (170, to_date('02-01-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (757, to_date('03-03-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (750, to_date('21-10-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (719, to_date('11-11-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (792, to_date('19-08-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (874, to_date('17-06-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (390, to_date('01-09-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (745, to_date('17-11-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (241, to_date('09-11-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (624, to_date('14-03-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (536, to_date('21-09-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (727, to_date('26-12-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (538, to_date('07-01-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (703, to_date('22-11-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (896, to_date('23-12-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (563, to_date('07-05-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (951, to_date('23-02-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (565, to_date('12-08-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (949, to_date('05-11-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (313, to_date('11-09-2027', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (402, to_date('19-01-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (990, to_date('20-06-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (465, to_date('06-12-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (730, to_date('08-02-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (263, to_date('18-11-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (519, to_date('07-05-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (732, to_date('30-12-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (308, to_date('15-08-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (850, to_date('12-05-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (462, to_date('24-07-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (233, to_date('28-04-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (277, to_date('30-08-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (766, to_date('23-09-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (615, to_date('31-12-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (867, to_date('06-04-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (983, to_date('31-05-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (325, to_date('01-12-2026', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (464, to_date('01-04-2024', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (373, to_date('29-04-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (458, to_date('08-11-2025', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (568, to_date('01-03-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (208, to_date('29-01-2030', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (388, to_date('22-05-2029', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (975, to_date('18-08-2028', 'dd-mm-yyyy'));
insert into WORKER (worker_id, start_of_work_date)
values (549, to_date('29-06-2024', 'dd-mm-yyyy'));
commit;
prompt 499 records loaded
prompt Loading ORDER_WORKER...
prompt Table is empty
prompt Loading PURCHASE...
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (604, to_date('27-03-2025', 'dd-mm-yyyy'), to_date('16-10-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (319, to_date('08-02-2025', 'dd-mm-yyyy'), to_date('02-05-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (348, to_date('28-03-2025', 'dd-mm-yyyy'), to_date('27-01-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (179, to_date('15-08-2025', 'dd-mm-yyyy'), to_date('14-08-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (388, to_date('23-12-2026', 'dd-mm-yyyy'), to_date('07-05-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (863, to_date('24-07-2025', 'dd-mm-yyyy'), to_date('14-03-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (116, to_date('21-05-2029', 'dd-mm-yyyy'), to_date('23-12-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (814, to_date('22-07-2029', 'dd-mm-yyyy'), to_date('05-08-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (474, to_date('04-01-2024', 'dd-mm-yyyy'), to_date('01-06-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (436, to_date('02-08-2028', 'dd-mm-yyyy'), to_date('21-10-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (339, to_date('11-09-2025', 'dd-mm-yyyy'), to_date('17-01-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (464, to_date('19-11-2028', 'dd-mm-yyyy'), to_date('06-02-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (676, to_date('29-05-2025', 'dd-mm-yyyy'), to_date('20-01-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (395, to_date('04-01-2027', 'dd-mm-yyyy'), to_date('22-03-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (183, to_date('27-02-2027', 'dd-mm-yyyy'), to_date('28-05-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (677, to_date('21-08-2024', 'dd-mm-yyyy'), to_date('09-04-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (611, to_date('18-06-2026', 'dd-mm-yyyy'), to_date('03-08-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (123, to_date('28-02-2030', 'dd-mm-yyyy'), to_date('06-10-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (852, to_date('22-05-2025', 'dd-mm-yyyy'), to_date('17-12-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (157, to_date('24-01-2027', 'dd-mm-yyyy'), to_date('03-07-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (843, to_date('17-10-2029', 'dd-mm-yyyy'), to_date('14-03-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (555, to_date('05-12-2024', 'dd-mm-yyyy'), to_date('21-03-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (208, to_date('09-12-2025', 'dd-mm-yyyy'), to_date('18-03-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (145, to_date('11-01-2025', 'dd-mm-yyyy'), to_date('29-07-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (778, to_date('25-02-2026', 'dd-mm-yyyy'), to_date('26-10-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (162, to_date('20-05-2024', 'dd-mm-yyyy'), to_date('26-03-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (377, to_date('04-10-2025', 'dd-mm-yyyy'), to_date('11-08-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (956, to_date('26-12-2030', 'dd-mm-yyyy'), to_date('07-12-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (911, to_date('14-01-2030', 'dd-mm-yyyy'), to_date('06-06-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (811, to_date('11-04-2028', 'dd-mm-yyyy'), to_date('05-04-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (605, to_date('08-06-2030', 'dd-mm-yyyy'), to_date('26-07-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (982, to_date('14-03-2030', 'dd-mm-yyyy'), to_date('19-03-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (993, to_date('21-03-2027', 'dd-mm-yyyy'), to_date('13-11-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (965, to_date('10-05-2024', 'dd-mm-yyyy'), to_date('08-09-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (847, to_date('21-06-2028', 'dd-mm-yyyy'), to_date('14-12-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (178, to_date('20-06-2028', 'dd-mm-yyyy'), to_date('29-11-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (976, to_date('13-04-2027', 'dd-mm-yyyy'), to_date('15-05-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (590, to_date('06-05-2025', 'dd-mm-yyyy'), to_date('05-06-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (638, to_date('22-07-2028', 'dd-mm-yyyy'), to_date('28-06-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (294, to_date('09-07-2027', 'dd-mm-yyyy'), to_date('03-05-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (307, to_date('19-11-2024', 'dd-mm-yyyy'), to_date('13-05-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (172, to_date('28-03-2026', 'dd-mm-yyyy'), to_date('22-06-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (207, to_date('12-04-2027', 'dd-mm-yyyy'), to_date('30-03-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (725, to_date('29-03-2027', 'dd-mm-yyyy'), to_date('07-11-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (702, to_date('31-08-2030', 'dd-mm-yyyy'), to_date('10-04-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (987, to_date('08-08-2028', 'dd-mm-yyyy'), to_date('28-12-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (189, to_date('21-07-2024', 'dd-mm-yyyy'), to_date('01-10-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (352, to_date('17-03-2028', 'dd-mm-yyyy'), to_date('16-04-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (851, to_date('26-08-2024', 'dd-mm-yyyy'), to_date('19-05-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (358, to_date('07-04-2024', 'dd-mm-yyyy'), to_date('10-01-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (648, to_date('02-03-2029', 'dd-mm-yyyy'), to_date('14-06-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (364, to_date('20-10-2026', 'dd-mm-yyyy'), to_date('29-09-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (498, to_date('05-05-2027', 'dd-mm-yyyy'), to_date('08-06-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (789, to_date('27-10-2025', 'dd-mm-yyyy'), to_date('13-05-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (554, to_date('18-12-2026', 'dd-mm-yyyy'), to_date('30-09-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (266, to_date('29-12-2028', 'dd-mm-yyyy'), to_date('25-07-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (130, to_date('26-03-2025', 'dd-mm-yyyy'), to_date('23-08-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (461, to_date('12-09-2030', 'dd-mm-yyyy'), to_date('21-08-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (878, to_date('07-04-2024', 'dd-mm-yyyy'), to_date('19-06-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (653, to_date('04-01-2029', 'dd-mm-yyyy'), to_date('31-05-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (508, to_date('03-12-2029', 'dd-mm-yyyy'), to_date('24-07-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (949, to_date('30-03-2030', 'dd-mm-yyyy'), to_date('14-04-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (968, to_date('08-09-2030', 'dd-mm-yyyy'), to_date('06-10-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (896, to_date('21-08-2024', 'dd-mm-yyyy'), to_date('12-04-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (444, to_date('17-07-2029', 'dd-mm-yyyy'), to_date('09-10-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (849, to_date('21-01-2024', 'dd-mm-yyyy'), to_date('23-06-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (833, to_date('15-02-2028', 'dd-mm-yyyy'), to_date('20-07-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (290, to_date('27-10-2027', 'dd-mm-yyyy'), to_date('15-06-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (516, to_date('08-03-2026', 'dd-mm-yyyy'), to_date('06-04-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (614, to_date('09-04-2024', 'dd-mm-yyyy'), to_date('31-03-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (805, to_date('23-06-2025', 'dd-mm-yyyy'), to_date('22-01-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (220, to_date('04-01-2025', 'dd-mm-yyyy'), to_date('08-09-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (724, to_date('25-09-2025', 'dd-mm-yyyy'), to_date('03-05-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (933, to_date('16-06-2028', 'dd-mm-yyyy'), to_date('04-02-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (801, to_date('02-07-2028', 'dd-mm-yyyy'), to_date('04-08-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (793, to_date('11-10-2030', 'dd-mm-yyyy'), to_date('21-12-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (795, to_date('18-08-2029', 'dd-mm-yyyy'), to_date('24-12-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (631, to_date('04-01-2025', 'dd-mm-yyyy'), to_date('29-01-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (366, to_date('14-09-2027', 'dd-mm-yyyy'), to_date('01-01-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (439, to_date('18-11-2030', 'dd-mm-yyyy'), to_date('01-04-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (809, to_date('05-12-2024', 'dd-mm-yyyy'), to_date('31-03-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (186, to_date('04-02-2030', 'dd-mm-yyyy'), to_date('06-09-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (650, to_date('14-02-2030', 'dd-mm-yyyy'), to_date('20-09-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (547, to_date('06-03-2028', 'dd-mm-yyyy'), to_date('28-03-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (504, to_date('14-10-2028', 'dd-mm-yyyy'), to_date('22-09-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (762, to_date('11-11-2024', 'dd-mm-yyyy'), to_date('13-04-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (821, to_date('05-07-2024', 'dd-mm-yyyy'), to_date('19-09-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (640, to_date('19-10-2030', 'dd-mm-yyyy'), to_date('16-01-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (600, to_date('15-08-2026', 'dd-mm-yyyy'), to_date('25-06-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (610, to_date('06-01-2028', 'dd-mm-yyyy'), to_date('02-01-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (258, to_date('14-09-2030', 'dd-mm-yyyy'), to_date('28-05-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (839, to_date('24-06-2030', 'dd-mm-yyyy'), to_date('23-08-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (527, to_date('20-07-2028', 'dd-mm-yyyy'), to_date('17-03-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (184, to_date('09-08-2027', 'dd-mm-yyyy'), to_date('28-06-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (257, to_date('15-04-2028', 'dd-mm-yyyy'), to_date('08-10-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (672, to_date('03-03-2026', 'dd-mm-yyyy'), to_date('03-07-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (935, to_date('13-05-2024', 'dd-mm-yyyy'), to_date('06-01-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (467, to_date('16-04-2024', 'dd-mm-yyyy'), to_date('30-04-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (393, to_date('06-04-2025', 'dd-mm-yyyy'), to_date('11-03-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (767, to_date('05-07-2030', 'dd-mm-yyyy'), to_date('30-08-2024', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (685, to_date('03-07-2030', 'dd-mm-yyyy'), to_date('21-04-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (728, to_date('23-02-2025', 'dd-mm-yyyy'), to_date('24-08-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (261, to_date('12-12-2027', 'dd-mm-yyyy'), to_date('11-01-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (460, to_date('19-07-2028', 'dd-mm-yyyy'), to_date('22-05-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (825, to_date('14-05-2026', 'dd-mm-yyyy'), to_date('01-09-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (705, to_date('15-07-2027', 'dd-mm-yyyy'), to_date('07-09-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (808, to_date('30-05-2030', 'dd-mm-yyyy'), to_date('03-07-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (478, to_date('14-09-2024', 'dd-mm-yyyy'), to_date('10-09-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (582, to_date('22-12-2030', 'dd-mm-yyyy'), to_date('10-03-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (885, to_date('07-01-2030', 'dd-mm-yyyy'), to_date('23-12-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (427, to_date('02-08-2026', 'dd-mm-yyyy'), to_date('04-06-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (782, to_date('29-12-2024', 'dd-mm-yyyy'), to_date('16-07-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (382, to_date('15-03-2028', 'dd-mm-yyyy'), to_date('14-08-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (587, to_date('25-02-2030', 'dd-mm-yyyy'), to_date('01-02-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (699, to_date('10-12-2026', 'dd-mm-yyyy'), to_date('19-09-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (556, to_date('22-11-2028', 'dd-mm-yyyy'), to_date('05-09-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (494, to_date('19-03-2024', 'dd-mm-yyyy'), to_date('31-10-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (837, to_date('19-08-2024', 'dd-mm-yyyy'), to_date('30-06-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (983, to_date('10-07-2028', 'dd-mm-yyyy'), to_date('16-11-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (454, to_date('01-05-2026', 'dd-mm-yyyy'), to_date('15-08-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (295, to_date('06-11-2029', 'dd-mm-yyyy'), to_date('30-12-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (948, to_date('10-07-2027', 'dd-mm-yyyy'), to_date('09-08-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (385, to_date('30-06-2028', 'dd-mm-yyyy'), to_date('14-10-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (522, to_date('28-03-2030', 'dd-mm-yyyy'), to_date('09-09-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (409, to_date('24-12-2029', 'dd-mm-yyyy'), to_date('15-11-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (376, to_date('15-04-2028', 'dd-mm-yyyy'), to_date('14-12-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (264, to_date('01-12-2028', 'dd-mm-yyyy'), to_date('16-03-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (749, to_date('13-03-2026', 'dd-mm-yyyy'), to_date('06-07-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (893, to_date('05-08-2029', 'dd-mm-yyyy'), to_date('16-06-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (649, to_date('11-03-2025', 'dd-mm-yyyy'), to_date('23-01-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (412, to_date('20-02-2024', 'dd-mm-yyyy'), to_date('03-08-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (141, to_date('07-02-2030', 'dd-mm-yyyy'), to_date('13-10-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (637, to_date('19-02-2024', 'dd-mm-yyyy'), to_date('27-09-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (799, to_date('24-02-2024', 'dd-mm-yyyy'), to_date('18-06-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (137, to_date('26-03-2027', 'dd-mm-yyyy'), to_date('15-10-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (239, to_date('22-09-2025', 'dd-mm-yyyy'), to_date('22-08-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (780, to_date('28-01-2030', 'dd-mm-yyyy'), to_date('27-07-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (149, to_date('21-01-2029', 'dd-mm-yyyy'), to_date('20-09-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (941, to_date('19-02-2028', 'dd-mm-yyyy'), to_date('20-08-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (570, to_date('26-02-2029', 'dd-mm-yyyy'), to_date('10-04-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (296, to_date('08-12-2030', 'dd-mm-yyyy'), to_date('01-09-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (629, to_date('11-06-2025', 'dd-mm-yyyy'), to_date('03-07-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (691, to_date('19-02-2029', 'dd-mm-yyyy'), to_date('15-05-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (397, to_date('22-10-2029', 'dd-mm-yyyy'), to_date('20-02-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (817, to_date('21-08-2025', 'dd-mm-yyyy'), to_date('11-05-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (758, to_date('05-08-2027', 'dd-mm-yyyy'), to_date('29-10-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (874, to_date('11-01-2030', 'dd-mm-yyyy'), to_date('29-12-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (177, to_date('27-11-2029', 'dd-mm-yyyy'), to_date('06-10-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (868, to_date('25-08-2027', 'dd-mm-yyyy'), to_date('06-03-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (110, to_date('17-01-2025', 'dd-mm-yyyy'), to_date('20-04-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (175, to_date('05-01-2029', 'dd-mm-yyyy'), to_date('18-04-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (422, to_date('05-10-2024', 'dd-mm-yyyy'), to_date('22-11-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (625, to_date('16-04-2024', 'dd-mm-yyyy'), to_date('04-06-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (963, to_date('27-03-2027', 'dd-mm-yyyy'), to_date('30-11-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (740, to_date('20-06-2029', 'dd-mm-yyyy'), to_date('08-03-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (523, to_date('01-11-2025', 'dd-mm-yyyy'), to_date('04-10-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (776, to_date('10-10-2026', 'dd-mm-yyyy'), to_date('05-10-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (855, to_date('17-06-2026', 'dd-mm-yyyy'), to_date('09-06-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (857, to_date('08-08-2030', 'dd-mm-yyyy'), to_date('02-11-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (410, to_date('24-12-2026', 'dd-mm-yyyy'), to_date('24-03-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (297, to_date('18-03-2025', 'dd-mm-yyyy'), to_date('29-06-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (564, to_date('27-06-2025', 'dd-mm-yyyy'), to_date('16-04-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (323, to_date('10-06-2027', 'dd-mm-yyyy'), to_date('22-07-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (573, to_date('02-02-2029', 'dd-mm-yyyy'), to_date('18-11-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (344, to_date('27-10-2030', 'dd-mm-yyyy'), to_date('22-05-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (111, to_date('16-01-2024', 'dd-mm-yyyy'), to_date('28-01-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (652, to_date('01-10-2028', 'dd-mm-yyyy'), to_date('17-06-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (201, to_date('23-06-2029', 'dd-mm-yyyy'), to_date('09-01-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (877, to_date('25-10-2025', 'dd-mm-yyyy'), to_date('29-12-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (932, to_date('27-09-2028', 'dd-mm-yyyy'), to_date('26-06-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (218, to_date('28-07-2026', 'dd-mm-yyyy'), to_date('04-11-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (219, to_date('18-08-2028', 'dd-mm-yyyy'), to_date('23-10-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (539, to_date('31-10-2024', 'dd-mm-yyyy'), to_date('08-11-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (727, to_date('19-05-2029', 'dd-mm-yyyy'), to_date('20-07-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (531, to_date('14-12-2024', 'dd-mm-yyyy'), to_date('16-10-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (197, to_date('25-02-2026', 'dd-mm-yyyy'), to_date('23-06-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (430, to_date('30-12-2028', 'dd-mm-yyyy'), to_date('28-08-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (456, to_date('04-12-2025', 'dd-mm-yyyy'), to_date('06-09-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (190, to_date('16-01-2025', 'dd-mm-yyyy'), to_date('15-10-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (337, to_date('02-05-2024', 'dd-mm-yyyy'), to_date('11-01-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (400, to_date('06-07-2028', 'dd-mm-yyyy'), to_date('13-04-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (205, to_date('25-11-2026', 'dd-mm-yyyy'), to_date('31-10-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (288, to_date('13-01-2024', 'dd-mm-yyyy'), to_date('26-01-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (310, to_date('14-09-2026', 'dd-mm-yyyy'), to_date('04-02-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (742, to_date('29-01-2025', 'dd-mm-yyyy'), to_date('03-05-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (813, to_date('10-06-2028', 'dd-mm-yyyy'), to_date('05-02-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (918, to_date('16-03-2028', 'dd-mm-yyyy'), to_date('06-04-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (404, to_date('02-11-2030', 'dd-mm-yyyy'), to_date('03-06-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (748, to_date('01-12-2024', 'dd-mm-yyyy'), to_date('07-04-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (381, to_date('28-02-2024', 'dd-mm-yyyy'), to_date('15-02-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (543, to_date('28-08-2030', 'dd-mm-yyyy'), to_date('26-08-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (589, to_date('04-10-2028', 'dd-mm-yyyy'), to_date('26-05-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (443, to_date('21-01-2026', 'dd-mm-yyyy'), to_date('22-01-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (255, to_date('27-05-2025', 'dd-mm-yyyy'), to_date('02-03-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (670, to_date('01-02-2024', 'dd-mm-yyyy'), to_date('30-11-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (603, to_date('04-11-2029', 'dd-mm-yyyy'), to_date('08-05-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (551, to_date('21-11-2025', 'dd-mm-yyyy'), to_date('14-02-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (229, to_date('15-06-2026', 'dd-mm-yyyy'), to_date('25-09-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (815, to_date('28-03-2025', 'dd-mm-yyyy'), to_date('28-12-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (711, to_date('29-01-2030', 'dd-mm-yyyy'), to_date('13-04-2024', 'dd-mm-yyyy'));
commit;
prompt 200 records committed...
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (269, to_date('17-11-2027', 'dd-mm-yyyy'), to_date('08-02-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (591, to_date('14-11-2028', 'dd-mm-yyyy'), to_date('13-04-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (254, to_date('21-06-2025', 'dd-mm-yyyy'), to_date('19-04-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (929, to_date('17-11-2029', 'dd-mm-yyyy'), to_date('09-05-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (618, to_date('12-12-2025', 'dd-mm-yyyy'), to_date('25-03-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (788, to_date('22-09-2026', 'dd-mm-yyyy'), to_date('22-12-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (226, to_date('10-06-2030', 'dd-mm-yyyy'), to_date('10-09-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (971, to_date('28-10-2027', 'dd-mm-yyyy'), to_date('14-08-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (867, to_date('02-11-2024', 'dd-mm-yyyy'), to_date('16-03-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (350, to_date('12-04-2029', 'dd-mm-yyyy'), to_date('26-10-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (526, to_date('14-01-2024', 'dd-mm-yyyy'), to_date('03-03-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (741, to_date('28-03-2026', 'dd-mm-yyyy'), to_date('17-08-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (950, to_date('31-07-2027', 'dd-mm-yyyy'), to_date('08-01-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (881, to_date('25-12-2027', 'dd-mm-yyyy'), to_date('08-10-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (124, to_date('28-06-2026', 'dd-mm-yyyy'), to_date('31-05-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (644, to_date('06-02-2029', 'dd-mm-yyyy'), to_date('27-10-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (368, to_date('01-04-2028', 'dd-mm-yyyy'), to_date('26-05-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (280, to_date('28-04-2027', 'dd-mm-yyyy'), to_date('14-01-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (155, to_date('24-12-2027', 'dd-mm-yyyy'), to_date('30-10-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (916, to_date('14-07-2025', 'dd-mm-yyyy'), to_date('18-10-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (930, to_date('02-10-2025', 'dd-mm-yyyy'), to_date('17-01-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (777, to_date('24-01-2029', 'dd-mm-yyyy'), to_date('13-02-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (442, to_date('11-05-2028', 'dd-mm-yyyy'), to_date('25-05-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (969, to_date('16-07-2030', 'dd-mm-yyyy'), to_date('11-01-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (506, to_date('15-11-2028', 'dd-mm-yyyy'), to_date('31-05-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (734, to_date('15-05-2029', 'dd-mm-yyyy'), to_date('24-12-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (171, to_date('20-02-2026', 'dd-mm-yyyy'), to_date('19-07-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (118, to_date('15-02-2025', 'dd-mm-yyyy'), to_date('29-11-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (479, to_date('16-09-2029', 'dd-mm-yyyy'), to_date('06-02-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (407, to_date('11-03-2024', 'dd-mm-yyyy'), to_date('31-05-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (645, to_date('08-02-2028', 'dd-mm-yyyy'), to_date('20-02-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (246, to_date('28-05-2026', 'dd-mm-yyyy'), to_date('29-04-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (580, to_date('23-05-2027', 'dd-mm-yyyy'), to_date('28-01-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (844, to_date('01-06-2026', 'dd-mm-yyyy'), to_date('22-12-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (129, to_date('05-12-2027', 'dd-mm-yyyy'), to_date('09-03-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (720, to_date('08-06-2027', 'dd-mm-yyyy'), to_date('05-02-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (925, to_date('06-06-2026', 'dd-mm-yyyy'), to_date('06-02-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (818, to_date('09-01-2028', 'dd-mm-yyyy'), to_date('03-03-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (891, to_date('11-04-2030', 'dd-mm-yyyy'), to_date('11-09-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (101, to_date('17-10-2030', 'dd-mm-yyyy'), to_date('24-09-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (302, to_date('03-11-2027', 'dd-mm-yyyy'), to_date('14-11-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (332, to_date('09-10-2025', 'dd-mm-yyyy'), to_date('08-11-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (519, to_date('25-07-2029', 'dd-mm-yyyy'), to_date('15-04-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (380, to_date('17-01-2028', 'dd-mm-yyyy'), to_date('02-09-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (306, to_date('14-02-2026', 'dd-mm-yyyy'), to_date('06-11-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (515, to_date('20-08-2030', 'dd-mm-yyyy'), to_date('26-04-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (369, to_date('21-02-2025', 'dd-mm-yyyy'), to_date('10-09-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (892, to_date('19-03-2026', 'dd-mm-yyyy'), to_date('01-05-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (566, to_date('15-03-2025', 'dd-mm-yyyy'), to_date('25-05-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (390, to_date('15-11-2024', 'dd-mm-yyyy'), to_date('05-06-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (598, to_date('06-04-2029', 'dd-mm-yyyy'), to_date('05-01-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (117, to_date('29-08-2029', 'dd-mm-yyyy'), to_date('07-11-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (533, to_date('05-07-2025', 'dd-mm-yyyy'), to_date('02-08-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (535, to_date('27-07-2025', 'dd-mm-yyyy'), to_date('09-11-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (206, to_date('25-03-2024', 'dd-mm-yyyy'), to_date('04-06-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (505, to_date('24-04-2030', 'dd-mm-yyyy'), to_date('08-05-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (944, to_date('17-07-2024', 'dd-mm-yyyy'), to_date('22-06-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (169, to_date('08-01-2028', 'dd-mm-yyyy'), to_date('29-09-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (990, to_date('09-01-2030', 'dd-mm-yyyy'), to_date('04-01-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (770, to_date('29-10-2028', 'dd-mm-yyyy'), to_date('06-08-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (912, to_date('28-11-2027', 'dd-mm-yyyy'), to_date('04-02-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (899, to_date('27-07-2024', 'dd-mm-yyyy'), to_date('20-07-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (810, to_date('16-03-2030', 'dd-mm-yyyy'), to_date('12-11-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (624, to_date('25-04-2027', 'dd-mm-yyyy'), to_date('31-05-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (667, to_date('04-10-2027', 'dd-mm-yyyy'), to_date('24-12-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (173, to_date('14-11-2026', 'dd-mm-yyyy'), to_date('16-04-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (514, to_date('29-06-2027', 'dd-mm-yyyy'), to_date('22-08-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (466, to_date('14-02-2026', 'dd-mm-yyyy'), to_date('31-01-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (658, to_date('04-06-2026', 'dd-mm-yyyy'), to_date('11-09-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (832, to_date('20-11-2024', 'dd-mm-yyyy'), to_date('18-08-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (939, to_date('18-12-2029', 'dd-mm-yyyy'), to_date('05-05-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (717, to_date('04-04-2025', 'dd-mm-yyyy'), to_date('24-02-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (105, to_date('09-08-2026', 'dd-mm-yyyy'), to_date('25-07-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (321, to_date('08-08-2029', 'dd-mm-yyyy'), to_date('06-03-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (633, to_date('29-12-2027', 'dd-mm-yyyy'), to_date('28-10-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (729, to_date('22-02-2027', 'dd-mm-yyyy'), to_date('26-07-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (700, to_date('27-05-2028', 'dd-mm-yyyy'), to_date('06-09-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (154, to_date('07-07-2027', 'dd-mm-yyyy'), to_date('03-11-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (946, to_date('17-08-2028', 'dd-mm-yyyy'), to_date('07-01-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (666, to_date('30-07-2030', 'dd-mm-yyyy'), to_date('02-12-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (991, to_date('09-10-2027', 'dd-mm-yyyy'), to_date('07-03-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (247, to_date('27-07-2028', 'dd-mm-yyyy'), to_date('24-04-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (827, to_date('27-10-2029', 'dd-mm-yyyy'), to_date('03-06-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (225, to_date('14-02-2024', 'dd-mm-yyyy'), to_date('15-07-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (534, to_date('16-07-2029', 'dd-mm-yyyy'), to_date('17-06-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (260, to_date('10-12-2024', 'dd-mm-yyyy'), to_date('06-01-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (903, to_date('10-07-2025', 'dd-mm-yyyy'), to_date('20-07-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (938, to_date('07-11-2030', 'dd-mm-yyyy'), to_date('16-10-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (662, to_date('14-10-2025', 'dd-mm-yyyy'), to_date('14-09-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (627, to_date('25-06-2024', 'dd-mm-yyyy'), to_date('04-07-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (796, to_date('15-03-2025', 'dd-mm-yyyy'), to_date('28-06-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (544, to_date('07-12-2029', 'dd-mm-yyyy'), to_date('04-12-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (797, to_date('26-07-2030', 'dd-mm-yyyy'), to_date('21-02-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (765, to_date('05-04-2026', 'dd-mm-yyyy'), to_date('08-08-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (664, to_date('03-03-2026', 'dd-mm-yyyy'), to_date('10-07-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (790, to_date('21-01-2028', 'dd-mm-yyyy'), to_date('06-06-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (865, to_date('23-06-2030', 'dd-mm-yyyy'), to_date('22-02-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (730, to_date('21-06-2029', 'dd-mm-yyyy'), to_date('23-11-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (235, to_date('16-01-2026', 'dd-mm-yyyy'), to_date('15-10-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (324, to_date('03-11-2028', 'dd-mm-yyyy'), to_date('22-04-2029', 'dd-mm-yyyy'));
commit;
prompt 300 records committed...
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (606, to_date('22-07-2027', 'dd-mm-yyyy'), to_date('12-12-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (673, to_date('18-02-2028', 'dd-mm-yyyy'), to_date('31-10-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (182, to_date('01-09-2024', 'dd-mm-yyyy'), to_date('18-03-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (739, to_date('01-03-2024', 'dd-mm-yyyy'), to_date('12-01-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (304, to_date('24-07-2026', 'dd-mm-yyyy'), to_date('18-12-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (998, to_date('03-03-2027', 'dd-mm-yyyy'), to_date('09-10-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (655, to_date('12-10-2027', 'dd-mm-yyyy'), to_date('29-07-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (492, to_date('06-01-2030', 'dd-mm-yyyy'), to_date('22-01-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (828, to_date('05-05-2026', 'dd-mm-yyyy'), to_date('15-11-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (872, to_date('03-05-2029', 'dd-mm-yyyy'), to_date('29-11-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (824, to_date('25-02-2025', 'dd-mm-yyyy'), to_date('11-08-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (146, to_date('20-01-2025', 'dd-mm-yyyy'), to_date('10-11-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (919, to_date('28-01-2027', 'dd-mm-yyyy'), to_date('27-07-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (602, to_date('22-12-2030', 'dd-mm-yyyy'), to_date('16-07-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (571, to_date('09-09-2025', 'dd-mm-yyyy'), to_date('19-10-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (771, to_date('13-11-2024', 'dd-mm-yyyy'), to_date('24-03-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (340, to_date('01-11-2025', 'dd-mm-yyyy'), to_date('02-08-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (181, to_date('28-03-2030', 'dd-mm-yyyy'), to_date('30-09-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (854, to_date('25-08-2024', 'dd-mm-yyyy'), to_date('22-12-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (542, to_date('30-10-2028', 'dd-mm-yyyy'), to_date('28-07-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (663, to_date('25-11-2030', 'dd-mm-yyyy'), to_date('18-01-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (913, to_date('08-06-2024', 'dd-mm-yyyy'), to_date('28-03-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (905, to_date('08-01-2024', 'dd-mm-yyyy'), to_date('30-12-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (387, to_date('01-01-2029', 'dd-mm-yyyy'), to_date('12-02-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (158, to_date('25-06-2029', 'dd-mm-yyyy'), to_date('03-02-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (986, to_date('29-03-2028', 'dd-mm-yyyy'), to_date('28-02-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (265, to_date('26-06-2024', 'dd-mm-yyyy'), to_date('11-07-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (546, to_date('06-10-2029', 'dd-mm-yyyy'), to_date('28-12-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (707, to_date('16-01-2024', 'dd-mm-yyyy'), to_date('10-03-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (906, to_date('05-05-2025', 'dd-mm-yyyy'), to_date('02-04-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (768, to_date('25-06-2029', 'dd-mm-yyyy'), to_date('30-05-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (540, to_date('18-07-2030', 'dd-mm-yyyy'), to_date('23-05-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (609, to_date('12-12-2026', 'dd-mm-yyyy'), to_date('22-12-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (209, to_date('21-03-2024', 'dd-mm-yyyy'), to_date('15-10-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (715, to_date('12-11-2026', 'dd-mm-yyyy'), to_date('13-07-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (485, to_date('28-03-2026', 'dd-mm-yyyy'), to_date('06-09-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (371, to_date('24-06-2024', 'dd-mm-yyyy'), to_date('15-05-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (639, to_date('01-08-2027', 'dd-mm-yyyy'), to_date('22-04-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (253, to_date('30-07-2026', 'dd-mm-yyyy'), to_date('06-02-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (530, to_date('21-03-2025', 'dd-mm-yyyy'), to_date('26-01-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (584, to_date('02-07-2026', 'dd-mm-yyyy'), to_date('03-05-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (417, to_date('24-12-2027', 'dd-mm-yyyy'), to_date('29-01-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (864, to_date('08-04-2028', 'dd-mm-yyyy'), to_date('23-03-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (697, to_date('14-06-2025', 'dd-mm-yyyy'), to_date('09-04-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (528, to_date('05-04-2026', 'dd-mm-yyyy'), to_date('02-06-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (470, to_date('26-06-2030', 'dd-mm-yyyy'), to_date('10-12-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (626, to_date('27-04-2030', 'dd-mm-yyyy'), to_date('14-01-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (884, to_date('08-08-2026', 'dd-mm-yyyy'), to_date('01-01-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (634, to_date('17-10-2025', 'dd-mm-yyyy'), to_date('14-08-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (834, to_date('24-05-2025', 'dd-mm-yyyy'), to_date('04-09-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (308, to_date('27-01-2024', 'dd-mm-yyyy'), to_date('26-12-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (379, to_date('06-01-2030', 'dd-mm-yyyy'), to_date('08-10-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (636, to_date('25-06-2028', 'dd-mm-yyyy'), to_date('11-05-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (999, to_date('15-06-2024', 'dd-mm-yyyy'), to_date('21-04-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (894, to_date('10-02-2024', 'dd-mm-yyyy'), to_date('22-04-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (882, to_date('21-05-2028', 'dd-mm-yyyy'), to_date('03-11-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (343, to_date('27-07-2026', 'dd-mm-yyyy'), to_date('28-07-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (274, to_date('19-10-2027', 'dd-mm-yyyy'), to_date('15-09-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (284, to_date('19-01-2026', 'dd-mm-yyyy'), to_date('14-07-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (755, to_date('13-10-2027', 'dd-mm-yyyy'), to_date('24-07-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (977, to_date('07-09-2027', 'dd-mm-yyyy'), to_date('08-02-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (736, to_date('04-03-2027', 'dd-mm-yyyy'), to_date('27-02-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (907, to_date('17-09-2029', 'dd-mm-yyyy'), to_date('10-05-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (500, to_date('17-03-2024', 'dd-mm-yyyy'), to_date('04-01-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (572, to_date('10-12-2026', 'dd-mm-yyyy'), to_date('18-01-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (335, to_date('04-10-2026', 'dd-mm-yyyy'), to_date('28-07-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (841, to_date('11-10-2027', 'dd-mm-yyyy'), to_date('13-02-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (674, to_date('07-07-2030', 'dd-mm-yyyy'), to_date('06-04-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (413, to_date('09-09-2026', 'dd-mm-yyyy'), to_date('25-04-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (954, to_date('14-03-2026', 'dd-mm-yyyy'), to_date('21-08-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (168, to_date('09-09-2028', 'dd-mm-yyyy'), to_date('01-08-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (651, to_date('26-08-2030', 'dd-mm-yyyy'), to_date('03-04-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (426, to_date('08-12-2029', 'dd-mm-yyyy'), to_date('02-08-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (160, to_date('12-02-2024', 'dd-mm-yyyy'), to_date('02-11-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (131, to_date('08-04-2026', 'dd-mm-yyyy'), to_date('06-01-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (268, to_date('12-06-2025', 'dd-mm-yyyy'), to_date('15-05-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (803, to_date('17-11-2024', 'dd-mm-yyyy'), to_date('11-05-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (970, to_date('18-05-2027', 'dd-mm-yyyy'), to_date('02-06-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (469, to_date('22-10-2025', 'dd-mm-yyyy'), to_date('19-09-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (305, to_date('18-12-2027', 'dd-mm-yyyy'), to_date('25-01-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (180, to_date('03-04-2025', 'dd-mm-yyyy'), to_date('02-02-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (753, to_date('08-08-2030', 'dd-mm-yyyy'), to_date('20-03-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (126, to_date('11-04-2025', 'dd-mm-yyyy'), to_date('03-01-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (448, to_date('03-09-2029', 'dd-mm-yyyy'), to_date('31-01-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (128, to_date('07-09-2029', 'dd-mm-yyyy'), to_date('06-10-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (104, to_date('26-06-2029', 'dd-mm-yyyy'), to_date('01-01-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (721, to_date('25-03-2025', 'dd-mm-yyyy'), to_date('05-08-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (423, to_date('14-04-2027', 'dd-mm-yyyy'), to_date('15-08-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (270, to_date('29-01-2025', 'dd-mm-yyyy'), to_date('16-05-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (613, to_date('04-05-2029', 'dd-mm-yyyy'), to_date('21-12-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (228, to_date('03-03-2024', 'dd-mm-yyyy'), to_date('01-04-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (349, to_date('30-04-2025', 'dd-mm-yyyy'), to_date('22-03-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (365, to_date('22-07-2030', 'dd-mm-yyyy'), to_date('17-06-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (277, to_date('28-11-2027', 'dd-mm-yyyy'), to_date('31-10-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (457, to_date('25-12-2030', 'dd-mm-yyyy'), to_date('12-04-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (862, to_date('16-04-2028', 'dd-mm-yyyy'), to_date('10-07-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (125, to_date('22-05-2026', 'dd-mm-yyyy'), to_date('03-09-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (517, to_date('04-01-2029', 'dd-mm-yyyy'), to_date('07-06-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (244, to_date('15-02-2025', 'dd-mm-yyyy'), to_date('14-10-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (518, to_date('05-04-2026', 'dd-mm-yyyy'), to_date('21-10-2029', 'dd-mm-yyyy'));
commit;
prompt 400 records committed...
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (238, to_date('23-06-2028', 'dd-mm-yyyy'), to_date('11-08-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (746, to_date('21-02-2028', 'dd-mm-yyyy'), to_date('26-06-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (563, to_date('15-11-2029', 'dd-mm-yyyy'), to_date('26-06-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (445, to_date('24-04-2026', 'dd-mm-yyyy'), to_date('21-05-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (769, to_date('23-07-2026', 'dd-mm-yyyy'), to_date('01-11-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (831, to_date('29-12-2024', 'dd-mm-yyyy'), to_date('23-05-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (951, to_date('08-01-2029', 'dd-mm-yyyy'), to_date('16-04-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (537, to_date('17-09-2024', 'dd-mm-yyyy'), to_date('10-08-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (785, to_date('27-02-2024', 'dd-mm-yyyy'), to_date('16-12-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (121, to_date('31-08-2027', 'dd-mm-yyyy'), to_date('19-02-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (552, to_date('14-02-2030', 'dd-mm-yyyy'), to_date('03-03-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (798, to_date('14-05-2030', 'dd-mm-yyyy'), to_date('13-08-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (953, to_date('16-11-2028', 'dd-mm-yyyy'), to_date('22-08-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (414, to_date('03-12-2029', 'dd-mm-yyyy'), to_date('22-12-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (120, to_date('12-04-2029', 'dd-mm-yyyy'), to_date('08-12-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (133, to_date('05-08-2027', 'dd-mm-yyyy'), to_date('03-11-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (334, to_date('24-02-2025', 'dd-mm-yyyy'), to_date('25-04-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (415, to_date('22-06-2025', 'dd-mm-yyyy'), to_date('19-01-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (754, to_date('08-11-2024', 'dd-mm-yyyy'), to_date('10-08-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (227, to_date('15-06-2028', 'dd-mm-yyyy'), to_date('23-09-2027', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (763, to_date('24-04-2024', 'dd-mm-yyyy'), to_date('02-02-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (320, to_date('23-08-2028', 'dd-mm-yyyy'), to_date('03-04-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (623, to_date('28-10-2028', 'dd-mm-yyyy'), to_date('22-12-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (287, to_date('31-07-2025', 'dd-mm-yyyy'), to_date('31-07-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (812, to_date('02-06-2029', 'dd-mm-yyyy'), to_date('27-11-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (106, to_date('17-06-2024', 'dd-mm-yyyy'), to_date('31-03-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (588, to_date('09-06-2029', 'dd-mm-yyyy'), to_date('26-02-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (693, to_date('16-08-2027', 'dd-mm-yyyy'), to_date('29-01-2024', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (973, to_date('07-06-2029', 'dd-mm-yyyy'), to_date('12-11-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (314, to_date('11-06-2025', 'dd-mm-yyyy'), to_date('04-06-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (792, to_date('28-10-2027', 'dd-mm-yyyy'), to_date('17-04-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (779, to_date('01-06-2029', 'dd-mm-yyyy'), to_date('16-08-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (622, to_date('20-02-2026', 'dd-mm-yyyy'), to_date('13-06-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (732, to_date('04-10-2027', 'dd-mm-yyyy'), to_date('09-09-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (401, to_date('28-01-2029', 'dd-mm-yyyy'), to_date('11-12-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (140, to_date('03-02-2026', 'dd-mm-yyyy'), to_date('27-12-2025', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (241, to_date('14-10-2026', 'dd-mm-yyyy'), to_date('26-09-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (558, to_date('30-09-2027', 'dd-mm-yyyy'), to_date('29-07-2029', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (712, to_date('12-03-2030', 'dd-mm-yyyy'), to_date('16-12-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (166, to_date('24-09-2024', 'dd-mm-yyyy'), to_date('05-12-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (752, to_date('07-07-2025', 'dd-mm-yyyy'), to_date('14-01-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (641, to_date('28-02-2028', 'dd-mm-yyyy'), to_date('25-02-2030', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (822, to_date('31-07-2024', 'dd-mm-yyyy'), to_date('28-01-2026', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (509, to_date('12-04-2027', 'dd-mm-yyyy'), to_date('16-06-2028', 'dd-mm-yyyy'));
insert into PURCHASE (purchase_id, purchase_date, dellivery_date)
values (281, to_date('18-10-2025', 'dd-mm-yyyy'), to_date('13-05-2024', 'dd-mm-yyyy'));
commit;
prompt 445 records loaded
prompt Loading PURCHASE_CLIENT...
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (1, 677);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (1, 852);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (2, 843);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (3, 814);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (5, 319);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (9, 208);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (9, 605);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (9, 611);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (13, 814);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (19, 123);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (22, 183);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (23, 611);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (24, 388);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (24, 811);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (26, 676);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (26, 814);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (27, 395);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (28, 145);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (28, 911);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (29, 863);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (35, 377);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (36, 162);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (36, 676);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (37, 863);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (45, 348);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (48, 208);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (49, 145);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (50, 911);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (52, 611);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (54, 183);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (57, 604);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (58, 852);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (61, 464);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (62, 339);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (65, 436);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (67, 395);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (67, 911);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (68, 395);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (70, 811);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (70, 843);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (74, 377);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (75, 339);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (75, 474);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (81, 116);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (84, 339);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (89, 474);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (92, 377);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (94, 911);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (95, 863);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (95, 911);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (98, 162);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (98, 604);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (99, 811);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (101, 101);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (101, 348);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (104, 104);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (105, 105);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (106, 106);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (106, 116);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (107, 116);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (108, 208);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (109, 604);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (109, 676);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (110, 110);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (110, 863);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (111, 111);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (112, 157);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (114, 464);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (115, 179);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (116, 116);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (117, 117);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (117, 843);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (118, 118);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (119, 319);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (120, 120);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (120, 208);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (120, 395);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (121, 121);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (123, 123);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (124, 124);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (125, 125);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (126, 126);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (127, 911);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (128, 128);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (128, 852);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (129, 129);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (130, 130);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (131, 131);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (133, 133);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (133, 179);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (137, 137);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (139, 339);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (139, 604);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (140, 140);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (141, 141);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (144, 319);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (145, 145);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (145, 464);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (146, 146);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (148, 348);
commit;
prompt 100 records committed...
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (148, 436);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (149, 149);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (151, 179);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (154, 154);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (154, 852);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (155, 155);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (156, 676);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (156, 843);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (157, 157);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (157, 611);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (158, 158);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (160, 160);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (161, 179);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (161, 208);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (162, 162);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (162, 956);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (164, 162);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (166, 166);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (168, 168);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (169, 169);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (171, 171);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (172, 172);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (173, 173);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (175, 175);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (176, 116);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (177, 177);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (177, 377);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (178, 178);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (179, 179);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (180, 180);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (181, 181);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (182, 182);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (183, 183);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (183, 339);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (184, 184);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (185, 474);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (185, 843);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (186, 186);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (187, 145);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (188, 348);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (188, 388);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (188, 843);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (189, 189);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (190, 190);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (195, 395);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (195, 811);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (195, 911);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (197, 197);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (200, 605);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (201, 101);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (201, 201);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (201, 377);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (202, 778);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (203, 319);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (203, 388);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (204, 104);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (204, 956);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (205, 105);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (205, 205);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (206, 106);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (206, 206);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (207, 145);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (207, 207);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (207, 377);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (208, 208);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (209, 209);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (209, 778);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (210, 110);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (211, 111);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (212, 348);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (212, 863);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (213, 605);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (216, 116);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (216, 395);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (216, 778);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (217, 117);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (218, 118);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (218, 179);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (218, 218);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (219, 208);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (219, 219);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (219, 319);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (220, 120);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (220, 220);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (220, 464);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (221, 121);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (221, 395);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (223, 123);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (223, 436);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (223, 911);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (224, 124);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (225, 125);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (225, 225);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (226, 126);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (226, 226);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (226, 604);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (227, 227);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (228, 128);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (228, 228);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (229, 129);
commit;
prompt 200 records committed...
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (229, 229);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (230, 130);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (231, 131);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (231, 843);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (232, 208);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (232, 611);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (233, 133);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (235, 235);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (236, 436);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (237, 137);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (238, 238);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (239, 239);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (239, 339);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (240, 140);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (241, 141);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (241, 241);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (244, 244);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (245, 145);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (245, 162);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (245, 179);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (246, 146);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (246, 246);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (247, 247);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (248, 348);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (249, 149);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (251, 395);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (253, 253);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (253, 911);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (254, 154);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (254, 254);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (254, 474);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (255, 155);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (255, 255);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (257, 157);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (257, 257);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (258, 158);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (258, 258);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (259, 778);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (260, 160);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (260, 260);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (261, 261);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (262, 162);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (264, 264);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (264, 464);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (264, 474);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (265, 123);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (265, 265);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (266, 166);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (266, 266);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (268, 168);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (268, 268);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (269, 169);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (269, 269);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (270, 123);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (270, 270);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (271, 171);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (271, 852);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (272, 172);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (272, 611);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (273, 173);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (274, 274);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (274, 436);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (274, 474);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (275, 175);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (276, 852);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (277, 177);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (277, 208);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (277, 277);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (277, 377);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (277, 911);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (278, 178);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (279, 179);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (280, 180);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (280, 280);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (281, 181);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (281, 281);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (282, 182);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (283, 183);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (283, 611);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (284, 184);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (284, 284);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (285, 605);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (286, 186);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (287, 287);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (288, 288);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (288, 388);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (289, 189);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (290, 190);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (290, 290);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (291, 863);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (293, 388);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (294, 294);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (295, 295);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (295, 395);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (296, 183);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (296, 296);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (297, 197);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (297, 297);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (298, 778);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (300, 605);
commit;
prompt 300 records committed...
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (300, 676);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (301, 201);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (302, 302);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (302, 436);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (304, 304);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (305, 205);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (305, 305);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (306, 206);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (306, 306);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (307, 207);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (307, 307);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (308, 208);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (308, 308);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (308, 676);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (309, 209);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (309, 555);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (310, 310);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (310, 339);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (310, 911);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (314, 314);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (315, 956);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (316, 116);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (318, 218);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (319, 219);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (319, 319);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (320, 220);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (320, 320);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (321, 321);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (323, 123);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (323, 323);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (324, 324);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (325, 145);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (325, 225);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (325, 811);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (326, 226);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (327, 227);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (328, 228);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (329, 229);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (330, 395);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (331, 677);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (332, 319);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (332, 332);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (334, 334);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (335, 235);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (335, 335);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (336, 436);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (337, 337);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (338, 238);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (339, 239);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (339, 339);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (340, 340);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (341, 241);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (343, 343);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (344, 244);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (344, 344);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (344, 956);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (345, 145);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (346, 246);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (347, 247);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (348, 348);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (348, 676);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (349, 349);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (350, 350);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (350, 436);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (352, 352);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (353, 253);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (354, 254);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (355, 255);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (355, 555);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (357, 157);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (357, 257);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (358, 258);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (358, 358);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (359, 339);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (359, 377);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (359, 395);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (360, 260);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (361, 261);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (362, 162);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (363, 843);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (364, 264);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (364, 364);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (364, 464);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (365, 265);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (365, 365);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (366, 266);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (366, 366);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (368, 208);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (368, 268);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (368, 368);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (368, 395);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (369, 269);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (369, 369);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (370, 270);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (370, 604);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (371, 208);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (371, 371);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (371, 778);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (372, 157);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (372, 436);
commit;
prompt 400 records committed...
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (373, 183);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (374, 274);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (374, 388);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (374, 474);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (376, 376);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (377, 277);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (377, 348);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (377, 377);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (379, 157);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (379, 179);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (379, 379);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (380, 280);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (380, 380);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (381, 281);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (381, 381);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (382, 382);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (383, 183);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (384, 284);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (385, 385);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (386, 604);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (387, 287);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (387, 387);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (387, 956);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (388, 288);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (388, 388);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (389, 319);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (390, 290);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (390, 390);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (390, 911);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (393, 183);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (393, 393);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (394, 145);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (394, 294);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (395, 295);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (395, 395);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (396, 296);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (396, 395);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (396, 676);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (397, 145);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (397, 208);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (397, 297);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (397, 397);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (400, 208);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (400, 400);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (400, 911);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (405, 305);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (405, 605);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (423, 123);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (423, 323);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (423, 423);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (462, 162);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (487, 387);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (489, 436);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (492, 208);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (492, 814);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (501, 401);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (501, 604);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (504, 404);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (504, 604);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (512, 388);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (512, 412);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (513, 208);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (513, 413);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (536, 436);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (544, 388);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (544, 444);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (551, 388);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (551, 676);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (555, 555);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (592, 492);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (608, 208);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (611, 611);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (611, 811);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (615, 145);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (685, 157);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (704, 145);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (704, 604);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (727, 183);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (728, 676);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (730, 377);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (764, 464);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (791, 157);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (830, 604);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (868, 183);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (896, 145);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (896, 843);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (920, 605);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (928, 911);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (955, 555);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (975, 348);
insert into PURCHASE_CLIENT (client_id, purchase_id)
values (998, 183);
commit;
prompt 491 records loaded
prompt Loading PURCHASE_PRODUCT...
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (101, 101);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (101, 162);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (104, 104);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (105, 105);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (107, 814);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (109, 183);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (109, 811);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (109, 956);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (110, 110);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (111, 111);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (116, 116);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (116, 183);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (116, 339);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (117, 117);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (118, 118);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (120, 120);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (121, 121);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (123, 123);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (123, 814);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (124, 124);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (126, 126);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (128, 128);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (129, 129);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (130, 130);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (131, 131);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (133, 133);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (139, 395);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (140, 140);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (141, 141);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (145, 145);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (157, 157);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (159, 956);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (164, 814);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (166, 166);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (166, 388);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (167, 388);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (171, 171);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (172, 157);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (172, 172);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (177, 177);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (178, 178);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (182, 145);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (182, 182);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (183, 183);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (183, 208);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (184, 184);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (199, 123);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (201, 201);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (203, 157);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (205, 205);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (205, 604);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (207, 207);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (209, 209);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (213, 123);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (218, 218);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (220, 220);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (226, 226);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (227, 227);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (228, 228);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (229, 229);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (229, 811);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (229, 852);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (230, 677);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (235, 235);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (239, 239);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (240, 474);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (241, 241);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (243, 604);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (244, 244);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (247, 247);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (253, 253);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (257, 257);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (264, 264);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (264, 611);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (266, 266);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (271, 605);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (274, 274);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (277, 277);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (283, 123);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (284, 284);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (288, 288);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (291, 843);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (295, 295);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (296, 296);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (302, 302);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (304, 304);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (305, 305);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (305, 605);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (307, 183);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (307, 307);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (310, 310);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (310, 388);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (312, 677);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (314, 314);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (317, 162);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (318, 348);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (320, 320);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (320, 395);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (320, 611);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (321, 321);
commit;
prompt 100 records committed...
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (323, 323);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (324, 324);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (331, 183);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (332, 332);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (333, 464);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (335, 335);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (339, 339);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (339, 604);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (340, 340);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (340, 778);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (343, 343);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (343, 863);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (344, 344);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (348, 348);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (357, 116);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (357, 843);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (364, 364);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (366, 366);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (371, 371);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (377, 123);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (377, 377);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (382, 382);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (384, 677);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (388, 388);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (395, 395);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (395, 605);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (399, 377);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (400, 400);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (401, 401);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (403, 395);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (404, 404);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (407, 407);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (409, 409);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (410, 410);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (410, 843);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (412, 412);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (413, 179);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (413, 413);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (414, 414);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (415, 415);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (417, 417);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (417, 555);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (418, 179);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (423, 423);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (426, 426);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (427, 427);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (427, 605);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (430, 430);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (430, 604);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (436, 436);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (439, 439);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (442, 442);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (443, 443);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (444, 444);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (444, 956);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (445, 445);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (448, 448);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (448, 605);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (456, 456);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (457, 457);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (463, 956);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (464, 464);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (466, 466);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (467, 467);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (474, 474);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (478, 478);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (482, 319);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (482, 863);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (492, 492);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (500, 500);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (504, 504);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (505, 505);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (507, 183);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (509, 509);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (513, 157);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (514, 514);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (515, 157);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (515, 515);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (516, 183);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (516, 516);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (517, 517);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (518, 518);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (523, 523);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (524, 116);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (524, 555);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (526, 526);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (527, 527);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (528, 395);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (528, 528);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (528, 604);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (530, 530);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (531, 531);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (533, 533);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (535, 474);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (535, 535);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (539, 539);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (539, 863);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (540, 157);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (540, 540);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (541, 436);
commit;
prompt 200 records committed...
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (542, 542);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (543, 543);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (544, 348);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (544, 544);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (547, 547);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (556, 556);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (557, 474);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (557, 611);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (559, 157);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (563, 563);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (564, 564);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (566, 566);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (571, 571);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (572, 572);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (577, 145);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (582, 582);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (583, 319);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (584, 584);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (588, 588);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (588, 677);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (591, 591);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (600, 600);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (602, 602);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (603, 603);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (604, 348);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (604, 604);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (605, 605);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (605, 811);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (606, 606);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (606, 811);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (606, 911);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (607, 395);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (609, 609);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (610, 610);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (611, 611);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (611, 843);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (613, 613);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (613, 863);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (614, 614);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (616, 339);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (618, 618);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (622, 388);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (622, 622);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (623, 623);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (624, 605);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (624, 624);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (625, 625);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (626, 626);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (627, 627);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (628, 852);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (628, 911);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (629, 629);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (630, 157);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (630, 377);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (630, 863);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (631, 631);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (633, 633);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (633, 911);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (634, 634);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (636, 636);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (637, 157);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (637, 464);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (637, 637);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (637, 814);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (638, 638);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (639, 639);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (640, 640);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (641, 641);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (644, 377);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (644, 644);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (645, 645);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (648, 611);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (648, 648);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (651, 651);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (653, 653);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (655, 655);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (656, 388);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (658, 658);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (662, 662);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (663, 663);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (664, 664);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (665, 843);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (666, 611);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (666, 666);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (667, 667);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (670, 670);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (671, 116);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (672, 672);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (673, 673);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (674, 674);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (675, 179);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (676, 676);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (677, 677);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (682, 395);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (684, 436);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (685, 685);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (691, 691);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (694, 778);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (694, 843);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (699, 699);
commit;
prompt 300 records committed...
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (700, 700);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (702, 702);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (704, 911);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (705, 676);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (705, 705);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (709, 116);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (711, 711);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (712, 712);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (715, 715);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (717, 717);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (720, 720);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (721, 721);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (723, 116);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (724, 724);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (725, 725);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (727, 727);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (728, 377);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (728, 728);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (729, 729);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (730, 730);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (732, 732);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (734, 734);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (736, 677);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (736, 736);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (739, 739);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (739, 852);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (740, 740);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (741, 741);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (742, 742);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (743, 377);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (744, 162);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (746, 746);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (748, 748);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (749, 749);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (752, 752);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (753, 753);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (754, 754);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (755, 755);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (757, 605);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (758, 758);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (759, 605);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (762, 762);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (763, 763);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (765, 765);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (767, 767);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (768, 768);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (768, 814);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (769, 769);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (770, 770);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (771, 771);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (775, 555);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (776, 776);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (776, 814);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (777, 777);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (778, 778);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (779, 779);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (780, 780);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (782, 782);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (785, 785);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (788, 788);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (789, 789);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (790, 790);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (791, 162);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (792, 208);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (792, 792);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (793, 793);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (795, 795);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (796, 796);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (797, 676);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (797, 797);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (799, 799);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (801, 801);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (803, 803);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (803, 863);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (805, 805);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (808, 808);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (809, 809);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (810, 810);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (811, 811);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (812, 812);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (813, 813);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (814, 814);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (815, 815);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (816, 611);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (818, 818);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (819, 677);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (821, 821);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (822, 822);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (823, 157);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (824, 824);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (825, 825);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (827, 162);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (827, 827);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (828, 611);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (828, 828);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (830, 157);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (831, 831);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (832, 832);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (833, 319);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (833, 833);
commit;
prompt 400 records committed...
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (834, 834);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (837, 837);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (837, 863);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (839, 348);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (839, 839);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (841, 841);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (843, 843);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (844, 844);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (847, 179);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (847, 847);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (849, 123);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (849, 849);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (851, 319);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (851, 851);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (852, 319);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (852, 852);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (853, 339);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (853, 555);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (854, 854);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (857, 857);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (862, 862);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (863, 208);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (863, 377);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (863, 863);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (863, 956);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (864, 864);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (864, 956);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (865, 865);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (867, 867);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (868, 778);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (868, 868);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (870, 395);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (870, 555);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (871, 319);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (872, 872);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (874, 874);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (877, 811);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (877, 877);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (877, 956);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (878, 878);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (880, 123);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (880, 145);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (881, 881);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (882, 882);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (883, 956);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (884, 884);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (885, 885);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (886, 677);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (891, 891);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (892, 116);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (892, 892);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (893, 179);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (893, 893);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (894, 894);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (895, 348);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (896, 896);
insert into PURCHASE_PRODUCT (product_id, purchase_id)
values (899, 899);
commit;
prompt 457 records loaded
prompt Loading PURCHASE_WORKER...
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (104, 104);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (104, 208);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (104, 811);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (105, 105);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (106, 106);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (108, 208);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (111, 111);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (116, 116);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (118, 118);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (120, 120);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (121, 121);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (123, 123);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (124, 124);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (126, 126);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (128, 128);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (129, 129);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (130, 130);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (131, 131);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (135, 179);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (136, 436);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (137, 137);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (139, 339);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (140, 140);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (146, 146);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (149, 149);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (154, 154);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (158, 158);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (164, 464);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (166, 166);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (166, 676);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (169, 169);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (171, 171);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (172, 172);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (173, 173);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (177, 177);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (177, 377);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (179, 179);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (180, 180);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (182, 182);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (183, 183);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (184, 184);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (186, 186);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (188, 388);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (190, 190);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (201, 101);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (201, 201);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (204, 104);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (204, 604);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (205, 105);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (205, 205);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (205, 605);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (207, 207);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (208, 208);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (209, 209);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (211, 111);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (211, 611);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (216, 116);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (216, 811);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (218, 118);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (218, 218);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (219, 219);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (219, 319);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (223, 123);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (227, 145);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (227, 227);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (233, 133);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (237, 137);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (239, 239);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (239, 339);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (241, 141);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (241, 241);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (244, 244);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (245, 145);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (247, 247);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (248, 348);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (249, 149);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (254, 154);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (254, 254);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (257, 157);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (257, 257);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (264, 264);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (264, 464);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (268, 168);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (268, 268);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (269, 169);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (269, 269);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (270, 157);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (270, 270);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (272, 172);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (274, 274);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (274, 474);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (277, 177);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (277, 277);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (277, 377);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (278, 178);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (279, 179);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (280, 180);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (280, 280);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (281, 181);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (281, 281);
commit;
prompt 100 records committed...
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (283, 183);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (286, 186);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (288, 288);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (288, 388);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (289, 189);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (294, 294);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (296, 296);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (297, 197);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (297, 297);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (302, 302);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (304, 304);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (304, 604);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (306, 206);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (306, 306);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (308, 208);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (308, 308);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (311, 611);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (318, 218);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (320, 220);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (320, 320);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (321, 321);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (323, 123);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (323, 323);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (324, 324);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (325, 225);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (329, 229);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (329, 605);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (332, 332);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (334, 334);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (335, 235);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (335, 335);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (336, 436);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (339, 239);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (339, 339);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (340, 340);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (341, 241);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (346, 246);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (347, 247);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (348, 348);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (352, 352);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (353, 253);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (353, 852);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (354, 254);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (355, 255);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (355, 555);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (357, 157);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (357, 257);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (358, 258);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (358, 358);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (361, 261);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (365, 265);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (365, 365);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (366, 266);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (366, 366);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (369, 269);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (369, 369);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (371, 371);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (377, 277);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (377, 377);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (377, 677);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (381, 281);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (381, 381);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (382, 382);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (387, 287);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (387, 387);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (388, 288);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (388, 388);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (390, 290);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (390, 390);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (393, 393);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (394, 294);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (401, 401);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (402, 302);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (406, 306);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (407, 307);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (407, 407);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (408, 208);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (408, 308);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (409, 409);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (410, 310);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (410, 410);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (412, 412);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (414, 314);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (414, 414);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (419, 319);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (421, 321);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (422, 422);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (432, 332);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (434, 334);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (442, 442);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (443, 343);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (443, 443);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (445, 145);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (445, 445);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (449, 349);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (450, 350);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (454, 454);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (455, 555);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (457, 157);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (457, 457);
commit;
prompt 200 records committed...
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (458, 358);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (462, 162);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (464, 364);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (464, 464);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (465, 365);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (468, 368);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (469, 369);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (469, 469);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (470, 470);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (471, 371);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (476, 376);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (476, 676);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (477, 377);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (477, 677);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (478, 478);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (478, 778);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (481, 381);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (487, 387);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (494, 494);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (497, 397);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (498, 498);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (501, 401);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (502, 179);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (504, 404);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (504, 504);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (504, 604);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (505, 505);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (505, 605);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (509, 409);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (509, 509);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (510, 410);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (512, 412);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (513, 413);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (514, 414);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (514, 514);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (514, 814);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (515, 415);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (515, 515);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (516, 116);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (516, 516);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (518, 518);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (519, 319);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (519, 519);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (522, 422);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (522, 522);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (522, 605);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (523, 123);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (523, 423);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (523, 523);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (526, 426);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (526, 526);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (527, 427);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (527, 527);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (531, 531);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (533, 533);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (536, 436);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (539, 339);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (539, 439);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (539, 539);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (542, 442);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (542, 542);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (543, 443);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (543, 543);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (543, 843);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (544, 444);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (544, 544);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (545, 145);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (545, 445);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (546, 546);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (548, 348);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (548, 448);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (551, 551);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (552, 552);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (552, 852);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (557, 157);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (557, 457);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (561, 123);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (561, 461);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (563, 563);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (563, 605);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (563, 863);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (564, 464);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (564, 564);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (566, 466);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (566, 566);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (570, 470);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (570, 570);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (572, 572);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (574, 474);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (577, 377);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (577, 677);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (578, 478);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (578, 778);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (579, 116);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (579, 179);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (579, 479);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (582, 582);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (584, 584);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (585, 485);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (588, 388);
commit;
prompt 300 records committed...
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (588, 588);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (589, 589);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (590, 590);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (591, 591);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (592, 492);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (594, 494);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (598, 498);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (598, 598);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (600, 500);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (600, 600);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (603, 603);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (604, 504);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (604, 604);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (606, 506);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (606, 606);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (610, 610);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (611, 611);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (611, 811);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (611, 911);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (613, 613);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (614, 514);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (614, 614);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (614, 814);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (615, 515);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (616, 116);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (616, 516);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (618, 518);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (618, 618);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (619, 319);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (619, 519);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (624, 624);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (625, 625);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (627, 527);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (627, 627);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (629, 629);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (630, 530);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (635, 535);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (637, 537);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (637, 637);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (637, 863);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (640, 540);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (640, 640);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (641, 641);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (642, 542);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (643, 543);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (643, 843);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (645, 123);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (645, 145);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (645, 645);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (648, 348);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (648, 648);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (649, 649);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (651, 551);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (651, 651);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (651, 843);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (656, 556);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (656, 956);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (657, 157);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (662, 162);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (662, 662);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (664, 464);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (664, 564);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (664, 664);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (666, 566);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (666, 666);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (667, 667);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (670, 570);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (670, 670);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (671, 571);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (673, 573);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (673, 673);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (674, 474);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (674, 674);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (678, 778);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (679, 179);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (680, 580);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (682, 582);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (684, 584);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (688, 388);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (688, 588);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (691, 591);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (691, 691);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (695, 395);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (698, 598);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (700, 600);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (700, 700);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (703, 603);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (705, 605);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (705, 705);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (710, 610);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (715, 145);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (715, 715);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (719, 319);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (721, 721);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (722, 622);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (726, 339);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (726, 626);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (727, 627);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (727, 727);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (728, 728);
commit;
prompt 400 records committed...
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (729, 629);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (729, 729);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (730, 730);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (731, 631);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (732, 732);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (733, 633);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (736, 436);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (736, 636);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (736, 736);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (737, 637);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (739, 339);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (739, 639);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (739, 739);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (741, 641);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (741, 741);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (742, 742);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (744, 644);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (745, 645);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (746, 746);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (748, 348);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (748, 648);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (748, 748);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (749, 649);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (749, 749);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (750, 650);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (750, 811);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (751, 651);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (756, 956);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (758, 658);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (758, 758);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (761, 911);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (762, 662);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (762, 762);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (765, 765);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (766, 666);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (773, 673);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (774, 474);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (774, 674);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (776, 676);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (776, 776);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (778, 778);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (779, 779);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (782, 782);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (783, 319);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (788, 388);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (788, 604);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (788, 788);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (789, 789);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (790, 790);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (791, 691);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (792, 792);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (793, 693);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (793, 793);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (797, 697);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (797, 797);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (799, 699);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (799, 799);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (801, 801);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (802, 702);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (803, 803);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (804, 604);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (807, 707);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (808, 808);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (813, 813);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (815, 715);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (815, 815);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (820, 720);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (821, 721);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (821, 821);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (822, 822);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (832, 732);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (832, 832);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (833, 833);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (834, 734);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (834, 834);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (836, 436);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (836, 736);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (837, 837);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (839, 339);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (839, 739);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (839, 839);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (842, 742);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (843, 395);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (843, 843);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (844, 844);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (847, 847);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (848, 348);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (848, 748);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (852, 752);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (852, 852);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (855, 555);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (855, 755);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (855, 855);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (862, 762);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (862, 862);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (863, 763);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (863, 852);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (863, 863);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (865, 765);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (865, 865);
commit;
prompt 500 records committed...
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (867, 767);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (867, 867);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (868, 768);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (868, 868);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (874, 474);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (874, 874);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (876, 676);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (876, 776);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (876, 811);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (877, 377);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (877, 677);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (877, 777);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (877, 877);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (879, 779);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (880, 780);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (888, 388);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (888, 788);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (890, 790);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (896, 796);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (896, 896);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (898, 798);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (902, 395);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (904, 604);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (908, 808);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (909, 809);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (911, 319);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (911, 611);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (911, 811);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (911, 911);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (912, 812);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (912, 912);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (913, 813);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (913, 913);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (917, 817);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (919, 919);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (924, 824);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (928, 828);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (931, 831);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (932, 832);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (932, 932);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (933, 833);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (933, 933);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (934, 834);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (935, 935);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (936, 436);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (937, 837);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (938, 938);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (939, 839);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (939, 939);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (941, 841);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (941, 941);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (943, 843);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (944, 844);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (944, 944);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (947, 847);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (948, 948);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (949, 849);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (949, 949);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (950, 950);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (951, 851);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (951, 951);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (952, 852);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (955, 555);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (955, 855);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (963, 863);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (963, 963);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (965, 865);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (965, 965);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (970, 970);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (972, 872);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (973, 973);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (974, 474);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (974, 874);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (976, 676);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (976, 976);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (978, 778);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (978, 843);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (978, 878);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (982, 882);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (982, 982);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (983, 983);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (984, 884);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (990, 990);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (992, 892);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (993, 893);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (993, 993);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (994, 894);
insert into PURCHASE_WORKER (worker_id, purchase_id)
values (996, 896);
commit;
prompt 588 records loaded
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
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (627, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (615, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (700, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (685, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (611, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (536, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (791, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (513, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (975, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (896, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (832, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (830, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (701, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (581, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (764, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (935, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (730, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (630, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (550, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (772, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (834, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (920, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (501, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (3, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (4, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (5, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (6, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (10, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (11, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (14, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (16, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (21, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (26, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (27, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (28, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (32, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (34, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (35, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (37, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (39, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (42, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (43, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (44, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (46, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (48, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (49, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (50, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (54, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (55, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (56, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (57, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (58, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (60, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (65, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (66, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (67, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (68, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (69, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (71, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (72, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (73, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (74, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (81, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (82, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (83, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (85, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (87, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (88, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (89, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (90, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (94, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (95, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (97, null, null);
insert into SUBSCRIBERS (subscriberid, discountpercents, expirationdate)
values (98, null, null);
commit;
prompt 475 records loaded
prompt Loading THEATERS...
insert into THEATERS (theaterid, theatername, capacity)
values (100, 'Gladiolus', 242);
insert into THEATERS (theaterid, theatername, capacity)
values (101, 'Rose', 193);
insert into THEATERS (theaterid, theatername, capacity)
values (102, 'Tulip', 167);
insert into THEATERS (theaterid, theatername, capacity)
values (103, 'Lily', 251);
insert into THEATERS (theaterid, theatername, capacity)
values (104, 'Daisy', 263);
insert into THEATERS (theaterid, theatername, capacity)
values (105, 'Sunflower', 168);
insert into THEATERS (theaterid, theatername, capacity)
values (106, 'Marigold', 138);
insert into THEATERS (theaterid, theatername, capacity)
values (107, 'Orchid', 33);
insert into THEATERS (theaterid, theatername, capacity)
values (108, 'Lavender', 151);
insert into THEATERS (theaterid, theatername, capacity)
values (109, 'Poppy', 216);
insert into THEATERS (theaterid, theatername, capacity)
values (110, 'Peony', 148);
insert into THEATERS (theaterid, theatername, capacity)
values (111, 'Iris', 278);
insert into THEATERS (theaterid, theatername, capacity)
values (112, 'Chrysanthemum', 296);
insert into THEATERS (theaterid, theatername, capacity)
values (113, 'Daffodil', 172);
insert into THEATERS (theaterid, theatername, capacity)
values (114, 'Geranium', 188);
insert into THEATERS (theaterid, theatername, capacity)
values (115, 'Hibiscus', 57);
insert into THEATERS (theaterid, theatername, capacity)
values (116, 'Jasmine', 70);
insert into THEATERS (theaterid, theatername, capacity)
values (117, 'Lilac', 289);
insert into THEATERS (theaterid, theatername, capacity)
values (118, 'Magnolia', 162);
insert into THEATERS (theaterid, theatername, capacity)
values (119, 'Petunia', 199);
insert into THEATERS (theaterid, theatername, capacity)
values (120, 'Violet', 284);
insert into THEATERS (theaterid, theatername, capacity)
values (121, 'Begonia', 58);
insert into THEATERS (theaterid, theatername, capacity)
values (122, 'Carnation', 144);
insert into THEATERS (theaterid, theatername, capacity)
values (123, 'Camellia', 165);
insert into THEATERS (theaterid, theatername, capacity)
values (124, 'Azalea', 242);
insert into THEATERS (theaterid, theatername, capacity)
values (125, 'Buttercup', 51);
insert into THEATERS (theaterid, theatername, capacity)
values (126, 'Bluebell', 71);
insert into THEATERS (theaterid, theatername, capacity)
values (127, 'Crocus', 121);
insert into THEATERS (theaterid, theatername, capacity)
values (128, 'Dahlia', 260);
insert into THEATERS (theaterid, theatername, capacity)
values (129, 'Foxglove', 99);
insert into THEATERS (theaterid, theatername, capacity)
values (130, 'Gardenia', 94);
commit;
prompt 31 records loaded
prompt Loading TICKETS...
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (165, 100, 382, 563);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (376, 116, 424, 383);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (390, 117, 230, 417);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (343, 117, 230, 417);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (464, 102, 375, 321);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (441, 116, 115, 576);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (341, 111, 321, 433);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (489, 115, 296, 214);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (491, 114, 230, 113);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (265, 123, 410, 127);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (476, 110, 459, 305);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (412, 110, 459, 305);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (186, 125, 363, 558);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (280, 122, 348, 104);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (190, 122, 348, 104);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (457, 115, 325, 552);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (162, 115, 325, 552);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (445, 100, 294, 112);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (299, 100, 294, 112);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (481, 100, 441, 118);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (422, 100, 441, 118);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (405, 100, 441, 118);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (372, 100, 441, 118);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (171, 100, 441, 118);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (450, 102, 265, 551);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (380, 102, 265, 551);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (317, 102, 265, 551);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (225, 102, 265, 551);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (435, 120, 346, 280);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (392, 120, 346, 280);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (318, 104, 275, 384);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (125, 104, 275, 384);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (234, 124, 260, 198);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (383, 115, 386, 514);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (256, 115, 386, 514);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (428, 114, 427, 434);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (394, 100, 413, 261);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (469, 121, 229, 113);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (473, 122, 157, 381);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (213, 122, 157, 381);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (410, 104, 492, 164);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (378, 104, 492, 164);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (281, 104, 492, 164);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (344, 105, 110, 265);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (228, 105, 110, 265);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (463, 120, 309, 124);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (429, 121, 282, 179);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (396, 115, 457, 380);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (224, 108, 424, 369);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (260, 130, 132, 165);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (176, 130, 132, 165);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (350, 122, 315, 385);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (192, 122, 315, 385);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (322, 109, 163, 291);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (309, 120, 433, 547);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (497, 112, 173, 434);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (255, 124, 160, 168);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (480, 112, 358, 415);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (261, 112, 358, 415);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (488, 118, 251, 379);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (200, 121, 416, 358);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (128, 112, 437, 175);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (482, 110, 434, 322);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (361, 128, 108, 298);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (189, 128, 108, 298);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (301, 105, 363, 414);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (218, 123, 163, 517);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (346, 109, 292, 247);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (295, 109, 292, 247);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (453, 115, 153, 304);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (381, 118, 276, 463);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (129, 118, 276, 463);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (474, 106, 422, 350);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (462, 111, 164, 256);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (296, 130, 159, 381);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (219, 115, 329, 308);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (226, 112, 443, 284);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (180, 118, 205, 434);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (308, 128, 352, 192);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (367, 108, 224, 177);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (411, 113, 465, 155);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (222, 113, 465, 155);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (484, 111, 108, 370);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (498, 121, 365, 417);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (431, 111, 149, 203);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (352, 111, 149, 203);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (118, 111, 149, 203);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (277, 128, 136, 225);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (452, 126, 349, 463);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (449, 126, 349, 463);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (278, 122, 129, 461);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (267, 122, 129, 461);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (416, 130, 130, 371);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (354, 130, 130, 371);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (465, 100, 460, 404);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (206, 100, 460, 404);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (375, 112, 274, 412);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (139, 112, 274, 412);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (461, 104, 488, 377);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (312, 100, 455, 112);
commit;
prompt 100 records committed...
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (223, 111, 380, 449);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (169, 111, 380, 449);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (167, 111, 380, 449);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (357, 108, 265, 149);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (338, 103, 397, 518);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (370, 106, 276, 132);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (420, 111, 269, 291);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (274, 111, 269, 291);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (285, 129, 476, 169);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (201, 129, 476, 169);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (108, 114, 466, 194);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (495, 130, 264, 218);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (490, 130, 264, 218);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (187, 128, 321, 480);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (425, 125, 204, 284);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (247, 102, 394, 534);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (330, 124, 433, 113);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (163, 124, 433, 113);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (258, 101, 454, 113);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (112, 124, 321, 184);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (276, 109, 323, 487);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (254, 109, 323, 487);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (406, 129, 422, 540);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (316, 110, 440, 408);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (395, 109, 500, 321);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (468, 112, 435, 107);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (184, 112, 435, 107);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (499, 125, 270, 324);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (237, 113, 461, 419);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (113, 101, 195, 481);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (371, 130, 166, 575);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (257, 130, 166, 575);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (110, 113, 177, 578);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (436, 112, 490, 411);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (215, 109, 102, 468);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (202, 103, 238, 203);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (196, 103, 238, 203);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (387, 126, 481, 573);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (275, 130, 276, 126);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (421, 111, 171, 205);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (388, 111, 171, 205);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (332, 111, 171, 205);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (408, 122, 393, 271);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (107, 122, 393, 271);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (423, 127, 290, 350);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (123, 127, 290, 350);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (168, 114, 149, 262);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (335, 119, 301, 418);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (437, 125, 412, 420);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (133, 128, 227, 268);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (292, 112, 371, 445);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (400, 111, 309, 462);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (232, 111, 309, 462);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (439, 107, 417, 439);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (146, 114, 373, 321);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (140, 110, 237, 164);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (288, 126, 159, 468);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (456, 130, 238, 137);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (221, 130, 238, 137);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (319, 130, 278, 574);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (214, 130, 278, 574);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (331, 105, 212, 249);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (291, 105, 212, 249);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (141, 105, 212, 249);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (166, 128, 331, 355);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (272, 117, 323, 487);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (373, 101, 309, 367);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (355, 101, 309, 367);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (407, 102, 280, 314);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (289, 119, 239, 110);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (443, 127, 291, 218);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (104, 127, 291, 218);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (209, 104, 244, 574);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (360, 107, 200, 250);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (353, 107, 200, 250);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (321, 105, 360, 243);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (191, 119, 475, 307);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (193, 102, 400, 121);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (109, 130, 483, 578);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (345, 109, 227, 159);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (148, 123, 318, 177);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (397, 114, 333, 185);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (246, 114, 333, 185);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (198, 114, 333, 185);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (106, 114, 333, 185);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (114, 120, 298, 250);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (479, 127, 281, 130);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (147, 127, 281, 130);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (122, 127, 281, 130);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (418, 123, 441, 472);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (427, 103, 337, 561);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (175, 103, 337, 561);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (366, 124, 253, 452);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (150, 103, 196, 333);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (105, 103, 196, 333);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (369, 124, 232, 148);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (126, 121, 261, 180);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (326, 107, 269, 253);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (286, 107, 269, 253);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (307, 107, 417, 561);
commit;
prompt 200 records committed...
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (216, 107, 417, 561);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (401, 102, 414, 356);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (351, 115, 295, 368);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (385, 129, 205, 107);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (358, 129, 205, 107);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (134, 129, 205, 107);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (121, 129, 205, 107);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (158, 128, 367, 291);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (239, 125, 362, 183);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (115, 119, 217, 230);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (303, 116, 447, 483);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (161, 116, 447, 483);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (130, 116, 447, 483);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (304, 130, 334, 314);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (402, 122, 214, 547);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (356, 122, 214, 547);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (493, 109, 152, 252);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (172, 120, 301, 112);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (157, 120, 301, 112);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (323, 111, 459, 167);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (101, 111, 459, 167);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (472, 114, 353, 517);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (368, 114, 353, 517);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (103, 114, 353, 517);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (458, 130, 243, 175);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (409, 130, 243, 175);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (102, 130, 243, 175);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (119, 118, 236, 108);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (389, 124, 353, 446);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (329, 124, 353, 446);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (430, 122, 297, 224);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (334, 122, 297, 224);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (448, 130, 482, 504);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (485, 112, 481, 208);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (384, 112, 481, 208);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (333, 112, 481, 208);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (313, 112, 481, 208);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (337, 128, 193, 250);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (459, 118, 308, 413);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (283, 118, 308, 413);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (293, 129, 417, 126);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (446, 111, 273, 194);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (181, 121, 366, 453);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (314, 126, 455, 317);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (266, 126, 455, 317);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (136, 108, 227, 230);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (178, 115, 375, 144);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (342, 123, 316, 187);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (496, 122, 485, 495);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (391, 116, 486, 487);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (153, 116, 486, 487);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (320, 128, 340, 193);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (284, 101, 252, 148);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (116, 102, 318, 273);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (438, 122, 130, 383);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (403, 122, 130, 383);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (328, 122, 130, 383);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (259, 122, 130, 383);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (173, 122, 130, 383);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (300, 105, 450, 347);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (199, 127, 481, 432);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (419, 105, 474, 198);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (208, 128, 228, 575);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (487, 105, 101, 317);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (185, 105, 101, 317);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (194, 125, 270, 407);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (460, 110, 317, 401);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (414, 126, 462, 286);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (207, 126, 462, 286);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (444, 111, 145, 119);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (477, 114, 138, 338);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (142, 114, 138, 338);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (447, 113, 308, 120);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (235, 113, 308, 120);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (217, 113, 308, 120);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (137, 113, 308, 120);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (393, 114, 358, 377);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (154, 129, 500, 256);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (451, 104, 236, 127);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (204, 104, 236, 127);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (432, 109, 368, 489);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (290, 109, 368, 489);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (131, 122, 208, 265);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (374, 106, 101, 533);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (294, 101, 455, 446);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (120, 109, 239, 290);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (413, 110, 341, 381);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (347, 119, 121, 579);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (339, 109, 292, 225);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (426, 117, 169, 101);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (363, 117, 169, 101);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (433, 108, 315, 208);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (305, 108, 315, 208);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (245, 114, 123, 432);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (100, 114, 123, 432);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (241, 115, 238, 268);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (111, 115, 238, 268);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (440, 115, 277, 355);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (229, 115, 277, 355);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (379, 108, 154, 301);
commit;
prompt 300 records committed...
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (282, 108, 154, 301);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (417, 122, 125, 295);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (359, 109, 394, 435);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (398, 109, 295, 431);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (205, 109, 295, 431);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (455, 111, 132, 229);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (377, 117, 246, 528);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (212, 117, 246, 528);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (494, 108, 475, 272);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (311, 108, 475, 272);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (127, 108, 475, 272);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (336, 115, 336, 206);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (475, 111, 475, 252);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (263, 112, 426, 312);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (138, 112, 426, 312);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (155, 110, 375, 142);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (315, 120, 435, 180);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (348, 103, 380, 340);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (340, 103, 380, 340);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (268, 119, 273, 220);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (236, 119, 273, 220);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (386, 105, 493, 448);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (483, 100, 372, 169);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (325, 100, 372, 169);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (249, 128, 143, 262);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (144, 126, 292, 300);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (298, 109, 455, 461);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (362, 110, 145, 195);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (179, 110, 145, 195);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (349, 112, 342, 300);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (273, 112, 342, 300);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (467, 103, 204, 198);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (302, 117, 133, 110);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (466, 121, 455, 104);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (151, 121, 455, 104);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (149, 121, 455, 104);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (415, 128, 178, 479);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (279, 128, 178, 479);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (233, 128, 178, 479);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (145, 128, 178, 479);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (182, 100, 490, 543);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (434, 103, 492, 479);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (306, 103, 492, 479);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (170, 103, 492, 479);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (364, 123, 115, 186);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (365, 129, 187, 449);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (242, 129, 187, 449);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (238, 114, 162, 492);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (251, 130, 234, 480);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (124, 108, 305, 167);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (424, 125, 154, 203);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (152, 125, 154, 203);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (442, 124, 392, 383);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (271, 124, 392, 383);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (210, 113, 449, 561);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (327, 110, 250, 202);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (324, 110, 250, 202);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (310, 125, 161, 141);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (399, 104, 121, 300);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (197, 104, 121, 300);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (156, 128, 409, 368);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (231, 110, 371, 439);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (404, 127, 192, 293);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (297, 127, 192, 293);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (287, 127, 192, 293);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (243, 127, 110, 233);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (230, 113, 464, 559);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (220, 101, 302, 260);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (262, 101, 182, 420);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (188, 101, 182, 420);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (159, 101, 182, 420);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (382, 127, 305, 374);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (132, 123, 300, 163);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (174, 123, 170, 136);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (486, 126, 294, 156);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (269, 126, 294, 156);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (253, 126, 294, 156);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (195, 111, 150, 140);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (478, 110, 299, 106);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (248, 110, 299, 106);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (227, 118, 401, 365);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (492, 106, 191, 333);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (471, 106, 191, 333);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (470, 123, 233, 419);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (164, 123, 233, 419);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (454, 118, 353, 295);
insert into TICKETS (ticket_id, theaterid, movieid, dateid)
values (240, 108, 281, 401);
commit;
prompt 387 records loaded
prompt Enabling foreign key constraints for CLIENT...
alter table CLIENT enable constraint FK_CL;
prompt Enabling foreign key constraints for PRODUCTS...
alter table PRODUCTS enable constraint SYS_C008017;
prompt Enabling foreign key constraints for STOREPRODUCTS...
alter table STOREPRODUCTS enable constraint SYS_C008035;
prompt Enabling foreign key constraints for ORDER_PRODUCT...
alter table ORDER_PRODUCT enable constraint FK_OP;
alter table ORDER_PRODUCT enable constraint SYS_C008022;
prompt Enabling foreign key constraints for SUPPLIER...
alter table SUPPLIER enable constraint FK_SP;
prompt Enabling foreign key constraints for ORDER_SUPPLIER...
alter table ORDER_SUPPLIER enable constraint SYS_C007994;
alter table ORDER_SUPPLIER enable constraint SYS_C007995;
prompt Enabling foreign key constraints for WORKER...
alter table WORKER enable constraint FK_WR;
prompt Enabling foreign key constraints for ORDER_WORKER...
alter table ORDER_WORKER enable constraint SYS_C007999;
alter table ORDER_WORKER enable constraint SYS_C008000;
prompt Enabling foreign key constraints for PURCHASE_CLIENT...
alter table PURCHASE_CLIENT enable constraint SYS_C008009;
alter table PURCHASE_CLIENT enable constraint SYS_C008010;
prompt Enabling foreign key constraints for PURCHASE_PRODUCT...
alter table PURCHASE_PRODUCT enable constraint SYS_C008026;
alter table PURCHASE_PRODUCT enable constraint SYS_C008027;
prompt Enabling foreign key constraints for PURCHASE_WORKER...
alter table PURCHASE_WORKER enable constraint SYS_C008004;
alter table PURCHASE_WORKER enable constraint SYS_C008005;
prompt Enabling foreign key constraints for SUBSCRIBERS...
alter table SUBSCRIBERS enable constraint FK_SB;
prompt Enabling foreign key constraints for TICKETS...
alter table TICKETS enable constraint SYS_C008037;
alter table TICKETS enable constraint SYS_C008038;
alter table TICKETS enable constraint SYS_C008039;
alter table TICKETS enable constraint SYS_C008040;
prompt Enabling triggers for CATEGORYS...
alter table CATEGORYS enable all triggers;
prompt Enabling triggers for PERSON...
alter table PERSON enable all triggers;
prompt Enabling triggers for CLIENT...
alter table CLIENT enable all triggers;
prompt Enabling triggers for DATES...
alter table DATES enable all triggers;
prompt Enabling triggers for MOVIES...
alter table MOVIES enable all triggers;
prompt Enabling triggers for ORDERS...
alter table ORDERS enable all triggers;
prompt Enabling triggers for PRODUCTS...
alter table PRODUCTS enable all triggers;
prompt Enabling triggers for STOREPRODUCTS...
alter table STOREPRODUCTS enable all triggers;
prompt Enabling triggers for ORDER_PRODUCT...
alter table ORDER_PRODUCT enable all triggers;
prompt Enabling triggers for SUPPLIER...
alter table SUPPLIER enable all triggers;
prompt Enabling triggers for ORDER_SUPPLIER...
alter table ORDER_SUPPLIER enable all triggers;
prompt Enabling triggers for WORKER...
alter table WORKER enable all triggers;
prompt Enabling triggers for ORDER_WORKER...
alter table ORDER_WORKER enable all triggers;
prompt Enabling triggers for PURCHASE...
alter table PURCHASE enable all triggers;
prompt Enabling triggers for PURCHASE_CLIENT...
alter table PURCHASE_CLIENT enable all triggers;
prompt Enabling triggers for PURCHASE_PRODUCT...
alter table PURCHASE_PRODUCT enable all triggers;
prompt Enabling triggers for PURCHASE_WORKER...
alter table PURCHASE_WORKER enable all triggers;
prompt Enabling triggers for SUBSCRIBERS...
alter table SUBSCRIBERS enable all triggers;
prompt Enabling triggers for THEATERS...
alter table THEATERS enable all triggers;
prompt Enabling triggers for TICKETS...
alter table TICKETS enable all triggers;
set feedback on
set define on
prompt Done.
