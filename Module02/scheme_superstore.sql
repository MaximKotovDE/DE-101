-- ************************************** calendar_dim

CREATE TABLE calendar_dim
(
 order_date date NOT NULL,
 ship_date  date NOT NULL,
 year       numeric NOT NULL,
 quarter    varchar(5) NOT NULL,
 month      numeric NOT NULL,
 week       numeric NOT NULL,
 week_day   numeric NOT NULL,
 CONSTRAINT PK_1 PRIMARY KEY ( order_date, ship_date )
);



-- ************************************** customer_dim

CREATE TABLE customer_dim
(
 "id"            serial NOT NULL,
 customer_name varchar(22) NOT NULL,
 CONSTRAINT PK_1 PRIMARY KEY ( "id" )
);






-- ************************************** geo_dim

CREATE TABLE geo_dim
(
 "id"          serial NOT NULL,
 country     varchar(13) NOT NULL,
 region      varchar(7) NOT NULL,
 "state"       varchar(20) NOT NULL,
 city        varchar(17) NOT NULL,
 postal_code integer NOT NULL,
 CONSTRAINT PK_1 PRIMARY KEY ( "id" )
);





-- ************************************** product_dim

CREATE TABLE product_dim
(
 "id"           serial NOT NULL,
 product_name varchar(127) NOT NULL,
 segment      varchar(11) NOT NULL,
 category     varchar(15) NOT NULL,
 sub_category varchar(11) NOT NULL,
 CONSTRAINT PK_1 PRIMARY KEY ( "id" )
);




-- ************************************** shipping_dim

CREATE TABLE shipping_dim
(
 "id"        serial NOT NULL,
 ship_mode varchar(14) NOT NULL,
 CONSTRAINT PK_1 PRIMARY KEY ( "id" )
);








-- ************************************** sales_fact

CREATE TABLE sales_fact
(
 row_id      integer NOT NULL,
 order_id    varchar(14) NOT NULL,
 ship_id     serial NOT NULL,
 customer_id serial NOT NULL,
 product_id  serial NOT NULL,
 geo_id      serial NOT NULL,
 order_date  date NOT NULL,
 sales       numeric(9,4) NOT NULL,
 profit      numeric(21,16) NOT NULL,
 ship_date   date NOT NULL,
 discount    numeric(4,2) NOT NULL,
 quantity    integer NOT NULL,
 CONSTRAINT PK_1 PRIMARY KEY ( row_id ),
 CONSTRAINT FK_1 FOREIGN KEY ( order_date, ship_date ) REFERENCES calendar_dim ( order_date, ship_date ),
 CONSTRAINT FK_2 FOREIGN KEY ( geo_id ) REFERENCES geo_dim ( "id" ),
 CONSTRAINT FK_3 FOREIGN KEY ( product_id ) REFERENCES product_dim ( "id" ),
 CONSTRAINT FK_4 FOREIGN KEY ( customer_id ) REFERENCES customer_dim ( "id" ),
 CONSTRAINT FK_5 FOREIGN KEY ( ship_id ) REFERENCES shipping_dim ( "id" )
);

CREATE INDEX FK_2 ON sales_fact
(
 order_date,
 ship_date
);

CREATE INDEX FK_3 ON sales_fact
(
 geo_id
);

CREATE INDEX FK_4 ON sales_fact
(
 product_id
);

CREATE INDEX FK_5 ON sales_fact
(
 customer_id
);

CREATE INDEX FK_6 ON sales_fact
(
 ship_id
);


