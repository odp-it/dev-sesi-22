> Buka folder ini untuk bagian ini. Semua path relatif terhadap folder ini. Persiapan, troubleshooting, dan cleanup: [README utama](../README.md).

# Demo 2 · Load Seed dan DML (±35 menit)

Instruktur memperagakan `INSERT` dengan subquery FK, `UPDATE` tanpa `WHERE` lalu `ROLLBACK`, dan `COMMIT` (±12 menit). Peserta menjalankan 2.1 dan 2.2 (±23 menit).

## 2.1 Load seed (±5 menit)

1. Buka `02-seed.sql` dan pasang koneksi `ALP_DEV @ FREEPDB1` (file ini belum terhubung walau `../demo-1/01-ddl.sql` sudah), lihat sekilas: `INSERT` tanpa ID (diisi identity column) dan FK yang dicari lewat kode unik, mis. `(SELECT branch_id FROM branches WHERE branch_code = 'KCP-SIM-01')`.
2. Lihat baris `COMMIT;` di bagian bawah file.
3. Pasang koneksi, tekan **F5**. Tunggu sampai output selesai (±10 detik, 155 baris `1 row inserted.`).

Yang harus terlihat di akhir **Script Output**:

```text
Commit complete.

TABEL            JUMLAH
------------ ----------
BRANCHES              3
CUSTOMERS            12
ACCOUNTS             15
TRANSACTIONS        125

TOTAL_SALDO
-----------
  218000000
```

Angka ini sama di semua laptop. Kalau beda, jalankan ulang 1.1, 1.4, 2.1.

## 2.2 Latihan DML dengan `COMMIT` dan `ROLLBACK` (±10 menit)

Buka `dml-latihan.sql`, pasang koneksi. Jalankan **satu perintah sekali jalan** dengan Run Statement, urut dari atas. Setelah setiap perintah, cek hasilnya di **Query Result** atau **Script Output**.

| Langkah | Yang dikerjakan | Yang harus terlihat |
| --- | --- | --- |
| L1 | `UPDATE` nama cabang `KCP-SIM-03`, `SELECT`, `ROLLBACK`, `SELECT` lagi | Sebelum rollback: `Cabang Simulasi Tunjungan Plaza`. Sesudah: kembali `Cabang Simulasi Tunjungan` |
| L2 | `UPDATE accounts SET status = 'DIBLOKIR'` **tanpa `WHERE`**, `SELECT`, `ROLLBACK`, `SELECT` | `15 rows updated.`, lalu `DIBLOKIR 15`. Sesudah rollback: `AKTIF 14`, `DIBLOKIR 1` |
| L3 | `INSERT` cabang `KCP-SIM-04`, `COMMIT`, `SELECT` | `Commit complete.`, 4 cabang |
| L4 | `DELETE` cabang `KCP-SIM-04`, `COMMIT`, `SELECT COUNT(*)` | `JUMLAH_CABANG` = `3` |

`BRANCH_ID` cabang baru di L3 biasanya `4`; kalau database sempat restart, bisa berupa angka besar (mis. `21`) karena cache identity, dan nomor yang sudah dipakai tidak diulang. Ini normal.

## Tantangan tambahan Demo 2 (opsional)

Satu setoran sama dengan dua perubahan: baris baru di `transactions` dan saldo `accounts` bertambah. Dalam satu unit kerja, `INSERT` transaksi `SETOR` sebesar 500.000 untuk rekening `SIM-1000001` (ref `REF-SIM-900001`) lalu `UPDATE` saldo rekening yang sama. Tampilkan jumlah transaksi dan saldo sebelum dan sesudah `ROLLBACK`.
