🖥️ Termux Toolbox

Your Terminal, Your Utilities.

"🇮🇩 Bahasa Indonesia" (#-bahasa-indonesia) | "🇬🇧 English" (#-english)

A lightweight, multifunctional Termux utility built with Bash Script, featuring a cyber-inspired interface and practical system maintenance tools.

---

🇮🇩 Bahasa Indonesia

📌 Tentang Proyek

Termux Toolbox adalah kumpulan utilitas berbasis Bash Script yang dirancang untuk mempermudah pengelolaan lingkungan Termux melalui satu menu interaktif.

Menggabungkan tampilan terminal bergaya cyber dengan berbagai fungsi pemeliharaan sistem, manajemen paket, analisis penyimpanan, dan diagnostik jaringan dalam satu tempat.

Dirancang agar ringan, praktis, dan mudah digunakan tanpa memerlukan akses root.

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

Setelah instalasi berhasil, jalankan Toolbox kapan saja dan dari direktori mana saja menggunakan:

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

Toolbox menyimpan riwayat aktivitas dan backup daftar paket pada direktori berikut:

~/.termux-toolbox/
├── logs/
└── backups/

Data tersebut disimpan secara terpisah dari direktori instalasi utama.

👨‍💻 Pembuat

RahmanGileh

Dibuat dan dikembangkan menggunakan Bash Script untuk lingkungan Termux.

Proyek ini berawal dari kebutuhan sederhana untuk mempermudah proses pemeliharaan Termux melalui satu menu interaktif.

Termux Toolbox — Your Terminal, Your Utilities.

---

🇬🇧 English

📌 About

Termux Toolbox is a collection of Bash-based utilities designed to simplify Termux environment management through a single interactive menu.

It combines a cyber-inspired terminal interface with practical tools for system maintenance, package management, storage analysis, and network diagnostics.

Designed to be lightweight, practical, and accessible without requiring root access.

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

Make sure an internet connection is available. Follow the installation commands provided in the Indonesian section above.

After successful installation, launch Toolbox from any directory using:

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

Toolbox stores activity logs and package list backups in:

~/.termux-toolbox/
├── logs/
└── backups/

These files are stored separately from the main installation directory.

👨‍💻 Developer

RahmanGileh

Created and developed using Bash Script for the Termux environment.

This project started from a simple idea: making Termux maintenance easier through a single interactive menu.

Termux Toolbox — Your Terminal, Your Utilities.

---

© RahmanGileh. Termux Toolbox.