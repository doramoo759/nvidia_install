#!/bin/bash
# ============================================================
# Ubuntu용 Miniconda 설치 스크립트
# ============================================================

set -e

echo "🚀 Miniconda 설치 시작..."

# 1️⃣ 설치 경로 설정
MINICONDA_PATH="$HOME/miniconda3"

# 2️⃣ 설치 여부 확인
if [ -d "$MINICONDA_PATH" ]; then
    echo "Miniconda가 이미 설치되어 있습니다: $MINICONDA_PATH"
    exit 0
fi

# 3️⃣ Miniconda 다운로드
echo "[1/3] Miniconda 설치 파일 다운로드 중..."
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh

# 4️⃣ Miniconda 설치
echo "[2/3] Miniconda 설치 중..."
bash ~/miniconda.sh -b -p "$MINICONDA_PATH"

# 5️⃣ 설치 파일 삭제
rm ~/miniconda.sh

# 6️⃣ Conda 초기화
echo "[3/3] Conda 초기화 중..."
eval "$($MINICONDA_PATH/bin/conda shell.bash hook)"
conda init zsh

# 7️⃣ 완료 메시지
echo "✅ Miniconda 설치 완료!"
echo "설치 경로: $MINICONDA_PATH"
echo "터미널을 재시작하거나 'zsh'를 입력 후 Conda 사용 가능"
echo "예: conda create -n myenv python=3.11 && conda activate myenv"
