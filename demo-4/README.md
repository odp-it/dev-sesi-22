# Demo 4 · Query Laporan Dasar

[Persiapan](../README.md) · [Troubleshooting](../TROUBLESHOOTING.md)

Kerjakan Q2-Q8: `WHERE`, `NULL`, urutan, aggregate, `GROUP BY`, dan `HAVING`.

Buka `03-queries.sql`, pasang koneksi. Q1 sudah dijawab sebagai contoh. Untuk Q2-Q8:

1. Tulis query di baris kosong di bawah soal.
2. Jalankan dengan Run Statement.
3. Cocokkan nama kolom dan jumlah baris di **Query Result** (`All rows fetched: n`) dengan keterangan `Expected` di soal.

Petunjuk singkat ada di soal. Sintaks: lihat slide *Filter dengan WHERE*, *NULL Bukan Kosong*, *Urutkan dan Batasi*, *GROUP BY dan HAVING*, *Format Tanggal dan Uang*.

Titik rawan:

- `NULL` dicari dengan `IS NULL`, bukan `= NULL`.
- Filter rentang waktu pakai `txn_at >= TIMESTAMP '2026-02-01 00:00:00' AND txn_at < TIMESTAMP '2026-03-01 00:00:00'`, supaya transaksi tanggal terakhir bulan ikut terhitung.
- Kolom di `SELECT` yang bukan aggregate harus ada di `GROUP BY`.

## Tantangan tambahan Demo 4 (opsional)

Kerjakan di `03-queries.sql` sebagai Q9 dan Q10. Cukup satu tabel (`transactions`).

1. Q9: pemasukan (`SETOR`, `TRANSFER_MASUK`) dan pengeluaran (`TARIK`, `TRANSFER_KELUAR`) per bulan dalam dua kolom. Petunjuk: `SUM(CASE WHEN ... THEN amount ELSE 0 END)` dan `GROUP BY` bulan.
2. Q10: tanggal dengan transaksi terbanyak beserta jumlahnya. Kalau beberapa tanggal sama banyak, semuanya ikut tampil. Petunjuk: `TRUNC(txn_at)`, `FETCH FIRST ... ROWS WITH TIES`.
