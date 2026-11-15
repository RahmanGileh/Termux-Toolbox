🖥️ Termux Toolbox

"🇮🇩 Bahasa Indonesia" (#-bahasa-indonesia) | "🇬🇧 English" (#-english)

A lightweight, multifunctional Termux utility built with Bash Script, featuring a cyber-inspired interface and practical system maintenance tools.

---

🇮🇩 Bahasa Indonesia

Termux Toolbox adalah kumpulan utilitas berbasis Bash Script yang dirancang untuk mempermudah pengelolaan lingkungan Termux melalui satu menu interaktif.

Menggabungkan tampilan terminal bergaya cyber dengan fungsi utilitas yang praktis, ringan, dan mudah digunakan.

✨ Fitur Utama

* System Information: Menampilkan informasi Android, kernel, arsitektur perangkat, dan penyimpanan.
* System Updater: Memperbarui repositori dan seluruh paket Termux.
* System Cleaner: Membersihkan dependensi yang tidak terpakai, cache APT, dan cache Python.
* Package Manager: Mencari, memasang, melihat, dan menghapus paket Termux.
* Storage Analyzer: Menganalisis penggunaan penyimpanan dan folder terbesar.
* Network Diagnostics: Memeriksa koneksi internet, DNS, dan konektivitas jaringan.
* ADB Monitor: Memantau perangkat Android yang terhubung melalui ADB.
* Package Backup: Menyimpan daftar paket yang terpasang.
* Activity Logs: Menyimpan riwayat aktivitas Toolbox.

🛡️ Keamanan

* Tidak membutuhkan akses root.
* Tidak menghapus aplikasi sistem Android secara otomatis.
* Menyediakan simulasi sebelum proses autoremove.
* Meminta konfirmasi untuk operasi penghapusan paket.
* Dirancang untuk pemeliharaan lingkungan Termux secara lebih aman.

🚀 Instalasi & Penggunaan

Pastikan Git sudah tersedia:

pkg update && pkg install git -y

Clone repository:

git clone https://github.com/RahmanGileh/termux-cleaner Termux-Toolbox

Masuk ke direktori:

cd ~/Termux-Toolbox

Berikan izin eksekusi:

chmod +x toolbox.sh

Pasang command global:

ln -sf "$HOME/Termux-Toolbox/toolbox.sh" "$PREFIX/bin/toolbox"

Sekarang jalankan dari direktori mana saja:

toolbox

📋 Menu Utama

Menu| Fungsi
1| System Information
2| System Updater
3| System Cleaner
4| Package Manager
5| Storage Analyzer
6| Backup Package List
7| Network Diagnostics
8| ADB Monitor
9| Activity Logs
0| Exit

📦 Dependensi Tambahan

Beberapa fitur membutuhkan paket tambahan:

pkg install curl less iputils

Untuk fitur ADB:

pkg install android-tools

📁 Direktori Data

Termux-Toolbox/
├── toolbox.sh
├── logs/
└── backups/

Log dan backup digunakan untuk menyimpan riwayat aktivitas serta daftar paket yang terpasang.

---

🇬🇧 English

Termux Toolbox is a lightweight collection of Bash-based utilities designed to simplify Termux environment management through a single interactive menu.

Combining a cyber-inspired terminal interface with practical system utilities, it provides a convenient and accessible maintenance experience.

✨ Key Features

* System Information: Displays Android, kernel, device architecture, and storage information.
* System Updater: Updates repositories and upgrades installed Termux packages.
* System Cleaner: Removes unused dependencies and clears APT and Python caches.
* Package Manager: Searches, installs, lists, and removes Termux packages.
* Storage Analyzer: Examines storage usage and identifies large directories.
* Network Diagnostics: Checks internet connectivity, DNS, and basic network connectivity.
* ADB Monitor: Monitors Android devices connected through ADB.
* Package Backup: Saves a list of installed packages.
* Activity Logs: Records Toolbox activity history.

🛡️ Safety

* No root access required.
* Does not automatically remove Android system applications.
* Provides an autoremove simulation before package removal.
* Requests confirmation for package removal operations.
* Designed for safer Termux environment maintenance.

🚀 Installation & Usage

Install Git:

pkg update && pkg install git -y

Clone the repository:

git clone https://github.com/RahmanGileh/termux-cleaner Termux-Toolbox

Enter the project directory:

cd ~/Termux-Toolbox

Grant execution permission:

chmod +x toolbox.sh

Create a global command:

ln -sf "$HOME/Termux-Toolbox/toolbox.sh" "$PREFIX/bin/toolbox"

Run the Toolbox from anywhere:

toolbox

📋 Main Menu

Menu| Function
1| System Information
2| System Updater
3| System Cleaner
4| Package Manager
5| Storage Analyzer
6| Backup Package List
7| Network Diagnostics
8| ADB Monitor
9| Activity Logs
0| Exit

📦 Additional Dependencies

For additional utilities:

pkg install curl less iputils

For ADB functionality:

pkg install android-tools

---

👨‍💻 Author

RahmanGileh

Developed with Bash Script for the Termux environment.

📜 License

Open-source project. License details will be provided in the repository.

---

Termux Toolbox — Your Terminal, Your Utilities.