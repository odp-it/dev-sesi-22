# Demo 1 · Buat Tabel Tabungan UMKM

[Persiapan](../README.md) · [Troubleshooting](../TROUBLESHOOTING.md)

Kerjakan 1.1-1.4 dari starter `01-ddl.sql`: buat tabel beserta constraint-nya.

## 1.1 Mulai dari kosong

1. Buka `00-reset.sql`, pasang koneksi `ALP_DEV @ FREEPDB1` (**Attach Connection**; tiap file `.sql` baru dipasangi koneksi sendiri, kalau lupa muncul `Error: No session associated with the current worksheet`). Kalau VS Code menanyakan `Do you trust the authors of the files in this folder?`, pilih **Trust Folder & Continue**; sebelum itu tombol Run belum aktif.
2. Tekan **F5**.

Yang harus terlihat di **Script Output**: baris `Table ... dropped.` lalu `SISA_TABEL` bernilai `0`. Script ini aman dijalankan kapan saja, termasuk saat tabel belum ada.

## 1.2 Lengkapi constraint di `01-ddl.sql`

Buka `01-ddl.sql`. Tabel `BRANCHES` dan `CUSTOMERS` sudah lengkap, jadikan contoh. Di tabel `ACCOUNTS` dan `TRANSACTIONS` ada komentar `TODO 1.2`:

1. Tambahkan koma di akhir baris `CONSTRAINT pk_accounts PRIMARY KEY (account_id)`.
2. Tulis 5 constraint sesuai nama dan aturan di komentar. Pola penulisan: lihat `CUSTOMERS` (`UNIQUE`, `FOREIGN KEY ... REFERENCES`) dan slide *Constraint yang Menjaga Data* (`CHECK`).
3. Ulangi untuk `TRANSACTIONS`.

Titik rawan: baris constraint terakhir sebelum `);` **tanpa** koma.

## 1.3 Tambah constraint dengan `ALTER TABLE`

Di bawah komentar `TODO 1.3`, tulis satu perintah `ALTER TABLE customers ADD CONSTRAINT ck_customers_segment CHECK (...)` yang membatasi `segment` ke `'INDIVIDU'` atau `'UMKM'`.

## 1.4 Jalankan dan cek

1. Pasang koneksi ke `01-ddl.sql`, tekan **F5**.
2. Gulir **Script Output** ke bawah.

Yang harus terlihat: `Table BRANCHES created.` sampai `Table TRANSACTIONS created.`, `Table CUSTOMERS altered.`, lalu daftar constraint yang diakhiri `19 rows selected.`

Kalau jumlahnya kurang dari 19 atau muncul error: jalankan `00-reset.sql`, perbaiki `01-ddl.sql`, jalankan lagi. File ini selalu dijalankan dari kondisi kosong.

## Tantangan tambahan Demo 1 (opsional)

Kerjakan di file baru, jangan mengubah `01-ddl.sql`.

1. Rekening yang ditutup perlu waktu penutupannya. Dengan `ALTER TABLE`, tambahkan kolom `closed_at TIMESTAMP` ke `accounts`, lalu constraint bernama `ck_accounts_closed`: rekening berstatus `'DITUTUP'` wajib punya `closed_at` (CHECK yang membandingkan dua kolom). Coba `UPDATE` satu rekening menjadi `'DITUTUP'` tanpa dan dengan `closed_at`, lalu `ROLLBACK`. **Kembalikan** schema: `DROP CONSTRAINT ck_accounts_closed` dan `DROP COLUMN closed_at`, supaya constraint kembali 19 dan sesi 23 jalan dari kondisi yang sama.
2. Tulis query ke `USER_CONSTRAINTS` yang hanya menampilkan constraint `CHECK` buatan sendiri (tanpa nama `SYS%`) milik keempat tabel, lengkap dengan aturannya, urut nama tabel. Petunjuk: kolom `search_condition_vc`.
