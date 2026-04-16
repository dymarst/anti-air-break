# AirBreak Detection Filterscript (SA-MP)

## 📌 Overview

Filterscript ini digunakan untuk mendeteksi pemain yang menggunakan cheat **airbreak (terbang tanpa izin)** saat berjalan kaki di server **SA-MP**.

Script bekerja dengan memonitor perubahan posisi **Z (ketinggian)** pemain dan kecepatan dalam interval waktu tertentu.

---

## ⚙️ Cara Kerja

Setiap ±1 detik:

1. Mengambil posisi pemain
2. Menghitung selisih ketinggian (Z)
3. Menghitung kecepatan pemain
4. Membandingkan dengan batas yang ditentukan

Trigger deteksi jika:

* Kenaikan Z > **5.0**
* Speed > **0.5**
* Tidak di kendaraan
* Tidak menggunakan jetpack

---

## 🚨 Sistem Warning

* 1x pelanggaran → warning
* > 1 pelanggaran → **kick otomatis**

---

## 🔍 Contoh Log

```id="log2"
[AIR BREAK] ID PLAYER : 5 Ketinggian : 6.300000 Speed : 1.000000 Warning: 2
```

---

## 🧩 Instalasi

### 1. Compile

1. Masuk ke folder:

   ```
   pawno/
   ```
2. Buka:

   ```
   pawno.exe
   ```
3. Buat file:

   ```
   air.pwn
   ```
4. Paste script
5. Tekan **F5 (Compile)**
6. Akan menghasilkan:

   ```
   air.amx
   ```

---

### 2. Pasang ke Server

1. Pindahkan:

   ```
   air.amx
   ```

   ke:

   ```
   filterscripts/
   ```

2. Edit:

   ```
   server.cfg
   ```

3. Tambahkan:

   ```
   filterscripts air
   ```

---

### 3. Jalankan

Gunakan:

```id="run1"
/rcon loadfs air
```

atau restart server.

---

## ⚠️ Keterbatasan Script (PENTING)

Script ini **BELUM SEMPURNA** dan memiliki beberapa kekurangan:

### ❌ Potensi False Positive

Pemain bisa terdeteksi cheat padahal tidak, misalnya:

* Lag / ping tinggi
* Server delay / desync
* Map dengan elevasi ekstrem (gunung, gedung tinggi)
* Sistem teleport (admin / gamemode)
* Player terkena bug physics SA-MP

---

### ❌ Deteksi Masih Sederhana

* Hanya berdasarkan **selisih Z + speed**
* Tidak mendeteksi pola gerakan kompleks
* Tidak membedakan antara legit jump vs cheat lanjutan

---

### ❌ Tidak Ada Sistem Validasi Lanjutan

* Tidak ada pengecekan:

  * interior / virtual world
  * animasi player
  * state khusus (falling, jumping, dll)

---

### ❌ Tidak Ada Reset Warning

* Warning akan terus bertambah
* Tidak ada sistem cooldown / reset otomatis

---

### ❌ Tidak Cocok untuk Server Besar (Tanpa Improvement)

Untuk server besar, script ini:

* Terlalu basic
* Mudah bypass oleh cheat modern
* Perlu sistem tambahan

---
## 🛠️ Rekomendasi Penggunaan

Gunakan script ini untuk:

* Server kecil / testing
* Pembelajaran anti-cheat SA-MP
* Base untuk pengembangan anti-cheat lebih lanjut

---

## 👨‍💻 Fungsi Utama

* `OnPlayerUpdate` → Deteksi utama
* `GetPlayerSpeed` → Hitung kecepatan
* `KickD` → Delay kick

---

## 📎 Credit

Basic AirBreak Detection Filterscript
Custom logic (simple version)

---

## ⚠️ Disclaimer

Script ini dibuat sebagai **basic anti-cheat**, bukan solusi final.
Gunakan dan kembangkan sesuai kebutuhan server Anda.
