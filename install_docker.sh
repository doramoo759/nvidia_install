#!/bin/bash
# ============================================================
# Ubuntu용 Docker 설치 + sudo 없이 사용 가능 설정 스크립트
# ============================================================

set -e

echo "🚀 Docker 설치 시작..."

# ----------------------------
# 1️⃣ 필수 패키지 설치
# ----------------------------
echo "[1/5] 필수 패키지 설치 중..."
sudo apt update
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# ----------------------------
# 2️⃣ Docker GPG key 추가
# ----------------------------
echo "[2/5] Docker GPG key 추가..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# ----------------------------
# 3️⃣ Docker repository 추가
# ----------------------------
echo "[3/5] Docker repository 추가..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# ----------------------------
# 4️⃣ Docker 설치
# ----------------------------
echo "[4/5] Docker 설치 중..."
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# ----------------------------
# 5️⃣ sudo 없이 사용 가능하도록 설정
# ----------------------------
echo "[5/5] 현재 사용자 docker 그룹에 추가..."
sudo groupadd -f docker
sudo usermod -aG docker $USER

echo "✅ Docker 설치 완료!"
echo "⚠️ 터미널을 완전히 닫았다가 다시 열어야 권한 변경 적용됨."
echo "테스트: docker run hello-world"
