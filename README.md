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
- Quản trị viên thêm, sửa, xóa sản phẩm, quản lý đơn hàngbash
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

