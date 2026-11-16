#!/data/data/com.termux/files/usr/bin/bash
# TERMUX TOOLBOX v2.0 - practical maintenance utilities
# Copyright (c) RahmanGileh
# No root required. Android apps are never uninstalled by this script.

set -o pipefail

# ---------- ENVIRONMENT ----------
if [[ -z "${PREFIX:-}" || ! -x "${PREFIX}/bin/pkg" ]]; then
  printf 'ERROR: Jalankan script ini dari aplikasi Termux.\n' >&2
  exit 1
fi

# ---------- COLORS ----------
if [[ -t 1 && -z "${NO_COLOR:-}" ]]; then
  R=$'\033[1;31m'; G=$'\033[1;32m'; C=$'\033[1;36m'
  Y=$'\033[1;33m'; W=$'\033[1;37m'; D=$'\033[0;90m'
  M=$'\033[1;35m'; N=$'\033[0m'
else
  R=''; G=''; C=''; Y=''; W=''; D=''; M=''; N=''
fi

# ---------- DATA DIRECTORIES ----------
BASE="${HOME}/.termux-toolbox"
LOGS="${BASE}/logs"
BACKUPS="${BASE}/backups"
if ! mkdir -p "$LOGS" "$BACKUPS"; then
  printf 'ERROR: Tidak bisa membuat direktori data: %s\n' "$BASE" >&2
  exit 1
fi
LOG_FILE="$LOGS/session_$(date +%Y%m%d).log"

# Log to file when tee is available; terminal output remains visible.
if command -v tee >/dev/null 2>&1; then
  exec > >(tee -a "$LOG_FILE") 2>&1
fi

# ---------- HELPERS ----------
has() { command -v "$1" >/dev/null 2>&1; }

pause() {
  printf '\n%s[ ENTER ]%s Tekan Enter untuk kembali...' "$D" "$N"
  IFS= read -r _ || true
}

line() {
  printf '%s━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━%s\n' "$D" "$N"
}

header() {
  clear 2>/dev/null || true
  printf '%s' "$C"
  cat <<'BANNER'
╔══════════════════════════════════════════════════════════════╗
║  _____ _____ ____  __  __ _   _ _  __   _____ ___   ___  _   ║
║ |_   _| ____|  _ \|  \/  | | | | |/ /  |_   _/ _ \ / _ \| |  ║
║   | | |  _| | |_) | |\/| | | | | ' /     | || | | | | | | |  ║
║   | | | |___|  _ <| |  | | |_| | . \     | || |_| | |_| | |__║
║   |_| |_____|_| \_\_|  |_|\___/|_|\_\    |_| \___/ \___/|____║
╚══════════════════════════════════════════════════════════════╝
BANNER
  printf '%s             TERMUX TOOLBOX v2.0%s\n' "$G" "$N"
  printf '%s       SMALL TOOLBOX. LESS MANUAL CHAOS.%s\n' "$D" "$N"
  line
}

status()  { printf '%s[  OK  ]%s %s\n' "$G" "$N" "$1"; }
warning() { printf '%s[ WARN ]%s %s\n' "$Y" "$N" "$1"; }
error()   { printf '%s[ FAIL ]%s %s\n' "$R" "$N" "$1"; }
info()    { printf '%s[ INFO ]%s %s\n' "$C" "$N" "$1"; }

ask() {
  local answer
  printf '%s [y/N]: ' "$1"
  IFS= read -r answer || return 1
  [[ "$answer" =~ ^[Yy]([Ee][Ss])?$ ]]
}

disk_free() {
  df -h "$HOME" 2>/dev/null | awk 'NR==2 {print $4; found=1} END {if (!found) print "Unknown"}'
}

valid_package_name() {
  [[ "$1" =~ ^[a-zA-Z0-9][a-zA-Z0-9.+_-]*$ ]]
}

show_pager() {
  if has less; then less -F -X
  else cat
  fi
}

package_installed() {
  local state
  state="$(dpkg-query -W -f='${db:Status-Status}' "$1" 2>/dev/null || true)"
  [[ "$state" == "installed" ]]
}

# Packages that should not be removed through this menu.
is_protected_package() {
  case "$1" in
    apt|bash|coreutils|dpkg|findutils|grep|ncurses|ncurses-utils|sed|tar|termux-exec|termux-keyring|termux-tools|termux-am|termux-licenses|curl|less|libcurl)
      return 0 ;;
    *) return 1 ;;
  esac
}

# ---------- 1. SYSTEM INFORMATION ----------
system_info() {
  header
  printf '%s[ SYSTEM INFORMATION ]%s\n' "$C" "$N"
  line
  local android sdk shell_name package_count
  android="$(getprop ro.build.version.release 2>/dev/null || true)"
  sdk="$(getprop ro.build.version.sdk 2>/dev/null || true)"
  shell_name="${SHELL:-Unknown}"
  [[ -n "$android" ]] || android='Unknown'
  [[ -n "$sdk" ]] || sdk='Unknown'
  printf ' Android version : %s\n' "$android"
  printf ' Android SDK     : %s\n' "$sdk"
  printf ' Architecture    : %s\n' "$(uname -m 2>/dev/null || echo Unknown)"
  printf ' Kernel          : %s\n' "$(uname -r 2>/dev/null || echo Unknown)"
  printf ' Shell           : %s\n' "$shell_name"
  printf ' Termux prefix   : %s\n' "$PREFIX"
  line
  printf '%s[ STORAGE ]%s\n' "$C" "$N"
  df -h "$HOME" 2>/dev/null || warning 'Informasi penyimpanan tidak tersedia.'
  line
  printf '%s[ INSTALLED TERMUX PACKAGES ]%s\n' "$C" "$N"
  if has dpkg-query; then
    package_count="$(dpkg-query -W -f='${binary:Package}\n' 2>/dev/null | wc -l | tr -d ' ')"
    printf ' Jumlah paket: %s\n' "${package_count:-0}"
  else
    warning 'dpkg-query tidak tersedia.'
  fi
  pause
}

# ---------- 2. SYSTEM UPDATER ----------
system_update() {
  header
  printf '%s[ SYSTEM UPDATER ]%s\n' "$C" "$N"
  line
  warning 'Fitur ini memperbarui paket di lingkungan Termux, bukan Android.'
  if ! ask 'Jalankan pkg update lalu pkg upgrade?'; then
    warning 'Pembaruan dibatalkan.'
    pause
    return
  fi
  if ! pkg update; then
    error 'Pembaruan daftar repository gagal. Periksa koneksi atau mirror.'
    pause
    return
  fi
  if pkg upgrade; then status 'Proses upgrade selesai.'
  else error 'Upgrade gagal. Baca pesan dari package manager.'; fi
  pause
}

# ---------- 3. SYSTEM CLEANER ----------
cleaner() {
  header
  local before after
  before="$(disk_free)"
  printf '%s[ SYSTEM CLEANER ]%s\n' "$C" "$N"
  printf ' Ruang kosong sebelum: %s\n' "$before"
  line

  printf '%s[1] Simulasi autoremove%s\n' "$Y" "$N"
  if apt-get -s autoremove; then
    warning 'Daftar di atas adalah simulasi, belum ada paket yang dihapus.'
    warning 'Periksa nama paket sebelum menyetujui penghapusan sungguhan.'
    if ask 'Jalankan apt autoremove sekarang?'; then
      if apt autoremove; then status 'Autoremove selesai.'
      else error 'Autoremove gagal. Tidak ada tindakan paksa yang dilakukan.'; fi
    else
      warning 'Autoremove dilewati.'
    fi
  else
    warning 'Simulasi autoremove gagal; bagian ini dilewati.'
  fi

  printf '\n%s[2] Membersihkan cache APT%s\n' "$Y" "$N"
  if ask 'Hapus cache unduhan APT?'; then
    if apt clean && apt autoclean; then status 'Cache APT dibersihkan.'
    else error 'Pembersihan cache APT gagal.'; fi
  else
    warning 'Pembersihan cache APT dilewati.'
  fi

  printf '\n%s[3] Cache Python%s\n' "$Y" "$N"
  if has pip; then
    if ask 'Bersihkan cache pip?'; then
      pip cache purge || warning 'Cache pip tidak berhasil dibersihkan.'
    fi
  elif has pip3; then
    if ask 'Bersihkan cache pip3?'; then
      pip3 cache purge || warning 'Cache pip3 tidak berhasil dibersihkan.'
    fi
  else
    info 'pip tidak terpasang; bagian ini dilewati.'
  fi

  after="$(disk_free)"
  line
  printf ' Ruang kosong sebelum : %s\n Ruang kosong sesudah : %s\n' "$before" "$after"
  warning 'Cleaner mengelola paket/cache Termux. Fitur ini tidak menghapus aplikasi Android.'
  pause
}

# ---------- 4. PACKAGE MANAGER ----------
package_manager() {
  local choice name
  while true; do
    header
    printf '%s[ PACKAGE MANAGER ]%s\n' "$C" "$N"
    line
    printf ' 1. Cari paket\n 2. Lihat paket terpasang\n 3. Install paket\n 4. Hapus paket Termux\n 5. Kembali\n'
    line
    printf ' Pilihan: '
    IFS= read -r choice || return
    case "$choice" in
      1)
        printf ' Nama/kata kunci paket: '
        IFS= read -r name || continue
        if [[ -n "$name" ]]; then pkg search "$name"
        else warning 'Kata kunci kosong.'; fi
        pause
        ;;
      2)
        pkg list-installed 2>&1 | show_pager
        pause
        ;;
      3)
        printf ' Nama paket yang ingin di-install: '
        IFS= read -r name || continue
        if ! valid_package_name "$name"; then
          warning 'Nama paket tidak valid.'
        elif ask "Install paket '$name'?"; then
          pkg install "$name"
        else
          warning 'Instalasi dibatalkan.'
        fi
        pause
        ;;
      4)
        printf ' Nama paket Termux yang ingin dihapus: '
        IFS= read -r name || continue
        if ! valid_package_name "$name"; then
          warning 'Nama paket tidak valid.'
        elif is_protected_package "$name"; then
          error "Paket '$name' dilindungi karena penting bagi Termux atau fitur toolbox."
        elif ! package_installed "$name"; then
          warning "Paket '$name' tidak terdeteksi sebagai paket terpasang."
        else
          printf '\nPaket yang dipilih: %s\n' "$name"
          warning 'Menghapus paket dapat memengaruhi program lain yang bergantung padanya.'
          if ask "Yakin menghapus paket '$name'?"; then
            pkg uninstall "$name"
          else
            warning 'Penghapusan dibatalkan.'
          fi
        fi
        pause
        ;;
      5) break ;;
      *) warning 'Pilihan tidak valid.'; sleep 1 ;;
    esac
  done
}

# ---------- 5. STORAGE ANALYZER ----------
storage_analyzer() {
  header
  printf '%s[ STORAGE ANALYZER ]%s\n' "$C" "$N"
  line
  printf '%s[1] Ringkasan penyimpanan HOME%s\n' "$Y" "$N"
  df -h "$HOME" 2>/dev/null || warning 'Tidak dapat membaca kapasitas penyimpanan.'
  printf '\n%s[2] Folder terbesar di HOME%s\n' "$Y" "$N"
  if has du; then
    du -h --max-depth=1 "$HOME" 2>/dev/null | sort -hr | head -15
  else
    warning 'Perintah du tidak tersedia.'
  fi
  printf '\n%sCatatan: pemindaian folder dapat memerlukan waktu.%s\n' "$D" "$N"
  pause
}

# ---------- 6. NETWORK DIAGNOSTICS ----------
network_tools() {
  header
  printf '%s[ NETWORK DIAGNOSTICS ]%s\n' "$C" "$N"
  line
  printf '%s[1] Tes HTTPS%s\n' "$Y" "$N"
  if has curl; then
    if curl -L -sS --connect-timeout 5 --max-time 12 -o /dev/null https://termux.dev; then
      status 'HTTPS ke termux.dev berhasil.'
    else
      warning 'HTTPS gagal/timeout. Periksa koneksi atau DNS.'
    fi
  else
    warning 'curl tidak tersedia. Tes HTTPS dilewati.'
  fi

  printf '\n%s[2] Tes DNS%s\n' "$Y" "$N"
  if has getent; then
    if getent hosts termux.dev; then status 'Resolusi DNS berhasil.'
    else warning 'Resolusi DNS gagal.'; fi
  elif has nslookup; then
    if nslookup termux.dev; then status 'Pemeriksaan DNS selesai.'
    else warning 'Resolusi DNS gagal.'; fi
  else
    warning 'getent/nslookup tidak tersedia; tes DNS dilewati.'
  fi

  printf '\n%s[3] Tes ping (opsional)%s\n' "$Y" "$N"
  if has ping; then
    ping -c 3 -W 3 1.1.1.1 || warning 'Ping gagal; beberapa jaringan memblokir ICMP.'
  else
    info 'ping tidak tersedia. Ini opsional dan tidak perlu dipasang hanya untuk toolbox.'
  fi
  pause
}

# ---------- 7. PACKAGE BACKUP ----------
backup_packages() {
  header
  printf '%s[ PACKAGE LIST BACKUP ]%s\n' "$C" "$N"
  line
  local file tmp
  file="$BACKUPS/packages_$(date +%Y%m%d_%H%M%S).txt"
  tmp="${file}.tmp"

  if ! has dpkg-query; then
    error 'dpkg-query tidak tersedia.'
    pause
    return
  fi

  if dpkg-query -W -f='${binary:Package}\n' > "$tmp" 2>/dev/null && [[ -s "$tmp" ]]; then
    if mv "$tmp" "$file"; then
      status 'Daftar paket berhasil disimpan.'
      printf ' Lokasi: %s\n' "$file"
      printf ' Jumlah: %s paket\n' "$(wc -l < "$file" | tr -d ' ')"
    else
      rm -f "$tmp"
      error 'Tidak bisa memindahkan file backup ke lokasi tujuan.'
    fi
  else
    rm -f "$tmp"
    error 'Backup gagal atau daftar paket kosong.'
  fi
  warning 'Backup ini hanya daftar nama paket, bukan APK, konfigurasi, atau data aplikasi.'
  pause
}

# ---------- 8. ACTIVITY LOGS ----------
activity_logs() {
  header
  printf '%s[ ACTIVITY LOGS ]%s\n' "$C" "$N"
  line
  printf ' Lokasi log: %s\n\n' "$LOGS"
  ls -lh "$LOGS" 2>/dev/null || warning 'Belum ada file log.'
  printf '\n'
  if [[ -f "$LOG_FILE" ]] && ask 'Lihat log hari ini?'; then
    if has less; then less -F "$LOG_FILE"
    else tail -n 200 "$LOG_FILE"; fi
  fi
  pause
}

# ---------- MAIN DASHBOARD ----------
while true; do
  header
  printf '%s USER    : %s%s\n' "$W" "$(id -un 2>/dev/null || whoami)" "$N"
  printf '%s STORAGE : %s FREE%s\n' "$W" "$(disk_free)" "$N"
  printf '%s DEVICE  : %s%s\n' "$W" "$(uname -m 2>/dev/null || echo Unknown)" "$N"
  printf '%s STATUS  : %sTOOLBOX READY%s\n' "$W" "$G" "$N"
  line
  printf '%s[ SYSTEM UTILITIES ]%s\n' "$C" "$N"
  printf ' 1. System Information\n 2. System Updater\n 3. System Cleaner\n\n'
  printf '%s[ PACKAGE & STORAGE ]%s\n' "$C" "$N"
  printf ' 4. Package Manager\n 5. Storage Analyzer\n 6. Backup Package List\n\n'
  printf '%s[ DIAGNOSTICS ]%s\n' "$C" "$N"
  printf ' 7. Network Diagnostics\n 8. Activity Logs\n\n'
  printf '%s 0. Exit Termux Toolbox%s\n' "$R" "$N"
  line
  printf ' SELECT OPTION >> '
  IFS= read -r option || { printf '\n'; break; }
  case "$option" in
    1) system_info ;;
    2) system_update ;;
    3) cleaner ;;
    4) package_manager ;;
    5) storage_analyzer ;;
    6) backup_packages ;;
    7) network_tools ;;
    8) activity_logs ;;
    0)
      printf '\n'
      status 'Session terminated.'
      printf 'Thank you for using TERMUX TOOLBOX.\n'
      exit 0
      ;;
    *) error 'Pilihan tidak valid.'; sleep 1 ;;
  esac
done