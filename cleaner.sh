#!/bin/bash

# Warna teks
red='\033[1;31m'
green='\033[1;32m'
cyan='\033[1;36m'
yellow='\033[1;33m'
nc='\033[0m'

# Fungsi Cek Sisa Penyimpanan Termux
cek_ruang() {
    df -h $PREFIX | awk 'NR==2 {print $4}'
}

# Fungsi Update Sistem (Tanpa Konfirmasi)
update_sistem() {
    echo -e "\n${yellow}[*] Memperbarui daftar repositori & meng-upgrade paket...${nc}"
    export DEBIAN_FRONTEND=noninteractive
    apt update -y
    apt upgrade -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"
    echo -e "${green}[✓] Pembaruan paket selesai!${nc}"
}

# Fungsi Bersihkan Paket & Cache + Indikator Ruang
bersihkan_sampah() {
    ruang_awal=$(cek_ruang)
    echo -e "\n${cyan}[i] Sisa ruang kosong sebelum dibersihkan: ${yellow}$ruang_awal${nc}"

    echo -e "\n${yellow}[1/3] Menghapus paket ketergantungan tidak terpakai...${nc}"
    apt autoremove -y

    echo -e "\n${yellow}[2/3] Membersihkan cache instalasi (apt clean)...${nc}"
    apt clean
    apt autoclean -y

    echo -e "\n${yellow}[3/3] Membersihkan cache pip (Python)...${nc}"
    if command -v pip &> /dev/null; then
        pip cache purge
    else
        echo "Pip tidak ditemukan, dilewati."
    fi

    ruang_akhir=$(cek_ruang)
    echo -e "\n${green}[✓] Pembersihan selesai!${nc}"
    echo -e "${cyan}[i] Sisa ruang kosong sekarang: ${green}$ruang_akhir${nc} (Sebelumnya: $ruang_awal)"
}

# Loop Menu Utama
while true; do
    clear
    echo -e "${cyan}==========================================${nc}"
    echo -e "${cyan}   TERMUX SYSTEM CLEANER & UPDATER MENU   ${nc}"
    echo -e "${cyan}==========================================${nc}"
    echo -e "Sisa Penyimpanan Saat Ini: ${green}$(cek_ruang)${nc}"
    echo -e "${cyan}------------------------------------------${nc}"
    echo -e "1. ${green}Update & Upgrade Paket Saja${nc}"
    echo -e "2. ${yellow}Bersihkan Paket & Cache Saja${nc}"
    echo -e "3. ${cyan}Jalankan Semua (Update + Bersihkan)${nc}"
    echo -e "4. ${red}Keluar${nc}"
    echo -e "${cyan}==========================================${nc}"
    read -p "Pilih menu [1-4]: " pilihan

    case $pilihan in
        1)
            update_sistem
            read -p "Tekan Enter untuk kembali ke menu..."
            ;;
        2)
            bersihkan_sampah
            read -p "Tekan Enter untuk kembali ke menu..."
            ;;
        3)
            update_sistem
            bersihkan_sampah
            read -p "Tekan Enter untuk kembali ke menu..."
            ;;
        4)
            echo -e "\n${green}Keluar dari tools. Terima kasih!${nc}"
            exit 0
            ;;
        *)
            echo -e "\n${red}[!] Pilihan tidak valid! Masukkan angka 1 sampai 4.${nc}"
            sleep 1.5
            ;;
    esac
done
