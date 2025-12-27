# Cấu trúc Database - Hệ thống Bán Điện thoại và Laptop

## Tổng quan

Database: **wedmobile**
- Charset: utf8mb4
- Collation: utf8mb4_unicode_ci
- Engine: InnoDB

---

## Các bảng trong hệ thống

### 1. **users** - Bảng người dùng

Lưu trữ thông tin người dùng và admin

| Cột | Kiểu dữ liệu | Mô tả |
|-----|-------------|-------|
| id | BIGINT UNSIGNED | ID chính (Primary Key, Auto Increment) |
| name | VARCHAR(255) | Họ tên |
| email | VARCHAR(255) | Email (Unique) |
| email_verified_at | TIMESTAMP | Ngày xác thực email |
| password | VARCHAR(255) | Mật khẩu (đã hash) |
| remember_token | VARCHAR(100) | Token ghi nhớ đăng nhập |
| role | VARCHAR(255) | Vai trò: 'admin' hoặc 'user' (default: 'user') |
| phone | VARCHAR(20) | Số điện thoại |
| address | TEXT | Địa chỉ |
| created_at | TIMESTAMP | Ngày tạo |
| updated_at | TIMESTAMP | Ngày cập nhật |

**Relationships:**
- hasMany: orders, cartItems

---

### 2. **categories** - Bảng danh mục sản phẩm

Lưu trữ các danh mục sản phẩm (Điện thoại, Laptop, ...)

| Cột | Kiểu dữ liệu | Mô tả |
|-----|-------------|-------|
| id | BIGINT UNSIGNED | ID chính |
| name | VARCHAR(255) | Tên danh mục |
| slug | VARCHAR(255) | URL thân thiện (Unique) |
| description | TEXT | Mô tả danh mục |
| image | VARCHAR(255) | Đường dẫn ảnh danh mục |
| status | TINYINT(1) | 1: Kích hoạt, 0: Vô hiệu (default: 1) |
| created_at | TIMESTAMP | Ngày tạo |
| updated_at | TIMESTAMP | Ngày cập nhật |

**Relationships:**
- hasMany: products

---

### 3. **products** - Bảng sản phẩm

Lưu trữ thông tin sản phẩm (Điện thoại, Laptop)

| Cột | Kiểu dữ liệu | Mô tả |
|-----|-------------|-------|
| id | BIGINT UNSIGNED | ID chính |
| category_id | BIGINT UNSIGNED | ID danh mục (Foreign Key -> categories.id) |
| name | VARCHAR(255) | Tên sản phẩm |
| slug | VARCHAR(255) | URL thân thiện (Unique) |
| description | TEXT | Mô tả sản phẩm |
| specifications | JSON | Thông số kỹ thuật (JSON format) |
| price | DECIMAL(10,2) | Giá gốc |
| sale_price | DECIMAL(10,2) | Giá khuyến mãi |
| quantity | INT | Số lượng tồn kho (default: 0) |
| image | VARCHAR(255) | Đường dẫn ảnh chính |
| images | JSON | Nhiều ảnh sản phẩm (JSON array) |
| brand | VARCHAR(255) | Thương hiệu |
| sku | VARCHAR(255) | Mã SKU (Unique) |
| status | TINYINT(1) | 1: Kích hoạt, 0: Vô hiệu (default: 1) |
| featured | TINYINT(1) | 1: Sản phẩm nổi bật, 0: Không (default: 0) |
| views | INT | Số lượt xem (default: 0) |
| created_at | TIMESTAMP | Ngày tạo |
| updated_at | TIMESTAMP | Ngày cập nhật |

**Relationships:**
- belongsTo: category
- hasMany: cartItems, orderItems

**Foreign Keys:**
- category_id -> categories.id (ON DELETE CASCADE)

---

### 4. **carts** - Bảng giỏ hàng

Lưu trữ các sản phẩm trong giỏ hàng của người dùng

| Cột | Kiểu dữ liệu | Mô tả |
|-----|-------------|-------|
| id | BIGINT UNSIGNED | ID chính |
| user_id | BIGINT UNSIGNED | ID người dùng (Foreign Key -> users.id) |
| product_id | BIGINT UNSIGNED | ID sản phẩm (Foreign Key -> products.id) |
| quantity | INT | Số lượng sản phẩm |
| created_at | TIMESTAMP | Ngày tạo |
| updated_at | TIMESTAMP | Ngày cập nhật |

**Unique Constraint:**
- (user_id, product_id) - Mỗi user chỉ có 1 record cho mỗi sản phẩm

**Relationships:**
- belongsTo: user, product

**Foreign Keys:**
- user_id -> users.id (ON DELETE CASCADE)
- product_id -> products.id (ON DELETE CASCADE)

---

### 5. **orders** - Bảng đơn hàng

Lưu trữ thông tin đơn hàng

| Cột | Kiểu dữ liệu | Mô tả |
|-----|-------------|-------|
| id | BIGINT UNSIGNED | ID chính |
| order_number | VARCHAR(255) | Mã đơn hàng (Unique, tự động tạo) |
| user_id | BIGINT UNSIGNED | ID người dùng (Foreign Key -> users.id) |
| customer_name | VARCHAR(255) | Tên khách hàng |
| customer_email | VARCHAR(255) | Email khách hàng |
| customer_phone | VARCHAR(20) | Số điện thoại |
| shipping_address | TEXT | Địa chỉ giao hàng |
| billing_address | TEXT | Địa chỉ thanh toán |
| subtotal | DECIMAL(10,2) | Tạm tính |
| tax | DECIMAL(10,2) | Thuế (default: 0.00) |
| shipping_cost | DECIMAL(10,2) | Phí vận chuyển (default: 0.00) |
| total | DECIMAL(10,2) | Tổng tiền |
| status | ENUM | Trạng thái: 'pending', 'processing', 'shipped', 'delivered', 'cancelled' (default: 'pending') |
| payment_status | ENUM | Trạng thái thanh toán: 'pending', 'paid', 'failed' (default: 'pending') |
| payment_method | ENUM | Phương thức: 'cod', 'bank_transfer', 'credit_card' (default: 'cod') |
| notes | TEXT | Ghi chú |
| created_at | TIMESTAMP | Ngày tạo |
| updated_at | TIMESTAMP | Ngày cập nhật |

**Relationships:**
- belongsTo: user
- hasMany: orderItems

**Foreign Keys:**
- user_id -> users.id (ON DELETE CASCADE)

---

### 6. **order_items** - Bảng chi tiết đơn hàng

Lưu trữ chi tiết các sản phẩm trong đơn hàng

| Cột | Kiểu dữ liệu | Mô tả |
|-----|-------------|-------|
| id | BIGINT UNSIGNED | ID chính |
| order_id | BIGINT UNSIGNED | ID đơn hàng (Foreign Key -> orders.id) |
| product_id | BIGINT UNSIGNED | ID sản phẩm (Foreign Key -> products.id) |
| product_name | VARCHAR(255) | Tên sản phẩm (lưu lại để tránh mất dữ liệu) |
| price | DECIMAL(10,2) | Giá tại thời điểm đặt hàng |
| quantity | INT | Số lượng |
| subtotal | DECIMAL(10,2) | Thành tiền (price * quantity) |
| created_at | TIMESTAMP | Ngày tạo |
| updated_at | TIMESTAMP | Ngày cập nhật |

**Relationships:**
- belongsTo: order, product

**Foreign Keys:**
- order_id -> orders.id (ON DELETE CASCADE)
- product_id -> products.id (ON DELETE CASCADE)

---

### 7. **password_reset_tokens** - Bảng token reset password

| Cột | Kiểu dữ liệu | Mô tả |
|-----|-------------|-------|
| email | VARCHAR(255) | Email (Primary Key) |
| token | VARCHAR(255) | Token reset |
| created_at | TIMESTAMP | Ngày tạo |

---

### 8. **sessions** - Bảng phiên đăng nhập

| Cột | Kiểu dữ liệu | Mô tả |
|-----|-------------|-------|
| id | VARCHAR(255) | Session ID (Primary Key) |
| user_id | BIGINT UNSIGNED | ID người dùng |
| ip_address | VARCHAR(45) | Địa chỉ IP |
| user_agent | TEXT | User Agent |
| payload | LONGTEXT | Dữ liệu session |
| last_activity | INT | Thời gian hoạt động cuối |

---

### 9. **cache** - Bảng cache

| Cột | Kiểu dữ liệu | Mô tả |
|-----|-------------|-------|
| key | VARCHAR(255) | Cache key (Primary Key) |
| value | MEDIUMTEXT | Giá trị cache |
| expiration | INT | Thời gian hết hạn |

---

### 10. **jobs** - Bảng jobs queue

Lưu trữ các jobs trong queue

| Cột | Kiểu dữ liệu | Mô tả |
|-----|-------------|-------|
| id | BIGINT UNSIGNED | ID chính |
| queue | VARCHAR(255) | Tên queue |
| payload | LONGTEXT | Dữ liệu job |
| attempts | TINYINT UNSIGNED | Số lần thử |
| reserved_at | INT UNSIGNED | Thời gian reserve |
| available_at | INT UNSIGNED | Thời gian có sẵn |
| created_at | INT UNSIGNED | Ngày tạo |

---

## Sơ đồ quan hệ (ERD)

```
users (1) ──< (N) carts
users (1) ──< (N) orders

categories (1) ──< (N) products

products (1) ──< (N) carts
products (1) ──< (N) order_items

orders (1) ──< (N) order_items
```

---

## Indexes và Constraints

### Primary Keys
- Tất cả các bảng đều có `id` là Primary Key (Auto Increment)

### Unique Keys
- `users.email`
- `categories.slug`
- `products.slug`
- `products.sku`
- `orders.order_number`
- `carts(user_id, product_id)` - Composite unique

### Foreign Keys
- `products.category_id` -> `categories.id` (CASCADE)
- `carts.user_id` -> `users.id` (CASCADE)
- `carts.product_id` -> `products.id` (CASCADE)
- `orders.user_id` -> `users.id` (CASCADE)
- `order_items.order_id` -> `orders.id` (CASCADE)
- `order_items.product_id` -> `products.id` (CASCADE)

### Indexes
- `sessions.user_id`
- `sessions.last_activity`
- `products.category_id`
- `carts.user_id`
- `carts.product_id`
- `orders.user_id`
- `order_items.order_id`
- `order_items.product_id`

---

## Cách sử dụng

### Import vào MySQL:

1. **Sử dụng phpMyAdmin:**
   - Mở phpMyAdmin
   - Chọn database `wedmobile`
   - Click tab "SQL"
   - Copy nội dung file `database_schema.sql` và paste vào
   - Click "Go"

2. **Sử dụng Command Line:**
   ```bash
   mysql -u root -p wedmobile < database_schema.sql
   ```

3. **Sử dụng Laravel Migrations (Khuyến nghị):**
   ```bash
   php artisan migrate
   ```


