-- ฐานข้อมูลสำหรับเว็บการงานงาน (MySQL / MariaDB สำหรับ Laragon)
CREATE DATABASE IF NOT EXISTS kannganngan
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE kannganngan;

CREATE TABLE IF NOT EXISTS accounts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  display_name VARCHAR(100) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_accounts_display_name (display_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS tasks (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  description TEXT NULL,
  task_type ENUM('once', 'daily') NOT NULL DEFAULT 'once',
  account_id INT UNSIGNED NOT NULL,
  is_done TINYINT(1) NOT NULL DEFAULT 0,
  completed_at DATETIME NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_tasks_account_id (account_id),
  KEY idx_tasks_status (is_done),
  KEY idx_tasks_type (task_type),
  CONSTRAINT fk_tasks_account
    FOREIGN KEY (account_id) REFERENCES accounts(id)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO accounts (display_name)
VALUES ('แก้ว'), ('อุ้ย')
ON DUPLICATE KEY UPDATE display_name = VALUES(display_name);

-- ข้อมูลตัวอย่าง (เพิ่มเฉพาะเมื่อยังไม่มีงานชื่อเดียวกัน)
INSERT INTO tasks (name, description, task_type, account_id)
SELECT 'เช็กอีเมลและข้อความ', 'ตรวจสอบข้อความสำคัญประจำวัน', 'daily', id
FROM accounts WHERE display_name = 'แก้ว'
AND NOT EXISTS (SELECT 1 FROM tasks WHERE name = 'เช็กอีเมลและข้อความ');
