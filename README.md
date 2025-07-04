#  Web Code - Hệ Thống Bán Đồ Chơi Trực Tuyến

Dự án **Web Code** là một nền tảng thương mại điện tử mini chuyên bán các sản phẩm đồ chơi dành cho trẻ em. Hệ thống được xây dựng với kiến trúc **fullstack** gồm front-end React, back-end ASP.NET Core và cơ sở dữ liệu SQL Server.

---

## Giới Thiệu

Hệ thống cho phép:
- Người dùng đăng ký, đăng nhập, quản lý giỏ hàng, đặt hàng.
- Quản trị viên thêm, sửa, xóa sản phẩm, quản lý đơn hàng, người dùng và chương trình khuyến mãi.

###  Tài Liệu Dự Án

-  [Report Đồ Án (https://drive.google.com/file/d/1bpE3fy2Fh4wzEoMXDAe_2M0LSuJs5WMe/view?usp=sharing)](#)
-  [Thiết Kế Giao Diện Figma (https://www.figma.com/design/TSmxiPzNUSbEt82IpW4CmH/TOY-STORE-_-NH%C3%93M-3?node-id=37-16004&t=nwzXvvep5ppsbMsj-1)](#)

---

##  Cài Đặt

###  Yêu Cầu Hệ Thống

- Node.js >= 14.x
- .NET SDK >= 6.0
- SQL Server >= 2017

###  Cài Đặt Front-End

```bash
cd front_end
npm install
npm start
```
Truy cập tại: `http://localhost:3000`

###  Cài Đặt Back-End

```bash
cd back_end
dotnet restore
dotnet run
```
API khởi chạy tại: `http://localhost:5166`

> Hoặc mở `codeWeb.sln` trong Visual Studio và nhấn `F5`

###  Cài Đặt Cơ Sở Dữ Liệu

```sql
-- Bước 1: Tạo Database & Bảng
RUN_DTB.sql

-- Bước 2: Thêm dữ liệu mẫu
data_script.sql

-- Bước 3: Cập nhật schema nếu cần
update.sql
```

---

##  Cấu Trúc Dự Án

```
 web_code/
├── front_end/            # Giao diện người dùng ReactJS
├── back_end/             # ASP.NET Core Web API (.NET 6)
├── SQL_SCRIPT/           # Tập hợp các script SQL
│   ├── RUN_DTB.sql       # Tạo database & bảng
│   ├── data_script.sql   # Dữ liệu mẫu
│   └── update.sql        # Cập nhật schema & ràng buộc
└── README.md             # Tài liệu hướng dẫn
```

---

##  Cách Sử Dụng

###  Người Dùng
- Đăng ký tài khoản
- Thêm sản phẩm vào giỏ và mua hàng
- Thanh toán đơn hàng

###  Quản Trị Viên
- Đăng nhập trang admin
- Quản lý sản phẩm, đơn hàng, người dùng, chương trình khuyến mãi

---

##  API Endpoint (http://localhost:5166)

## 📬 Liên Hệ

 Email: `ngtruc7104@gmail.com`  





