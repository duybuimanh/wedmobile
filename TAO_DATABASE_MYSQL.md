# Hướng dẫn tạo Database MySQL

## ⚠️ QUAN TRỌNG: Bạn cần tạo database trước khi chạy migrations!

File `.env` đã được cấu hình với MySQL:
- DB_CONNECTION=mysql
- DB_HOST=127.0.0.1
- DB_PORT=3306
- DB_DATABASE=wedmobile
- DB_USERNAME=root
- DB_PASSWORD= (để trống)

## Cách 1: Tạo Database bằng phpMyAdmin (Khuyến nghị)

1. **Mở phpMyAdmin:**
   - Truy cập: http://localhost/phpmyadmin
   - Đăng nhập với username: `root` (password để trống nếu không có)

2. **Tạo database mới:**
   - Click vào tab "New" hoặc "Mới" ở sidebar trái
   - Trong phần "Database name", nhập: `wedmobile`
   - Chọn Collation: `utf8mb4_unicode_ci`
   - Click nút "Create" hoặc "Tạo"

3. **Kiểm tra:**
   - Bạn sẽ thấy database `wedmobile` xuất hiện ở sidebar trái

## Cách 2: Tạo Database bằng MySQL Command Line

1. **Mở Command Prompt/Terminal**

2. **Kết nối MySQL:**
   ```bash
   mysql -u root -p
   ```
   (Nhấn Enter nếu không có mật khẩu)

3. **Tạo database:**
   ```sql
   CREATE DATABASE wedmobile CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   ```

4. **Kiểm tra:**
   ```sql
   SHOW DATABASES;
   ```
   (Bạn sẽ thấy `wedmobile` trong danh sách)

5. **Thoát:**
   ```sql
   EXIT;
   ```

## Cách 3: Sử dụng file SQL có sẵn

1. Mở phpMyAdmin
2. Click vào tab "SQL"
3. Copy nội dung file `create-database.sql` và paste vào
4. Click "Go" hoặc "Thực thi"

## Sau khi tạo database xong:

Chạy các lệnh sau trong thư mục dự án:

```bash
# Chạy migrations để tạo các bảng
php artisan migrate

# Tạo tài khoản admin
php artisan db:seed --class=AdminUserSeeder
```

## Kiểm tra kết nối:

```bash
php artisan tinker
```

Trong tinker:
```php
DB::connection()->getPdo();
```

Nếu không có lỗi → Kết nối thành công! ✅


