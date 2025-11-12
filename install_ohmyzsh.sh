#!/bin/bash
# ============================================================
# Oh My Zsh + Powerlevel10k 자동 설치 스크립트 (Ubuntu 전용)
# Author: 라무
# ============================================================

set -e

echo "🚀 Oh My Zsh + Powerlevel10k 자동 설치 시작..."

# 1️⃣ 필요한 패키지 설치
echo "[1/7] Zsh, Git, Curl 설치 중..."
sudo apt update
sudo apt install -y zsh git curl wget fonts-powerline

# 2️⃣ 기본 셸을 Zsh로 변경
echo "[2/7] 기본 셸을 Zsh로 변경..."
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)"
else
    echo "기본 셸이 이미 Zsh입니다."
fi

# 3️⃣ Oh My Zsh 설치
echo "[3/7] Oh My Zsh 설치 중..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh 이미 설치됨."
fi

# 4️⃣ Powerlevel10k 테마 설치
echo "[4/7] Powerlevel10k 테마 설치 중..."
P10K_PATH="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ ! -d "$P10K_PATH" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_PATH"
else
    echo "Powerlevel10k 이미 설치됨."
fi

# 5️⃣ .zshrc 설정 수정
echo "[5/7] Zsh 설정 갱신..."
ZSHRC="$HOME/.zshrc"

# ZSH_THEME 변경
if grep -q '^ZSH_THEME=' "$ZSHRC"; then
    sed -i 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' "$ZSHRC"
else
    echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> "$ZSHRC"
fi

# 플러그인 설정
if grep -q '^plugins=' "$ZSHRC"; then
    sed -i 's|^plugins=.*|plugins=(git z sudo colored-man-pages history-substring-search)|' "$ZSHRC"
else
    echo 'plugins=(git z sudo colored-man-pages history-substring-search)' >> "$ZSHRC"
fi

# 6️⃣ 설정 적용
echo "[6/7] 설정 적용 중..."
source "$ZSHRC" || true

# 7️⃣ 완료 메시지
echo "✅ 설치 완료!"
echo "🔁 터미널을 완전히 닫았다가 다시 열면 Powerlevel10k 설정 마법사가 자동 실행됩니다."
echo "⚙️ 설정을 다시 실행하려면 다음 명령을 입력하세요:"
echo "   p10k configure"
