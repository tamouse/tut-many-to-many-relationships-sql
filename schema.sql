DROP TABLE IF EXISTS users;
CREATE TABLE users (
id     	     INT		NOT NULL AUTO_INCREMENT PRIMARY KEY,
username     VARCHAR(200) 	UNIQUE,
email 	     VARCHAR(200)
) ENGINE=INNODB;

INSERT INTO users (username, email) VALUES
  ('joe','joe@example.com'),
  ('jane','jane@example.com'),
  ('alex','alex@example.com'),
  ('fred','fred@example.com'),
  ('betsy','betsy@example.com'),
  ('pat','pat@example.com');

SELECT * FROM users;

DROP TABLE IF EXISTS products;
CREATE TABLE products (
id     	     INT		NOT NULL AUTO_INCREMENT PRIMARY KEY,
prodname     VARCHAR(200),
price	     NUMERIC(10,2)
) ENGINE=INNODB;

INSERT INTO products (prodname, price) VALUES
  ('vegamatic',99.99),
  ('juicy-juicer',139.99),
  ('left flanged niblik',2000.01),
  ('interrupting cow',0.01),
  ('squeegee',2.99);

SELECT * FROM products;

DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
id     	     INT		NOT NULL AUTO_INCREMENT PRIMARY KEY,
discountcode VARCHAR(20) 	UNIQUE,
discountrate NUMERIC(4,2)
) ENGINE=INNODB;

INSERT INTO discounts (discountcode, discountrate) VALUES
  ('d1',10),
  ('d2',12.5),
  ('d3',40);

SELECT * FROM discounts;

DROP TABLE IF EXISTS usersdiscounts;
CREATE TABLE usersdiscounts (
user_id      INT		NOT NULL,
discount_id  INT 		NOT NULL,
PRIMARY KEY (user_id, discount_id),
CONSTRAINT users_fk
  FOREIGN KEY (user_id)
  REFERENCES users(id)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
CONSTRAINT discount_fk
  FOREIGN KEY (discount_id)
  REFERENCES discounts(id)
  ON DELETE CASCADE
  ON UPDATE CASCADE
) ENGINE=INNODB;

INSERT INTO usersdiscounts (user_id, discount_id) VALUES
  ((SELECT id FROM users WHERE username = 'joe'),
   (SELECT id FROM discounts WHERE discountcode = 'd1')),
  ((SELECT id FROM users WHERE username = 'joe'),
   (SELECT id FROM discounts WHERE discountcode = 'd3')),
  ((SELECT id FROM users WHERE username = 'alex'),
   (SELECT id FROM discounts WHERE discountcode = 'd1')),
  ((SELECT id FROM users WHERE username = 'pat'),
   (SELECT id FROM discounts WHERE discountcode = 'd2')),
  ((SELECT id FROM users WHERE username = 'pat'),
   (SELECT id FROM discounts WHERE discountcode = 'd3'));

SELECT users.id AS uid, username, email, discountcode, discountrate FROM users, discounts, usersdiscounts WHERE users.id = usersdiscounts.user_id AND discounts.id = usersdiscounts.discount_id ORDER BY uid;

DROP TABLE IF EXISTS productsdiscounts;
CREATE TABLE productsdiscounts (
product_id   INT		NOT NULL,
discount_id  INT		NOT NULL,
PRIMARY KEY (product_id, discount_id),
CONSTRAINT products_fk
  FOREIGN KEY (product_id)
  REFERENCES products(id)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
CONSTRAINT discounts_fk
  FOREIGN KEY (discount_id)
  REFERENCES discounts(id)
  ON DELETE CASCADE
  ON UPDATE CASCADE
) ENGINE=INNODB;
