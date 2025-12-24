-- 插入商家介绍
INSERT INTO tb_introduce (id, content) VALUES (1, '欢迎光临WSDC订餐系统！我们提供各类精品美食，新鲜食材，快速配送，让您足不出户享受美味佳肴。');

-- 插入菜单数据
SET IDENTITY_INSERT tb_menu ON;
INSERT INTO tb_menu (menu_id, menu_name, menu_content, menu_price, menu_image) VALUES 
(1, '宫保鸡丁', '经典川菜，鸡肉鲜嫩，麻辣鲜香', 38.00, 'gongbao.jpg'),
(2, '鱼香肉丝', '四川名菜，酸甜适口，回味无穷', 32.00, 'yuxiang.jpg'),
(3, '麻婆豆腐', '传统川菜，麻辣鲜香，豆腐嫩滑', 28.00, 'mapo.jpg'),
(4, '红烧肉', '经典家常菜，肥而不腻，香气扑鼻', 45.00, 'hongshao.jpg'),
(5, '糖醋排骨', '酸甜可口，外酥里嫩，老少皆宜', 42.00, 'tangcu.jpg'),
(6, '清蒸鲈鱼', '鲜嫩可口，营养丰富，健康美味', 58.00, 'qingzheng.jpg'),
(7, '干锅花菜', '干香麻辣，脆嫩爽口，下饭神器', 26.00, 'ganguo.jpg'),
(8, '水煮牛肉', '麻辣鲜香，牛肉嫩滑，经典川菜', 48.00, 'shuizhu.jpg'),
(9, '酸菜鱼', '酸辣开胃，鱼肉鲜嫩，汤鲜味美', 52.00, 'suancai.jpg'),
(10, '蒜蓉西兰花', '清淡营养，蒜香浓郁，健康之选', 18.00, 'xilan.jpg');
SET IDENTITY_INSERT tb_menu OFF;

-- 插入推荐菜品
SET IDENTITY_INSERT tb_menu_top ON;
INSERT INTO tb_menu_top (id, menu_id) VALUES 
(1, 1),
(2, 4),
(3, 6),
(4, 9);
SET IDENTITY_INSERT tb_menu_top OFF;

-- 插入测试用户（如果不存在）
IF NOT EXISTS (SELECT 1 FROM tb_user WHERE user_name = 'admin')
BEGIN
    SET IDENTITY_INSERT tb_user ON;
    INSERT INTO tb_user (user_id, user_name, user_password, user_realname, user_sex, user_flag, user_mail) 
    VALUES (1, 'admin', '123456', '管理员', '男', '管理员', 'admin@wsdc.com');
    SET IDENTITY_INSERT tb_user OFF;
END;

IF NOT EXISTS (SELECT 1 FROM tb_user WHERE user_name = 'test')
BEGIN
    SET IDENTITY_INSERT tb_user ON;
    INSERT INTO tb_user (user_id, user_name, user_password, user_realname, user_sex, user_flag, user_mail) 
    VALUES (2, 'test', '123456', '测试用户', '女', '普通用户', 'test@wsdc.com');
    SET IDENTITY_INSERT tb_user OFF;
END;

SELECT '数据插入完成!' AS Message;
