-- Database: laporpak_db
CREATE DATABASE IF NOT EXISTS laporpak_db;
USE laporpak_db;

-- Table: users
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    nik VARCHAR(16) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('user', 'admin') DEFAULT 'user',
    foto_profil VARCHAR(255) DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table: kategori
CREATE TABLE IF NOT EXISTS kategori (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama_kategori VARCHAR(100) NOT NULL,
    icon VARCHAR(50) DEFAULT 'fa-folder',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table: aduan
CREATE TABLE IF NOT EXISTS aduan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    kategori_id INT NOT NULL,
    judul VARCHAR(255) NOT NULL,
    isi TEXT NOT NULL,
    lokasi VARCHAR(255) DEFAULT NULL,
    foto VARCHAR(255) DEFAULT NULL,
    status ENUM('pending', 'proses', 'selesai', 'ditolak') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (kategori_id) REFERENCES kategori(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table: tanggapan
CREATE TABLE IF NOT EXISTS tanggapan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    aduan_id INT NOT NULL,
    admin_id INT NOT NULL,
    isi TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (aduan_id) REFERENCES aduan(id) ON DELETE CASCADE,
    FOREIGN KEY (admin_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table: logs
CREATE TABLE IF NOT EXISTS logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT DEFAULT NULL,
    aktivitas TEXT NOT NULL,
    ip_address VARCHAR(45) DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert default admin
INSERT INTO users (nama, nik, email, password, role) VALUES
('Administrator', '3578000000000001', 'admin@laporpak.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin');
-- Password: password

-- Insert default kategori
INSERT INTO kategori (nama_kategori, icon) VALUES
('Infrastruktur', 'fa-road'),
('Kebersihan', 'fa-trash'),
('Kesehatan', 'fa-hospital'),
('Pendidikan', 'fa-school'),
('Keamanan', 'fa-shield-alt'),
('Lainnya', 'fa-ellipsis-h');

-- Insert sample user
INSERT INTO users (nama, nik, email, password, role) VALUES
('John Doe', '3578000000000002', 'user@laporpak.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'user');
-- Password: password

-- Insert sample aduan
INSERT INTO aduan (user_id, kategori_id, judul, isi, lokasi, status) VALUES
(2, 1, 'Jalan Berlubang di Jl. Merdeka', 'Mohon segera diperbaiki jalan yang berlubang di Jl. Merdeka dekat pasar, sangat membahayakan pengendara', 'Jl. Merdeka, Surabaya', 'pending'),
(2, 2, 'Sampah Menumpuk di Taman Kota', 'Sudah 3 hari sampah tidak diangkut di Taman Kota', 'Taman Kota, Surabaya', 'proses');
