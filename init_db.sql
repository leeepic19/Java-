CREATE DATABASE IF NOT EXISTS food_order_system DEFAULT CHARACTER SET utf8mb4;
USE food_order_system;

-- Create application user
CREATE USER IF NOT EXISTS 'root1'@'localhost' IDENTIFIED BY '208716';
GRANT ALL PRIVILEGES ON food_order_system.* TO 'root1'@'localhost';
FLUSH PRIVILEGES;

-- Tables
CREATE TABLE IF NOT EXISTS t_user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(64) NOT NULL UNIQUE,
    password VARCHAR(128) NOT NULL,
    user_type TINYINT NOT NULL COMMENT '1: User, 2: Merchant',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS t_food (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    merchant_id BIGINT NOT NULL,
    merchant_name VARCHAR(128),
    food_name VARCHAR(128) NOT NULL,
    price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    stock INT NOT NULL DEFAULT 0,
    food_img VARCHAR(255),
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    KEY idx_merchant_id (merchant_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS t_user_address (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    receiver VARCHAR(64) NOT NULL,
    phone VARCHAR(32) NOT NULL,
    province VARCHAR(64),
    city VARCHAR(64),
    district VARCHAR(64),
    detail_address VARCHAR(255),
    is_default TINYINT NOT NULL DEFAULT 0,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY idx_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS t_order (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    food_id BIGINT NOT NULL,
    order_num INT NOT NULL,
    order_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    food_name VARCHAR(128),
    merchant_id BIGINT,
    merchant_name VARCHAR(128),
    user_name VARCHAR(64),
    user_phone VARCHAR(32),
    user_address VARCHAR(255),
    address_id BIGINT,
    status TINYINT NOT NULL DEFAULT 0,
    delivery_time INT,
    KEY idx_user (user_id),
    KEY idx_merchant (merchant_id),
    KEY idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Seed Data
INSERT IGNORE INTO t_user (username, password, user_type) VALUES ('user1', '123456', 1);
INSERT IGNORE INTO t_user (username, password, user_type) VALUES ('merchant1', '123456', 2);
