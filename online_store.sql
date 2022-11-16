/*
 * База данных для интернет магазина. Содержит таблицы с продукции магазина, каталог продукции,
 * список заказов пользователя и остаток товара на складе. Также пользователь может сохранить  товар и 
 * оставить комментарий о товаре. 
 */


DROP DATABASE IF EXISTS MySQL_online_store;
CREATE DATABASE MySQL_online_store;
USE MySQL_online_store;
SHOW tables;

-- Таблица Пользователь

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	firstname VARCHAR(55),
	lastname VARCHAR(55),
	email VARCHAR(130) UNIQUE,
	phone BIGINT UNSIGNED UNIQUE,
	password_hash VARCHAR(100),
	
	INDEX users_firstname_lastname_idx(firstname, lastname)
);

INSERT INTO 
users (firstname, lastname, email, password_hash, phone)
VALUES
('Javonte','Jakubowski','trey62@example.net','38515893c796660bb1307410f6aed138988b97d1',89676723604),
('Aurelia','Ratke','rrolfson@example.org','84f259f5415b6f0cd20c6d4aff1a4868ac3ff0ae',89339101296),
('Jacey','Fritsch','stone96@example.com','b9fd1bbdc3f7caccb0923003ea81acdab2b59610',89802518644),
('Whitney','Jerde','jonathon.feil@example.com','06292d6942f52879745960fcf6b1f1074875e53a',89397268208),
('Axel','Lynch','ckuhic@example.org','e3e4d5c8e9c84cd665be208849c4e066ae2f8849',89585747656),
('Karlee','Kunde','syost@example.org','46b15aca372c290f92cc7bd49a842b2cede3e1f8',89125986482),
('Ryann','Prosacco','malvina.toy@example.net','856f6b5f9c993da0c5048e83570de7dccf6c188a',89334895548),
('Ona','Schumm','adelia91@example.com','6cba3682da29e775f84f14c16d6fc511248a5b7d',89838377175),
('Kennith','Gaylord','alphonso71@example.com','62ed6ae488aa4374d644cd571e3ae7d95959ce3d',89777246849),
('Alexandre','Rowe','esipes@example.net','06e3c0a3e879a95c24452691d4f323f62756e367',89230775666);


-- Таблица Профиль пользователя 

DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
	user_id BIGINT UNSIGNED NOT NULL UNIQUE,
	gender ENUM('Male' , 'Female'),
	birthday datetime, 
	photo_id BIGINT UNSIGNED NULL,
	created_at DATETIME DEFAULT NOW(),
	hometown VARCHAR(99),
	
	FOREIGN KEY (user_id) REFERENCES users(id)
);



INSERT INTO 
profiles 
VALUES 
(1,'Male','1970-02-07 18:12:53',41,'2017-12-29 07:21:05','South Hilarioville'),
(2,'Male','2020-03-11 07:24:06',41,'2000-05-08 07:22:16','Runolfssonside'),
(3,'Male','1976-10-08 12:32:29',41,'2003-10-05 04:41:16','Mooreport'),
(4,'Male','1987-09-13 20:08:26',41,'1986-11-09 19:14:10','Bartonstad'),
(5,'Female','1988-10-27 17:21:07',41,'1980-04-03 10:33:52','Gulgowskiberg'),
(6,'Female','2015-12-06 08:58:34',41,'1993-05-14 08:06:36','Tromptown'),
(7,'Male','1992-03-31 14:56:30',41,'1976-05-25 08:55:50','Dietrichside'),
(8,'Female','1998-04-21 11:09:54',41,'1988-03-14 09:10:35','Auerchester'),
(9,'Male','1980-12-07 21:39:39',41,'2019-10-07 23:14:46','Marcelhaven'),
(10,'Male','1993-10-07 13:51:20',41,'1999-06-01 23:23:48','Port Virginieborough');



-- Таблица заказов

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 
  
  FOREIGN KEY (user_id) REFERENCES users(id)
);


INSERT INTO 
orders 
VALUES 
(1,1,'1992-05-18 00:27:08','1980-01-09 23:22:11'),
(2,2,'2010-01-07 13:14:35','2004-02-04 17:02:59'),
(3,3,'2001-04-06 14:06:45','1975-03-22 03:51:28'),
(4,4,'1999-08-26 15:07:58','1973-08-28 08:06:46'),
(5,5,'1985-07-04 00:51:37','1971-09-20 20:12:35'),
(6,6,'1984-05-20 06:29:12','1978-05-22 07:27:21'),
(7,7,'2013-05-21 08:32:25','1976-07-01 16:56:40'),
(8,8,'1974-02-03 20:26:25','1989-04-15 06:58:42'),
(9,9,'1975-05-08 07:02:56','2012-11-09 08:42:30'),
(10,10,'1993-05-26 02:09:34','2005-07-30 15:58:59');


-- Таблица Продукции

DROP TABLE IF EXISTS products;
CREATE TABLE products (
	id SERIAL,
	catalog_id int UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	name_product VARCHAR(200),
	desription text,
	price decimal(10,0),
	metadate JSON,
	created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
	
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (catalog_id) REFERENCES catalogs(id)
);



INSERT INTO 
products
VALUES
(1,1,1,'Ноутбук','Honor MagicBook X 15 i5/8/512 Gray 15.6"/1920x1080 пикс., Процессор ntel Core i5 10210U',375189,NULL,'2003-09-03 01:47:40','2019-01-10 13:37:54'),
(2,2,2,'Ноутбук','ASUS R565MA-BR290T Диагональ/разрешение 15.6"/1366x768 пикс. Процессор Intel Pentium Silver N5030 1.1 ГГц',32999,NULL,'1994-06-12 20:34:36','2018-10-26 19:10:31'),
(3,3,3,'Планшет','Apple 11'' iPad Pro Wi-Fi 128GB Space Grey',70999,NULL,'2000-08-01 06:49:25','1998-12-01 21:15:27'),
(4,4,4,'Планшет','Samsung Galaxy Tab A7 Lite LTE 32GB Dark Grey (SM-T225N)',14990,NULL,'1976-06-28 21:32:51','1995-01-26 07:44:53'),
(5,5,5,'Планшет','Huawei MatePad 11 6+128GB WiFi Matte Grey (DBY-W09)',37990,NULL,'2018-08-02 00:51:30','1990-10-30 10:20:35'),
(6,6,6,'Игровая консоль','Sony PlayStation 5',50000,NULL,'1990-02-23 13:14:55','1986-06-05 12:28:22'),
(7,7,7,'Смартфон','Samsung Galaxy Z Flip3 128GB Beige (SM-F711B)',29375,NULL,'2006-11-20 16:29:45','1984-03-25 12:40:03'),
(8,8,8,'Смартфон','Apple iPhone 13 128GB Midnight (MLNW3RU/A)',79999,NULL,'1984-10-09 07:43:37','1971-02-15 18:11:57'),
(9,9,9,'Телевизор','Samsung UE55TU7097U',285377,NULL,'1991-02-09 20:14:21','1994-03-20 05:06:22'),
(10,1,3,'Ноутбук','Honor MagicBook X 15 i5/8/512 Gray 15.6"/1920x1080 пикс., Процессор ntel Core i5 10210U',375189,NULL,'2003-09-03 01:47:40','2019-01-10 13:37:54'),
(11,2,3,'Ноутбук','ASUS R565MA-BR290T Диагональ/разрешение 15.6"/1366x768 пикс. Процессор Intel Pentium Silver N5030 1.1 ГГц',32999,NULL,'1994-06-12 20:34:36','2018-10-26 19:10:31'),
(12,3,3,'Планшет','Apple 11'' iPad Pro Wi-Fi 128GB Space Grey',70999,NULL,'2000-08-01 06:49:25','1998-12-01 21:15:27');



-- Таблица Каталог 

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
	id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name ENUM('Ноутбук', 'Планшет', 'Игровая консоль', 'Смартфон', 'Телевизор'),
	created_at datetime DEFAULT NOW(),
 	updated_at datetime ON UPDATE current_timestamp,
	
	INDEX catalogs_name_idx(name);
  
);



INSERT INTO catalogs 
VALUES 
(1,'Ноутбук','1972-06-29 17:42:42','1970-11-09 09:37:08'),
(2,'Ноутбук','2020-03-18 19:45:55','1997-12-28 20:26:59'),
(3,'Планшет','1981-04-10 07:06:09','2008-11-25 10:12:25'),
(4,'Планшет','2020-11-13 05:26:46','1975-05-02 08:12:00'),
(5,'Планшет','1999-03-06 20:04:52','2007-12-02 15:09:16'),
(6,'Игровая консоль','1996-09-19 16:23:55','2017-08-01 05:55:33'),
(7,'Смартфон','1999-05-28 11:14:19','2016-08-03 02:42:31'),
(8,'Смартфон','1979-01-08 14:13:25','1980-09-25 05:04:31'),
(9,'Телевизор','2016-01-06 08:01:54','2002-06-13 13:36:23');


-- Таблица Избранное 

DROP TABLE IF EXISTS favorites;
CREATE TABLE favorites (
	id INT unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id bigint UNSIGNED NOT NULL UNIQUE,
	product_id bigint UNSIGNED,
	order_id INT UNSIGNED,
	favorite_product INT UNSIGNED NOT NULL,
	
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (product_id ) REFERENCES products(id),
	FOREIGN KEY (order_id) REFERENCES orders(id)
);


INSERT INTO 
favorites 
VALUES 
(1,1,1,1,2),
(2,2,1,2,1),
(3,3,1,3,3),
(4,4,1,4,5),
(5,5,1,5,4);

-- Таблица Комментарий

DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
	id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id bigint UNSIGNED NOT NULL,
	favorite_id INT UNSIGNED NOT NULL,
	product_id bigint UNSIGNED,
	comm_txt text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,

	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (favorite_id) REFERENCES favorites(id),
	FOREIGN KEY (product_id) REFERENCES products(id)
); 

INSERT INTO 
comments 
VALUES 
(1,3,1,1, 'Классный ноут всем рекомендую!!'),
(2,4,2,8, 'Классный iphone всем рекомендую!!'),
(3,5,2,6, 'Классная PS всем рекомендую!!'),
(4,3,3,4, 'Классный планшет всем рекомендую!!'),
(5,3,3,2, 'Классный ноут всем рекомендую!!');


-- Таблица заказанных товаров 

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
  id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  order_id INT UNSIGNED,
  product_id bigint UNSIGNED,
  total INT UNSIGNED DEFAULT 1,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  FOREIGN KEY (order_id) REFERENCES orders(id),
  FOREIGN KEY (product_id) REFERENCES products(id)
);


INSERT INTO
orders_products 
VALUES 
(1,1,10,null,'1976-11-05 09:43:12','2017-11-16 19:54:51'),
(2,2,11,null,'1989-03-01 14:53:10','2016-09-11 20:11:51'),
(3,3,12,null,'2009-08-23 11:34:54','1996-10-20 08:49:11');  



-- Таблица склад

DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
  id bigint unsigned NOT NULL AUTO_INCREMENT,
  name varchar(255) DEFAULT NULL,
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  PRIMARY KEY (id),
  
  UNIQUE KEY id (id)

  
);


INSERT INTO 
storehouses
VALUES 
(1, 'Ноутбук', '2001-11-05 09:43:12','2015-11-16 19:54:51'),
(2, 'Планшет', '2002-11-05 09:43:12','2016-11-16 19:54:51'),
(3, 'Игровая консоль', '2003-11-05 09:43:12','2014-11-16 19:54:51'),
(4, 'Смартфон', '2004-11-05 09:43:12','2013-11-16 19:54:51'),
(5,	'Телевизор', '2005-11-05 09:43:12','2011-11-16 19:54:51'),
(6, 'Ноутбук', '2006-11-05 09:43:12','2017-11-16 19:54:51'),
(7, 'Планшет', '2007-11-05 09:43:12','2018-11-16 19:54:51'),
(8, 'Планшет', '2008-11-05 09:43:12','2019-11-16 19:54:51'),
(9, 'Смартфон', '2009-11-05 09:43:12','2020-11-16 19:54:51');

-- Таблица Склад Продукции  

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id bigint unsigned NOT NULL AUTO_INCREMENT,
  storehouse_id bigint unsigned DEFAULT NULL,
  product_id bigint unsigned DEFAULT NULL,
  value int unsigned DEFAULT NULL,
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  
  UNIQUE KEY id (id),
  
  FOREIGN KEY (product_id) REFERENCES products(id),
  FOREIGN KEY (storehouse_id) REFERENCES storehouses(id)
);



INSERT INTO
storehouses_products 
VALUES 
(1, 1, 1, 1, '2001-11-05 09:43:12','2015-11-16 19:54:51'),
(2, 2, 2, 1, '2001-11-05 09:43:12','2015-11-16 19:54:51'),
(3, 3, 3, 1, '2001-11-05 09:43:12','2015-11-16 19:54:51'),
(4, 4, 4, 1, '2001-11-05 09:43:12','2015-11-16 19:54:51'),
(5, 5, 5, 1, '2001-11-05 09:43:12','2015-11-16 19:54:51'),
(6, 6, 2, 1, '2001-11-05 09:43:12','2015-11-16 19:54:51'),
(7, 7, 7, 1, '2001-11-05 09:43:12','2015-11-16 19:54:51'),
(8, 8, 8, 1, '2001-11-05 09:43:12','2015-11-16 19:54:51'),
(9, 9, 9, 1, '2001-11-05 09:43:12','2015-11-16 19:54:51');





------------------------------------------------------------------------------------

/*
 * Cкрипты характерных выборок (включающие группировки, JOIN'ы, вложенные таблицы);
 */

-------------------------------------------------------------------------------------

-- Запрос выведем пользователя N со списком куплено продукции.


SELECT 
	u.firstname,
	u.lastname, 
	p.name_product, 
	p.desription, 
	p.price 
   FROM products AS p 
	LEFT JOIN users AS u 
   ON p.user_id = u.id 
	WHERE user_id = 3 ORDER BY price DESC;



-- Запрос: Выведем остаток на складе и посчитаем его количество.


SELECT 
	s.name,
	count(*)
   FROM storehouses_products AS sp JOIN storehouses AS s ON sp.storehouse_id = s.id 
	WHERE s.name = 'Планшет'
   GROUP BY s.name;


-- Запрос: Выведем количество комментарии на товар N


SELECT 
	c.user_id,
	u.firstname, 
	u.lastname,
	p.name_product,
	p.desription,
	p.price,
	c.comm_txt
   FROM comments AS c
	JOIN users AS u ON c.user_id = u.id
	JOIN products AS p ON p.id = c.product_id
   WHERE p.name_product = 'Ноутбук';

SELECT * FROM comments;

 select @@sql_mode;
 set @@sql_mode = concat(@@sql_mode, ',ONLY_FULL_GROUP_BY');
 set @@sql_mode = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';



-- Представление 

/*
 * Представление, которое выводит desription товарной позиции из таблицы products и 
 * название каталога name из таблицы catalogs.
 */

CREATE OR REPLACE VIEW products_catalogs 
AS 
	SELECT 
		p.desription AS products,
		c.name AS catalogs
	FROM 
		products AS p
	JOIN 
		catalogs AS c
	ON 
		p.catalog_id = c.id;
	
	
SELECT * FROM products_catalogs;


/*
 *  Представление: Которое выводит даные о бользователи из таблицы users, который купил самый дорогой продукт
 * из таблицы  
 */


CREATE OR REPLACE VIEW users_products
AS 
	SELECT 
		u.firstname,
		u.lastname,
		p.name_product,
		p.desription,
		MAX(price)
	FROM 
		users AS u
	JOIN
		products AS p
	ON 
		u.id = p.user_id;

SELECT * FROM users_products;




-- Процедура которая возращает 3 самых дорогих тавара в котологе  их название и описание


DROP PROCEDURE IF EXISTS The_most_products;


DELIMITER // 

CREATE PROCEDURE The_most_products()
BEGIN 
	SELECT 
		p.name_product,
		p.desription,
		p.price 
	FROM products AS p
	ORDER BY p.price DESC LIMIT 3;
 
END//

DELIMITER ;

CALL The_most_popular_products(1);




-- Триггер добавлении записи в табл user, пароль преобразовывать в хеш md5(), также имя и отчество преобразовывать в инициалы.


DELIMITER //
CREATE TRIGGER user_pass BEFORE INSERT ON users
FOR EACH ROW
BEGIN
	SET NEW.firstname = LEFT(NEW.firstname,1);
	SET NEW.lastname = LEFT(NEW.lastname,1);
	SET NEW.password_hash = md5(NEW.password_hash);
 END//
DELIMITER ;

	
SELECT * FROM users u 


-- Триггер чтобы пользователь не смог записать полное имя, отчество и пароль не в МД5

DELIMITER //
CREATE TRIGGER user_pass1 BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
	SET NEW.firstname = LEFT(NEW.firstname,1);
    SET NEW.lastname = LEFT(NEW.lastname,1);
    SET NEW.password_hash = md5(NEW.password_hash);
 END//

DELIMITER ;


UPDATE
users 
SET firstname ='Иванов', lastname ='Иван', email = 'fsdf@sfs.ru', phone = 89232231222, password_hash = 'pass' WHERE id=1;