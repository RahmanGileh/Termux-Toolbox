
#!/data/data/com.termux/files/usr/bin/bash

# ==================================================
# TERMUX TOOLBOX v1.0
# Cyber Utility Edition
# Safe | Lightweight | No Root
# ==================================================

# ---------- COLOR ENGINE ----------
R='\033[1;31m'
G='\033[1;32m'
C='\033[1;36m'
Y='\033[1;33m'
B='\033[1;34m'
W='\033[1;37m'
D='\033[0;90m'
N='\033[0m'

# ---------- DIRECTORY ----------
BASE="$HOME/.termux-toolbox"
LOGS="$BASE/logs"
BACKUPS="$BASE/backups"

mkdir -p "$LOGS" "$BACKUPS"

LOG_FILE="$LOGS/session_$(date +%Y%m%d).log"

# ---------- LOGGING ----------
exec > >(tee -a "$LOG_FILE") 2>&1

# ---------- BASIC FUNCTIONS ----------

pause() {
    echo
    read -r -p " [ENTER] Kembali ke menu..." _
}

line() {
    echo -e "${D}--------------------------------------------------${N}"
}

header() {
    clear
    echo -e "${C}"
    echo "  _______ ______ _____  __  __ _    _"
    echo " |__   __|  ____|  __ \|  \/  | |  | |"
    echo "    | |  | |__  | |__) | \  / | |  | |"
    echo "    | |  |  __| |  _  /| |\/| | |  | |"
    echo "    | |  | |____| | \ \| |  | | |__| |"
    echo "    |_|  |______|_|  \_\_|  |_|\____/"
    echo -e "${N}"
    echo -e "${G}          T O O L B O X   v1.0${N}"
    echo -e "${D}          CYBER UTILITY EDITION${N}"
    line
}

ask() {
    local answer
    read -r -p " [ ? ] $1 [y/N]: " answer
    [[ "$answer" =~ ^[Yy]$ ]]
}

has() {
    command -v "$1" >/dev/null 2>&1
}

disk_free() {
    df -h "$HOME" | awk 'NR==2 {print $4}'
}

status() {
    echo -e "${G}[ OK ]${N} $1"
}

warning() {
    echo -e "${Y}[ WARN ]${N} $1"
}

error() {
    echo -e "${R}[ ERROR ]${N} $1"
}

# ==================================================
# 1. SYSTEM INFORMATION
# ==================================================

system_info() {
    header

    echo -e "${C} [ SYSTEM INFORMATION ]${N}"
    line

    echo -e "${W} Android       : ${G}$(getprop ro.build.version.release 2>/dev/null || echo Unknown)${N}"
    echo -e "${W} Android SDK   : ${G}$(getprop ro.build.version.sdk 2>/dev/null || echo Unknown)${N}"
    echo -e "${W} Architecture  : ${G}$(uname -m)${N}"
    echo -e "${W} Kernel        : ${G}$(uname -r)${N}"
    echo -e "${W} Shell         : ${G}$SHELL${N}"
    echo -e "${W} Termux Prefix : ${G}$PREFIX${N}"

    line
    echo -e "${C} [ STORAGE INFORMATION ]${N}"
    df -h "$HOME"

    line
    echo -e "${C} [ PACKAGE COUNT ]${N}"

    if has dpkg-query; then
        dpkg-query -W -f='${binary:Package}\n' 2>/dev/null | wc -l
    fi

    pause
}

# ==================================================
# 2. SYSTEM UPDATER
# ==================================================

system_update() {
    header

    echo -e "${C} [ SYSTEM UPDATE ]${N}"
    line

    if ! has pkg; then
        error "Package manager tidak ditemukan."
        pause
        return
    fi

    echo -e "${Y} [1/2] Memperbarui repository...${N}"

    if ! pkg update; then
        error "Repository update gagal."
        pause
        return
    fi

    echo
    echo -e "${Y} [2/2] Upgrade paket...${N}"

    if pkg upgrade -y; then
        status "Upgrade selesai."
    else
        error "Upgrade gagal. Periksa pesan error."
    fi

    pause
}

# ==================================================
# 3. SYSTEM CLEANER
# ==================================================

cleaner() {
    header

    local before after

    before=$(disk_free)

    echo -e "${C} [ SYSTEM CLEANER ]${N}"
    echo -e " Ruang kosong sebelum: ${G}$before${N}"
    line

    echo -e "${Y} [1] Simulasi autoremove${N}"

    apt-get -s autoremove

    echo
    warning "Periksa daftar paket sebelum menghapus."

    if ask "Lanjutkan autoremove?"; then
        if apt-get autoremove -y; then
            status "Autoremove selesai."
        else
            error "Autoremove gagal."
        fi
    else
        warning "Autoremove dilewati."
    fi

    echo
    echo -e "${Y} [2] Membersihkan APT cache${N}"

    if apt-get clean && apt-get autoclean -y; then
        status "APT cache dibersihkan."
    else
        error "Pembersihan APT gagal."
    fi

    echo
    echo -e "${Y} [3] Membersihkan Python cache${N}"

    if has pip; then
        if ask "Bersihkan pip cache?"; then
            pip cache purge
        fi
    elif has pip3; then
        if ask "Bersihkan pip3 cache?"; then
            pip3 cache purge
        fi
    else
        warning "Pip tidak ditemukan."
    fi

    after=$(disk_free)

    line
    echo -e "${G} [ COMPLETE ]${N}"
    echo -e " Sebelum : $before"
    echo -e " Sesudah : $after"

    pause
}

# ==================================================
# 4. PACKAGE MANAGER
# ==================================================

package_manager() {
    while true; do
        header

        echo -e "${C} [ PACKAGE MANAGER ]${N}"
        line
        echo " 1. Cari paket"
        echo " 2. Lihat paket terpasang"
        echo " 3. Install paket"
        echo " 4. Hapus paket Termux"
        echo " 5. Kembali"
        line

        read -r -p " Pilihan: " choice

        case "$choice" in
            1)
                read -r -p " Nama paket: " name
                if [[ -n "$name" ]]; then
                    pkg search "$name"
                fi
                pause
                ;;

            2)
                pkg list-installed | less
                ;;

            3)
                read -r -p " Paket yang ingin diinstall: " name

                if [[ "$name" =~ ^[a-zA-Z0-9.+_-]+$ ]]; then
                    if ask "Install $name?"; then
                        pkg install "$name"
                    fi
                else
                    warning "Nama paket tidak valid."
                fi
                pause
                ;;

            4)
                read -r -p " Paket yang ingin dihapus: " name

                if [[ "$name" =~ ^[a-zA-Z0-9.+_-]+$ ]]; then
                    if ask "Yakin menghapus paket Termux $name?"; then
                        pkg uninstall "$name"
                    fi
                else
                    warning "Nama paket tidak valid."
                fi
                pause
                ;;

            5)
                break
                ;;

            *)
                warning "Pilihan tidak valid."
                sleep 1
                ;;
        esac
    done
}

# ==================================================
# 5. STORAGE ANALYZER
# ==================================================

storage_analyzer() {
    header

    echo -e "${C} [ STORAGE ANALYZER ]${N}"
    line

    echo -e "${Y} [1] Ringkasan penyimpanan${N}"
    df -h "$HOME"

    echo
    echo -e "${Y} [2] Folder terbesar di HOME${N}"

    du -h -d 1 "$HOME" 2>/dev/null | sort -hr | head -15

    echo
    echo -e "${D}Catatan: pemeriksaan folder bisa memerlukan waktu.${N}"

    pause
}

# ==================================================
# 6. NETWORK DIAGNOSTICS
# ==================================================

network_tools() {
    header

    echo -e "${C} [ NETWORK DIAGNOSTICS ]${N}"
    line

    echo -e "${Y} [1] Koneksi internet${N}"

    if has curl; then
        if curl -Is --max-time 8 https://termux.dev >/dev/null; then
            status "Koneksi HTTPS berhasil."
        else
            warning "Koneksi HTTPS gagal atau timeout."
        fi
    else
        warning "curl belum terpasang."
    fi

    echo
    echo -e "${Y} [2] Pemeriksaan DNS${N}"

    if has getent; then
        if getent hosts termux.dev; then
            status "DNS berhasil."
        else
            warning "DNS gagal."
        fi
    else
        warning "getent tidak tersedia."
    fi

    echo
    echo -e "${Y} [3] Pemeriksaan ping${N}"

    if has ping; then
        ping -c 4 -W 3 1.1.1.1
    else
        warning "Ping tidak tersedia."
    fi

    pause
}

# ==================================================
# 7. ADB MONITOR
# ==================================================

adb_monitor() {
    header

    echo -e "${C} [ ADB MONITOR ]${N}"
    line

    if ! has adb; then
        warning "ADB belum terpasang."
        echo "Install dengan: pkg install android-tools"
        pause
        return
    fi

    echo -e "${Y} [ CONNECTED DEVICES ]${N}"
    adb devices -l

    echo
    echo -e "${Y} [ OPTIONAL PACKAGE INSPECTION ]${N}"

    if ask "Lihat aplikasi pihak ketiga pada perangkat terhubung?"; then
        adb shell pm list packages -3
    fi

    echo
    warning "Mode monitor: tidak melakukan penghapusan aplikasi Android."

    pause
}

# ==================================================
# 8. BACKUP PACKAGE LIST
# ==================================================

backup_packages() {
    header

    echo -e "${C} [ PACKAGE BACKUP ]${N}"
    line

    local file="$BACKUPS/packages_$(date +%Y%m%d_%H%M%S).txt"

    if dpkg-query -W -f='${binary:Package}\n' > "$file" 2>/dev/null; then
        status "Daftar paket berhasil disimpan."
        echo
        echo "Lokasi backup:"
        echo "$file"
    else
        error "Backup gagal."
    fi

    pause
}

# ==================================================
# 9. ACTIVITY LOGS
# ==================================================

activity_logs() {
    header

    echo -e "${C} [ ACTIVITY LOGS ]${N}"
    line

    echo "Lokasi: $LOGS"
    echo

    ls -lh "$LOGS"

    echo
    if ask "Lihat log hari ini?"; then
        less "$LOG_FILE"
    fi

    pause
}

# ==================================================
# MAIN DASHBOARD
# ==================================================

while true; do
    header

    echo -e "${W} USER       : ${G}$(whoami)${N}"
    echo -e "${W} STORAGE    : ${G}$(disk_free) FREE${N}"
    echo -e "${W} DEVICE     : ${G}$(uname -m)${N}"
    echo -e "${W} STATUS     : ${G}TOOLBOX ONLINE${N}"

    line

    echo -e "${C} [ SYSTEM UTILITIES ]${N}"
    echo " 1. System Information"
    echo " 2. System Updater"
    echo " 3. System Cleaner"

    echo
    echo -e "${C} [ PACKAGE & STORAGE ]${N}"
    echo " 4. Package Manager"
    echo " 5. Storage Analyzer"
    echo " 6. Backup Package List"

    echo
    echo -e "${C} [ DIAGNOSTICS ]${N}"
    echo " 7. Network Diagnostics"
    echo " 8. ADB Monitor"
    echo " 9. Activity Logs"

    echo
    echo -e "${R} 0. Exit Toolbox${N}"

    line

    read -r -p " SELECT OPTION >> " option

    case "$option" in
        1) system_info ;;
        2) system_update ;;
        3) cleaner ;;
        4) package_manager ;;
        5) storage_analyzer ;;
        6) backup_packages ;;
        7) network_tools ;;
        8) adb_monitor ;;
        9) activity_logs ;;

        0)
            echo
            status "Session terminated."
            echo -e "${C}Thank you for using TERMUX TOOLBOX.${N}"
            exit 0
            ;;

        *)
            error "Invalid option."
            sleep 1
            ;;
    esac
done
