#!/bin/bash
# ============================================================
# Ubuntu용 SSH 서버 + mDNS 설치 스크립트 (ping 설치 포함)
# ============================================================

set -e

echo "🚀 SSH + mDNS 설치 시작..."

# ----------------------------
# 1️⃣ 패키지 업데이트
# ----------------------------
echo "[1/5] apt 패키지 목록 업데이트..."
sudo apt update

# ----------------------------
# 2️⃣ OpenSSH 서버 설치
# ----------------------------
echo "[2/5] OpenSSH 서버 설치 중..."
sudo apt install -y openssh-server

# SSH 서비스 활성화
sudo systemctl enable ssh
sudo systemctl start ssh

# ----------------------------
# 3️⃣ Avahi (mDNS) 및 ping 설치
# ----------------------------
echo "[3/5] Avahi(mDNS) 및 ping 설치 중..."
sudo apt install -y avahi-daemon avahi-utils libnss-mdns iputils-ping

# Avahi 서비스 활성화
sudo systemctl enable avahi-daemon
sudo systemctl start avahi-daemon

# ----------------------------
# 4️⃣ 방화벽 확인 및 허용
# ----------------------------
echo "[4/5] SSH 포트 허용 (ufw 사용 시)..."
if command -v ufw >/dev/null 2>&1; then
    sudo ufw allow ssh
fi

# ----------------------------
# 5️⃣ 설치 완료 및 Avahi 상태 출력
# ----------------------------
echo "[5/5] 설치 완료!"
echo
echo "🔹 SSH 접속: ssh <username>@<ip주소>"
echo "🔹 mDNS 접속: ssh <username>@<hostname>.local (물리 Linux 환경에서만 가능)"
echo
echo "🔹 Avahi 상태 확인:"
sudo systemctl status avahi-daemon
