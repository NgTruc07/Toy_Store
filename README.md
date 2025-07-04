# Web Code - Hệ Thống Bán Đồ Chơi Trực Tuyến

Dự án **Web Code** là một nền tảng thương mại điện tử mini chuyên bán các sản phẩm đồ chơi dành cho trẻ em. Hệ thống được xây dựng với kiến trúc **fullstack** gồm front-end React, back-end ASP.NET Core và cơ sở dữ liệu SQL Server.

---

## Mục Lục

- [ Giới Thiệu](#-giới-thiệu)
- [ Cài Đặt](#️-cài-đặt)
- [ Cấu Trúc Dự Án](#-cấu-trúc-dự-án)
- [ Cách Sử Dụng](#-cách-sử-dụng)
- [ Stored Procedures & Scripts](#-stored-procedures--scripts)
- [ Liên Hệ](#-liên-hệ)

---

## Giới Thiệu

Hệ thống cho phép:
- Người dùng đăng ký, đăng nhập, quản lý giỏ hàng, đặt hàng.
- Quản trị viên thêm, sửa, xóa sản phẩm, quản lý đơn hàng, người dùng và chương trình khuyến mãi.
- Giao diện đơn giản, dễ dùng, phù hợp với người dùng cuối và quản trị viên.

###  Tài Liệu Dự Án

-  [Report Đồ Án (DOCX)](https://drive.google.com/file/d/1bpE3fy2Fh4wzEoMXDAe_2M0LSuJs5WMe/view?usp=sharing)
-  [Thiết Kế Giao Diện Figma](https://www.figma.com/design/TSmxiPzNUSbEt82IpW4CmH/TOY-STORE-_-NH%C3%93M-3?node-id=37-16004&t=nwzXvvep5ppsbMsj-1)
  
---

## Cài Đặt

### Yêu Cầu Hệ Thống

- Node.js >= 14.x
- .NET SDK >= 6.0
- SQL Server >= 2017

---

### Cài Đặt Front-End

```bash
cd front_end
npm install
npm start
Truy cập tại: http://localhost:3000

Cài Đặt Back-End
bash
Sao chép
Chỉnh sửa
cd back_end
dotnet restore
dotnet run
API khởi chạy tại: http://localhost:5166

Lưu ý: Nếu cần build bằng Visual Studio, mở file codeWeb.sln và nhấn F5.

Cài Đặt Cơ Sở Dữ Liệu
Tạo Database & Table:

Chạy RUN_DTB.sql trên SQL Server Management Studio.

Thêm Dữ Liệu Mẫu:

Chạy data_script.sql để thêm người dùng, sản phẩm, danh mục, khuyến mãi.

Cập Nhật Schema (nếu có):

Chạy update.sql để cập nhật thêm cột, khóa ngoại, banner,...

Cấu Trúc Dự Án
bash
Sao chép
Chỉnh sửa
web_code/
├── front_end/            # Giao diện người dùng ReactJS
├── back_end/             # ASP.NET Core Web API (.NET 6)
├── SQL_SCRIPT/           # Tập hợp các script SQL
│   ├── RUN_DTB.sql       # Tạo database & bảng
│   ├── data_script.sql   # Dữ liệu mẫu
│   └── update.sql        # Cập nhật schema & ràng buộc
└── README.md             # Tài liệu hướng dẫn
Cách Sử Dụng
Người Dùng
Đăng ký tài khoản

Thêm sản phẩm vào giỏ và mua hànghàng

Thanh toán đơn hàng

Quản Trị Viên
Đăng nhập admin

Quản lý sản phẩm, đơn hàng, người dùng

Quản lý người dùng

API Endpoint (http://localhost:5166)
Phương thức	Đường dẫn	Mô tả
GET	/api/products	Lấy danh sách sản phẩm
POST	/api/register	Đăng ký tài khoản người dùng
POST	/api/login	Đăng nhập và nhận token
GET	/api/cart/:user_id	Lấy giỏ hàng của người dùng
POST	/api/cart/add	Thêm sản phẩm vào giỏ hàng
POST	/api/orders	Tạo đơn hàng mới
GET	/api/orders/:buyer_id	Lấy đơn hàng theo người mua
DELETE	/api/cart/remove	Xoá sản phẩm khỏi giỏ hàng

