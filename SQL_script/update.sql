USE web_code;
GO

Alter Table order_tb
add payment_method_id Varchar(25) NULL;

ALTER TABLE address
ALTER COLUMN user_id INT;
go

ALTER TABLE address
ADD CONSTRAINT FK_address_user
FOREIGN KEY (user_id)
REFERENCES user_tb(user_id);

SELECT 
    p.product_id,
    p.name,
    p.price1 AS GiaGoc,
    p.price2 AS GiaGiam,
    CASE 
        WHEN p.price2 IS NULL THEN N'❌ Chưa có giá giảm'
        WHEN p.price2 >= p.price1 THEN N'⚠️ Giá giảm không hợp lệ'
        ELSE N'✅ Đã có giảm giá'
    END AS TrangThaiGiamGia
FROM product p
JOIN promotion_product pp ON p.product_id = pp.product_id
JOIN promotion promo ON pp.promotion_id = promo.promotion_id
WHERE promo.status = 1;

-- ⚠️ Cập nhật giá giảm nếu chưa có (giảm 10%)
UPDATE product
SET price2 = price1 * 0.9
WHERE product_id IN ('prd04', 'prd08');

UPDATE product
SET price2 = price1 * 0.9
WHERE product_id IN ('4304');

SELECT * FROM promotion_product;

-- Bước 1: Thêm cột price2 vào bảng product nếu chưa có
IF NOT EXISTS (
    SELECT * FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'product' AND COLUMN_NAME = 'price2'
)
BEGIN
    ALTER TABLE product
    ADD price2 DECIMAL(18, 2) NULL;
END
GO

-- Bước 2: Cập nhật giá giảm (price2) cho các sản phẩm (dữ liệu mẫu)
-- Chỉ cập nhật nếu muốn đặt khuyến mãi cụ thể
UPDATE product
SET price2 = price1 * 0.8
WHERE product_id IN ('prd01', 'prd02', 'prd03');
GO

-- Bước 3: Kiểm tra lại kết quả
SELECT product_id, name, price1 AS GiaGoc, price2 AS GiaDaGiam
FROM product
WHERE price2 IS NOT NULL;

---------------------
-- ⚠️ Đảm bảo đã có cột price2
IF NOT EXISTS (
    SELECT * FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'product' AND COLUMN_NAME = 'price2'
)
BEGIN
    ALTER TABLE product
    ADD price2 DECIMAL(18, 2) NULL;
END
GO

-- 🎯 Cập nhật sản phẩm đang có khuyến mãi
-- ⚠️ Giá mới (price2) phải nhỏ hơn giá gốc (price1)
-- Sản phẩm 1: LEGO City Sở Cứu hỏa
UPDATE product
SET price2 = 2590000
WHERE product_id = 'prd01';

-- Sản phẩm 2: Xe đạp trẻ em Fisher-Price 16 inch
UPDATE product
SET price2 = 2850000
WHERE product_id = 'prd02';

-- Sản phẩm 3: Robot Transformer Optimus Prime
UPDATE product
SET price2 = 1690000
WHERE product_id = 'prd03';
GO



-- BƯỚC 1: Thêm cột banner_url vào bảng promotion nếu chưa có
IF COL_LENGTH('promotion', 'banner_url') IS NULL
BEGIN
    ALTER TABLE promotion
    ADD banner_url NVARCHAR(MAX);
END;

-- BƯỚC 2: Cập nhật URL banner tương ứng với từng chương trình khuyến mãi
UPDATE promotion
SET banner_url = 'https://img.pikbest.com/templates/20240815/banner-promoting-the-sale-of-toys-for-children-in-the-supermarket_10729034.jpg!bw700'
WHERE promotion_id = '4501';

UPDATE promotion
SET banner_url = 'https://tudongchat.com/wp-content/uploads/2024/12/mau-content-ban-do-choi-tre-em-1.jpg'
WHERE promotion_id = '4502';

UPDATE promotion
SET banner_url = 'https://img.pikbest.com/templates/20240725/sale-banner-template-to-decorate-a-shop-selling-children-27s-toys_10680872.jpg!w700wp'
WHERE promotion_id = '4503';

UPDATE promotion
SET banner_url = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNWkOBVp6Kx8CXy_CSknH8yr-J1QMAbbZWKQ&s'
WHERE promotion_id = '4504';

UPDATE promotion
SET banner_url = 'https://www.mykingdom.com.vn/cdn/shop/articles/mykingdom-do-choi-tre-em-gia-tot-thump.jpg?v=1686029392'
WHERE promotion_id = 'promo001';

UPDATE promotion
SET banner_url = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSerlwpIzE55PjOKq-HIwXM5cDA5e9gq5ZvZYPvQY-dkec7-EZ_4WHQ7SgwDbp9h0Ee-L8&usqp=CAU'
WHERE promotion_id = 'promo002';

UPDATE promotion
SET banner_url = 'https://thegioipatin.com/wp-content/uploads/2022/03/banner-t3-1-02-min.jpg'
WHERE promotion_id = 'promo003';

UPDATE promotion
SET banner_url = 'https://down-vn.img.susercontent.com/file/vn-11134207-7ras8-m0cs7s74zu6nec'
WHERE promotion_id = 'promo004';

-- Cập nhật hình ảnh sản phẩm
UPDATE product
SET url_image1 = 'https://www.mykingdom.com.vn/cdn/shop/products/60374_lifestyle_envr_crop.jpg?v=1725520116&width=1100'
WHERE product_id = 'prd02';

UPDATE product
SET url_image1 = 'https://www.mykingdom.com.vn/cdn/shop/files/31154_a054fe16-24da-4dd7-a10d-0d348eb87e90.jpg?v=1725612595&width=1100'
WHERE product_id = 'prd03';

UPDATE product
SET url_image1 = 'https://www.mykingdom.com.vn/cdn/shop/files/31147_594a64b9-133a-47b2-aab6-9eb2a2e2b4ea.jpg?v=1746980450&width=1100'
WHERE product_id = 'prd04';

-- Thêm nhiều sản phẩm mới
INSERT INTO product (product_id, name, price1, price2, url_image1, category_id, status)
VALUES 
('prd_new01', N'Kính bơi chuyên nghiệp màu xám Intex', 119000, NULL, 'https://www.mykingdom.com.vn/cdn/shop/files/kinh-boi-chuyen-nghiep-mau-xam-intex-g-55685_4.jpg?v=1745466610&width=1100', '4002', 1),

('prd_new02', N'Con quay BX-23 Starter Phoenixwing', 529000, NULL, 'https://www.mykingdom.com.vn/cdn/shop/files/con-quay-bx-23-starter-phoenixwing-beyblade-x-913092_4.jpg?v=1736852227&width=1100', '4004', 1),

('prd_new03', N'Bảng vẽ khủng long màu xanh', 249000, NULL, 'https://www.mykingdom.com.vn/cdn/shop/files/do-choi-tre-em-bang-ve-khung-long-mt587741-xanh-mt587741.jpg?v=1721905528&width=1100', '4003', 1),

('prd_new04', N'Xe lửa Thomas mini', 76000, NULL, 'https://www.mykingdom.com.vn/cdn/shop/products/tst626_kr_1.png?v=1684956643&width=1100', '4004', 1),

('prd_new05', N'Mô hình lắp ráp Máy xúc & Xe nâng', 379000, NULL, 'https://www.mykingdom.com.vn/cdn/shop/files/mo-hinh-lap-rap-may-xuc-va-xe-nang-nat-geo-steam-ds1131h_1.jpg?v=1745230978&width=1100', '4001', 1),

('prd_new06', N'Bộ thí nghiệm nuôi san hô tinh thể', 819000, NULL, 'https://www.mykingdom.com.vn/cdn/shop/files/bo-thi-nghiem-nuoi-san-ho-tinh-the-nat-geo-steam-rtcryshab_3.jpg?v=1745490881&width=1100', '4001', 1),

('prd_new07', N'LEGO Rồng Trung Cổ Creator 31161', 1543000, NULL, 'https://www.mykingdom.com.vn/cdn/shop/files/do-choi-lap-rap-rong-trung-co-lego-creator-31161.png?v=1741236257&width=1100', '4004', 1),

('prd_new08', N'LEGO Duplo Bộ Xếp Hình Sáng Tạo 10914', 1245000, NULL, 'https://www.mykingdom.com.vn/cdn/shop/files/10914_0b6bf1f4-f164-4058-8c51-bfe7fbb2c589.jpg?v=1725527238&width=1100', '4003', 1),

('prd_new09', N'LEGO Máy Chụp Hình Polaroid OneStep SX-70', 2569000, NULL, 'https://www.mykingdom.com.vn/cdn/shop/files/do-choi-lap-rap-may-chup-hinh-polaroid-onestep-sx-70-lego-ideas-21345_3.jpg?v=1747809232&width=1100', '4004', 1),

('prd_new10', N'Xe Deadpool Scooter Hot Wheels', 269000, NULL, 'https://www.mykingdom.com.vn/cdn/shop/files/sieu-xe-pop-culture-deadpool-scooter-hot-wheels-jbl70-hxd63.jpg?v=1747640183&width=1100', '4004', 1),

('prd_new11', N'Mô hình Rồng hoạt hình - How to Train Your Dragon', 179000, NULL, 'https://www.mykingdom.com.vn/cdn/shop/files/con-vat-hoat-hinh-trong-how-to-train-your-dragon-6072554_10.jpg?v=1747197053&width=1100', '4004', 1),

('prd_new12', N'LEGO Cuộc đua truy bắt cướp City 60455', 309000, NULL, 'https://www.mykingdom.com.vn/cdn/shop/files/do-choi-lap-rap-cuoc-dua-truy-bat-cuop-lego-city-60455_2.jpg?v=1747046598&width=1100', '4001', 1);
GO

-- XEM THÔNG TIN SẢN PHẨM VÀ TÌNH TRẠNG KHUYẾN MÃI
SELECT 
    p.product_id,
    p.name AS product_name,
    c.category_id,
    c.category_name,
    p.price1 AS price_original,
    p.price2 AS price_discounted,
    CASE 
        WHEN p.price2 IS NULL THEN N'❌ Chưa có giá giảm'
        WHEN p.price2 >= p.price1 THEN N'⚠️ Giá giảm không hợp lệ'
        ELSE N'✅ Đã có giảm giá'
    END AS discount_status
FROM product p
JOIN category c ON p.category_id = c.category_id
WHERE p.status = 1 AND c.status = 1
ORDER BY c.category_name, p.name;

SELECT 
  product_id,
  name AS product_name,
  price1,
  price2,
  CASE 
    WHEN price2 IS NULL THEN N'Không khuyến mãi'
    WHEN price2 >= price1 THEN N'Không hợp lệ'
    ELSE N'Đang khuyến mãi'
  END AS promo_status
FROM product
WHERE status = 1
ORDER BY promo_status DESC, name;

SELECT 
    p.product_id,
    p.name AS product_name,
    c.category_name,
    p.price1 AS original_price,
    p.price2 AS discounted_price,
    CASE 
        WHEN p.price2 IS NULL THEN N'❌ Không khuyến mãi'
        WHEN p.price2 >= p.price1 THEN N'⚠️ Giá khuyến mãi không hợp lệ'
        ELSE N'✅ Có khuyến mãi'
    END AS promo_status
FROM product p
LEFT JOIN category c ON p.category_id = c.category_id
WHERE p.status = 1
ORDER BY promo_status DESC, p.name;
