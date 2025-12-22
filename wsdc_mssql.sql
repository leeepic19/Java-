/*
SQL Server Database Script for WSDC
Target Server: SQL Server 2022
*/

USE master;
GO

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'wsdc')
BEGIN
    CREATE DATABASE wsdc;
END
GO

USE wsdc;
GO

-- ----------------------------
-- Table structure for tb_introduce
-- ----------------------------
IF OBJECT_ID('tb_introduce', 'U') IS NOT NULL DROP TABLE tb_introduce;
CREATE TABLE tb_introduce (
  id int IDENTITY(1,1) NOT NULL,
  content nvarchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (id)
);
GO

-- ----------------------------
-- Table structure for tb_menu
-- ----------------------------
IF OBJECT_ID('tb_menu', 'U') IS NOT NULL DROP TABLE tb_menu;
CREATE TABLE tb_menu (
  menu_id int IDENTITY(1,1) NOT NULL,
  menu_name nvarchar(50) NOT NULL DEFAULT '',
  menu_content nvarchar(50) NOT NULL DEFAULT '',
  menu_price decimal(10,2) NOT NULL DEFAULT 0.00,
  menu_image nvarchar(255) DEFAULT NULL,
  PRIMARY KEY (menu_id)
);
GO

-- ----------------------------
-- Table structure for tb_menu_top
-- ----------------------------
IF OBJECT_ID('tb_menu_top', 'U') IS NOT NULL DROP TABLE tb_menu_top;
CREATE TABLE tb_menu_top (
  id int IDENTITY(1,1) NOT NULL,
  menu_id int NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
);
GO

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
IF OBJECT_ID('tb_user', 'U') IS NOT NULL DROP TABLE tb_user;
CREATE TABLE tb_user (
  user_id int IDENTITY(1,1) NOT NULL,
  user_name nvarchar(30) NOT NULL DEFAULT '',
  user_password nvarchar(30) NOT NULL DEFAULT '',
  user_realname nvarchar(50) DEFAULT NULL,
  user_sex nvarchar(30) DEFAULT NULL,
  user_flag nvarchar(4) NOT NULL DEFAULT '',
  user_mail nvarchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (user_id)
);
GO

-- ----------------------------
-- Table structure for tb_message
-- ----------------------------
IF OBJECT_ID('tb_message', 'U') IS NOT NULL DROP TABLE tb_message;
CREATE TABLE tb_message (
  id int IDENTITY(1,1) NOT NULL,
  user_id int NOT NULL DEFAULT 0,
  menu_id int NOT NULL DEFAULT 0,
  content nvarchar(200) DEFAULT NULL,
  mg_date nvarchar(45) DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT FK_Message_User FOREIGN KEY (user_id) REFERENCES tb_user(user_id)
);
GO

-- ----------------------------
-- Table structure for tb_orders
-- ----------------------------
IF OBJECT_ID('tb_orders', 'U') IS NOT NULL DROP TABLE tb_orders;
CREATE TABLE tb_orders (
  order_id int IDENTITY(1,1) NOT NULL,
  user_id int NOT NULL DEFAULT 0,
  menu_id int NOT NULL DEFAULT 0,
  order_num int NOT NULL DEFAULT 0,
  order_notice nvarchar(45) DEFAULT NULL,
  other_notice nvarchar(100) DEFAULT NULL,
  states nvarchar(4) NOT NULL DEFAULT '',
  PRIMARY KEY (order_id),
  CONSTRAINT FK_Orders_User FOREIGN KEY (user_id) REFERENCES tb_user(user_id),
  CONSTRAINT FK_Orders_Menu FOREIGN KEY (menu_id) REFERENCES tb_menu(menu_id)
);
GO

-- Insert initial data (Optional)
INSERT INTO tb_user (user_name, user_password, user_flag, user_mail) VALUES ('admin', 'admin', '1', 'admin@wsdc.com');
GO
