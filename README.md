# 22 - Oracle DDL, DML & Basic SQL

Lab ini mengubah ERD Tabungan UMKM dari sesi 21 menjadi tabel Oracle sungguhan. Hasil akhirnya: 4 tabel dengan constraint di schema `ALP_DEV`, data contoh yang sama di semua laptop, bukti bahwa constraint menolak data yang salah, 8 query laporan dasar, dan DDL untuk ALP tim yang dinilai dengan rubrik 100 poin.

## Tujuan

1. Membuat tabel dengan `CREATE TABLE`, identity column, dan constraint (`PRIMARY KEY`, `UNIQUE`, `FOREIGN KEY`, `CHECK`, `NOT NULL`, `DEFAULT`), lalu menambah constraint dengan `ALTER TABLE`.
2. Mengisi dan mengubah data dengan `INSERT`, `UPDATE`, `DELETE`, dan menyimpan atau membatalkannya dengan `COMMIT` dan `ROLLBACK`.
3. Membaca pesan ORA saat constraint menolak data.
4. Menulis `SELECT` dengan filter, sort, `FETCH FIRST`, aggregate, `GROUP BY`, dan `HAVING`.

## Estimasi Waktu

Format sesi: **4 Demo + 1 Lab**. Di tiap Demo instruktur memperagakan, lalu peserta mengikuti langkah yang sama dari file *starter* (file di folder tiap Demo; bagian `TODO` sengaja belum lengkap). Demo 1 dan 2 inti sesi (tabel, data, constraint): wajib selesai. Demo 3 dan 4 penting. **Lab** adalah tugas tim yang menerapkan semuanya, dinilai dengan rubrik 100 poin dan cek otomatis. Tiap Demo punya **Tantangan tambahan** untuk yang selesai lebih cepat (tidak wajib).

| Bagian | Durasi di kelas (peraga + ikuti) |
| --- | --- |
| Demo 1 · Buat tabel Tabungan UMKM | ±40 menit (20 + 20) |
| Demo 2 · Seed dan DML dengan `COMMIT`/`ROLLBACK` | ±35 menit (12 + 23) |
| Demo 3 · Test invalid input | ±35 menit (10 + 25) |
| Demo 4 · Query laporan dasar | ±50 menit (20 + 30) |
| **Lab** · Schema ALP tim (lanjut setelah kelas) | ±35 menit |
| **Total** | **±195 menit** (+ pembuka dan penutup = 210) |

## Environment & Tools

Sama dengan sesi 21. Tidak ada instalasi baru.

| Item | Cara cek | Harus terlihat |
| --- | --- | --- |
| Container Oracle | `docker ps` | `oracle-alp` dengan status `Up ... (healthy)`. Kalau mati: buka Docker Desktop, `docker start oracle-alp`, tunggu `(healthy)` |
| Koneksi SQL client | Panel **SQL Developer** → **Connections** | `ALP_DEV @ FREEPDB1` ada dan bisa dibuka |
| Ekstensi | VS Code → Extensions | Oracle SQL Developer for VS Code 26.3.1 |

Versi dicek 22 Nov 2026: Oracle AI Database 26ai Free 23.26.4.0.0 (`container-registry.oracle.com/database/free:23.26.4.0-lite`), Docker Desktop (Docker Engine 29.9.3), Oracle SQL Developer for VS Code 26.3.1.

**Auto Commit mati.** Koneksi SQL Developer for VS Code dibuat dengan Auto Commit tidak dicentang (bawaan). Artinya `INSERT`, `UPDATE`, dan `DELETE` belum permanen sampai `COMMIT` dijalankan. Session lain (aplikasi, teman satu tim, sesi 23) tidak melihat data yang belum di-commit.

### Cara menjalankan SQL di VS Code

| Aksi | Cara | Hasil tampil di |
| --- | --- | --- |
| Pasang koneksi ke file `.sql` | Klik `No connection attached` di status bar bawah (atau ikon **Attach Connection** di kanan atas editor), pilih `ALP_DEV @ FREEPDB1` | Status bar berubah menjadi `(Dedicated) ALP_DEV @ FREEPDB1` |
| Jalankan satu perintah | Taruh kursor di perintah, tekan **Run Statement**: `Ctrl+Enter` (Windows/Linux) atau `⌘Enter` (macOS) | Tab **Query Result** (SELECT) atau **Script Output** |
| Jalankan seluruh file | **Run Script**: `F5` | Tab **Script Output** |

## Struktur Repo

| Folder | Isi |
| --- | --- |
| [`demo-1/`](demo-1/) | Demo 1 · Buat Tabel Tabungan UMKM |
| [`demo-2/`](demo-2/) | Demo 2 · Load Seed dan DML |
| [`demo-3/`](demo-3/) | Demo 3 · Test Invalid Input |
| [`demo-4/`](demo-4/) | Demo 4 · Query Laporan Dasar |
| [`lab/`](lab/) | Lab · Schema ALP Tim |

Setiap folder punya `README.md` berisi langkahnya. Kerjakan berurutan: `demo-1` sampai `demo-4`, lalu `lab`.

## Demo dan Lab

Demo 1–4 dikerjakan **individu** di schema `ALP_DEV` masing-masing. Lab dikerjakan **per tim ALP**.

### Target

| Bagian | Hasil |
| --- | --- |
| Demo 1 | 4 tabel dengan 19 constraint bernama |
| Demo 2 | Seed termuat (3 / 12 / 15 / 125 baris), latihan DML selesai |
| Demo 3 | Tabel expected error T1–T6 terisi |
| Demo 4 | `demo-4/03-queries.sql` berisi 8 query yang hasilnya sesuai kolom dan jumlah baris expected |
| Lab | `ddl-alp-<nama-tim>.sql` dengan skor otomatis dari `lab/cek-lab.sql` |

### Studi Kasus

**Tabungan UMKM**: bank fiktif dengan cabang, nasabah perorangan dan UMKM, rekening, dan transaksi. Di sesi 21 kasus ini sudah digambar sebagai ERD 4 entity. Sekarang ERD itu dijadikan tabel, diisi data simulasi, lalu dipakai untuk laporan. Tabel dan data yang sama dipakai lagi di sesi 23 dan sesi REST API.

### Kriteria Selesai

- [ ] Query cek di 1.4 menampilkan `19 rows selected.`
- [ ] Hasil seed 2.1: 3 / 12 / 15 / 125 baris, total saldo `218000000`
- [ ] L1–L4 selesai, jumlah cabang kembali `3`
- [ ] Tabel expected error T1–T6 terisi
- [ ] Q2–Q8 sesuai kolom dan jumlah baris expected
- [ ] Lab: DDL tim jalan tanpa error dan `lab/cek-lab.sql` menampilkan skor otomatis (target minimal 48 dari 80, setara 60%)

## Verifikasi & Expected Result

| Cek | Expected result |
| --- | --- |
| 1.4 | 4 tabel, 19 constraint bernama: `BRANCHES` 2, `CUSTOMERS` 5, `ACCOUNTS` 6, `TRANSACTIONS` 6 |
| 2.1 | `Commit complete.`, jumlah baris 3 / 12 / 15 / 125, `TOTAL_SALDO` 218000000 |
| 2.2 | Setelah L4: 3 cabang, status rekening `AKTIF 14` dan `DIBLOKIR 1` |
| 3.2 | 6 blok `Error starting at line`, masing-masing dengan kode ORA berbeda atau constraint berbeda; hitungan akhir 3 / 12 / 15 |
| Demo 4 | Jumlah baris Q1–Q8: 6, 2, 5, 13, 2, 4, 9, 3 |
| Lab | `lab/cek-lab.sql` menampilkan 6 baris kriteria dan subtotal otomatis maks. 80 |
| Mulai ulang | `demo-1/00-reset.sql` → `demo-1/01-ddl.sql` → `demo-2/02-seed.sql` selalu menghasilkan angka 2.1 yang sama |

## Troubleshooting

| Masalah / Error | Penyebab | Solusi |
| --- | --- | --- |
| `Error: No session associated with the current worksheet`, atau Run belum aktif | File `.sql` belum dipasangi koneksi, atau folder belum di-Trust | **Attach Connection** di tiap file; **Trust Folder & Continue** |
| Container `Exited (255)` setelah laptop dimatikan | Container ikut berhenti | `docker start oracle-alp`, tunggu `(healthy)` (±15–40 detik), lanjut |
| `ORA-00955: name is already used by an existing object` saat F5 di `demo-1/01-ddl.sql` | Tabel sudah ada dari percobaan sebelumnya | Jalankan `demo-1/00-reset.sql`, lalu `demo-1/01-ddl.sql` lagi |
| `ORA-03075: unexpected item CONSTRAINT in an out-of-line constraint` di `CREATE TABLE` | Koma hilang setelah baris PK (atau antar constraint) | Tambahkan koma di akhir baris sebelumnya |
| `ORA-03078: unexpected right parenthesis after ,` (disertai `ORA-00931: missing identifier`) | Ada koma di baris constraint terakhir sebelum `);` | Hapus koma terakhir |
| 1.4 hanya `8 rows selected.` | `demo-1/01-ddl.sql` dijalankan sebelum TODO dikerjakan | `demo-1/00-reset.sql`, kerjakan TODO, jalankan lagi |
| T3 atau T4 malah `1 row inserted.` | Constraint `ck_accounts_balance` atau `fk_transactions_account` belum dibuat | Ulangi 1.1 → 1.4 → 2.1 dengan DDL lengkap |
| `ORA-00001: unique constraint (ALP_DEV.UQ_BRANCHES_CODE) violated` saat 2.1 | Seed dijalankan dua kali | `demo-1/00-reset.sql` → `demo-1/01-ddl.sql` → `demo-2/02-seed.sql` |
| `ORA-02291 ... parent key not found` saat 2.1 | Seed dijalankan sebagian, atau tabel induk kosong | Mulai ulang dari 1.1 |
| Teman/aplikasi lain tidak melihat data yang baru di-insert | Belum `COMMIT` (Auto Commit mati) | Jalankan `COMMIT;` |
| `ORA-00937: not a single-group group function` | Ada aggregate (`COUNT`, `SUM`) dan kolom biasa di `SELECT`, tapi tanpa `GROUP BY` | Tambahkan `GROUP BY <kolom biasa>` |
| `ORA-00979: "STATUS": must appear in the GROUP BY clause or be used in an aggregate function` | Kolom di `SELECT` tidak ada di `GROUP BY` | Tambahkan kolom itu ke `GROUP BY` |
| Q2 menghasilkan 0 baris tanpa error | Memakai `phone = NULL` (perbandingan dengan NULL tidak pernah benar) | Pakai `phone IS NULL` |
| `lab/cek-lab.sql` menampilkan `0 tabel` | Awalan di `DEFINE awalan` tidak sama dengan awalan tabel, atau DDL tim belum dijalankan | Samakan awalan (huruf besar, tanpa garis bawah), jalankan DDL tim dulu |
| `No connection attached` / query tidak jalan | File belum dipasangi koneksi | Klik status bar, pilih `ALP_DEV @ FREEPDB1` |

## Cleanup

Tidak ada yang perlu dihapus. Tabel dan data Tabungan UMKM dipakai di sesi 23. Setelah kelas: `docker stop oracle-alp`.

Sesi 23 memakai data ini untuk query lintas tabel (JOIN), transfer dengan transaksi, dan optimasi query dengan index.
