# Hướng dẫn sử dụng Database Schema

## File SQL đã tạo

1. **database_schema.sql** - File SQL đầy đủ để tạo tất cả các bảng
2. **database_schema_detailed.md** - Tài liệu mô tả chi tiết từng bảng

## Cách import Database

### Cách 1: Sử dụng phpMyAdmin (Khuyến nghị)

1. Mở phpMyAdmin: http://localhost/phpmyadmin
2. Tạo database mới (nếu chưa có):
   - Click "New" hoặc "Mới"
   - Tên: `wedmobile`
   - Collation: `utf8mb4_unicode_ci`
   - Click "Create"
3. Chọn database `wedmobile` ở sidebar trái
4. Click tab "SQL"
5. Mở file `database_schema.sql` và copy toàn bộ nội dung
6. Paste vào khung SQL trong phpMyAdmin
7. Click "Go" hoặc "Thực thi"
8. Kiểm tra: Bạn sẽ thấy tất cả các bảng được tạo

### Cách 2: Sử dụng MySQL Command Line

```bash
# Tạo database
mysql -u root -e "CREATE DATABASE wedmobile CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

# Import schema
mysql -u root wedmobile < database_schema.sql
```

Hoặc:

```bash
# Kết nối MySQL
mysql -u root -p

# Trong MySQL console
CREATE DATABASE IF NOT EXISTS wedmobile CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE wedmobile;
SOURCE database_schema.sql;
```

### Cách 3: Sử dụng Laravel Migrations (Tốt nhất)

Nếu bạn đang sử dụng Laravel, nên dùng migrations thay vì import SQL trực tiếp:

```bash
# Đảm bảo .env đã cấu hình MySQL
DB_CONNECTION=mysql
DB_DATABASE=wedmobile
DB_USERNAME=root
DB_PASSWORD=

# Chạy migrations
php artisan migrate

# Tạo admin user
php artisan db:seed --class=AdminUserSeeder
```

## Kiểm tra sau khi import

### Kiểm tra các bảng đã tạo:

```sql
SHOW TABLES;
```

Bạn sẽ thấy các bảng:
- users
- categories
- products
- carts
- orders
- order_items
- password_reset_tokens
- sessions
- cache
- cache_locks
- jobs
- job_batches
- failed_jobs
- migrations

### Kiểm tra cấu trúc một bảng:

```sql
DESCRIBE products;
-- hoặc
SHOW COLUMNS FROM products;
```

### Kiểm tra Foreign Keys:

```sql
SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE
    TABLE_SCHEMA = 'wedmobile'
    AND REFERENCED_TABLE_NAME IS NOT NULL;
```

## Xóa và tạo lại database

Nếu muốn xóa và tạo lại database:

```sql
DROP DATABASE IF EXISTS wedmobile;
CREATE DATABASE wedmobile CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE wedmobile;
-- Sau đó import lại file database_schema.sql
```

Hoặc với Laravel:

```bash
php artisan migrate:fresh
php artisan db:seed --class=AdminUserSeeder
```

## Lưu ý quan trọng

1. **Backup trước khi import**: Nếu database đã có dữ liệu, hãy backup trước
2. **Charset/Collation**: Đảm bảo sử dụng `utf8mb4_unicode_ci` để hỗ trợ tiếng Việt và emoji
3. **Foreign Keys**: Tất cả foreign keys đều dùng CASCADE, khi xóa record cha sẽ xóa các record con
4. **Unique Constraints**: 
   - Mỗi user chỉ có 1 record giỏ hàng cho mỗi sản phẩm
   - Email, slug, SKU phải unique

## Tài khoản Admin mặc định

Sau khi chạy seeder, tài khoản admin:
- Email: admin@example.com
- Password: password
- Role: admin

**⚠️ Lưu ý**: Hãy đổi mật khẩu ngay sau khi đăng nhập!


