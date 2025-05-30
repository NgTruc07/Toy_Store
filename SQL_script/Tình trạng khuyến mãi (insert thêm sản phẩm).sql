USE web_code;
GO

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

-------------------------------------------------------------------------------------------
-- XEM THÔNG TIN CÁC SẢN PHẨM VÀ TÌNH TRẠNG ÁP DỤNG KHUYẾN MÃI
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
