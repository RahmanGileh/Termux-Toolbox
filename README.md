TERMUX TOOLBOX v2.0

Small toolbox. Less manual chaos.

Author: RahmanGileh
License: MIT
Platform: Android + Termux
Root: Tidak diperlukan

---

🇮🇩 Bahasa Indonesia

Tentang Proyek Ini

Termux Toolbox adalah kumpulan utilitas sederhana yang dirancang untuk membantu mengelola lingkungan Termux.

Isinya bukan alat ajaib yang membuat RAM mendadak lega, bukan tombol turbo yang mengubah HP menjadi komputer NASA, dan jelas bukan aplikasi pembersih Android yang sok tahu.

Toolbox ini menyediakan berbagai utilitas praktis yang dapat dijalankan langsung melalui terminal, mulai dari melihat informasi sistem, memperbarui paket, memeriksa cache, mengelola package Termux, memantau penggunaan penyimpanan, melakukan pemeriksaan jaringan dasar, membuat daftar backup package, hingga membaca log aktivitas.

Tujuannya sederhana: membuat pekerjaan rutin di Termux menjadi lebih praktis tanpa harus terus-menerus mengetik perintah yang sama.

Catatan Kecil dari Pembuat

«Awalnya pembuat cuma ingin mengurangi pekerjaan mengetik perintah berulang-ulang.

Masalahnya, pembuat ini punya kebiasaan aneh: terlalu pintar untuk kemalasannya sendiri. Niatnya menghemat beberapa baris perintah, ujung-ujungnya malah bikin satu toolbox, menu interaktif, sistem log, backup, validasi input, dan README panjang yang mungkin lebih rajin dibaca daripada kode sumbernya.

Ada orang yang kalau malas akan berhenti bekerja. Ada juga yang kalau malas malah membuat repositori GitHub supaya besok tidak perlu bekerja dua kali.

Kami tidak menghilangkan pekerjaan. Kami hanya memindahkan pekerjaan ke kode.

Kalau suatu hari pembuat terlihat sedang tidak melakukan apa-apa, jangan langsung disimpulkan sedang menganggur. Bisa jadi dia sedang memikirkan cara agar tidak perlu mengetik perintah yang sama untuk ke-47 kalinya.

— RahmanGileh»

Fitur

Menu| Fungsi
System Information| Menampilkan informasi versi Android, SDK, arsitektur, kernel, shell, prefix Termux, dan jumlah package yang terpasang.
System Updater| Memperbarui daftar repository dan menjalankan upgrade package Termux.
System Cleaner| Menampilkan simulasi autoremove, membersihkan cache APT, serta cache pip jika tersedia.
Package Manager| Mencari, melihat, memasang, dan menghapus package Termux dengan konfirmasi serta perlindungan terhadap package penting.
Storage Analyzer| Menampilkan kapasitas penyimpanan dan folder terbesar di direktori HOME.
Backup Package List| Menyimpan daftar nama package Termux yang terpasang.
Network Diagnostics| Melakukan pemeriksaan HTTPS, DNS, dan ping opsional.
Activity Logs| Menampilkan catatan aktivitas sesi Toolbox.

Instalasi

1. Izinkan Termux Mengakses Penyimpanan

Jalankan perintah berikut:

termux-setup-storage

Pilih Izinkan ketika Android meminta izin akses penyimpanan.

2. Buat Folder Toolbox

Buat direktori khusus untuk menyimpan file Toolbox:

mkdir -p "$HOME/Termux-Toolbox"

3. Pindahkan File "toolbox.sh"

Setelah mengunduh file "toolbox.sh", pindahkan file tersebut ke folder Toolbox.

Contoh jika file berada di folder Download:

cp "$HOME/storage/downloads/toolbox.sh" "$HOME/Termux-Toolbox/toolbox.sh"

Jika file berada di lokasi lain, sesuaikan path sumber pada perintah "cp".

4. Berikan Izin Eksekusi dan Buat Perintah Global

Berikan izin agar script dapat dijalankan:

chmod +x "$HOME/Termux-Toolbox/toolbox.sh"

Selanjutnya, buat symbolic link agar Toolbox dapat dipanggil dari direktori mana pun di Termux:

ln -sf "$HOME/Termux-Toolbox/toolbox.sh" "$PREFIX/bin/toolbox"

5. Jalankan Toolbox

Setelah semua langkah selesai, jalankan:

toolbox

Jika berhasil, menu utama Termux Toolbox akan muncul di terminal.

Package Opsional

Termux Toolbox tidak memaksa pengguna memasang banyak package tambahan.

Beberapa package berikut hanya bersifat opsional untuk mendukung kenyamanan atau fungsi tertentu.

1. curl

Digunakan untuk mengaktifkan pemeriksaan HTTPS pada menu Network Diagnostics.

pkg install curl

2. less

Menyediakan tampilan pager agar daftar package dan log lebih nyaman dibaca.

Jika "less" tidak tersedia, Toolbox akan menggunakan tampilan output terminal biasa.

pkg install less

Memperbarui Toolbox

Untuk memperbarui Toolbox, unduh file "toolbox.sh" versi terbaru, kemudian salin untuk menggantikan file lama.

Contoh jika file terbaru berada di folder Download:

cp "$HOME/storage/downloads/toolbox.sh" "$HOME/Termux-Toolbox/toolbox.sh"

Pastikan izin eksekusi tetap tersedia:

chmod +x "$HOME/Termux-Toolbox/toolbox.sh"

Setelah itu, jalankan kembali:

toolbox

Menghapus Toolbox

Jika Toolbox sudah tidak digunakan, ikuti langkah berikut.

1. Hapus shortcut global

rm -i "$PREFIX/bin/toolbox"

2. Hapus folder Toolbox

rm -ri "$HOME/Termux-Toolbox"

3. Hapus data Toolbox (opsional)

rm -ri "$HOME/.termux-toolbox"

Perintah terakhir akan menghapus log dan backup daftar package yang tersimpan.

Package opsional yang dipasang secara manual tidak otomatis dihapus bersama Toolbox. Hapus package tersebut hanya jika sudah yakin tidak digunakan oleh program lain.

Jangan menghapus dependensi penting Termux secara sembarangan.

Lokasi Data

Termux Toolbox menyimpan data aktivitas dan backup package di direktori berikut:

~/.termux-toolbox/
├── logs/
└── backups/

Keterangan:

- "logs/": Menyimpan catatan aktivitas sesi Toolbox.
- "backups/": Menyimpan daftar nama package Termux yang telah dicadangkan.

Penting: Fitur Backup Package List hanya menyimpan daftar nama package. Fitur ini bukan backup APK, data aplikasi, konfigurasi, ataupun sistem pemulihan penuh.

Batasan dan Keamanan

- Tidak membutuhkan akses root.
- Tidak menghapus aplikasi Android.
- System Cleaner menampilkan simulasi autoremove sebelum meminta persetujuan pengguna. Selalu periksa daftar package yang akan dihapus sebelum melanjutkan.
- Package Manager memiliki perlindungan terhadap beberapa package inti dan package yang dibutuhkan Toolbox. Namun, pengguna tetap harus membaca dan memeriksa konfirmasi dari package manager.
- Network Diagnostics hanya melakukan pemeriksaan koneksi dasar, bukan audit keamanan jaringan.
- Toolbox tidak menjanjikan peningkatan RAM atau performa Android secara ajaib.
- Selalu pahami perintah yang dijalankan sebelum memberikan konfirmasi.

Troubleshooting

Perintah "toolbox" Tidak Ditemukan

Pastikan symbolic link berhasil dibuat:

ls -l "$PREFIX/bin/toolbox"

Jika belum tersedia, ulangi langkah pembuatan symbolic link pada bagian instalasi.

Script Tidak Ditemukan

Periksa apakah file "toolbox.sh" benar-benar berada di folder Toolbox:

ls -l "$HOME/Termux-Toolbox/"

Pastikan nama file dan lokasi penyimpanannya sesuai.

File Tidak Ditemukan Saat Instalasi atau Pembaruan

Periksa kembali lokasi file hasil unduhan.

Jika file tidak berada di folder Download, sesuaikan path pada perintah "cp".

---

🇬🇧 English

About

Termux Toolbox is a small collection of utilities designed to help users manage their Termux environment.

It is not a magical RAM booster, not a one-tap turbo button that turns your phone into a NASA computer, and definitely not an Android cleaner pretending to know everything.

The toolbox provides practical terminal utilities, including system information, package updates, cache maintenance, Termux package management, storage analysis, basic network diagnostics, package-list backups, and activity logs.

Its purpose is simple: make routine tasks in Termux more convenient without repeatedly typing the same commands.

A Note from the Author

«The original idea was simple: reduce repetitive typing.

Unfortunately, the author has a peculiar talent: being too clever for his own laziness. A few repeated commands somehow turned into a toolbox with an interactive menu, logging, backups, input validation, and a README that may be more hardworking than its creator.

Some people stop working when they feel lazy. Others create a GitHub repository so they do not have to do the same work twice tomorrow.

We do not eliminate work. We move the work into code.

If the author ever appears to be doing nothing, do not immediately assume he is unemployed. He may simply be figuring out how to avoid typing the same command for the 47th time.

— RahmanGileh»

Features

Menu| Description
System Information| Displays Android version, SDK, architecture, kernel, shell, Termux prefix, and installed package count.
System Updater| Updates repository information and upgrades installed Termux packages.
System Cleaner| Provides an autoremove simulation, APT cache cleanup, and pip cache cleanup when available.
Package Manager| Searches, lists, installs, and removes Termux packages with confirmation prompts and essential-package protection.
Storage Analyzer| Displays storage capacity and the largest directories inside HOME.
Backup Package List| Saves a list of installed Termux package names.
Network Diagnostics| Performs HTTPS, DNS, and optional ping checks.
Activity Logs| Displays Toolbox session activity logs.

Installation

1. Allow Termux to Access Shared Storage

Run the following command:

termux-setup-storage

Grant storage permission when Android asks for it.

2. Create the Toolbox Directory

Create a dedicated directory for the Toolbox files:

mkdir -p "$HOME/Termux-Toolbox"

3. Copy the "toolbox.sh" File

After downloading "toolbox.sh", copy it into the Toolbox directory.

For example, if the file is located in the Download folder:

cp "$HOME/storage/downloads/toolbox.sh" "$HOME/Termux-Toolbox/toolbox.sh"

If the file is stored elsewhere, adjust the source path accordingly.

4. Make the Script Executable and Create a Global Command

Grant execution permission:

chmod +x "$HOME/Termux-Toolbox/toolbox.sh"

Then create a symbolic link so Toolbox can be launched from anywhere in Termux:

ln -sf "$HOME/Termux-Toolbox/toolbox.sh" "$PREFIX/bin/toolbox"

5. Launch Toolbox

Once the previous steps are complete, run:

toolbox

If everything is set up correctly, the Termux Toolbox main menu will appear.

Optional Packages

Termux Toolbox does not force users to install additional packages.

The following packages are optional and only provide extra convenience or functionality.

1. curl

Enables HTTPS connectivity checks in Network Diagnostics.

pkg install curl

2. less

Provides a pager for more convenient browsing of package lists and activity logs.

If "less" is unavailable, Toolbox falls back to regular terminal output.

pkg install less

Updating Toolbox

To update Toolbox, download the latest "toolbox.sh" file and copy it over the existing version.

For example, if the updated file is located in the Download folder:

cp "$HOME/storage/downloads/toolbox.sh" "$HOME/Termux-Toolbox/toolbox.sh"

Make sure execution permission is still available:

chmod +x "$HOME/Termux-Toolbox/toolbox.sh"

Then launch Toolbox again:

toolbox

Uninstalling Toolbox

If you no longer need Toolbox, follow these steps.

1. Remove the global shortcut

rm -i "$PREFIX/bin/toolbox"

2. Remove the Toolbox directory

rm -ri "$HOME/Termux-Toolbox"

3. Remove Toolbox data (optional)

rm -ri "$HOME/.termux-toolbox"

The last command removes stored activity logs and package-list backups.

Optional packages installed manually are not automatically removed with Toolbox. Only uninstall them if you are certain that no other program depends on them.

Do not forcefully remove essential Termux dependencies.

Data Storage

Termux Toolbox stores activity logs and package-list backups in the following directory:

~/.termux-toolbox/
├── logs/
└── backups/

Directory descriptions:

- "logs/": Stores Toolbox session activity records.
- "backups/": Stores saved lists of installed Termux package names.

Important: The Backup Package List feature only saves package names. It does not back up APK files, application data, configuration files, or provide full system restoration.

Limitations and Security

- Does not require root access.
- Does not uninstall Android applications.
- System Cleaner displays an autoremove simulation before asking for user confirmation. Always review the package list before proceeding.
- Package Manager protects several core packages and packages required by Toolbox. However, users must still review package manager confirmation prompts.
- Network Diagnostics performs basic connectivity checks, not a network security audit.
- Toolbox does not promise magical improvements to Android RAM usage or overall performance.
- Always understand the commands being executed before confirming an operation.

Troubleshooting

The "toolbox" Command Is Not Found

Make sure the symbolic link was created successfully:

ls -l "$PREFIX/bin/toolbox"

If it does not exist, repeat the symbolic-link creation step in the installation section.

The Script Cannot Be Found

Check whether "toolbox.sh" exists inside the Toolbox directory:

ls -l "$HOME/Termux-Toolbox/"

Make sure the filename and storage location are correct.

The File Cannot Be Found During Installation or Updating

Check the location of the downloaded file.

If the file is not inside the Download folder, adjust the source path in the "cp" command.

---

Credits

Made by RahmanGileh.

Built for people who like useful terminal tools, readable menus, and fewer repetitive commands.

Also built by someone who may have spent more time automating laziness than simply doing the task.

License

This project is licensed under the MIT License.

See the "LICENSE" file for the full license text.