# Troubleshooting

[Kembali ke README](README.md)

| Masalah / Error | Penyebab | Solusi |
| --- | --- | --- |
| `Error: No session associated with the current worksheet`, atau Run belum aktif | File `.sql` belum dipasangi koneksi, atau folder belum di-Trust | **Attach Connection** di tiap file; **Trust Folder & Continue** |
| Container `Exited (255)` setelah laptop dimatikan | Container ikut berhenti | `docker start oracle-alp`, tunggu `(healthy)` (±15-40 detik), lanjut |
| `ORA-00955: name is already used by an existing object` saat F5 di `demo-1/01-ddl.sql` | Tabel sudah ada dari percobaan sebelumnya | Jalankan `demo-1/00-reset.sql`, lalu `demo-1/01-ddl.sql` lagi |
| `ORA-03075: unexpected item CONSTRAINT in an out-of-line constraint` di `CREATE TABLE` | Koma hilang setelah baris PK (atau antar constraint) | Tambahkan koma di akhir baris sebelumnya |
| `ORA-03078: unexpected right parenthesis after ,` (disertai `ORA-00931: missing identifier`) | Ada koma di baris constraint terakhir sebelum `);` | Hapus koma terakhir |
| 1.4 hanya `8 rows selected.` | `demo-1/01-ddl.sql` dijalankan sebelum TODO dikerjakan | `demo-1/00-reset.sql`, kerjakan TODO, jalankan lagi |
| T3 atau T4 malah `1 row inserted.` | Constraint `ck_accounts_balance` atau `fk_transactions_account` belum dibuat | Ulangi 1.1 → 1.4 → 2.1 dengan DDL lengkap |
| `ORA-00001: unique constraint (ALP_DEV.UQ_BRANCHES_CODE) violated` saat 2.1 | Seed dijalankan dua kali | `demo-1/00-reset.sql` → `demo-1/01-ddl.sql` → `demo-2/02-seed.sql` |
| `ORA-02291 ... parent key not found` saat 2.1 | Seed dijalankan sebagian, atau tabel parent kosong | Mulai ulang dari 1.1 |
| Teman/aplikasi lain tidak melihat data yang baru di-insert | Belum `COMMIT` (Auto Commit mati) | Jalankan `COMMIT;` |
| `ORA-00937: not a single-group group function` | Ada aggregate (`COUNT`, `SUM`) dan kolom biasa di `SELECT`, tapi tanpa `GROUP BY` | Tambahkan `GROUP BY <kolom biasa>` |
| `ORA-00979: "STATUS": must appear in the GROUP BY clause or be used in an aggregate function` | Kolom di `SELECT` tidak ada di `GROUP BY` | Tambahkan kolom itu ke `GROUP BY` |
| Q2 menghasilkan 0 baris tanpa error | Memakai `phone = NULL` (perbandingan dengan NULL tidak pernah benar) | Pakai `phone IS NULL` |
| `lab/cek-lab.sql` menampilkan `0 tabel` | Awalan di `DEFINE awalan` tidak sama dengan awalan tabel, atau DDL kelompok belum dijalankan | Samakan awalan (huruf besar, tanpa garis bawah), jalankan `00-run-all.sql` dulu |
| `00-run-all.sql` kedua kali error `ORA-00955` | `demo-1/01-ddl.sql` belum menghapus semua objek lama (ada tabel yang tidak di-`DROP`, atau urutan drop salah) | Tambahkan `DROP TABLE IF EXISTS ... PURGE` untuk semua tabel, urut child → parent |
| `00-run-all.sql` error `ORA-02291` di seed | Urutan `INSERT` tidak mengikuti parent → child, atau kode parent di subquery salah ketik | Urutkan seed parent dulu; samakan kode di subquery |
| `03-test-invalid.sql` menghasilkan `1 row created.` | Constraint yang dites belum ada di `demo-1/01-ddl.sql` | Tambahkan constraint, jalankan `00-run-all.sql` lagi |
| `git pull` bentrok di `db/01-ddl.sql` | Dua anggota mengedit file yang sama | Satu driver per file; selesaikan konflik, jalankan `00-run-all.sql` ulang |
| `No connection attached` / query tidak jalan | File belum dipasangi koneksi | Klik status bar, pilih `ALP_DEV @ FREEPDB1` |
