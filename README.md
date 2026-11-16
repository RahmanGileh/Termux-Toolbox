# TERMUX TOOLBOX v2.0
### Small toolbox. Less manual chaos.

**Author:** RahmanGileh  
**License:** MIT (tambahkan file LICENSE jika repository menggunakan lisensi MIT)  
**Platform:** Android + Termux  
**Root:** Tidak diperlukan

---

## 🇮🇩 Bahasa Indonesia

### Tentang proyek ini

Termux Toolbox adalah kumpulan utilitas sederhana untuk membantu mengelola lingkungan Termux. Isinya bukan alat ajaib yang membuat RAM mendadak lega, bukan tombol turbo yang mengubah HP menjadi komputer NASA, dan jelas bukan aplikasi pembersih Android yang sok tahu.

Toolbox ini dibuat untuk pekerjaan yang memang bisa dilakukan dari terminal: melihat informasi sistem, memperbarui paket, memeriksa cache, mengelola package Termux, memantau penyimpanan, melakukan pemeriksaan jaringan dasar, membuat daftar backup package, dan membaca log aktivitas.

### Catatan kecil dari pembuat

> Awalnya pembuat cuma ingin mengurangi pekerjaan mengetik perintah berulang-ulang.
>
> Masalahnya, pembuat ini punya kebiasaan aneh: terlalu pintar untuk kemalasannya sendiri. Niatnya menghemat beberapa baris perintah, ujung-ujungnya malah bikin satu toolbox, menu interaktif, sistem log, backup, validasi input, dan README panjang yang mungkin lebih rajin dibaca daripada kode sumbernya.
>
> Ada orang yang kalau malas akan berhenti bekerja. Ada juga yang kalau malas malah membuat repositori GitHub supaya besok tidak perlu bekerja dua kali.
>
> **Kami tidak menghilangkan pekerjaan. Kami hanya memindahkan pekerjaan ke kode.**
>
> Kalau suatu hari pembuat terlihat sedang tidak melakukan apa-apa, jangan langsung disimpulkan sedang menganggur. Bisa jadi dia sedang memikirkan cara agar tidak perlu mengetik perintah yang sama untuk ke-47 kalinya.
>
> — RahmanGileh

### Fitur

| Menu | Fungsi |
|---|---|
| System Information | Menampilkan versi Android, SDK, arsitektur, kernel, shell, prefix Termux, dan jumlah package |
| System Updater | Menjalankan pembaruan daftar repository dan upgrade package Termux |
| System Cleaner | Simulasi autoremove, pembersihan cache APT, dan cache pip jika tersedia |
| Package Manager | Mencari, melihat, memasang, dan menghapus package Termux dengan konfirmasi serta perlindungan package penting |
| Storage Analyzer | Melihat kapasitas penyimpanan dan folder terbesar di HOME |
| Backup Package List | Menyimpan daftar nama package yang terpasang |
| Network Diagnostics | Tes HTTPS, DNS, dan ping opsional |
| Activity Logs | Melihat log sesi Toolbox |

### Instalasi

**1. Izinkan Termux mengakses penyimpanan**

```bash
termux-setup-storage
```

Pilih Izinkan saat Android meminta izin.

**2. Siapkan folder Toolbox**

```bash
mkdir -p "$HOME/Termux-Toolbox"
```

**3. Pindahkan file `toolbox.sh` yang sudah diunduh**

Contoh jika file berada di folder Download:

```bash
cp "$HOME/storage/downloads/toolbox.sh" "$HOME/Termux-Toolbox/toolbox.sh"
```

**4. Beri izin eksekusi dan buat perintah global**

```bash
chmod +x "$HOME/Termux-Toolbox/toolbox.sh"
ln -sf "$HOME/Termux-Toolbox/toolbox.sh" "$PREFIX/bin/toolbox"
```

**5. Jalankan**

```bash
toolbox
```

Jika file tersimpan di folder lain, sesuaikan lokasi pada perintah `cp`.

### Package opsional

Toolbox tidak memaksa pemasangan banyak package tambahan.

- `curl` mengaktifkan tes HTTPS pada Network Diagnostics:

```bash
pkg install curl
```

- `less` membuat daftar dan log lebih nyaman dibaca. Tanpanya, Toolbox memakai tampilan output biasa:

```bash
pkg install less
```

### Memperbarui Toolbox

Unduh versi `toolbox.sh` terbaru, lalu salin untuk menggantikan file lama:

```bash
cp "$HOME/storage/downloads/toolbox.sh" "$HOME/Termux-Toolbox/toolbox.sh"
chmod +x "$HOME/Termux-Toolbox/toolbox.sh"
```

### Menghapus Toolbox

Hapus shortcut global:

```bash
rm -i "$PREFIX/bin/toolbox"
```

Hapus folder repository:

```bash
rm -ri "$HOME/Termux-Toolbox"
```

Hapus log dan backup Toolbox jika memang tidak dibutuhkan:

```bash
rm -ri "$HOME/.termux-toolbox"
```

Package opsional yang dipasang secara manual tidak otomatis dihapus. Hapus hanya jika sudah yakin tidak digunakan program lain. Jangan memaksa penghapusan dependensi penting Termux.

### Lokasi data

```text
~/.termux-toolbox/
├── logs/
└── backups/
```

- `logs/`: catatan aktivitas sesi.
- `backups/`: daftar nama package Termux yang tersimpan.

**Penting:** fitur Backup Package List hanya menyimpan daftar nama package. Fitur ini bukan backup APK, data aplikasi, konfigurasi, atau pemulihan penuh sistem.

### Batasan dan keamanan

- Tidak membutuhkan root.
- Tidak menghapus aplikasi Android.
- System Cleaner menampilkan simulasi autoremove sebelum meminta persetujuan. Selalu baca daftar package yang akan dihapus.
- Package Manager melindungi beberapa package inti dan package yang dibutuhkan fitur Toolbox, tetapi pengguna tetap harus membaca konfirmasi package manager.
- Network Diagnostics hanya melakukan pemeriksaan koneksi dasar; bukan audit keamanan jaringan.
- Toolbox tidak menjanjikan peningkatan RAM atau performa Android secara ajaib.

### Troubleshooting

**Perintah `toolbox` tidak ditemukan**

Pastikan symlink berhasil dibuat:

```bash
ls -l "$PREFIX/bin/toolbox"
```

**Script tidak ditemukan**

Pastikan file ada:

```bash
ls -l "$HOME/Termux-Toolbox/"
```

**File tidak ditemukan**

Periksa lokasi file unduhan dan sesuaikan path pada perintah `cp`.

---

## 🇬🇧 English

### About

Termux Toolbox is a small collection of utilities for maintaining the Termux environment. It is not a magic RAM booster, not a one-tap turbo button, and definitely not an Android cleaner pretending to know everything.

It provides practical terminal utilities: system information, package updates, cache maintenance, Termux package management, storage analysis, basic network diagnostics, package-list backups, and activity logs.

### A note from the author

> The original idea was simple: reduce repetitive typing.
>
> Unfortunately, the author has a peculiar talent: being too clever for his own laziness. A few repeated commands somehow turned into a toolbox with an interactive menu, logging, backups, input validation, and a README that may be more hardworking than its creator.
>
> Some people stop working when they feel lazy. Others create a GitHub repository so they do not have to do the same work twice tomorrow.
>
> **We do not eliminate work. We move the work into code.**
>
> If the author ever appears to be doing nothing, do not assume he is unemployed. He may simply be figuring out how to avoid typing the same command for the 47th time.
>
> — RahmanGileh

### Features

1. System Information
2. System Updater
3. System Cleaner
4. Package Manager
5. Storage Analyzer
6. Package List Backup
7. Network Diagnostics
8. Activity Logs

### Installation

**1. Allow Termux to access shared storage**

```bash
termux-setup-storage
```

Grant the permission when Android asks.

**2. Create the Toolbox folder**

```bash
mkdir -p "$HOME/Termux-Toolbox"
```

**3. Copy the downloaded `toolbox.sh` file**

If it is in the Download folder:

```bash
cp "$HOME/storage/downloads/toolbox.sh" "$HOME/Termux-Toolbox/toolbox.sh"
```

**4. Make it executable and create a global command**

```bash
chmod +x "$HOME/Termux-Toolbox/toolbox.sh"
ln -sf "$HOME/Termux-Toolbox/toolbox.sh" "$PREFIX/bin/toolbox"
```

**5. Run**

```bash
toolbox
```

Change the source path in the `cp` command if the file is stored elsewhere.

### Optional packages

- `curl` enables the HTTPS test:

```bash
pkg install curl
```

- `less` provides a pager; without it, output falls back to regular terminal output:

```bash
pkg install less
```

### Update

Download the latest `toolbox.sh`, then replace the old file:

```bash
cp "$HOME/storage/downloads/toolbox.sh" "$HOME/Termux-Toolbox/toolbox.sh"
chmod +x "$HOME/Termux-Toolbox/toolbox.sh"
```

### Uninstall

```bash
rm -i "$PREFIX/bin/toolbox"
rm -ri "$HOME/Termux-Toolbox"
rm -ri "$HOME/.termux-toolbox"
```

The last command removes Toolbox logs and package-list backups. Optional packages installed separately are not automatically removed; uninstall them only if no other program needs them.

### Data and limitations

Toolbox stores logs and package-list backups under `~/.termux-toolbox/`. The backup contains package names only, not APKs, app data, or configuration files.

Toolbox does not require root, does not uninstall Android apps, and does not promise magical Android performance or RAM improvements. Always review the package list before confirming autoremove.

---

## Credits

Made by **RahmanGileh**.

Built for people who like useful terminal tools, readable menus, and fewer repetitive commands. Also built by someone who may have spent more time automating laziness than simply doing the task.