-- Sesi 22 · Lab: cek otomatis Schema ALP Tim (80 poin otomatis; 20 poin dinilai manual)
-- Cara pakai:
--   1. Ganti awalan di baris DEFINE di bawah (huruf besar, tanpa garis bawah), mis. GRD untuk tabel GRD_*.
--   2. Pasang koneksi ALP_DEV @ FREEPDB1, tekan Run Script (F5).
--   3. Baca tabel poin di Script Output. Perbaiki DDL tim, jalankan ulang file DDL, lalu cek lagi.
-- File ini hanya membaca katalog dan menghitung baris; tidak mengubah data.

SET SERVEROUTPUT ON SIZE UNLIMITED
SET VERIFY OFF
DEFINE awalan = 'GRD'

DECLARE
  v_prefix   VARCHAR2(30) := UPPER('&awalan') || '\_%';
  n_tabel    PLS_INTEGER;
  n_pk       PLS_INTEGER;
  n_fk       PLS_INTEGER;
  n_cu       PLS_INTEGER;
  n_bernama  PLS_INTEGER;
  n_total    PLS_INTEGER;
  n_data     PLS_INTEGER := 0;
  n_baris    NUMBER;
  p_tabel    PLS_INTEGER;
  p_pk       PLS_INTEGER;
  p_fk       PLS_INTEGER;
  p_nama     PLS_INTEGER;
  p_aturan   PLS_INTEGER;
  p_data     PLS_INTEGER;
  v_total    PLS_INTEGER;

  PROCEDURE baris(k VARCHAR2, hasil VARCHAR2, poin PLS_INTEGER, maks PLS_INTEGER) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE(RPAD(k, 34) || RPAD(hasil, 22) || LPAD(poin, 3) || ' / ' || LPAD(maks, 2));
  END;
BEGIN
  SELECT COUNT(*) INTO n_tabel
    FROM user_tables WHERE table_name LIKE v_prefix ESCAPE '\';

  SELECT COUNT(DISTINCT c.table_name) INTO n_pk
    FROM user_constraints c
   WHERE c.constraint_type = 'P' AND c.table_name LIKE v_prefix ESCAPE '\';

  SELECT COUNT(*) INTO n_fk
    FROM user_constraints c
   WHERE c.constraint_type = 'R' AND c.table_name LIKE v_prefix ESCAPE '\';

  SELECT COUNT(*) INTO n_cu
    FROM user_constraints c
   WHERE c.table_name LIKE v_prefix ESCAPE '\'
     AND (c.constraint_type = 'U'
          OR (c.constraint_type = 'C' AND c.search_condition_vc NOT LIKE '%IS NOT NULL'));

  SELECT COUNT(*), NVL(SUM(CASE WHEN c.generated = 'USER NAME' THEN 1 ELSE 0 END), 0)
    INTO n_total, n_bernama
    FROM user_constraints c
   WHERE c.table_name LIKE v_prefix ESCAPE '\'
     AND (c.constraint_type IN ('P', 'U', 'R')
          OR (c.constraint_type = 'C' AND c.search_condition_vc NOT LIKE '%IS NOT NULL'));

  FOR t IN (SELECT table_name FROM user_tables WHERE table_name LIKE v_prefix ESCAPE '\') LOOP
    EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM "' || t.table_name || '"' INTO n_baris;
    IF n_baris >= 3 THEN n_data := n_data + 1; END IF;
  END LOOP;

  p_tabel  := LEAST(20, ROUND(20 * n_tabel / 3));
  p_pk     := CASE WHEN n_tabel = 0 THEN 0 ELSE ROUND(15 * n_pk / n_tabel) END;
  p_fk     := CASE WHEN n_tabel <= 1 THEN 0 ELSE LEAST(15, ROUND(15 * n_fk / (n_tabel - 1))) END;
  p_nama   := CASE WHEN n_total = 0 THEN 0 ELSE ROUND(10 * n_bernama / n_total) END;
  p_aturan := CASE WHEN n_cu >= 2 THEN 10 WHEN n_cu = 1 THEN 5 ELSE 0 END;
  p_data   := CASE WHEN n_tabel = 0 THEN 0 ELSE ROUND(10 * n_data / n_tabel) END;
  v_total  := p_tabel + p_pk + p_fk + p_nama + p_aturan + p_data;

  DBMS_OUTPUT.PUT_LINE('Cek Lab Sesi 22 - awalan ' || UPPER('&awalan') || '_');
  DBMS_OUTPUT.PUT_LINE(RPAD('Kriteria', 34) || RPAD('Hasil', 22) || 'Poin');
  DBMS_OUTPUT.PUT_LINE(RPAD('-', 62, '-'));
  baris('1. Jumlah tabel (min. 3)',          n_tabel || ' tabel',                   p_tabel,  20);
  baris('2. Tabel punya PK',                  n_pk || ' dari ' || n_tabel,           p_pk,     15);
  baris('3. Relasi FK (min. tabel - 1)',      n_fk || ' FK',                         p_fk,     15);
  baris('4. Constraint bernama',              n_bernama || ' dari ' || n_total,      p_nama,   10);
  baris('5. Aturan data (CHECK / UNIQUE)',    n_cu || ' constraint',                 p_aturan, 10);
  baris('6. Data contoh (min. 3 baris)', n_data || ' dari ' || n_tabel,        p_data,   10);
  DBMS_OUTPUT.PUT_LINE(RPAD('-', 62, '-'));
  baris('Subtotal otomatis',                  '',                                    v_total,  80);
  DBMS_OUTPUT.PUT_LINE('Dinilai manual (20): test invalid input 10, file jalan dua kali tanpa error 5, DDL cocok kamus data 5.');
END;
/
