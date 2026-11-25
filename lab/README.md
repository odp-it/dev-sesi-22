# Lab · Schema ALP Tim

[Persiapan](../README.md) · [Troubleshooting](../TROUBLESHOOTING.md)

**Skenario.** Tim sudah punya ERD dan kamus data ALP dari sesi 21. Tim lead meminta schema Oracle yang siap dipakai sesi 23 (query laporan) dan sesi REST API: tabel sesuai ERD, relasi dan aturan data dijaga constraint, dan ada data contoh untuk demo. Hasil dinilai dengan rubrik di bawah.

Satu laptop per tim, schema `ALP_DEV` milik laptop itu.

1. Salin `ddl-alp-tim.sql` menjadi `ddl-alp-<nama-tim>.sql`.
2. Pilih awalan tabel tim (2–4 huruf, mis. `GRD_`), supaya tabel ALP tidak bentrok dengan tabel Tabungan UMKM.
3. Dari ERD dan kamus data tim sesi 21 (`erd/kamus-data-<nama-tim>.md`, sudah diperbaiki sesuai review), tulis `DROP TABLE IF EXISTS` (urutan anak → induk) dan `CREATE TABLE` (urutan induk → anak) dengan constraint bernama.
4. Isi minimal 3 baris data contoh per tabel (data simulasi, domain `example.com`, kode `SIM`), diakhiri `COMMIT`, lalu tulis minimal 3 perintah test invalid input yang ditolak (kode ORA dicatat di komentar).
5. Jalankan dengan **F5** sampai semua tabel terbuat tanpa error.
6. Buka `cek-lab.sql`, ganti awalan di baris `DEFINE awalan = 'GRD'`, pasang koneksi, tekan **F5**. Output berupa tabel poin otomatis (maks. 80). Perbaiki DDL tim sampai skor otomatis puas, lalu jalankan `cek-lab.sql` lagi.

## Rubrik Lab (100 poin)

| Kriteria | Poin | Dinilai oleh | Indikator keberhasilan |
| --- | --- | --- | --- |
| Jumlah tabel | 20 | `cek-lab.sql` | Minimal 3 tabel berawalan tim, satu tabel untuk setiap entity di ERD |
| Primary key | 15 | `cek-lab.sql` | Setiap tabel punya PK identity |
| Relasi FK | 15 | `cek-lab.sql` | Minimal jumlah tabel dikurangi 1 FK; relasi N:M memakai tabel penghubung dengan dua FK |
| Constraint bernama | 10 | `cek-lab.sql` | Semua constraint memakai pola `pk_`, `uq_`, `fk_`, `ck_` |
| Aturan data | 10 | `cek-lab.sql` | Minimal 2 constraint `CHECK` atau `UNIQUE` yang bermakna bisnis |
| Data contoh | 10 | `cek-lab.sql` | Minimal 3 baris per tabel, data simulasi, diakhiri `COMMIT` |
| Test invalid input | 10 | Review tim lain | Minimal 3 perintah yang ditolak, kode ORA dicatat di komentar |
| Idempoten | 5 | Review tim lain | File dijalankan dua kali berturut-turut (F5) tanpa error |
| Cocok kamus data | 5 | Review tim lain | Nama tabel, kolom, dan tipe sama dengan ERD dan kamus data tim |
| **Total** | **100** | | |

Target minimal 60 poin. Cek sendiri dengan `cek-lab.sql` dan daftar rubrik di atas.

## Bonus Lab (opsional, maks. +10)

1. Tambahkan kolom audit `updated_at TIMESTAMP` ke semua tabel tim dengan `ALTER TABLE`. Buktikan dengan satu query ke `USER_TAB_COLUMNS` bahwa kolom itu ada di setiap tabel berawalan tim.
2. Cocokkan DDL dengan kamus data tim dari sesi 21: untuk satu tabel, tampilkan nama kolom, tipe, panjang atau presisi, dan wajib diisi (`nullable`) dari `USER_TAB_COLUMNS`, lalu cari selisih dengan kamus. Perbaiki yang berbeda, kamus atau DDL.
