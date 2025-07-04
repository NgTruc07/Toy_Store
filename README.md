# Web Code - Hệ Thống Bán Đồ Chơi Trực Tuyến

Dự án **Web Code** là một nền tảng thương mại điện tử mini chuyên bán các sản phẩm đồ chơi dành cho trẻ em. Hệ thống được xây dựng với kiến trúc **fullstack** gồm front-end React, back-end ASP.NET Core và cơ sở dữ liệu SQL Server.

---

## 🧾 Mục Lục

- [📌 Giới Thiệu](#-giới-thiệu)
- [⚙️ Cài Đặt](#️-cài-đặt)
- [📁 Cấu Trúc Dự Án](#-cấu-trúc-dự-án)
- [🚀 Cách Sử Dụng](#-cách-sử-dụng)
- [🧠 Stored Procedures & Scripts](#-stored-procedures--scripts)
- [📬 Liên Hệ](#-liên-hệ)

---

## 📌 Giới Thiệu

Hệ thống cho phép:
- Người dùng đăng ký, đăng nhập, quản lý giỏ hàng, đặt hàng.
- Quản trị viên thêm, sửa, xóa sản phẩm, quản lý đơn hàng, người dùng và chương trình khuyến mãi.
- Giao diện đơn giản, dễ dùng, phù hợp với người dùng cuối và quản trị viên.

---

## ⚙️ Cài Đặt

### 🛠 Yêu Cầu Hệ Thống

- Node.js >= 14.x
- .NET SDK >= 6.0
- SQL Server >= 2017

---

### 🧩 Cài Đặt Front-End

```bash
cd front_end
npm install
npm start
Truy cập tại: http://localhost:3000

🔧 Cài Đặt Back-End
bash
Sao chép
Chỉnh sửa
cd back_end
dotnet restore
dotnet run
API khởi chạy tại: http://localhost:5166

Lưu ý: Nếu cần build bằng Visual Studio, mở file codeWeb.sln và nhấn F5.

🗃️ Cài Đặt Cơ Sở Dữ Liệu
Tạo Database & Table:

Chạy RUN_DTB.sql trên SQL Server Management Studio.

Thêm Dữ Liệu Mẫu:

Chạy data_script.sql để thêm người dùng, sản phẩm, danh mục, khuyến mãi.

Cập Nhật Schema (nếu có):

Chạy update.sql để cập nhật thêm cột, khóa ngoại, banner,...

📁 Cấu Trúc Dự Án
bash
Sao chép
Chỉnh sửa
📦 web_code/
├── 📁 front_end/         # ReactJS giao diện người dùng
├── 📁 back_end/          # ASP.NET Core Web API
├── 📄 RUN_DTB.sql        # Tạo database và bảng
├── 📄 data_script.sql    # Dữ liệu mẫu
├── 📄 update.sql         # Cập nhật schema
└── 📄 README.md          # Tài liệu dự án
🚀 Cách Sử Dụng
🧑‍💻 Người Dùng
Đăng ký tài khoản

Duyệt và thêm sản phẩm vào giỏ

Thanh toán đơn hàng

👨‍💼 Quản Trị Viên
Đăng nhập admin

Quản lý sản phẩm, đơn hàng, người dùng

Thêm chương trình khuyến mãi

🌐 API Endpoint (http://localhost:5166)
Phương thức	Đường dẫn	Mô tả
GET	/api/products	Lấy danh sách sản phẩm
POST	/api/register	Đăng ký tài khoản người dùng
POST	/api/login	Đăng nhập và nhận token
GET	/api/cart/:user_id	Lấy giỏ hàng của người dùng
POST	/api/cart/add	Thêm sản phẩm vào giỏ hàng
POST	/api/orders	Tạo đơn hàng mới
GET	/api/orders/:buyer_id	Lấy đơn hàng theo người mua
DELETE	/api/cart/remove	Xoá sản phẩm khỏi giỏ hàng

🧠 Stored Procedures & Scripts
📌 Giỏ Hàng
sql
Sao chép
Chỉnh sửa
CREATE PROCEDURE sp_DeleteCartItem
@user_id INT,
@product_id VARCHAR(25)
AS
BEGIN
    DELETE FROM cart
    WHERE user_id = @user_id AND product_id = @product_id;
END
📌 Đơn Hàng
sql
Sao chép
Chỉnh sửa
CREATE PROCEDURE sp_get_orders_by_buyer
@buyer_id INT
AS
BEGIN
    SELECT * Fcom
