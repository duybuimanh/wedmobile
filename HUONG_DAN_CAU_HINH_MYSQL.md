# Hướng dẫn cấu hình MySQL cho dự án

## Bước 1: Tạo Database MySQL

1. Mở phpMyAdmin hoặc MySQL Command Line
2. Tạo database mới:
```sql
CREATE DATABASE wedmobile CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

Hoặc sử dụng phpMyAdmin:
- Vào phpMyAdmin (http://localhost/phpmyadmin)
- Click "New" hoặc "Mới"
- Tên database: `wedmobile`
- Chọn collation: `utf8mb4_unicode_ci`
- Click "Create" hoặc "Tạo"

## Bước 2: Cấu hình file .env

Mở file `.env` trong thư mục gốc dự án và cập nhật các thông tin sau:

```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=wedmobile
DB_USERNAME=root
DB_PASSWORD=
```

**Lưu ý:**
- `DB_DATABASE`: Tên database bạn vừa tạo (ví dụ: `wedmobile`)
- `DB_USERNAME`: Tên người dùng MySQL (thường là `root` cho XAMPP)
- `DB_PASSWORD`: Mật khẩu MySQL (để trống nếu không có mật khẩu)

## Bước 3: Chạy migrations

Sau khi cấu hình xong, chạy lệnh sau để tạo các bảng:

```bash
php artisan migrate
```

## Bước 4: Tạo tài khoản admin

```bash
php artisan db:seed --class=AdminUserSeeder
```

## Kiểm tra kết nối

Để kiểm tra kết nối database có thành công không:

```bash
php artisan tinker
```

Sau đó trong tinker, chạy:
```php
DB::connection()->getPdo();
```

Nếu không có lỗi, kết nối đã thành công!

## Troubleshooting

### Lỗi: SQLSTATE[HY000] [1045] Access denied
- Kiểm tra lại `DB_USERNAME` và `DB_PASSWORD` trong file `.env`
- Đảm bảo user MySQL có quyền truy cập database

### Lỗi: SQLSTATE[HY000] [2002] No connection could be made
- Kiểm tra MySQL đã chạy chưa
- Kiểm tra `DB_HOST` và `DB_PORT` có đúng không
- Với XAMPP, đảm bảo MySQL service đang chạy

### Lỗi: SQLSTATE[42000] [1049] Unknown database
- Đảm bảo đã tạo database `wedmobile`
- Kiểm tra tên database trong `.env` có đúng không


