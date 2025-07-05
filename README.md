Toy_Store is a mini e-commerce web application for selling children's toys. The system supports user registration, product browsing, shopping cart, checkout, and a role-based admin dashboard for managing products, users, and orders.

The system is built with a **fullstack architecture** using ReactJS (Front-end), ASP.NET Core (Back-end), and SQL Server (Database).

---

##  Project Overview

The system supports:
-  Users: Register, login, manage cart, and place orders.
-  Admins: Manage products, orders, users, and promotions.

###  Project Documents

-  [Project Report (Google Drive)](https://drive.google.com/file/d/1bpE3fy2Fh4wzEoMXDAe_2M0LSuJs5WMe/view?usp=sharing)  
-  [Figma UI Design](https://www.figma.com/design/TSmxiPzNUSbEt82IpW4CmH/TOY-STORE-_-NH%C3%93M-3?node-id=37-16004&t=nwzXvvep5ppsbMsj-1)

---

##  Getting Started

###  System Requirements

- Node.js >= 14.x  
- .NET SDK >= 6.0  
- SQL Server >= 2017

---

###  Clone the Repository

```bash
git clone https://github.com/NgTruc07/Toy_Store.git
cd Toy_Store
```

> Default branch: `main`  
> After cloning, your project structure should look like:

```
Toy_Store/
├── front_end/
├── back_end/
├── SQL_script/
├── codeWeb.sln
└── README.md
```

---

###  Front-End Setup

```bash
cd front_end
npm install
npm start
```

Open your browser at: `http://localhost:3000`

---

###  Back-End Setup

```bash
cd back_end
dotnet restore
dotnet run
```

API will run at: `http://localhost:5166`

> Or open `codeWeb.sln` with Visual Studio and press `F5`.

---

###  Database Setup

Use SQL Server Management Studio (SSMS) to run the following scripts in order:

```sql
-- Step 1: Create database and tables
RUN_DTB.sql

-- Step 2: Insert sample data
data_script.sql

-- Step 3: Update schema (constraints, banners, etc.)
update.sql
```

---

##  Project Structure

```
Toy_Store/
├── front_end/            # ReactJS Frontend
├── back_end/             # ASP.NET Core Web API (.NET 6)
├── SQL_script/           # SQL Scripts
│   ├── RUN_DTB.sql
│   ├── data_script.sql
│   └── update.sql
├── codeWeb.sln           # Solution file
└── README.md             # Project guide
```

---

##  How to Use

### Login
#### Admin
- Mail: tranthib@email.com
- Pass: adminpass456
#### User
- Mail: user2@example.com
- Pass: pass2

### Users
- Register for an account
- Add products to cart and checkout
- View order history

### Admins
- Login to admin dashboard
- Manage products, orders, users, and promotions

---

---

##  Contact

Email: `ngtruc7104@gmail.com`
