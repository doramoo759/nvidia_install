#!/bin/bash
# ==============================================================
# NVIDIA 드라이버 완전 제거 및 Nouveau 비활성화 스크립트
# ==============================================================

set -e

echo "[1/6] 다중 사용자 모드로 전환..."
sudo systemctl isolate multi-user.target || true

echo "[2/6] 기존 NVIDIA 드라이버 제거..."
sudo apt purge 'nvidia*' -y
sudo apt autoremove --purge -y

echo "[3/6] 잔여 설정 파일 정리..."
sudo rm -rf /etc/X11/xorg.conf /usr/share/X11/xorg.conf.d/10-nvidia.conf
sudo rm -rf /lib/modprobe.d/nvidia* /etc/modprobe.d/nvidia* /etc/modules-load.d/nvidia*
sudo rm -rf /var/lib/nvidia-driver /usr/share/nvidia

echo "[4/6] Nouveau 블랙리스트 설정..."
echo -e "blacklist nouveau\noptions nouveau modeset=0" | sudo tee /etc/modprobe.d/blacklist-nouveau.conf > /dev/null

echo "[5/6] initramfs 재생성..."
sudo update-initramfs -u

echo "[6/6] 재부팅을 수행해야 nouveau가 완전히 비활성화됩니다."
echo ">>> sudo reboot 실행 후 다음 단계 스크립트를 수행하세요."
