DROP TABLE IF EXISTS users;
CREATE TABLE users (
id     	     INT		NOT NULL AUTO_INCREMENT PRIMARY KEY,
username     VARCHAR(200) 	UNIQUE,
email 	     VARCHAR(200)
) ENGINE=INNODB;

DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
id     	     INT		NOT NULL AUTO_INCREMENT PRIMARY KEY,
discountcode VARCHAR(20) 	UNIQUE,
discountrate NUMERIC(4,2)
) ENGINE=INNODB;

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

