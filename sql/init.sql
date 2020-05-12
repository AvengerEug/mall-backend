CREATE DATABASE eugmall;

USE mall;

CREATE TABLE `user`(
  user_id INT PRIMARY KEY AUTO_INCREMENT COMMENT "用户id, int类型够了，若到了存不够的情况，此时应该考虑分库分表了",
  user_name VARCHAR(50),
  user_password VARCHAR(256) NOT NULL,
  user_phone INT(11) NOT NULL,
  user_avatar VARCHAR(256),
  created_by INT NOT NULL,
  created_at INT(13) NOT NULL,
  last_modified_by INT NOT NULL,
  last_modified_at INT(13) NOT NULL,
  deleted TINYINT(1) NOT NULL
);

CREATE TABLE category(
  category_id INT PRIMARY KEY AUTO_INCREMENT COMMENT "类别id，只用int类型就能存够",
  category_name VARCHAR(256) NOT NULL COMMENT "类别名称",
  parent_id INT COMMENT "父级名称",
  level INT NOT NULL COMMENT "当前类别的级别"
);

CREATE TABLE specification(
  spec_id INT PRIMARY KEY AUTO_INCREMENT COMMENT "规格id，用int类型就能存够",
  spec_name VARCHAR(256) COMMENT "规格的名称，eg: 颜色",
);

CREATE TABLE specification_items(
  spec_item_id INT PRIMARY KEY AUTO_INCREMENT,
  spec_id INT NOT NULL,
  spec_item_name VARCHAR(256)
);

CREATE TABLE goods(
  goods_id INT PRIMARY KEY AUTO_INCREMENT,
  goods_name VARCHAR(256),
  goods_count INT,
  goods_price DECIMAL(6, 2) NOT NULL,
  goods_description VARCHAR(256),
  category_id INT NOT NULL COMMENT "二级品类",
  goods_ingredients_id INT NOT NULL COMMENT "配料id",
  spec_ids VARCHAR(128),
  created_by INT NOT NULL,
  created_at INT(13) NOT NULL,
  last_modified_by INT NOT NULL,
  last_modified_at INT(13) NOT NULL,
  deleted TINYINT(1) NOT NULL
);

CREATE TABLE goods_ingredients(
  goods_ingredients_id INT PRIMARY KEY AUTO_INCREMENT,
  goods_ingredients_name VARCHAR(256) COMMENT "配料名称"
);

CREATE TABLE goods_ingredients_items(
  goods_ingredients_items_id INT PRIMARY KEY AUTO_INCREMENT,
  goods_ingredients_id INT,
  goods_ingredients_item_name VARCHAR(256) COMMENT "配料项名称",
  goods_ingredients_item_price DECIMAL(6, 2) NOT NULL,
);

CREATE TABLE shop_cart(
  shop_cart_id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  total_price DECIMAL(6, 2) NOT NULL,
  total_goods INT
);

CREATE TABLE shop_cart_detail(
  shop_cart_detail_id INT PRIMARY KEY AUTO_INCREMENT,
  shop_cart_id INT NOT NULL,
  goods_id INT NOT NULL,
  goods_name VARCHAR(256) NOT NULL,
  goods_count INT NOT NULL,
  goods_price DECIMAL(6, 2) NOT NULL,
  goods_description VARCHAR(256),
  spec_id INT NOT NULL
);

CREATE TABLE order(
  order_id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  order_status INT NOT NULL,
  total_price DECIMAL(6, 2) NOT NULL,
  total_goods INT,
  created_by INT NOT NULL,
  created_at INT(13) NOT NULL,
  last_modified_by INT NOT NULL,
  last_modified_at INT(13) NOT NULL,
  deleted TINYINT(1) NOT NULL
);

CREATE TABLE order_detail(
  order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT NOT NULL,
  goods_id INT NOT NULL,
  goods_name VARCHAR(256) NOT NULL,
  goods_count INT NOT NULL,
  goods_price DECIMAL(6, 2) NOT NULL,
  goods_description VARCHAR(256),
  spec_id INT NOT NULL
);

-- 添加默认用户15575800308/123456
INSERT INTO user(user_name, user_phone, user_password, created_by, created_at, last_modified_by, last_modified_at, deleted)
VALUES("avenger", "15575800308", "123456", 0, 1589282191799, 0, 1589282191799, 0);


-- 添加规格
INSERT INTO specification(spec_name) VALUES("杯型");
INSERT INTO specification(spec_name) VALUES("冰度");
INSERT INTO specification(spec_name) VALUES("糖度");

-- 添加规格对应的item
-- 杯型对应的item
INSERT INTO specification_items(spec_id, spec_item_name) SELECT spec_id, "中杯" FROM specification WHERE spec_name = "杯型";
INSERT INTO specification_items(spec_id, spec_item_name) SELECT spec_id, "大杯" FROM specification WHERE spec_name = "杯型";

-- 冰度对应的item
INSERT INTO specification_items(spec_id, spec_item_name) SELECT spec_id, "少冰" FROM specification WHERE spec_name = "冰度";
INSERT INTO specification_items(spec_id, spec_item_name) SELECT spec_id, "去冰" FROM specification WHERE spec_name = "冰度";
INSERT INTO specification_items(spec_id, spec_item_name) SELECT spec_id, "常温" FROM specification WHERE spec_name = "冰度";
INSERT INTO specification_items(spec_id, spec_item_name) SELECT spec_id, "热饮" FROM specification WHERE spec_name = "冰度";

--糖度对应的item
INSERT INTO specification_items(spec_id, spec_item_name) SELECT spec_id, "正常糖" FROM specification WHERE spec_name = "糖度";
INSERT INTO specification_items(spec_id, spec_item_name) SELECT spec_id, "七分糖" FROM specification WHERE spec_name = "糖度";
INSERT INTO specification_items(spec_id, spec_item_name) SELECT spec_id, "五分糖" FROM specification WHERE spec_name = "糖度";
INSERT INTO specification_items(spec_id, spec_item_name) SELECT spec_id, "三分糖" FROM specification WHERE spec_name = "糖度";
INSERT INTO specification_items(spec_id, spec_item_name) SELECT spec_id, "不另外加糖" FROM specification WHERE spec_name = "糖度";

-- 添加一级category
INSERT INTO category(category_name, parent_id, level) VALUES ("店长推荐", null, 1);
INSERT INTO category(category_name, parent_id, level) VALUES ("找好茶", null, 1);
INSERT INTO category(category_name, parent_id, level) VALUES ("找口感", null, 1);
INSERT INTO category(category_name, parent_id, level) VALUES ("找奶茶", null, 1);
INSERT INTO category(category_name, parent_id, level) VALUES ("找新鲜", null, 1);
INSERT INTO category(category_name, parent_id, level) VALUES ("找拿铁", null, 1);


-- 添加配料
INSERT INTO goods_ingredients(goods_ingredients_name) VALUES ("通用");
INSERT INTO goods_ingredients_items(goods_ingredients_id, goods_ingredients_item_name, goods_ingredients_item_price)
SELECT goods_ingredients_id, "珍珠", 0.00 FROM goods_ingredients WHERE goods_ingredients_name = "通用";
INSERT INTO goods_ingredients_items(goods_ingredients_id, goods_ingredients_item_name, goods_ingredients_item_price)
SELECT goods_ingredients_id, "波霸", 0.00 FROM goods_ingredients WHERE goods_ingredients_name = "通用";
INSERT INTO goods_ingredients_items(goods_ingredients_id, goods_ingredients_item_name, goods_ingredients_item_price)
SELECT goods_ingredients_id, "椰果", 0.00 FROM goods_ingredients WHERE goods_ingredients_name = "通用";
INSERT INTO goods_ingredients_items(goods_ingredients_id, goods_ingredients_item_name, goods_ingredients_item_price)
SELECT goods_ingredients_id, "仙草", 0.00 FROM goods_ingredients WHERE goods_ingredients_name = "通用";
INSERT INTO goods_ingredients_items(goods_ingredients_id, goods_ingredients_item_name, goods_ingredients_item_price)
SELECT goods_ingredients_id, "红豆", 0.00 FROM goods_ingredients WHERE goods_ingredients_name = "通用";
INSERT INTO goods_ingredients_items(goods_ingredients_id, goods_ingredients_item_name, goods_ingredients_item_price)
SELECT goods_ingredients_id, "燕麦", 1.00 FROM goods_ingredients WHERE goods_ingredients_name = "通用";
INSERT INTO goods_ingredients_items(goods_ingredients_id, goods_ingredients_item_name, goods_ingredients_item_price)
SELECT goods_ingredients_id, "咖啡冻", 3.00 FROM goods_ingredients WHERE goods_ingredients_name = "通用";
INSERT INTO goods_ingredients_items(goods_ingredients_id, goods_ingredients_item_name, goods_ingredients_item_price)
SELECT goods_ingredients_id, "补丁", 4.00 FROM goods_ingredients WHERE goods_ingredients_name = "通用";
INSERT INTO goods_ingredients_items(goods_ingredients_id, goods_ingredients_item_name, goods_ingredients_item_price)
SELECT goods_ingredients_id, "奶霜", 5.00 FROM goods_ingredients WHERE goods_ingredients_name = "通用";
INSERT INTO goods_ingredients_items(goods_ingredients_id, goods_ingredients_item_name, goods_ingredients_item_price)
SELECT goods_ingredients_id, "冰淇淋", 6.00 FROM goods_ingredients WHERE goods_ingredients_name = "通用";
INSERT INTO goods_ingredients_items(goods_ingredients_id, goods_ingredients_item_name, goods_ingredients_item_price)
SELECT goods_ingredients_id, "免费配料多", 0.00 FROM goods_ingredients WHERE goods_ingredients_name = "通用";
INSERT INTO goods_ingredients_items(goods_ingredients_id, goods_ingredients_item_name, goods_ingredients_item_price)
SELECT goods_ingredients_id, "免费配料少", 6.00 FROM goods_ingredients WHERE goods_ingredients_name = "通用";
INSERT INTO goods_ingredients_items(goods_ingredients_id, goods_ingredients_item_name, goods_ingredients_item_price)
SELECT goods_ingredients_id, "去糖改黑糖", 3.00 FROM goods_ingredients WHERE goods_ingredients_name = "通用";
INSERT INTO goods_ingredients_items(goods_ingredients_id, goods_ingredients_item_name, goods_ingredients_item_price)
SELECT goods_ingredients_id, "去糖改蜜", 5.00 FROM goods_ingredients WHERE goods_ingredients_name = "通用";

-- 在找奶茶中添加一杯奶茶
INSERT INTO goods(goods_name, goods_count, goods_price, goods_description, category_id,
goods_ingredients_id, spec_ids, created_by, created_at, last_modified_by, last_modified_at, deleted)
VALUES ("奶茶", 9999, 10.00, "阿萨姆红茶搭配特选植脂末，香浓顺口，甄选多种配料，口感更佳", (SELECT category_name FROM category WHERE
category_name = "找奶茶"), (SELECT goods_ingredients_id FROM goods_ingredients WHERE goods_ingredients_name = "通用"),
"1,2,3", 0, 1589282191799, 0, 1589282191799, 0);

