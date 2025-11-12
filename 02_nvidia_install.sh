#!/bin/bash
# ==============================================================
# NVIDIA 공식 저장소 추가 및 RTX 5080 권장 드라이버 설치 스크립트
# ==============================================================

set -e

echo "[1/4] NVIDIA 그래픽 드라이버 PPA 추가..."
sudo add-apt-repository ppa:graphics-drivers/ppa -y
sudo apt update

echo "[2/4] 추천 드라이버 검색..."
ubuntu-drivers devices | grep "recommended" || echo "추천 드라이버를 찾지 못했습니다."

echo "[3/4] 권장 드라이버 자동 설치..."
sudo ubuntu-drivers autoinstall

echo "[4/4] 설치 완료! 재부팅 후 nvidia-smi로 확인하세요."
echo ">>> 예: nvidia-smi"
