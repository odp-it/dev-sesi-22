-- Sesi 22 · Test invalid input
-- Setiap perintah di bawah SENGAJA melanggar aturan data. Expected: semuanya DITOLAK Oracle.
-- Jalankan dengan Run Script (F5). Catat kode ORA dan nama constraint di tabel README langkah 2.4.

-- T1. Nasabah baru dengan email yang sudah dipakai Rina Contoh
INSERT INTO customers (cif_no, full_name, email, phone, segment, branch_id)
VALUES ('CIF-SIM-0101', 'Rudi Contoh', 'rina.contoh@example.com', '0800-0000-0101', 'INDIVIDU', 1);

-- T2. Nasabah baru tanpa nama lengkap
INSERT INTO customers (cif_no, full_name, email, phone, segment, branch_id)
VALUES ('CIF-SIM-0102', NULL, 'tanpa.nama@example.com', '0800-0000-0102', 'INDIVIDU', 1);

-- T3. Rekening baru dengan saldo negatif
INSERT INTO accounts (account_no, customer_id, product, balance)
VALUES ('SIM-1000101', 1, 'TABUNGAN', -50000);

-- T4. Transaksi untuk rekening yang tidak ada (account_id 9999)
INSERT INTO transactions (account_id, txn_type, category, amount, description, ref_no)
VALUES (9999, 'SETOR', 'PENJUALAN', 100000, 'Rekening tidak ada', 'REF-SIM-900001');

-- T5. Hapus cabang yang masih punya nasabah
DELETE FROM branches WHERE branch_code = 'KCP-SIM-01';

-- T6. Nomor CIF lebih panjang dari kolomnya (VARCHAR2(20))
INSERT INTO customers (cif_no, full_name, email, phone, segment, branch_id)
VALUES ('CIF-SIM-0103-CABANG-JAKARTA', 'Tari Contoh', 'tari.contoh@example.com', NULL, 'UMKM', 1);

-- Cek: jumlah baris tidak berubah (12 nasabah, 15 rekening, 3 cabang)
SELECT (SELECT COUNT(*) FROM branches)  AS cabang,
       (SELECT COUNT(*) FROM customers) AS nasabah,
       (SELECT COUNT(*) FROM accounts)  AS rekening
FROM dual;
