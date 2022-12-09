CREATE DATABASE orders;
go;

USE orders;
go;

DROP TABLE  IF EXISTS review;
DROP TABLE  IF EXISTS shipment;
DROP TABLE  IF EXISTS productinventory;
DROP TABLE  IF EXISTS warehouse;
DROP TABLE  IF EXISTS orderproduct;
DROP TABLE  IF EXISTS incart;
DROP TABLE  IF EXISTS product;
DROP TABLE  IF EXISTS category;
DROP TABLE  IF EXISTS ordersummary;
DROP TABLE  IF EXISTS paymentmethod;
DROP TABLE  IF EXISTS customer;


CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE category (
    categoryId          INT IDENTITY,
    categoryName        VARCHAR(50),    
    PRIMARY KEY (categoryId)
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(40),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(100),
    productImage        VARBINARY(MAX),
    productDesc         VARCHAR(1000),
    categoryId          INT,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),    
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(100),   
    warehouseId         INT, 
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,   
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(1000),          
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO category(categoryName) VALUES ('Laptop');
INSERT INTO category(categoryName) VALUES ('Phone');
INSERT INTO category(categoryName) VALUES ('Tablet');
INSERT INTO category(categoryName) VALUES ('Charger');
INSERT INTO category(categoryName) VALUES ('Head/Earphones');

SET ANSI_WARNINGS OFF;
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('MackBook Air 2017', 1, 'Second hand MacBook Air 2017 with Intel Corei5, 8GB RAM',825.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Dell XPS 13', 1, 'Second hand Dell XPS 13 with Intel Corei5, 8GB RAM',700.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('ASUS ROG Zephyrus G15 GA503', 1, 'Second hand ASUS ROG Zephyrus G15 GA503 with 32GB RAM, 1TB SSD ',1500.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('HP Spectre x360 14', 1, 'Second hand HP Spectre x360 14 with Intel Corei5, 16GB RAM',1250.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Lenovo ThinkPad X1 Nano', 1, 'Second hand Lenovo ThinkPad X1 Nano with Intel Corei7, 16GB RAM',1000.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('iPhone 11 Pro', 2, 'Second hand iPhone 11 Pro with 64GB. Silver colour.',800.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('iPhone X', 2, 'Second hand iPhone X with 64GB. Black colour.',400.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Samsung Galaxy S22 Ultra', 2, 'Second hand Samsung Galaxy S22 Ultra with 128GB. Burgundy colour.',850.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('iPhone 13', 2, 'Second hand iPhone 12 with 128GB. Green colour',950.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Samsung Galaxy S20', 2, 'Second hand Samsung Galaxy S20',700.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Apple USB-C to Lightning with 20W Power Adapter', 4, 'Second hand Apple charger compatible with iPhone 5+, MacBook (2017)+, iPad (5th Generation)+',25.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Apple Scosche BaseLynx Wireless Charging Pad', 4, 'Second hand wireless Apple charging pad compatible with iPhone 8+',40.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Genius 65W Surface Book Charger', 4, 'Second hand surface book charger compatible with Microsoft Surface Book 1 - 6',30.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Insignia Universal 90W Laptop Charger', 4, 'Second hand universal laptop charger. Includes six voltage controlling tips for most compatibility',23.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('AirPods(2nd generation) ', 5, 'Second hand AirPods(2nd generation)',100.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('AirPods(3rd generation) ', 5, 'Second hand AirPods(3rd generation)',125.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Sony MDRZX110 Over-Ear Headphones', 5, 'Second hand Sony MDRZX110 Over-Ear Headphones',20.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Sony WF-C500', 5, 'Second hand Sony WF-C500',100.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Beats Solo3 Wireless On-Ear Headphones', 5, 'Second hand Beats Solo3 Wireless On-Ear Headphones. White colour.',200.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Apple iPad Air 10.9” (5th Generation)', 3, 'Second hand Apple iPad Air with Apple M1 chip. Grey colour.',450.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Lenovo Tab M7 7”', 3, 'Second hand Lenovo Tab with MT8166 4-Core Processor. Black colour.',75.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Samsung Galaxy Tab A8 10.5”', 3, 'Second hand Samsung Galaxy Tab with Unisoc 618 8-Core Processor. Black colour.',200.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Amazon Fire HD 8”', 3, 'Second hand Android Tablet with MTK / MT8169A Processor. Black colour.',80.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Apple iPad Mini 8.3” (6th Generation)', 3, 'Second hand Apple iPad Mini with A15 Bionic chip. Grey colour. ',600.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Apple iPad Mini 2 (Refurbished)', 3, 'Second hand Apple iPad Mini 2 with A7 chip. Grey colour ',100.00);
SET ANSI_WARNINGS ON;

INSERT INTO warehouse(warehouseName) VALUES ('Main warehouse');
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (1, 1, 5, 825);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (2, 1, 10, 700);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (3, 1, 3, 1500);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (4, 1, 2, 1250);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (5, 1, 6, 1000);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (6, 1, 3, 800);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (7, 1, 1, 400);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (8, 1, 0, 850);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (9, 1, 2, 950);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (10, 1, 3, 700);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (11, 1, 5, 25);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (12, 1, 10, 40);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (13, 1, 3, 30);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (14, 1, 2, 23);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (15, 1, 6, 100);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (16, 1, 3, 125);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (17, 1, 1, 20);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (18, 1, 0, 100);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (19, 1, 2, 200);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (20, 1, 3, 450);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (21, 1, 5, 75);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (22, 1, 10, 200);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (23, 1, 3, 80);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (24, 1, 2, 600);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (25, 1, 6, 100);

INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , 'test');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , 'bobby');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Candace', 'Cole', 'cole@charity.org', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'candace' , 'password');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Darren', 'Doe', 'oe@doe.com', '250-807-2222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'darren' , 'pw');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Elizabeth', 'Elliott', 'engel@uiowa.edu', '555-666-7777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'beth' , 'test');

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (1, '2019-10-15 10:25:55', 1875.00)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 1, 1, 825)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 2, 2, 950)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 3, 1, 100);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-17 05:45:11', 327.85)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 10, 1, 700)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 8, 1, 850)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 15, 1, 100)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 14, 2, 23)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 19, 1, 200);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (5, '2019-10-15 10:25:55', 277.40)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 2, 1, 700)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 22, 1, 200)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 25, 3, 100);

UPDATE Product SET productImageURL = 'img/mackbookair17.jpeg' WHERE ProductId = 1;
UPDATE Product SET productImageURL = 'img/Dell XPS 13.jpg' WHERE ProductId = 2;
UPDATE Product SET productImageURL = 'img/ASUS ROG Zephyrus G15 GA503.jpg' WHERE ProductId = 3;
UPDATE Product SET productImageURL = 'img/HP Spectre x360 14.jpg' WHERE ProductId = 4;
UPDATE Product SET productImageURL = 'img/Lenovo ThinkPad X1 Nano.jpg' WHERE ProductId = 5;
UPDATE Product SET productImageURL = 'img/iphone11pro.jpeg' WHERE ProductId = 6;
UPDATE Product SET productImageURL = 'img/iPhone X.jpg' WHERE ProductId = 7;
UPDATE Product SET productImageURL = 'img/Samsung Galaxy S22 Ultra.jpg' WHERE ProductId = 8;
UPDATE Product SET productImageURL = 'img/iPhone 13.jpg' WHERE ProductId = 9;
UPDATE Product SET productImageURL = 'img/Samsung Galaxy S20.jpg' WHERE ProductId = 10;
UPDATE Product SET productImageURL = 'img/Apple USB-C to Lightning.jpeg' WHERE ProductId = 11;
UPDATE Product SET productImageURL = 'img/Apple Scosche.jpeg' WHERE ProductId = 12;
UPDATE Product SET productImageURL = 'img/Genius 65W .jpeg' WHERE ProductId = 13;
UPDATE Product SET productImageURL = 'img/insignia universal.jpeg' WHERE ProductId = 14;
UPDATE Product SET productImageURL = 'img/airpod2ndgen.jpeg' WHERE ProductId = 15;
UPDATE Product SET productImageURL = 'img/AirPods(3rd generation).jpg' WHERE ProductId = 16;
UPDATE Product SET productImageURL = 'img/Sony MDRZX110 .jpg' WHERE ProductId = 17;
UPDATE Product SET productImageURL = 'img/Sony WF-C500.jpg' WHERE ProductId = 18;
UPDATE Product SET productImageURL = 'img/Beats Solo3.jpg' WHERE ProductId = 19;
UPDATE Product SET productImageURL = 'img/Apple iPad Air 10.9.jpeg' WHERE ProductId = 20;
UPDATE Product SET productImageURL = 'img/Lenovo Tab.jpeg' WHERE ProductId = 21;
UPDATE Product SET productImageURL = 'img/Samsung Galaxy Tab.jpeg' WHERE ProductId = 22;
UPDATE Product SET productImageURL = 'img/‘Amazon Fire HD .jpeg' WHERE ProductId = 23;
UPDATE Product SET productImageURL = 'img/apple ipad min 8.3.jpeg' WHERE ProductId = 24;
UPDATE Product SET productImageURL = 'img/aple ipad mini 2.jpeg' WHERE ProductId = 25;

