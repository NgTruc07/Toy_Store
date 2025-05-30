USE web_code;
GO

-- ✅ Kiểm tra các sản phẩm trong chương trình khuyến mãi
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


SELECT * FROM promotion_product


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
WHERE product_id IN ('prd01', 'prd02', 'prd03'); -- thêm các product_id phù hợp
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
WHERE product_id = 'prd01'; -- thay bằng đúng ID sản phẩm

-- Sản phẩm 2: Xe đạp trẻ em Fisher-Price 16 inch
UPDATE product
SET price2 = 2850000
WHERE product_id = 'prd02';

-- Sản phẩm 3: Robot Transformer Optimus Prime (không có giảm giá → cập nhật để có)
UPDATE product
SET price2 = 1690000
WHERE product_id = 'prd03';
GO

-- ✅ Kiểm tra lại các sản phẩm đã có giá giảm
SELECT product_id, name, price1 AS GiaGoc, price2 AS GiaGiam
FROM product
WHERE price2 IS NOT NULL;
