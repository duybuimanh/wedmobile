-- ============================================================
-- DATABASE SCHEMA CHO HỆ THỐNG BÁN ĐIỆN THOẠI VÀ LAPTOP
-- Database: wedmobile
-- Charset: utf8mb4
-- Collation: utf8mb4_unicode_ci
-- ============================================================

-- Tạo database (chạy lệnh này trước nếu chưa tạo database)
CREATE DATABASE IF NOT EXISTS wedmobile CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE wedmobile;

-- ============================================================
-- 1. BẢNG USERS (Người dùng)
-- ============================================================
CREATE TABLE IF NOT EXISTS `users` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `email_verified_at` TIMESTAMP NULL DEFAULT NULL,
  `password` VARCHAR(255) NOT NULL,
  `remember_token` VARCHAR(100) DEFAULT NULL,
  `role` VARCHAR(255) NOT NULL DEFAULT 'user' COMMENT 'admin hoặc user',
  `phone` VARCHAR(20) DEFAULT NULL,
  `address` TEXT DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 2. BẢNG PASSWORD_RESET_TOKENS (Token reset password)
-- ============================================================
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` VARCHAR(255) NOT NULL,
  `token` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 3. BẢNG SESSIONS (Phiên đăng nhập)
-- ============================================================
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` VARCHAR(255) NOT NULL,
  `user_id` BIGINT UNSIGNED DEFAULT NULL,
  `ip_address` VARCHAR(45) DEFAULT NULL,
  `user_agent` TEXT DEFAULT NULL,
  `payload` LONGTEXT NOT NULL,
  `last_activity` INT NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 4. BẢNG CATEGORIES (Danh mục sản phẩm)
-- ============================================================
CREATE TABLE IF NOT EXISTS `categories` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL COMMENT 'Tên danh mục',
  `slug` VARCHAR(255) NOT NULL COMMENT 'URL thân thiện',
  `description` TEXT DEFAULT NULL COMMENT 'Mô tả danh mục',
  `image` VARCHAR(255) DEFAULT NULL COMMENT 'Ảnh danh mục',
  `status` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '1: Kích hoạt, 0: Vô hiệu',
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 5. BẢNG PRODUCTS (Sản phẩm)
-- ============================================================
CREATE TABLE IF NOT EXISTS `products` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_id` BIGINT UNSIGNED NOT NULL,
  `name` VARCHAR(255) NOT NULL COMMENT 'Tên sản phẩm',
  `slug` VARCHAR(255) NOT NULL COMMENT 'URL thân thiện',
  `description` TEXT DEFAULT NULL COMMENT 'Mô tả sản phẩm',
  `specifications` JSON DEFAULT NULL COMMENT 'Thông số kỹ thuật (JSON)',
  `price` DECIMAL(10,2) NOT NULL COMMENT 'Giá gốc',
  `sale_price` DECIMAL(10,2) DEFAULT NULL COMMENT 'Giá khuyến mãi',
  `quantity` INT NOT NULL DEFAULT 0 COMMENT 'Số lượng tồn kho',
  `image` VARCHAR(255) DEFAULT NULL COMMENT 'Ảnh chính',
  `images` JSON DEFAULT NULL COMMENT 'Nhiều ảnh sản phẩm (JSON)',
  `brand` VARCHAR(255) DEFAULT NULL COMMENT 'Thương hiệu',
  `sku` VARCHAR(255) DEFAULT NULL COMMENT 'Mã SKU',
  `status` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '1: Kích hoạt, 0: Vô hiệu',
  `featured` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '1: Sản phẩm nổi bật, 0: Không',
  `views` INT NOT NULL DEFAULT 0 COMMENT 'Số lượt xem',
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `products_slug_unique` (`slug`),
  UNIQUE KEY `products_sku_unique` (`sku`),
  KEY `products_category_id_foreign` (`category_id`),
  CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 6. BẢNG CARTS (Giỏ hàng)
-- ============================================================
CREATE TABLE IF NOT EXISTS `carts` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `product_id` BIGINT UNSIGNED NOT NULL,
  `quantity` INT NOT NULL COMMENT 'Số lượng sản phẩm',
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `carts_user_id_product_id_unique` (`user_id`, `product_id`),
  KEY `carts_product_id_foreign` (`product_id`),
  CONSTRAINT `carts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `carts_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 7. BẢNG ORDERS (Đơn hàng)
-- ============================================================
CREATE TABLE IF NOT EXISTS `orders` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_number` VARCHAR(255) NOT NULL COMMENT 'Mã đơn hàng',
  `user_id` BIGINT UNSIGNED NOT NULL,
  `customer_name` VARCHAR(255) NOT NULL COMMENT 'Tên khách hàng',
  `customer_email` VARCHAR(255) NOT NULL COMMENT 'Email khách hàng',
  `customer_phone` VARCHAR(20) NOT NULL COMMENT 'Số điện thoại',
  `shipping_address` TEXT NOT NULL COMMENT 'Địa chỉ giao hàng',
  `billing_address` TEXT DEFAULT NULL COMMENT 'Địa chỉ thanh toán',
  `subtotal` DECIMAL(10,2) NOT NULL COMMENT 'Tạm tính',
  `tax` DECIMAL(10,2) NOT NULL DEFAULT 0.00 COMMENT 'Thuế',
  `shipping_cost` DECIMAL(10,2) NOT NULL DEFAULT 0.00 COMMENT 'Phí vận chuyển',
  `total` DECIMAL(10,2) NOT NULL COMMENT 'Tổng tiền',
  `status` ENUM('pending', 'processing', 'shipped', 'delivered', 'cancelled') NOT NULL DEFAULT 'pending' COMMENT 'Trạng thái đơn hàng',
  `payment_status` ENUM('pending', 'paid', 'failed') NOT NULL DEFAULT 'pending' COMMENT 'Trạng thái thanh toán',
  `payment_method` ENUM('cod', 'bank_transfer', 'credit_card') NOT NULL DEFAULT 'cod' COMMENT 'Phương thức thanh toán',
  `notes` TEXT DEFAULT NULL COMMENT 'Ghi chú',
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orders_order_number_unique` (`order_number`),
  KEY `orders_user_id_foreign` (`user_id`),
  CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 8. BẢNG ORDER_ITEMS (Chi tiết đơn hàng)
-- ============================================================
CREATE TABLE IF NOT EXISTS `order_items` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` BIGINT UNSIGNED NOT NULL,
  `product_id` BIGINT UNSIGNED NOT NULL,
  `product_name` VARCHAR(255) NOT NULL COMMENT 'Tên sản phẩm (lưu lại để tránh mất dữ liệu nếu sản phẩm bị xóa)',
  `price` DECIMAL(10,2) NOT NULL COMMENT 'Giá tại thời điểm đặt hàng',
  `quantity` INT NOT NULL COMMENT 'Số lượng',
  `subtotal` DECIMAL(10,2) NOT NULL COMMENT 'Thành tiền',
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_items_order_id_foreign` (`order_id`),
  KEY `order_items_product_id_foreign` (`product_id`),
  CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 9. BẢNG CACHE (Cache)
-- ============================================================
CREATE TABLE IF NOT EXISTS `cache` (
  `key` VARCHAR(255) NOT NULL,
  `value` MEDIUMTEXT NOT NULL,
  `expiration` INT NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` VARCHAR(255) NOT NULL,
  `owner` VARCHAR(255) NOT NULL,
  `expiration` INT NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 10. BẢNG JOBS (Jobs Queue)
-- ============================================================
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` VARCHAR(255) NOT NULL,
  `payload` LONGTEXT NOT NULL,
  `attempts` TINYINT UNSIGNED NOT NULL,
  `reserved_at` INT UNSIGNED DEFAULT NULL,
  `available_at` INT UNSIGNED NOT NULL,
  `created_at` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` VARCHAR(255) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `total_jobs` INT NOT NULL,
  `pending_jobs` INT NOT NULL,
  `failed_jobs` INT NOT NULL,
  `failed_job_ids` LONGTEXT NOT NULL,
  `options` MEDIUMTEXT DEFAULT NULL,
  `cancelled_at` INT DEFAULT NULL,
  `created_at` INT NOT NULL,
  `finished_at` INT DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` VARCHAR(255) NOT NULL,
  `connection` TEXT NOT NULL,
  `queue` TEXT NOT NULL,
  `payload` LONGTEXT NOT NULL,
  `exception` LONGTEXT NOT NULL,
  `failed_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 11. BẢNG MIGRATIONS (Quản lý migrations)
-- ============================================================
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` VARCHAR(255) NOT NULL,
  `batch` INT NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- END OF SCHEMA
-- ============================================================


