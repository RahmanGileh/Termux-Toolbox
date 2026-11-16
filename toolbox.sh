#!/data/data/com.termux/files/usr/bin/bash
# Termux Toolbox v1.1 - safer maintenance utilities
# Copyright (c) RahmanGileh

set -o pipefail

# ---------- ENVIRONMENT ----------
if [[ -z "${PREFIX:-}" || ! -x "${PREFIX}/bin/pkg" ]]; then
  printf 'ERROR: Script ini harus dijalankan dari aplikasi Termux.\n' >&2
  exit 1
fi

# ---------- COLORS ----------
if [[ -t 1 && -z "${NO_COLOR:-}" ]]; then
  R=$'\033[1;31m'; G=$'\033[1;32m'; C=$'\033[1;36m'
  Y=$'\033[1;33m'; W=$'\033[1;37m'; D=$'\033[0;90m'; N=$'\033[0m'
else
  R=''; G=''; C=''; Y=''; W=''; D=''; N=''
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

# Avoid logging terminal-control output and avoid a pipeline for interactive input.
if command -v tee >/dev/null 2>&1; then
  exec > >(tee -a "$LOG_FILE") 2>&1
fi

# ---------- HELPERS ----------
pause() {
  printf '\n%s[ENTER] Tekan Enter untuk kembali...%s' "$D" "$N"
  IFS= read -r _ || true
}

line() { printf '%s------------------------------------------------------------%s\n' "$D" "$N"; }

header() {
  clear 2>/dev/null || true
  printf '%s' "$C"
  cat <<'BANNER'
 _______ ______ _____  __  __ _    _
|__   __|  ____|  __ \|  \/  | |  | |
   | |  | |__  | |__) | \  / | |  | |
   | |  |  __| |  _  /| |\/| | |  | |
   | |  | |____| | \ \| |  | | |__| |
   |_|  |______|_|  \_\_|  |_|\____/
BANNER
  printf '%s%sTERMUX TOOLBOX v1.1%s\n' "$G" '          ' "$N"
  printf '%s       CYBER UTILITY EDITION%s\n' "$D" "$N"
  line
}

has() { command -v "$1" >/dev/null 2>&1; }

status()  { printf '%s[ OK ]%s %s\n' "$G" "$N" "$1"; }
warning() { printf '%s[ WARN ]%s %s\n' "$Y" "$N" "$1"; }
error()   { printf '%s[ ERROR ]%s %s\n' "$R" "$N" "$1"; }

ask() {
  local answer
  printf '%s [y/N]: ' "$1"
  IFS= read -r answer || return 1
  [[ "$answer" =~ ^[Yy]([Ee][Ss])?$ ]]
}

disk_free() {
  df -h "$HOME" 2>/dev/null | awk 'NR==2 {print $4; found=1} END {if (!found) print "Unknown"}'
}

valid_package_name() { [[ "$1" =~ ^[a-zA-Z0-9][a-zA-Z0-9.+_-]*$ ]]; }

show_pager() {
  if has less; then less -F -X
  else cat
  fi
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
  if ! has pkg; then error 'Perintah pkg tidak ditemukan.'; pause; return; fi
  warning 'Proses ini memperbarui paket di lingkungan Termux, bukan Android.'
  if ! ask 'Jalankan pkg update lalu pkg upgrade?'; then warning 'Update dibatalkan.'; pause; return; fi
  if ! pkg update; then error 'Pembaruan daftar repository gagal. Periksa mirror dan koneksi.'; pause; return; fi
  if pkg upgrade -y; then status 'Paket Termux berhasil diperbarui.'
  else error 'Upgrade gagal. Periksa pesan dari pkg.'; fi
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
  printf '%s[1] Simulasi paket autoremove%s\n' "$Y" "$N"
  if apt-get -s autoremove; then
    warning 'Simulasi di atas hanya perkiraan paket yang akan dihapus.'
    if ask 'Jalankan autoremove sungguhan? Periksa daftar paket dengan teliti'; then
      if apt-get autoremove; then status 'Autoremove selesai.'
      else error 'Autoremove gagal.'; fi
    else warning 'Autoremove dilewati.'; fi
  else
    warning 'Simulasi autoremove tidak berhasil; langkah ini dilewati.'
  fi
  printf '\n%s[2] Membersihkan cache APT%s\n' "$Y" "$N"
  if ask 'Hapus cache unduhan APT?'; then
    if apt-get clean && apt-get autoclean; then status 'Cache APT dibersihkan.'
    else error 'Pembersihan cache APT gagal.'; fi
  else warning 'Pembersihan cache APT dilewati.'; fi
  printf '\n%s[3] Cache Python%s\n' "$Y" "$N"
  if has pip; then
    if ask 'Bersihkan cache pip?'; then pip cache purge || warning 'Cache pip tidak berhasil dibersihkan.'; fi
  elif has pip3; then
    if ask 'Bersihkan cache pip3?'; then pip3 cache purge || warning 'Cache pip3 tidak berhasil dibersihkan.'; fi
  else warning 'pip tidak terpasang; bagian ini dilewati.'; fi
  after="$(disk_free)"
  line
  printf ' Ruang kosong sebelum : %s\n Ruang kosong sesudah : %s\n' "$before" "$after"
  warning 'Cleaner hanya mengelola cache dan paket Termux; tidak menyentuh aplikasi Android.'
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
        printf ' Nama/kata kunci paket: '; IFS= read -r name || continue
        if [[ -n "$name" ]]; then pkg search "$name"; else warning 'Kata kunci kosong.'; fi
        pause ;;
      2)
        pkg list-installed 2>&1 | show_pager ;;
      3)
        printf ' Nama paket yang ingin diinstall: '; IFS= read -r name || continue
        if valid_package_name "$name"; then
          if ask "Install paket '$name'?"; then pkg install "$name"; else warning 'Instalasi dibatalkan.'; fi
        else warning 'Nama paket tidak valid.'; fi
        pause ;;
      4)
        printf ' Nama paket Termux yang ingin dihapus: '; IFS= read -r name || continue
        if ! valid_package_name "$name"; then
          warning 'Nama paket tidak valid.'
        elif [[ "$name" =~ ^(apt|bash|coreutils|dpkg|termux-exec|termux-keyring|termux-tools|termux-am|termux-licenses)$ ]]; then
          error "Paket inti '$name' dilindungi agar Termux tidak rusak."
        elif ! dpkg-query -W -f='${Status}' "$name" 2>/dev/null | grep -q 'install ok installed'; then
          warning "Paket '$name' tidak terdeteksi sebagai paket terpasang."
        else
          printf '\nPaket yang dipilih: %s\n' "$name"
          warning 'Menghapus dependensi inti dapat merusak instalasi Termux.'
          if ask "Yakin menghapus paket '$name'?"; then pkg uninstall "$name"; else warning 'Penghapusan dibatalkan.'; fi
        fi
        pause ;;
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
  if has du; then du -h --max-depth=1 "$HOME" 2>/dev/null | sort -hr | head -15
  else warning 'Perintah du tidak tersedia.'; fi
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
    if curl -L -sS --connect-timeout 5 --max-time 12 -o /dev/null https://termux.dev; then status 'HTTPS ke termux.dev berhasil.'
    else warning 'HTTPS gagal/timeout. Periksa koneksi atau DNS.'; fi
  else warning 'curl tidak tersedia. Instal dengan: pkg install curl'; fi
  printf '\n%s[2] Tes DNS%s\n' "$Y" "$N"
  if has getent; then
    if getent hosts termux.dev; then status 'Resolusi DNS berhasil.'; else warning 'Resolusi DNS gagal.'; fi
  elif has nslookup; then
    if nslookup termux.dev; then status 'Pemeriksaan DNS selesai.'; else warning 'Resolusi DNS gagal.'; fi
  else warning 'getent/nslookup tidak tersedia; tes DNS dilewati.'; fi
  printf '\n%s[3] Tes ping (opsional)%s\n' "$Y" "$N"
  if has ping; then ping -c 3 -W 3 1.1.1.1 || warning 'Ping gagal; beberapa jaringan memang memblokir ICMP.'
  else warning 'ping tidak tersedia. Ini opsional; tidak perlu paket iputils.'; fi
  pause
}

# ---------- 7. ADB MONITOR ----------
adb_monitor() {
  header
  printf '%s[ ADB MONITOR ]%s\n' "$C" "$N"
  line
  if ! has adb; then
    warning 'ADB belum terpasang. Instal dengan: pkg install android-tools'
    pause; return
  fi
  local devices
  printf '%s[ CONNECTED DEVICES ]%s\n' "$Y" "$N"
  adb devices -l
  devices="$(adb devices | awk 'NR>1 && $2=="device" {count++} END {print count+0}')"
  if [[ "$devices" -eq 0 ]]; then
    warning 'Belum ada perangkat berstatus device. Hubungkan melalui Wireless debugging terlebih dahulu.'
    pause; return
  fi
  printf '\n%s[ OPTIONAL PACKAGE INSPECTION ]%s\n' "$Y" "$N"
  if ask 'Lihat daftar aplikasi pihak ketiga pada perangkat yang terhubung?'; then
    adb shell pm list packages -3 || warning 'Gagal membaca daftar aplikasi. Periksa izin/koneksi ADB.'
  fi
  printf '\n'
  warning 'Mode monitor hanya membaca informasi; tidak menghapus aplikasi Android.'
  pause
}

# ---------- 8. PACKAGE BACKUP ----------
backup_packages() {
  header
  printf '%s[ PACKAGE LIST BACKUP ]%s\n' "$C" "$N"
  line
  local file tmp
  file="$BACKUPS/packages_$(date +%Y%m%d_%H%M%S).txt"
  tmp="${file}.tmp"
  if ! has dpkg-query; then error 'dpkg-query tidak tersedia.'; pause; return; fi
  if dpkg-query -W -f='${binary:Package}\n' > "$tmp" 2>/dev/null && [[ -s "$tmp" ]]; then
    mv "$tmp" "$file"
    status 'Daftar paket berhasil disimpan.'
    printf ' Lokasi: %s\n' "$file"
    printf ' Jumlah: %s paket\n' "$(wc -l < "$file" | tr -d ' ')"
  else
    rm -f "$tmp"
    error 'Backup gagal atau daftar paket kosong.'
  fi
  pause
}

# ---------- 9. ACTIVITY LOGS ----------
activity_logs() {
  header
  printf '%s[ ACTIVITY LOGS ]%s\n' "$C" "$N"
  line
  printf ' Lokasi log: %s\n\n' "$LOGS"
  ls -lh "$LOGS" 2>/dev/null || warning 'Belum ada file log.'
  printf '\n'
  if [[ -f "$LOG_FILE" ]] && ask 'Lihat log hari ini?'; then
    # Temporarily stop tee logging while reading the same log file.
    if has less; then less -F "$LOG_FILE"; else tail -n 200 "$LOG_FILE"; fi
  fi
  pause
}

# ---------- MAIN DASHBOARD ----------
while true; do
  header
  printf '%s USER    : %s%s\n' "$W" "$(id -un 2>/dev/null || whoami)" "$N"
  printf '%s STORAGE : %s FREE%s\n' "$W" "$(disk_free)" "$N"
  printf '%s DEVICE  : %s%s\n' "$W" "$(uname -m 2>/dev/null || echo Unknown)" "$N"
  printf '%s STATUS  : %sTOOLBOX ONLINE%s\n' "$W" "$G" "$N"
  line
  printf '%s[ SYSTEM UTILITIES ]%s\n' "$C" "$N"
  printf ' 1. System Information\n 2. System Updater\n 3. System Cleaner\n\n'
  printf '%s[ PACKAGE & STORAGE ]%s\n' "$C" "$N"
  printf ' 4. Package Manager\n 5. Storage Analyzer\n 6. Backup Package List\n\n'
  printf '%s[ DIAGNOSTICS ]%s\n' "$C" "$N"
  printf ' 7. Network Diagnostics\n 8. ADB Monitor\n 9. Activity Logs\n\n'
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
    8) adb_monitor ;;
    9) activity_logs ;;
    0) printf '\n'; status 'Session terminated.'; printf 'Thank you for using TERMUX TOOLBOX.\n'; exit 0 ;;
    *) error 'Pilihan tidak valid.'; sleep 1 ;;
  esac
done
