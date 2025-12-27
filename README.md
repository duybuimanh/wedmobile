# Website Bán Điện Thoại và Laptop - Laravel E-commerce System

Hệ thống website thương mại điện tử bán điện thoại di động và laptop được xây dựng bằng Laravel với đầy đủ chức năng cho cả admin và người dùng.

## Tính năng chính

### Cho người dùng:
- ✅ Đăng ký/Đăng nhập
- ✅ Xem danh sách sản phẩm (điện thoại, laptop)
- ✅ Tìm kiếm và lọc sản phẩm
- ✅ Xem chi tiết sản phẩm
- ✅ Thêm sản phẩm vào giỏ hàng
- ✅ Quản lý giỏ hàng (cập nhật số lượng, xóa sản phẩm)
- ✅ Đặt hàng và thanh toán
- ✅ Xem lịch sử đơn hàng
- ✅ Xem chi tiết đơn hàng

### Cho Admin:
- ✅ Dashboard với thống kê tổng quan
- ✅ Quản lý danh mục sản phẩm (CRUD)
- ✅ Quản lý sản phẩm (CRUD)
- ✅ Quản lý đơn hàng (xem danh sách, chi tiết, cập nhật trạng thái)
- ✅ Quản lý người dùng (xem danh sách, chi tiết, cập nhật vai trò)

## Yêu cầu hệ thống

- PHP >= 8.2
- Composer
- MySQL/PostgreSQL/SQLite
- Node.js & NPM (cho frontend assets)

## Cài đặt

1. **Clone repository:**
```bash
git clone <repository-url>
cd wedmobile
```

2. **Cài đặt dependencies:**
```bash
composer install
npm install
```

3. **Cấu hình môi trường:**
```bash
cp .env.example .env
php artisan key:generate
```

4. **Cấu hình database trong file `.env`:**
```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=wedmobile
DB_USERNAME=root
DB_PASSWORD=
```

5. **Chạy migrations:**
```bash
php artisan migrate
```

6. **Tạo admin user:**
```bash
php artisan db:seed --class=AdminUserSeeder
```

7. **Tạo symbolic link cho storage:**
```bash
php artisan storage:link
```

8. **Build assets:**
```bash
npm run build
```

9. **Khởi động server:**
```bash
php artisan serve
```

## Tài khoản mặc định

**Admin:**
- Email: admin@example.com
- Password: password

## Cấu trúc Database

- **users**: Thông tin người dùng (user/admin)
- **categories**: Danh mục sản phẩm
- **products**: Sản phẩm
- **carts**: Giỏ hàng
- **orders**: Đơn hàng
- **order_items**: Chi tiết đơn hàng

## Cấu trúc thư mục

```
app/
├── Http/
│   ├── Controllers/
│   │   ├── Admin/          # Admin controllers
│   │   ├── Auth/           # Authentication controllers
│   │   ├── CartController.php
│   │   ├── HomeController.php
│   │   ├── OrderController.php
│   │   └── ProductController.php
│   └── Middleware/
│       └── AdminMiddleware.php
├── Models/
│   ├── Cart.php
│   ├── Category.php
│   ├── Order.php
│   ├── OrderItem.php
│   ├── Product.php
│   └── User.php
database/
├── migrations/             # Database migrations
└── seeders/               # Database seeders
resources/
└── views/
    ├── admin/             # Admin views
    ├── auth/              # Authentication views
    ├── cart/              # Cart views
    ├── layouts/           # Layout templates
    ├── orders/            # Order views
    ├── products/          # Product views
    └── home.blade.php
routes/
└── web.php                # Web routes
```

## Routes chính

### User Routes:
- `/` - Trang chủ
- `/products` - Danh sách sản phẩm
- `/products/{slug}` - Chi tiết sản phẩm
- `/cart` - Giỏ hàng
- `/orders` - Đơn hàng
- `/orders/checkout` - Thanh toán

### Admin Routes (yêu cầu đăng nhập với role admin):
- `/admin/dashboard` - Dashboard
- `/admin/categories` - Quản lý danh mục
- `/admin/products` - Quản lý sản phẩm
- `/admin/orders` - Quản lý đơn hàng
- `/admin/users` - Quản lý người dùng

## Công nghệ sử dụng

- **Backend**: Laravel 11
- **Frontend**: Blade Templates, Tailwind CSS
- **Database**: MySQL/SQLite
- **Authentication**: Laravel Breeze

## Phát triển thêm

Để phát triển thêm tính năng:

1. Thêm migrations cho các bảng mới
2. Tạo Models và Relationships
3. Tạo Controllers và Views
4. Thêm Routes
5. Cập nhật Middleware nếu cần

## License

MIT License

## Tác giả

Được xây dựng với Laravel Framework
