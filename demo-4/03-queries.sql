-- Sesi 22 · Query laporan dasar
-- Tulis satu query di bawah setiap soal. Jalankan per query dengan Run Statement
-- (Ctrl+Enter / Cmd+Enter), cocokkan kolom dan jumlah barisnya dengan keterangan "Expected".
-- Semua soal cukup memakai SATU tabel. JOIN dibahas di sesi 23.

-- Q1 (contoh). Nasabah segmen UMKM, urut nama
-- Expected: kolom cif_no, full_name, email · 6 baris
SELECT cif_no, full_name, email
FROM customers
WHERE segment = 'UMKM'
ORDER BY full_name;

-- Q2. Nasabah yang belum punya nomor telepon
-- Expected: kolom cif_no, full_name, phone · 2 baris · urut cif_no


-- Q3. Lima rekening dengan saldo terbesar, saldo juga ditampilkan format rupiah (24.600.000,00)
-- Expected: kolom account_no, product, balance, saldo_rupiah · 5 baris · saldo terbesar di atas
-- Petunjuk: FETCH FIRST ... ROWS ONLY, TO_CHAR(balance, 'FM999G999G999D00', 'NLS_NUMERIC_CHARACTERS='',.''')


-- Q4. Transaksi Februari 2026 dengan nominal minimal 2.000.000
-- Expected: kolom ref_no, waktu (DD-MM-YYYY HH24:MI), txn_type, category, amount · 13 baris · urut waktu
-- Petunjuk: batasi txn_at dengan >= awal bulan dan < awal bulan berikutnya


-- Q5. Jumlah rekening dan total saldo per produk
-- Expected: kolom product, jumlah_rekening, total_saldo · 2 baris


-- Q6. Jumlah transaksi dan total nominal per jenis transaksi (txn_type)
-- Expected: kolom txn_type, jumlah, total_nominal · 4 baris


-- Q7. Mutasi rekening SIM-1000001 (account_no) diringkas per bulan, jenis, dan kategori
-- Expected: kolom bulan (YYYY-MM), txn_type, category, jumlah, total · 9 baris · urut bulan


-- Q8. Kategori selain TRANSFER dengan total nominal lebih dari 20.000.000
-- Expected: kolom category, jumlah, total · 3 baris · total terbesar di atas
-- Petunjuk: filter baris pakai WHERE, filter hasil grup pakai HAVING

