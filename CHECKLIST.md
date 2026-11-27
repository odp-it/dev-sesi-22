# Checklist

[Kembali ke README](README.md)

## Kriteria Selesai

- [ ] Query cek di 1.4 menampilkan `19 rows selected.`
- [ ] Hasil seed 2.1: 3 / 12 / 15 / 125 baris, total saldo `218000000`
- [ ] L1–L4 selesai, jumlah cabang kembali `3`
- [ ] Tabel expected error T1–T6 terisi
- [ ] Q2–Q8 sesuai kolom dan jumlah baris expected
- [ ] Lab: `db/01-ddl.sql`, `db/02-seed.sql`, `db/03-test-invalid.sql` (minimal 3 ditolak) dan `db/00-run-all.sql` ada di repo kelompok; `00-run-all.sql` jalan dua kali tanpa error
- [ ] Lab: `lab/cek-lab.sql` dengan awalan kelompok menampilkan skor otomatis (target minimal 48 dari 80, setara 60%)
- [ ] Lab: README repo bagian "Aturan data penting" terisi; semua perubahan sudah di-push
- [ ] Malam hari 1: setiap anggota sudah membangun database kelompok di laptopnya dengan `00-run-all.sql`

## Verifikasi & Expected Result

| Cek | Expected result |
| --- | --- |
| 1.4 | 4 tabel, 19 constraint bernama: `BRANCHES` 2, `CUSTOMERS` 5, `ACCOUNTS` 6, `TRANSACTIONS` 6 |
| 2.1 | `Commit complete.`, jumlah baris 3 / 12 / 15 / 125, `TOTAL_SALDO` 218000000 |
| 2.2 | Setelah L4: 3 cabang, status rekening `AKTIF 14` dan `DIBLOKIR 1` |
| 3.2 | 6 blok `Error starting at line`, masing-masing dengan kode ORA berbeda atau constraint berbeda; hitungan akhir 3 / 12 / 15 |
| Demo 4 | Jumlah baris Q1–Q8: 6, 2, 5, 13, 2, 4, 9, 3 |
| Lab | `00-run-all.sql` dua kali tanpa error; `lab/cek-lab.sql` menampilkan 6 baris kriteria dan subtotal otomatis maks. 80; `03-test-invalid.sql`: minimal 3 perintah ditolak dengan kode ORA |
| Mulai ulang | `demo-1/00-reset.sql` → `demo-1/01-ddl.sql` → `demo-2/02-seed.sql` selalu menghasilkan angka 2.1 yang sama |
