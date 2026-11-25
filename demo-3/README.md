# Demo 3 · Test Invalid Input

[Persiapan](../README.md) · [Troubleshooting](../TROUBLESHOOTING.md)

Jalankan 3.1 dan 3.2: kirim data yang salah dan catat pesan ORA dari constraint.

## 3.1 Baca file test invalid input

Buka `invalid-inputs.sql`. Ada 6 perintah (T1–T6), masing-masing sengaja melanggar satu aturan. Tebak dulu constraint mana yang akan menolak tiap perintah.

## 3.2 Jalankan dan isi tabel expected error

1. Pasang koneksi, tekan **F5**. Run Script tetap lanjut ke perintah berikutnya walau ada error.
2. Gulir **Script Output**. Setiap perintah menghasilkan blok `Error starting at line : ...` berisi kode `ORA-xxxxx` dan nama constraint.
3. Salin tabel ini ke catatan dan isi:

| Test | Kode ORA | Constraint / kolom yang menolak | Arti pesan dalam satu kalimat |
| --- | --- | --- | --- |
| T1 | | | |
| T2 | | | |
| T3 | | | |
| T4 | | | |
| T5 | | | |
| T6 | | | |

Yang harus terlihat di bagian paling bawah: `CABANG 3`, `NASABAH 12`, `REKENING 15`. Semua perintah ditolak, jadi jumlah baris tidak berubah.

Pesan ORA di sini **expected**: test invalid input berhasil kalau Oracle menolak datanya.

## Tantangan tambahan Demo 3 (opsional)

Rancang tiga test invalid input baru untuk `transactions` dan `accounts` yang belum ada di `invalid-inputs.sql`. Untuk tiap test tulis kode ORA yang diharapkan sebelum menjalankannya, lalu bandingkan.
