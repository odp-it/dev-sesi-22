-- Sesi 22 · Reset schema Tabungan UMKM
-- Menghapus 4 tabel beserta datanya. Urutan drop kebalikan dari urutan create (ikut FK).
-- Jalankan dengan Run Script (F5) kalau ingin mulai ulang dari kosong.
DROP TABLE IF EXISTS transactions PURGE;
DROP TABLE IF EXISTS accounts PURGE;
DROP TABLE IF EXISTS customers PURGE;
DROP TABLE IF EXISTS branches PURGE;

SELECT COUNT(*) AS sisa_tabel
FROM user_tables
WHERE table_name IN ('BRANCHES', 'CUSTOMERS', 'ACCOUNTS', 'TRANSACTIONS');
