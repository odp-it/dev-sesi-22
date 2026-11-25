-- Sesi 22 · Latihan DML + COMMIT/ROLLBACK
-- Jalankan SATU PERINTAH sekali jalan dengan Run Statement (Ctrl+Enter / Cmd+Enter), urut dari atas.
-- Auto Commit di SQL Developer for VS Code mati: perubahan belum permanen sampai COMMIT.

-- L1. Ubah nama cabang, lihat hasilnya, lalu batalkan
UPDATE branches SET branch_name = 'Cabang Simulasi Tunjungan Plaza' WHERE branch_code = 'KCP-SIM-03';
SELECT branch_code, branch_name FROM branches ORDER BY branch_code;
ROLLBACK;
SELECT branch_code, branch_name FROM branches ORDER BY branch_code;

-- L2. UPDATE tanpa WHERE: semua baris ikut berubah. Cek, lalu batalkan
UPDATE accounts SET status = 'DIBLOKIR';
SELECT status, COUNT(*) AS jumlah FROM accounts GROUP BY status;
ROLLBACK;
SELECT status, COUNT(*) AS jumlah FROM accounts GROUP BY status;

-- L3. Tambah cabang baru dan simpan permanen
INSERT INTO branches (branch_code, branch_name, city)
VALUES ('KCP-SIM-04', 'Cabang Simulasi Malioboro', 'Yogyakarta');
COMMIT;
SELECT branch_id, branch_code, branch_name, city FROM branches ORDER BY branch_id;

-- L4. Hapus lagi cabang baru (belum punya nasabah, jadi boleh dihapus) dan simpan
DELETE FROM branches WHERE branch_code = 'KCP-SIM-04';
COMMIT;
SELECT COUNT(*) AS jumlah_cabang FROM branches;
