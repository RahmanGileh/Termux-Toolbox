🖥️ Termux Toolbox

Your Terminal, Your Utilities.

"🇮🇩 Bahasa Indonesia" (#-bahasa-indonesia) | "🇬🇧 English" (#-english)

A lightweight, multifunctional Termux utility built with Bash Script, featuring a cyber-inspired interface and practical system maintenance tools.

---

🇮🇩 Bahasa Indonesia

📌 Tentang Proyek

Termux Toolbox adalah kumpulan utilitas berbasis Bash Script yang dibuat untuk mempermudah pengelolaan lingkungan Termux melalui satu menu interaktif.

Menggabungkan tampilan terminal bergaya cyber dengan berbagai fungsi pemeliharaan sistem, manajemen paket, analisis penyimpanan, dan diagnostik jaringan.

Dirancang agar ringan, praktis, dan mudah digunakan tanpa memerlukan akses root.

😂 Cerita di Balik Layar: Sebuah Proyek yang Lahir dari Rasa Malas

Jujur saja, proyek ini tidak lahir dari ide jenius, bukan juga hasil penelitian teknologi selama bertahun-tahun.

Semuanya berawal dari satu masalah sederhana:

DEVELOPER-NYA CAPEK NGETIK COMMAND TERUS. 😭

Bayangkan, setiap kali ingin memperbarui Termux harus mengetik:

pkg update
pkg upgrade

Belum lagi kalau ingin membersihkan cache, memeriksa penyimpanan, mencari paket, dan melakukan hal lainnya.

Awalnya sih biasa saja.

Tapi lama-lama muncul pikiran:

"Kenapa gue harus mengetik semuanya satu per satu? Kenapa nggak gue bikin satu tools yang isinya semua kebutuhan itu?"

Dan akhirnya...

Bukannya istirahat, sang developer malah membuka editor teks dan mulai menulis Bash Script. WKWKWK.

Awalnya cuma ingin membuat script kecil untuk update dan membersihkan Termux. Namun, entah bagaimana, proyek sederhana itu mulai berkembang.

Tambah fitur ini, tambah menu itu, utak-atik tampilan, perbaiki kode, lalu muncul ide baru lagi.

Yang tadinya ingin mengurangi pekerjaan, malah menciptakan pekerjaan baru untuk dirinya sendiri. 😂

Tapi ya sudahlah, setidaknya sekarang kalau mau melakukan maintenance tidak perlu mengetik command yang sama berulang kali.

Kesimpulannya: Termux Toolbox dibuat karena developernya malas mengetik, tetapi terlalu rajin mengembangkan tools untuk mengatasi kemalasannya sendiri.

Sebuah kontradiksi yang cukup menghibur.

✨ Fitur Utama

⚙️ System Utilities

- System Information: Menampilkan informasi Android, kernel, arsitektur perangkat, dan penyimpanan.
- System Updater: Memperbarui repositori dan seluruh paket Termux.
- System Cleaner: Membersihkan dependensi yang tidak terpakai, cache APT, dan cache Python.

📦 Package & Storage Management

- Package Manager: Mencari, memasang, melihat, dan menghapus paket Termux.
- Storage Analyzer: Menganalisis penggunaan penyimpanan dan mengidentifikasi folder berukuran besar.
- Package Backup: Menyimpan daftar paket yang terpasang sebagai referensi.

🌐 Diagnostics & Monitoring

- Network Diagnostics: Memeriksa koneksi internet, DNS, dan konektivitas jaringan.
- ADB Monitor: Memantau perangkat Android yang terhubung melalui ADB serta melihat daftar aplikasi pihak ketiga.
- Activity Logs: Menyimpan riwayat aktivitas Toolbox.

🛡️ Keamanan

Termux Toolbox mengutamakan pemeliharaan lingkungan Termux secara lebih aman.

- Tidak membutuhkan akses root.
- Tidak menghapus aplikasi sistem Android secara otomatis.
- Menyediakan simulasi sebelum proses "autoremove".
- Meminta konfirmasi sebelum operasi penghapusan paket.
- Tidak menjalankan debloating Android secara otomatis.

🚀 Instalasi & Penggunaan

Pastikan koneksi internet tersedia. Salin seluruh perintah berikut dan jalankan di Termux:

pkg update && pkg install git curl less iputils android-tools -y && git clone https://github.com/RahmanGileh/Termux-Toolbox.git "$HOME/Termux-Toolbox" && chmod +x "$HOME/Termux-Toolbox/toolbox.sh" && ln -sf "$HOME/Termux-Toolbox/toolbox.sh" "$PREFIX/bin/toolbox" && toolbox

Setelah berhasil diinstal, jalankan Toolbox kapan saja dari direktori mana saja dengan:

toolbox

📋 Daftar Menu

No.| Fitur| Fungsi
1| System Information| Informasi perangkat
2| System Updater| Update dan upgrade paket
3| System Cleaner| Pembersihan cache dan dependensi
4| Package Manager| Manajemen paket Termux
5| Storage Analyzer| Analisis penyimpanan
6| Package Backup| Backup daftar paket
7| Network Diagnostics| Diagnostik jaringan
8| ADB Monitor| Pemantauan perangkat ADB
9| Activity Logs| Riwayat aktivitas
0| Exit| Keluar dari program

📁 Penyimpanan Data

Toolbox menyimpan riwayat aktivitas dan backup daftar paket di:

~/.termux-toolbox/
├── logs/
└── backups/

👨‍💻 Pembuat

RahmanGileh

Dibuat dan dikembangkan menggunakan Bash Script untuk lingkungan Termux.

Motivasi awal: ingin mengurangi pekerjaan mengetik command secara manual.

Hasil akhirnya: malah punya proyek baru untuk dirawat. 😂

---

🇬🇧 English

📌 About

Termux Toolbox is a collection of Bash-based utilities designed to simplify Termux environment management through a single interactive menu.

It combines a cyber-inspired terminal interface with practical tools for system maintenance, package management, storage analysis, and network diagnostics.

Designed to be lightweight, practical, and accessible without requiring root access.

😂 The Story Behind the Project: Born Out of Laziness

Honestly, this project wasn't born from a genius idea or years of technological research.

It started with one simple problem:

THE DEVELOPER GOT TIRED OF TYPING THE SAME COMMANDS OVER AND OVER AGAIN. 😭

Imagine having to type these commands every time Termux needs an update:

pkg update
pkg upgrade

And that's not even counting cache cleanup, storage checks, package searches, and other maintenance tasks.

At first, it wasn't a big deal.

But eventually, the developer started thinking:

"Why should I keep typing everything manually? Why not build one tool that puts all these utilities together?"

And then...

Instead of taking a break, the developer opened a text editor and started writing Bash scripts. LOL.

It started as a small script for updating and cleaning Termux. Somehow, the project kept growing.

One feature here, another menu there, interface improvements, code fixes, and suddenly, another new idea appeared.

The original goal was to reduce work, but somehow the developer created even more work for themselves. 😂

Still, at least now, routine maintenance doesn't require typing the same commands repeatedly.

In short: Termux Toolbox was created because its developer was too lazy to type commands, but somehow too motivated to build a tool to solve that laziness.

Quite an entertaining contradiction.

✨ Key Features

⚙️ System Utilities

- System Information: Displays Android, kernel, device architecture, and storage information.
- System Updater: Updates repositories and installed Termux packages.
- System Cleaner: Removes unused dependencies and clears APT and Python caches.

📦 Package & Storage Management

- Package Manager: Searches, installs, lists, and removes Termux packages.
- Storage Analyzer: Examines storage usage and identifies large directories.
- Package Backup: Saves a list of installed packages for reference.

🌐 Diagnostics & Monitoring

- Network Diagnostics: Checks internet connectivity, DNS, and network availability.
- ADB Monitor: Monitors connected Android devices and lists third-party applications.
- Activity Logs: Records Toolbox activity history.

🛡️ Safety

Termux Toolbox prioritizes safer maintenance of the Termux environment.

- No root access required.
- Does not automatically remove Android system applications.
- Provides an autoremove simulation before execution.
- Requests confirmation before package removal operations.
- Does not automatically perform Android debloating.

🚀 Installation & Usage

Make sure an internet connection is available. Copy and execute the following commands in Termux:

pkg update && pkg install git curl less iputils android-tools -y && git clone https://github.com/RahmanGileh/Termux-Toolbox.git "$HOME/Termux-Toolbox" && chmod +x "$HOME/Termux-Toolbox/toolbox.sh" && ln -sf "$HOME/Termux-Toolbox/toolbox.sh" "$PREFIX/bin/toolbox" && toolbox

After installation, launch the Toolbox from any directory using:

toolbox

📋 Main Menu

No.| Feature| Description
1| System Information| Device information
2| System Updater| Update and upgrade packages
3| System Cleaner| Cache and dependency cleanup
4| Package Manager| Termux package management
5| Storage Analyzer| Storage analysis
6| Package Backup| Installed package list backup
7| Network Diagnostics| Network diagnostics
8| ADB Monitor| ADB device monitoring
9| Activity Logs| Activity history
0| Exit| Close the program

📁 Data Storage

Toolbox stores activity logs and package backups in:

~/.termux-toolbox/
├── logs/
└── backups/

👨‍💻 Developer

RahmanGileh

Created and developed using Bash Script for the Termux environment.

Original motivation: reducing repetitive manual command typing.

Final result: another project to maintain. 😂

---

Termux Toolbox — Your Terminal, Your Utilities.

© RahmanGileh. All rights reserved.