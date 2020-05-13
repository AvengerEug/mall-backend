DROP DATABASE IF EXISTS eugmall;

CREATE DATABASE eugmall DEFAULT CHARACTER SET utf8;

USE eugmall;

-- mysql默认为innodb引擎，所以没显示指定了
CREATE TABLE `user`(
  user_id INT PRIMARY KEY AUTO_INCREMENT COMMENT "用户id, int类型够了，若到了存不够的情况，此时应该考虑分库分表了",
  user_name VARCHAR(50),
  password VARCHAR(256) NOT NULL,
  phone VARCHAR(11) NOT NULL,
  avatar VARCHAR(256),
  created_by INT NOT NULL,
  created_at BIGINT(13) NOT NULL,
  last_modified_by INT NOT NULL,
  last_modified_at BIGINT(13) NOT NULL,
  deleted TINYINT(1) NOT NULL
);

CREATE TABLE store(
  store_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(128) COMMENT "门店名称",
  avatar VARCHAR(256),
  phone VARCHAR(15) NOT NULL COMMENT "带区号，eg: (021)3353-3397",
  created_by INT NOT NULL,
  created_at BIGINT(13) NOT NULL,
  last_modified_by INT NOT NULL,
  last_modified_at BIGINT(13) NOT NULL,
  deleted TINYINT(1) NOT NULL
);

CREATE TABLE category(
  cate_id INT PRIMARY KEY AUTO_INCREMENT COMMENT "类别id，只用int类型就能存够",
  name VARCHAR(256) NOT NULL COMMENT "类别名称",
  parent_id INT COMMENT "父级名称",
  store_id INT NOT NULL COMMENT "属于哪个门店",
  level INT NOT NULL COMMENT "当前类别的级别",
  ordered INT NOT NULL COMMENT "当前门店和level下按顺序排列，从0开始往上叠加"
);

CREATE TABLE spec(
  spec_id INT PRIMARY KEY AUTO_INCREMENT COMMENT "规格id，用int类型就能存够",
  spec_name VARCHAR(256) COMMENT "规格的名称，eg: 颜色"
);

CREATE TABLE spec_items(
  spec_item_id INT PRIMARY KEY AUTO_INCREMENT,
  spec_id INT NOT NULL,
  spec_item_name VARCHAR(256)
);

CREATE TABLE goods(
  goods_id INT PRIMARY KEY AUTO_INCREMENT,
  goods_name VARCHAR(256),
  goods_count INT COMMENT "-200表示永远有",
  goods_price DECIMAL(6, 2) NOT NULL,
  goods_description VARCHAR(256),
  cate_id INT NOT NULL COMMENT "level最低的品类",
  store_id INT NOT NULL COMMENT "门店id",
  spec_ids VARCHAR(128),
  created_by INT NOT NULL,
  created_at BIGINT(13) NOT NULL,
  last_modified_by INT NOT NULL,
  last_modified_at BIGINT(13) NOT NULL,
  deleted TINYINT(1) NOT NULL
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

CREATE TABLE `order`(
  order_id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  order_status INT NOT NULL,
  total_price DECIMAL(6, 2) NOT NULL,
  total_goods INT,
  created_by INT NOT NULL,
  created_at BIGINT(13) NOT NULL,
  last_modified_by INT NOT NULL,
  last_modified_at BIGINT(13) NOT NULL,
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
INSERT INTO user(user_name, phone, password, created_by, created_at, last_modified_by, last_modified_at, deleted)
VALUES("avenger", "15575800308", "123456", 0, 1589282191799, 0, 1589282191799, 0);

-- 添加门店：一点点
INSERT INTO store(name, avatar, phone, created_by, created_at, last_modified_by, last_modified_at, deleted)
VALUES("一点点", "https://www.alittle-tea.com/images/logo.png", "(021)3353-3397" , 0, 1589282191799, 0, 1589282191799, 0);
INSERT INTO store(name, avatar, phone, created_by, created_at, last_modified_by, last_modified_at, deleted)
VALUES("书亦烧仙草", "https://dss0.bdstatic.com/6KYTfyqn1Ah3otqbppnN2DJv/zhanpinglogo/85e1f3ab38f5b6e2d824a78344d992b9_originalsize.jpeg", "400-085-7085" , 0, 1589282191799, 0, 1589282191799, 0);
INSERT INTO store(name, avatar, phone, created_by, created_at, last_modified_by, last_modified_at, deleted)
VALUES("吾饮良品", "http://www.idrink.com.cn/images/logo.png", "400-8888-967" , 0, 1589282191799, 0, 1589282191799, 0);
INSERT INTO store(name, avatar, phone, created_by, created_at, last_modified_by, last_modified_at, deleted)
VALUES("CoCo奶茶", "http://www.coco-tea.com.cn/img/logo.png", "400-990-6985" , 0, 1589282191799, 0, 1589282191799, 0);


-- 添加规格
INSERT INTO spec(spec_name) VALUES("杯型");
INSERT INTO spec(spec_name) VALUES("冰度");
INSERT INTO spec(spec_name) VALUES("糖度");

-- 添加规格对应的item
-- 杯型对应的item
INSERT INTO spec_items(spec_id, spec_item_name) SELECT spec_id, "中杯" FROM spec WHERE spec_name = "杯型";
INSERT INTO spec_items(spec_id, spec_item_name) SELECT spec_id, "大杯" FROM spec WHERE spec_name = "杯型";

-- 冰度对应的item
INSERT INTO spec_items(spec_id, spec_item_name) SELECT spec_id, "少冰" FROM spec WHERE spec_name = "冰度";
INSERT INTO spec_items(spec_id, spec_item_name) SELECT spec_id, "去冰" FROM spec WHERE spec_name = "冰度";
INSERT INTO spec_items(spec_id, spec_item_name) SELECT spec_id, "常温" FROM spec WHERE spec_name = "冰度";
INSERT INTO spec_items(spec_id, spec_item_name) SELECT spec_id, "热饮" FROM spec WHERE spec_name = "冰度";

-- 糖度对应的item
INSERT INTO spec_items(spec_id, spec_item_name) SELECT spec_id, "正常糖" FROM spec WHERE spec_name = "糖度";
INSERT INTO spec_items(spec_id, spec_item_name) SELECT spec_id, "七分糖" FROM spec WHERE spec_name = "糖度";
INSERT INTO spec_items(spec_id, spec_item_name) SELECT spec_id, "五分糖" FROM spec WHERE spec_name = "糖度";
INSERT INTO spec_items(spec_id, spec_item_name) SELECT spec_id, "三分糖" FROM spec WHERE spec_name = "糖度";
INSERT INTO spec_items(spec_id, spec_item_name) SELECT spec_id, "不另外加糖" FROM spec WHERE spec_name = "糖度";

-- 添加一级category
INSERT INTO category(name, parent_id, level, store_id, ordered) SELECT "店长推荐", null, 1, store_id, 0 FROM store WHERE name = "一点点";
INSERT INTO category(name, parent_id, level, store_id, ordered) SELECT "找好茶", null, 1, store_id, 1 FROM store WHERE name = "一点点";
INSERT INTO category(name, parent_id, level, store_id, ordered) SELECT "找口感", null, 1, store_id, 2 FROM store WHERE name = "一点点";
INSERT INTO category(name, parent_id, level, store_id, ordered) SELECT "找奶茶", null, 1, store_id, 3 FROM store WHERE name = "一点点";
INSERT INTO category(name, parent_id, level, store_id, ordered) SELECT "找新鲜", null, 1, store_id, 4 FROM store WHERE name = "一点点";
INSERT INTO category(name, parent_id, level, store_id, ordered) SELECT "找拿铁", null, 1, store_id, 5 FROM store WHERE name = "一点点";
INSERT INTO category(name, parent_id, level, store_id, ordered) SELECT "配料", null, 1, store_id, 6 FROM store WHERE name = "一点点";

-- 添加商品 -- 配料
INSERT INTO goods(goods_name, goods_count, goods_price, goods_description, cate_id, store_id,
spec_ids, created_by, created_at, last_modified_by, last_modified_at, deleted)
VALUES ("珍珠", -200, 0.00, "珍珠", (SELECT cate_id FROM category WHERE name = "配料"),
(SELECT name FROM store WHERE name = "一点点"), null, 0, 1589282191799, 0, 1589282191799, 0);
INSERT INTO goods(goods_name, goods_count, goods_price, goods_description, cate_id, store_id,
spec_ids, created_by, created_at, last_modified_by, last_modified_at, deleted)
VALUES ("波霸", -200, 0.00, "波霸", (SELECT cate_id FROM category WHERE name = "配料"),
(SELECT name FROM store WHERE name = "一点点"), null, 0, 1589282191799, 0, 1589282191799, 0);
INSERT INTO goods(goods_name, goods_count, goods_price, goods_description, cate_id, store_id,
spec_ids, created_by, created_at, last_modified_by, last_modified_at, deleted)
VALUES ("椰果", -200, 0.00, "椰果", (SELECT cate_id FROM category WHERE name = "配料"),
(SELECT name FROM store WHERE name = "一点点"), null, 0, 1589282191799, 0, 1589282191799, 0);
INSERT INTO goods(goods_name, goods_count, goods_price, goods_description, cate_id, store_id,
spec_ids, created_by, created_at, last_modified_by, last_modified_at, deleted)
VALUES ("仙草", -200, 0.00, "仙草", (SELECT cate_id FROM category WHERE name = "配料"),
(SELECT name FROM store WHERE name = "一点点"), null, 0, 1589282191799, 0, 1589282191799, 0);
INSERT INTO goods(goods_name, goods_count, goods_price, goods_description, cate_id, store_id,
spec_ids, created_by, created_at, last_modified_by, last_modified_at, deleted)
VALUES ("红豆", -200, 0.00, "红豆", (SELECT cate_id FROM category WHERE name = "配料"),
(SELECT name FROM store WHERE name = "一点点"), null, 0, 1589282191799, 0, 1589282191799, 0);
INSERT INTO goods(goods_name, goods_count, goods_price, goods_description, cate_id, store_id,
spec_ids, created_by, created_at, last_modified_by, last_modified_at, deleted)
VALUES ("燕麦", -200, 0.00, "燕麦", (SELECT cate_id FROM category WHERE name = "配料"),
(SELECT name FROM store WHERE name = "一点点"), null, 0, 1589282191799, 0, 1589282191799, 0);
INSERT INTO goods(goods_name, goods_count, goods_price, goods_description, cate_id, store_id,
spec_ids, created_by, created_at, last_modified_by, last_modified_at, deleted)
VALUES ("咖啡冻", -200, 0.00, "咖啡冻", (SELECT cate_id FROM category WHERE name = "配料"),
(SELECT name FROM store WHERE name = "一点点"), null, 0, 1589282191799, 0, 1589282191799, 0);
INSERT INTO goods(goods_name, goods_count, goods_price, goods_description, cate_id, store_id,
spec_ids, created_by, created_at, last_modified_by, last_modified_at, deleted)
VALUES ("布丁", -200, 0.00, "布丁", (SELECT cate_id FROM category WHERE name = "配料"),
(SELECT name FROM store WHERE name = "一点点"), null, 0, 1589282191799, 0, 1589282191799, 0);
INSERT INTO goods(goods_name, goods_count, goods_price, goods_description, cate_id, store_id,
spec_ids, created_by, created_at, last_modified_by, last_modified_at, deleted)
VALUES ("奶霜", -200, 0.00, "奶霜", (SELECT cate_id FROM category WHERE name = "配料"),
(SELECT name FROM store WHERE name = "一点点"), null, 0, 1589282191799, 0, 1589282191799, 0);
INSERT INTO goods(goods_name, goods_count, goods_price, goods_description, cate_id, store_id,
spec_ids, created_by, created_at, last_modified_by, last_modified_at, deleted)
VALUES ("冰淇淋", -200, 0.00, "冰淇淋", (SELECT cate_id FROM category WHERE name = "配料"),
(SELECT name FROM store WHERE name = "一点点"), null, 0, 1589282191799, 0, 1589282191799, 0);
INSERT INTO goods(goods_name, goods_count, goods_price, goods_description, cate_id, store_id,
spec_ids, created_by, created_at, last_modified_by, last_modified_at, deleted)
VALUES ("免费配料多", -200, 0.00, "免费配料多", (SELECT cate_id FROM category WHERE name = "配料"),
(SELECT name FROM store WHERE name = "一点点"), null, 0, 1589282191799, 0, 1589282191799, 0);
INSERT INTO goods(goods_name, goods_count, goods_price, goods_description, cate_id, store_id,
spec_ids, created_by, created_at, last_modified_by, last_modified_at, deleted)
VALUES ("免费配料少", -200, 0.00, "免费配料少", (SELECT cate_id FROM category WHERE name = "配料"),
(SELECT name FROM store WHERE name = "一点点"), null, 0, 1589282191799, 0, 1589282191799, 0);
INSERT INTO goods(goods_name, goods_count, goods_price, goods_description, cate_id, store_id,
spec_ids, created_by, created_at, last_modified_by, last_modified_at, deleted)
VALUES ("去糖改黑糖", -200, 0.00, "去糖改黑糖", (SELECT cate_id FROM category WHERE name = "配料"),
(SELECT name FROM store WHERE name = "一点点"), null, 0, 1589282191799, 0, 1589282191799, 0);
INSERT INTO goods(goods_name, goods_count, goods_price, goods_description, cate_id, store_id,
spec_ids, created_by, created_at, last_modified_by, last_modified_at, deleted)
VALUES ("去糖改蜜", -200, 0.00, "去糖改蜜", (SELECT cate_id FROM category WHERE name = "配料"),
(SELECT name FROM store WHERE name = "一点点"), null, 0, 1589282191799, 0, 1589282191799, 0);


-- 在找奶茶中添加一杯奶茶
INSERT INTO goods(goods_name, goods_count, goods_price, goods_description, cate_id, store_id,
spec_ids, created_by, created_at, last_modified_by, last_modified_at, deleted)
VALUES ("奶茶", -200, 10.00, "阿萨姆红茶搭配特选植脂末，香浓顺口，甄选多种配料，口感更佳",
(SELECT cate_id FROM category WHERE name = "找奶茶"),
(SELECT name FROM store WHERE name = "一点点"), "1,2,3", 0, 1589282191799, 0, 1589282191799, 0);

