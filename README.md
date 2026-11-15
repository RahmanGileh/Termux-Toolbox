# 🧹 Termux Auto Cleaner & Updater

[🇮🇩 Bahasa Indonesia](#-bahasa-indonesia) | [🇬🇧 English](#-english)

---

## 🇮🇩 Bahasa Indonesia

Tools berbasis **Bash Script** yang ringan untuk memperbarui seluruh paket Termux sekaligus membersihkan file sampah dan cache yang tidak terpakai secara otomatis melalui menu interaktif.

### ✨ Fitur Utama
* **Update & Upgrade Otomatis:** Memperbarui repositori dan paket sistem tanpa jeda konfirmasi manual (`-y` & non-interactive).
* **Pembersih Paket & Cache:** Menghapus dependensi yang tidak terpakai (`apt autoremove`), membersihkan cache instalasi (`apt clean`), serta cache Python (`pip cache purge`).
* **Indikator Sisa Ruang:** Menampilkan perbandingan sisa kapasitas penyimpanan Termux sebelum dan sesudah dibersihkan.
* **Perintah Global:** Dapat dijalankan dari direktori mana saja hanya dengan mengetik perintah `bersih`.

### 🚀 Cara Instalasi & Penggunaan

Salin dan jalankan perintah berikut di Termux Anda:

```bash
pkg update && pkg install git -y
git clone https://github.com
cd termux-cleane
chmod +x cleaner.sh
mv cleaner.sh \$PREFIX/bin/bersih
```

Untuk menjalankan tools kapan saja, cukup ketik:
```bash
bersih
```

### 📋 Pilihan Menu
1. **Update & Upgrade Paket Saja** — Memperbarui seluruh paket Termux.
2. **Bersihkan Paket & Cache Saja** — Menghapus cache sampah dan menampilkan ruang kosong yang berhasil dihemat.
3. **Jalankan Semua (Update + Bersihkan)** — Menjalankan pembaruan dan pembersihan secara berurutan.
4. **Keluar** — Menutup program.

---

## 🇬🇧 English

A lightweight **Bash Script** tool designed to automatically update Termux packages and clean up unused dependencies and cache files through a simple interactive menu.

### ✨ Key Features
* **Auto Update & Upgrade:** Updates repositories and upgrades installed packages automatically without manual confirmation prompts.
* **Package & Cache Cleaner:** Removes unused dependencies (`apt autoremove`), clears installation cache (`apt clean`), and purges Python cache (`pip cache purge`).
* **Storage Space Indicator:** Displays available Termux storage space before and after cleanup.
* **Global Command:** Accessible from any directory by simply typing `bersih`.

### 🚀 Installation & Usage

Copy and run the following commands in your Termux terminal:

```bash
pkg update && pkg install git -y
git clone https://github.com
cd termux-cleane
chmod +x cleaner.sh
mv cleaner.sh \$PREFIX/bin/bersih
```

To launch the tool anytime, simply run:
```bash
bersih
```

### 📋 Menu Options
1. **Update & Upgrade Packages Only** — Updates all installed Termux packages.
2. **Clean Packages & Cache Only** — Removes junk cache and displays freed storage space.
3. **Run All (Update + Clean)** — Executes system update followed by cleanup.
4. **Exit** — Closes the tool.
