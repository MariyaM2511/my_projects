USE apteka;

/*Добавить в таблицу продукты новую колонку "срок годности" (измеряется в месяцах) */
ALTER TABLE product ADD COLUMN expiration_date INT;
UPDATE product SET expiration_date=(12) WHERE id=1;
UPDATE product SET expiration_date=(24) WHERE id=2;
UPDATE product SET expiration_date=(36) WHERE id=3;
UPDATE product SET expiration_date=(48) WHERE id=4;
UPDATE product SET expiration_date=(36) WHERE id=5;
UPDATE product SET expiration_date=(24) WHERE id=6;
UPDATE product SET expiration_date=(12) WHERE id=7;
UPDATE product SET expiration_date=(24) WHERE id=8;
UPDATE product SET expiration_date=(36) WHERE id=9;
UPDATE product SET expiration_date=(48) WHERE id=10;
UPDATE product SET expiration_date=(12) WHERE id=11;
UPDATE product SET expiration_date=(24) WHERE id=12;
UPDATE product SET expiration_date=(36) WHERE id=13;
UPDATE product SET expiration_date=(48) WHERE id=14;
UPDATE product SET expiration_date=(36) WHERE id=15;
UPDATE product SET expiration_date=(24) WHERE id=16;
UPDATE product SET expiration_date=(12) WHERE id=17;
UPDATE product SET expiration_date=(24) WHERE id=18;
UPDATE product SET expiration_date=(36) WHERE id=19;
UPDATE product SET expiration_date=(48) WHERE id=20;
UPDATE product SET expiration_date=(12) WHERE id=21;
UPDATE product SET expiration_date=(24) WHERE id=22;
UPDATE product SET expiration_date=(36) WHERE id=23;
UPDATE product SET expiration_date=(48) WHERE id=24;
UPDATE product SET expiration_date=(36) WHERE id=25;
UPDATE product SET expiration_date=(24) WHERE id=26;
UPDATE product SET expiration_date=(12) WHERE id=27;
UPDATE product SET expiration_date=(24) WHERE id=28;
UPDATE product SET expiration_date=(36) WHERE id=29;
UPDATE product SET expiration_date=(48) WHERE id=30;
UPDATE product SET expiration_date=(12) WHERE id=31;
UPDATE product SET expiration_date=(24) WHERE id=32;
UPDATE product SET expiration_date=(36) WHERE id=33;
UPDATE product SET expiration_date=(48) WHERE id=34;
UPDATE product SET expiration_date=(36) WHERE id=35;
UPDATE product SET expiration_date=(24) WHERE id=36;
UPDATE product SET expiration_date=(12) WHERE id=37;
UPDATE product SET expiration_date=(24) WHERE id=38;
UPDATE product SET expiration_date=(36) WHERE id=39;
UPDATE product SET expiration_date=(48) WHERE id=40;
UPDATE product SET expiration_date=(12) WHERE id=41;
UPDATE product SET expiration_date=(24) WHERE id=42;
UPDATE product SET expiration_date=(36) WHERE id=43;
UPDATE product SET expiration_date=(48) WHERE id=44;
UPDATE product SET expiration_date=(36) WHERE id=45;
UPDATE product SET expiration_date=(24) WHERE id=46;
UPDATE product SET expiration_date=(12) WHERE id=47;
UPDATE product SET expiration_date=(24) WHERE id=48;
UPDATE product SET expiration_date=(36) WHERE id=49;
UPDATE product SET expiration_date=(48) WHERE id=50;
UPDATE product SET expiration_date=(12) WHERE id=51;
UPDATE product SET expiration_date=(24) WHERE id=52;
UPDATE product SET expiration_date=(36) WHERE id=53;
UPDATE product SET expiration_date=(48) WHERE id=54;
UPDATE product SET expiration_date=(36) WHERE id=55;
UPDATE product SET expiration_date=(24) WHERE id=56;
UPDATE product SET expiration_date=(12) WHERE id=57;
UPDATE product SET expiration_date=(24) WHERE id=58;
UPDATE product SET expiration_date=(36) WHERE id=59;
UPDATE product SET expiration_date=(48) WHERE id=60;
UPDATE product SET expiration_date=(12) WHERE id=61;
UPDATE product SET expiration_date=(24) WHERE id=62;
UPDATE product SET expiration_date=(36) WHERE id=63;
UPDATE product SET expiration_date=(48) WHERE id=64;
UPDATE product SET expiration_date=(36) WHERE id=65;
UPDATE product SET expiration_date=(24) WHERE id=66;
UPDATE product SET expiration_date=(12) WHERE id=67;
UPDATE product SET expiration_date=(24) WHERE id=68;
UPDATE product SET expiration_date=(36) WHERE id=69;
UPDATE product SET expiration_date=(48) WHERE id=70;
UPDATE product SET expiration_date=(12) WHERE id=71;
UPDATE product SET expiration_date=(24) WHERE id=72;
UPDATE product SET expiration_date=(36) WHERE id=73;
UPDATE product SET expiration_date=(48) WHERE id=74;
UPDATE product SET expiration_date=(36) WHERE id=75;
UPDATE product SET expiration_date=(24) WHERE id=76;
UPDATE product SET expiration_date=(12) WHERE id=77;
UPDATE product SET expiration_date=(24) WHERE id=78;
UPDATE product SET expiration_date=(36) WHERE id=79;
UPDATE product SET expiration_date=(48) WHERE id=80;
UPDATE product SET expiration_date=(12) WHERE id=81;
UPDATE product SET expiration_date=(24) WHERE id=82;
UPDATE product SET expiration_date=(36) WHERE id=83;
UPDATE product SET expiration_date=(48) WHERE id=84;
UPDATE product SET expiration_date=(36) WHERE id=85;
UPDATE product SET expiration_date=(24) WHERE id=86;
UPDATE product SET expiration_date=(12) WHERE id=87;
UPDATE product SET expiration_date=(24) WHERE id=88;
UPDATE product SET expiration_date=(36) WHERE id=89;
UPDATE product SET expiration_date=(48) WHERE id=90;
UPDATE product SET expiration_date=(12) WHERE id=91;
UPDATE product SET expiration_date=(24) WHERE id=92;
UPDATE product SET expiration_date=(36) WHERE id=93;
UPDATE product SET expiration_date=(48) WHERE id=94;
UPDATE product SET expiration_date=(36) WHERE id=95;
UPDATE product SET expiration_date=(24) WHERE id=96;
UPDATE product SET expiration_date=(12) WHERE id=97;
UPDATE product SET expiration_date=(24) WHERE id=98;
UPDATE product SET expiration_date=(36) WHERE id=99;
UPDATE product SET expiration_date=(48) WHERE id=100;
UPDATE product SET expiration_date=(36) WHERE id=101;
UPDATE product SET expiration_date=(48) WHERE id=102;
UPDATE product SET expiration_date=(12) WHERE id=103;
UPDATE product SET expiration_date=(24) WHERE id=104;
UPDATE product SET expiration_date=(36) WHERE id=105;
UPDATE product SET expiration_date=(48) WHERE id=106;
UPDATE product SET expiration_date=(36) WHERE id=107;
UPDATE product SET expiration_date=(24) WHERE id=108;
UPDATE product SET expiration_date=(12) WHERE id=109;
UPDATE product SET expiration_date=(24) WHERE id=110;
UPDATE product SET expiration_date=(36) WHERE id=111;

/*Создать и заполнить колонку в таблице product 'годен до'*/

ALTER TABLE product ADD column use_to DATE;
UPDATE product AS p SET p.use_to=DATE_ADD(p.prod_date, INTERVAL p.expiration_date MONTH);

/*Выбрать топ-5 лекарств*/

SELECT c.name AS drugs, p.name, COUNT(b.quantity) AS orderqty
FROM product AS p
JOIN basket AS b ON (b.product_id=p.id)
JOIN subcataloge AS s ON (s.id=p.subcatalode_id)
JOIN cataloge AS c ON (s.catalode_id=c.id)
WHERE c.name='лекарства'
GROUP BY product_id
ORDER BY orderqty DESC
LIMIT 5;

/*5 самый активных пользователей интернет магазина, заказавшие больше всего товаров */

SELECT concat_ws(' ', u.first_name, u.last_name) AS topusers
FROM users AS u
WHERE u.id IN (SELECT b.user_id 
			FROM basket AS b
            WHERE b.id IN (SELECT o.basket_id FROM `order` AS o) -- выбираем товар положенны в корзину, который оформили в заказ
            GROUP by b.user_id
            ORDER BY COUNT(b.user_id))
            LIMIT 5;

/* На все лекарственные травы с 15 июня по 15 июля установить скидку 15%*/

			SELECT 
            p.name
            , p.price
           , CASE
			WHEN curdate() BETWEEN '2021-05-05' AND '2021-06-05'
            THEN  (p.price*0.85) 
			ELSE p.price
			end
            AS CurPrice
            FROM product AS p
            WHERE subcatalode_id IN(
									SELECT sb.id FROM subcataloge AS sb WHERE catalode_id IN(
												SELECT c.id FROM cataloge AS c WHERE c.name='лекарственные травы '
																							)
                                  )
								AND p.price>0;
		SELECT *FROM orderstatus;
        
/*Заказы доставленые в 1ый пункт выдачи заказов*/

SELECT o.id, os.status, pp.id 
FROM `order` as O
RIGHT JOIN orderstatus AS os ON(os.id=o.status_id)
RIGHT JOIN pickpoint AS pp ON(pp.id=o.pick_point_id)
WHERE (os.status='в пункте выдачи') AND (pp.id=1);

/*Вывести максимальный и минимальные суммы заказов*/

(SELECT o.id, SUM(b.quantity*p.price) AS MINandMAXorder
FROM `order` as o
INNER JOIN basket AS b ON (b.id=o.basket_id)
INNER JOIN product AS p ON (p.id=b.product_id)
WHERE p.price>0
GROUP BY o.basket_id
ORDER BY MINandMAXorder 
LIMIT 1)
UNION
(SELECT o.id, SUM(b.quantity*p.price) AS MINandMAXorder
FROM `order` as o
INNER JOIN basket AS b ON (b.id=o.basket_id)
INNER JOIN product AS p ON (p.id=b.product_id)
WHERE p.price>0
GROUP BY o.basket_id
ORDER BY MINandMAXorder DESC
LIMIT 1);

/*Установлению скидку на товары, у которых срок годности заканчивается в ближайший 3 месяца, товары с истекшим сроком годности обезценить*/

 	   SELECT p.name,  p.use_to, p.price,
       CASE
			WHEN p.use_to<CURDATE() THEN  p.price*0  
			WHEN (p.use_to-INTERVAL 3 MONTH)<CURDATE() THEN p.price*0.8 
										       ELSE p.price*1
		 END
         AS NEWPrice
         FROM product AS p
         ORDER BY NEWPrice DESC;


/*Пользовательская корзина с расчетом суммы по каждому пункту*/

CREATE VIEW orders AS SELECT b.id, p.name, b.quantity, p.price, p.price*b.quantity AS Amount
FROM basket AS b, product AS p
WHERE p.id=b.product_id;

SELECT * FROM orders;

/* Заказ с расчетом итоговой суммы*/

CREATE VIEW TotalOrder AS 
SELECT b.id, u.first_name, u.last_name, SUM(p.price*b.quantity) AS amount
FROM users AS u, product AS p, basket AS b
WHERE (b.user_id=u.id) AND (b.product_id=p.id)
GROUP BY b.id;
;

/*Найти отзывы о заданном лекарстве*/

DELIMITER //
CREATE PROCEDURE reply (IN var1 VARCHAR(100))
BEGIN
SELECT concat_ws(' ', u.first_name, u.last_name) AS UserName, p.name, f.review
FROM product AS p
RIGHT JOIN feedback AS f ON f.product_id=p.id
JOIN users AS u on u.id=f.user_id
WHERE p.name=var1;
END //
DELIMITER ;

CALL reply('exercitationem');


SELECT *FROM product;
-- quis
-- exercitationem
-- vero
-- aperiam

/* Найти все заказы для заданного пользователя*/

ALTER DATABASE apteka CHARACTER SET utf8 COLLATE utf8_general_ci;

DROP PROCEDURE search;
DELIMITER //
CREATE PROCEDURE search (IN var1 VARCHAR(100), IN var2 VARCHAR(100))
BEGIN
SELECT u.first_name, u.last_name, p.name, b.quantity, os.status
FROM users AS u
JOIN basket AS b ON (u.id=b.user_id)
JOIN product AS p ON (p.id=b.product_id)
JOIN `order` AS o ON (o.basket_id=b.id)
JOIN orderstatus AS os ON (os.id=o.status_id)
WHERE u.first_name=var1 AND
 u.last_name=var2
 ORDER BY os.status;
END //
DELIMITER ;

CALL search('Braxton', 'Larkin');

/*Установить ограничение на ввод и обновление данных о продукте, если срок годности истек*/
DELIMITER //

CREATE TRIGGER insert_product 
BEFORE INSERT
ON product FOR EACH ROW
BEGIN
IF new.use_to<current_date() THEN
    SIGNAL SQLSTATE "45000"
    SET MESSAGE_TEXT = "Срок годности истек!";
  END IF;
END//
DELIMITER ;
INSERT INTO product (`id`,`subcatalode_id`,`name`,`price`,`prod_date`,`doze`,`created_at`,`updated_at`,`use_to`,`expiration_date`) VALUES (112,4,'yfhvv', 1200, '2021-01-02', 100, '2021-05-09',NOW(), '2023-01-02', 24);
INSERT INTO product (`id`,`subcatalode_id`,`name`,`price`,`prod_date`,`doze`,`created_at`,`updated_at`,`use_to`,`expiration_date`) VALUES (117,4,'yjhv', 1200, '2018-01-02', 100, '2021-05-09',NOW(), '2020-01-02', 49);


