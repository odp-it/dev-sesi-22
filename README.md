# 22 - Oracle DDL, DML & Basic SQL

Lab ini mengubah ERD Tabungan UMKM dari sesi 21 menjadi tabel Oracle sungguhan. Hasil akhirnya: 4 tabel dengan constraint di schema `ALP_DEV`, data contoh yang sama di semua laptop, bukti bahwa constraint menolak data yang salah, 8 query laporan dasar, dan DDL untuk ALP tim yang dinilai dengan rubrik 100 poin.

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

## Studi Kasus

**Tabungan UMKM**: bank fiktif dengan cabang, nasabah perorangan dan UMKM, rekening, dan transaksi. Di sesi 21 kasus ini sudah digambar sebagai ERD 4 entity. Sekarang ERD itu dijadikan tabel, diisi data simulasi, lalu dipakai untuk laporan. Tabel dan data yang sama dipakai lagi di sesi 23 dan sesi REST API.

## Bantuan

- [TROUBLESHOOTING.md](TROUBLESHOOTING.md): pesan error dan cara memperbaikinya.
- [CHECKLIST.md](CHECKLIST.md): hasil yang harus terlihat dan kriteria selesai.

## Cleanup

Tabel dan data Tabungan UMKM dipakai di sesi 23. Setelah selesai: `docker stop oracle-alp`.

Sesi 23 memakai data ini untuk query lintas tabel (JOIN), transfer dengan transaksi, dan optimasi query dengan index.
