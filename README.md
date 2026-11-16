TERMUX TOOLBOX v2.0

Small toolbox. Less manual chaos.

Author: RahmanGileh
License: MIT
Platform: Android + Termux
Root: Tidak diperlukan

---

🇮🇩 Bahasa Indonesia

Tentang Proyek Ini

Termux Toolbox adalah kumpulan utilitas sederhana untuk membantu mengelola lingkungan Termux. Isinya bukan alat ajaib yang membuat RAM mendadak lega, bukan tombol turbo yang mengubah HP menjadi komputer NASA, dan jelas bukan aplikasi pembersih Android yang sok tahu.

Toolbox ini dibuat untuk pekerjaan yang memang bisa dilakukan dari terminal: melihat informasi sistem, memperbarui paket, memeriksa cache, mengelola package Termux, memantau penyimpanan, melakukan pemeriksaan jaringan dasar, membuat daftar backup package, dan membaca log aktivitas.

Catatan Kecil dari Pembuat

«Awalnya pembuat cuma ingin mengurangi pekerjaan mengetik perintah berulang-ulang.

Masalahnya, pembuat ini punya kebiasaan aneh: terlalu pintar untuk kemalasannya sendiri. Niatnya menghemat beberapa baris perintah, ujung-ujungnya malah bikin satu toolbox, menu interaktif, sistem log, backup, validasi input, dan README panjang yang mungkin lebih rajin dibaca daripada kode sumbernya.

Ada orang yang kalau malas akan berhenti bekerja. Ada juga yang kalau malas malah membuat repositori GitHub supaya besok tidak perlu bekerja dua kali.

Kami tidak menghilangkan pekerjaan. Kami hanya memindahkan pekerjaan ke kode.

Kalau suatu hari pembuat terlihat sedang tidak melakukan apa-apa, jangan langsung disimpulkan sedang menganggur. Bisa jadi dia sedang memikirkan cara agar tidak perlu mengetik perintah yang sama untuk ke-47 kalinya.

— RahmanGileh»

Fitur

Menu| Fungsi
System Information| Menampilkan versi Android, SDK, arsitektur, kernel, shell, prefix Termux, dan jumlah package.
System Updater| Menjalankan pembaruan daftar repository dan upgrade package Termux.
System Cleaner| Simulasi autoremove, pembersihan cache APT, dan cache pip jika tersedia.
Package Manager| Mencari, melihat, memasang, dan menghapus package Termux dengan konfirmasi serta perlindungan package penting.
Storage Analyzer| Melihat kapasitas penyimpanan dan folder terbesar di HOME.
Backup Package List| Menyimpan daftar nama package yang terpasang.
Network Diagnostics| Tes HTTPS, DNS, dan ping opsional.
Activity Logs| Melihat log sesi Toolbox.

Instalasi

1. Izinkan Termux Mengakses Penyimpanan

termux-setup-storage

Pilih Izinkan saat Android meminta izin.

2. Siapkan Folder Toolbox

mkdir -p "$HOME/Termux-Toolbox"

3. Pindahkan File "toolbox.sh" yang Sudah Diunduh

Contoh jika file berada di folder Download:

cp "$HOME/storage/downloads/toolbox.sh" "$HOME/Termux-Toolbox/toolbox.sh"

4. Beri Izin Eksekusi dan Buat Perintah Global

chmod +x "$HOME/Termux-Toolbox/toolbox.sh"
ln -sf "$HOME/Termux-Toolbox/toolbox.sh" "$PREFIX/bin/toolbox"

5. Jalankan

toolbox

Jika file tersimpan di folder lain, sesuaikan lokasi pada perintah "cp".

Package Opsional

Toolbox tidak memaksa pemasangan banyak package tambahan.

- "curl" mengaktifkan tes HTTPS pada Network Diagnostics:

pkg install curl

- "less" membuat daftar dan log lebih nyaman dibaca. Tanpanya, Toolbox memakai tampilan output biasa:

pkg install less

Memperbarui Toolbox

Unduh versi "toolbox.sh" terbaru, lalu salin untuk menggantikan file lama:

cp "$HOME/storage/downloads/toolbox.sh" "$HOME/Termux-Toolbox/toolbox.sh"
chmod +x "$HOME/Termux-Toolbox/toolbox.sh"

Menghapus Toolbox

1. Hapus shortcut global:

rm -i "$PREFIX/bin/toolbox"

2. Hapus folder repository:

rm -ri "$HOME/Termux-Toolbox"

3. Hapus log dan backup Toolbox jika memang tidak dibutuhkan:

rm -ri "$HOME/.termux-toolbox"

Package opsional yang dipasang secara manual tidak otomatis dihapus. Hapus hanya jika sudah yakin tidak digunakan program lain. Jangan memaksa penghapusan dependensi penting Termux.

Lokasi Data

~/.termux-toolbox/
├── logs/
└── backups/

- "logs/": Catatan aktivitas sesi.
- "backups/": Daftar nama package Termux yang tersimpan.

Penting: Fitur Backup Package List hanya menyimpan daftar nama package. Fitur ini bukan backup APK, data aplikasi, konfigurasi, atau pemulihan penuh sistem.

Batasan dan Keamanan

- Tidak membutuhkan root.
- Tidak menghapus aplikasi Android.
- System Cleaner menampilkan simulasi autoremove sebelum meminta persetujuan. Selalu baca daftar package yang akan dihapus.
- Package Manager melindungi beberapa package inti dan package yang dibutuhkan fitur Toolbox, tetapi pengguna tetap harus membaca konfirmasi package manager.
- Network Diagnostics hanya melakukan pemeriksaan koneksi dasar; bukan audit keamanan jaringan.
- Toolbox tidak menjanjikan peningkatan RAM atau performa Android secara ajaib.

Troubleshooting

Perintah "toolbox" tidak ditemukan

Pastikan symlink berhasil dibuat:

ls -l "$PREFIX/bin/toolbox"

Script tidak ditemukan

Pastikan file ada:

ls -l "$HOME/Termux-Toolbox/"

File tidak ditemukan

Periksa lokasi file unduhan dan sesuaikan path pada perintah "cp".

---

🇬🇧 English

About

Termux Toolbox is a small collection of utilities for maintaining the Termux environment. It is not a magic RAM booster, not a one-tap turbo button, and definitely not an Android cleaner pretending to know everything.

It provides practical terminal utilities: system information, package updates, cache maintenance, Termux package management, storage analysis, basic network diagnostics, package-list backups, and activity logs.

A Note from the Author

«The original idea was simple: reduce repetitive typing.

Unfortunately, the author has a peculiar talent: being too clever for his own laziness. A few repeated commands somehow turned into a toolbox with an interactive menu, logging, backups, input validation, and a README that may be more hardworking than its creator.

Some people stop working when they feel lazy. Others create a GitHub repository so they do not have to do the same work twice tomorrow.

We do not eliminate work. We move the work into code.

If the author ever appears to be doing nothing, do not assume he is unemployed. He may simply be figuring out how to avoid typing the same command for the 47th time.

— RahmanGileh»

Features

Menu| Description
System Information| Displays Android version, SDK, architecture, kernel, shell, Termux prefix, and installed package count.
System Updater| Updates repository information and upgrades Termux packages.
System Cleaner| Provides an autoremove simulation, APT cache cleanup, and pip cache cleanup when available.
Package Manager| Searches, lists, installs, and removes Termux packages with confirmation and essential-package protection.
Storage Analyzer| Displays storage capacity and the largest directories in HOME.
Backup Package List| Saves a list of installed package names.
Network Diagnostics| Performs HTTPS, DNS, and optional ping tests.
Activity Logs| Displays Toolbox session logs.

Installation

1. Allow Termux to Access Shared Storage

termux-setup-storage

Grant permission when Android asks.

2. Create the Toolbox Folder

mkdir -p "$HOME/Termux-Toolbox"

3. Copy the Downloaded "toolbox.sh" File

If the file is in the Download folder:

cp "$HOME/storage/downloads/toolbox.sh" "$HOME/Termux-Toolbox/toolbox.sh"

4. Make It Executable and Create a Global Command

chmod +x "$HOME/Termux-Toolbox/toolbox.sh"
ln -sf "$HOME/Termux-Toolbox/toolbox.sh" "$PREFIX/bin/toolbox"

5. Run

toolbox

Change the source path in the "cp" command if the file is stored elsewhere.

Optional Packages

Toolbox does not force users to install additional packages.

- "curl" enables the HTTPS test in Network Diagnostics:

pkg install curl

- "less" provides a pager for more convenient browsing. Without it, Toolbox falls back to regular terminal output:

pkg install less

Updating Toolbox

Download the latest "toolbox.sh" file, then replace the existing version:

cp "$HOME/storage/downloads/toolbox.sh" "$HOME/Termux-Toolbox/toolbox.sh"
chmod +x "$HOME/Termux-Toolbox/toolbox.sh"

Uninstalling Toolbox

1. Remove the global shortcut:

rm -i "$PREFIX/bin/toolbox"

2. Remove the repository folder:

rm -ri "$HOME/Termux-Toolbox"

3. Remove Toolbox logs and backups if they are no longer needed:

rm -ri "$HOME/.termux-toolbox"

Optional packages installed manually are not automatically removed. Uninstall them only if you are certain that no other program needs them. Do not forcefully remove essential Termux dependencies.

Data Storage

~/.termux-toolbox/
├── logs/
└── backups/

- "logs/": Session activity records.
- "backups/": Saved lists of installed Termux package names.

Important: The Backup Package List feature only saves package names. It does not back up APKs, application data, configuration files, or provide full system restoration.

Limitations and Security

- Does not require root access.
- Does not uninstall Android applications.
- System Cleaner displays an autoremove simulation before asking for confirmation. Always review the package list before proceeding.
- Package Manager protects several core packages and packages required by Toolbox. However, users must still review package manager confirmation prompts.
- Network Diagnostics only performs basic connectivity checks; it is not a network security audit.
- Toolbox does not promise magical improvements to Android RAM usage or overall performance.

Troubleshooting

The "toolbox" command is not found

Make sure the symbolic link was created successfully:

ls -l "$PREFIX/bin/toolbox"

The script cannot be found

Make sure the file exists:

ls -l "$HOME/Termux-Toolbox/"

The file cannot be found

Check the downloaded file location and adjust the path in the "cp" command.

---

Credits

Made by RahmanGileh.

Built for people who like useful terminal tools, readable menus, and fewer repetitive commands. Also built by someone who may have spent more time automating laziness than simply doing the task.

License

This project is licensed under the MIT License.

See the "LICENSE" file for the complete license text.