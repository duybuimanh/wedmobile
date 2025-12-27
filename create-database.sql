-- Script tạo database cho dự án wedmobile
-- Chạy file này trong phpMyAdmin hoặc MySQL Command Line

-- Tạo database
CREATE DATABASE IF NOT EXISTS wedmobile CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Sử dụng database
USE wedmobile;

-- Hiển thị thông báo
SELECT 'Database wedmobile đã được tạo thành công!' AS Message;


