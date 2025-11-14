#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$NAME
        VER=$VERSION_ID
    else
        echo -e "${RED}❌ Não foi possível detectar o sistema operacional${NC}"
        exit 1
    fi
}

install_base_packages() {
    echo -e "${BLUE}📦 Instalando pacotes base...${NC}"
    
    if [[ "$OS" == *"Ubuntu"* ]]; then
        sudo apt update
        sudo apt install -y zsh git curl wget unzip build-essential \
            fonts-powerline software-properties-common apt-transport-https \
            ca-certificates gnupg lsb-release
    elif [[ "$OS" == *"Rocky"* ]] || [[ "$OS" == *"CentOS"* ]] || [[ "$OS" == *"RHEL"* ]]; then
        sudo dnf update -y
        sudo dnf install -y zsh git curl wget unzip gcc gcc-c++ make \
            fontconfig-devel libX11-devel libXft-devel libXext-devel \
            libXrender-devel libXinerama-devel libXi-devel libXrandr-devel \
            libXcursor-devel libXcomposite-devel libXdamage-devel \
            libXfixes-devel libXss-devel libXtst-devel alsa-lib-devel \
            mesa-libEGL-devel mesa-libGL-devel mesa-libGLU-devel \
            mesa-libgbm-devel mesa-libwayland-egl-devel mesa-libxatracker-devel \
            libdrm-devel libxcb-devel libxcb-dri2-devel libxcb-dri3-devel \
            libxcb-glx-devel libxcb-present-devel libxcb-sync-devel \
            libxcb-xfixes-devel libxshmfence-devel
    else
        echo -e "${RED}❌ Sistema operacional não suportado: $OS${NC}"
        exit 1
    fi
}

install_docker() {
    echo -e "${BLUE}🐳 Instalando Docker...${NC}"
    
    if [[ "$OS" == *"Ubuntu"* ]]; then
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt update
        sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
    elif [[ "$OS" == *"Rocky"* ]] || [[ "$OS" == *"CentOS"* ]] || [[ "$OS" == *"RHEL"* ]]; then
        sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
        sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
    fi
    
    sudo usermod -aG docker $USER
    sudo systemctl enable docker
    sudo systemctl start docker
}

install_nodejs() {
    echo -e "${BLUE}📦 Instalando Node.js via NVM...${NC}"
    
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    
    nvm install --lts
    nvm use --lts
    nvm alias default node
    
    npm install -g yarn pnpm typescript ts-node nodemon

    curl -fsSL https://bun.sh/install | bash
}

install_dev_tools() {
    echo -e "${BLUE}🔧 Instalando ferramentas de desenvolvimento...${NC}"
    
    if [[ "$OS" == *"Ubuntu"* ]]; then
        sudo apt install -y make cmake pkg-config
    elif [[ "$OS" == *"Rocky"* ]] || [[ "$OS" == *"CentOS"* ]] || [[ "$OS" == *"RHEL"* ]]; then
        sudo dnf install -y make cmake pkg-config
    fi
    
    if command -v snap &> /dev/null; then
        sudo snap install code --classic
    fi
}

setup_zsh() {
    echo -e "${BLUE}⚙️ Configurando ZSH...${NC}"
    
    chsh -s $(which zsh)
    
    echo -e "${BLUE}📦 Instalando Oh My Zsh...${NC}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    
    ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
    
    echo -e "${BLUE}🔌 Instalando plugins...${NC}"
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
    git clone https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM/plugins/zsh-completions"
    git clone https://github.com/paulirish/git-open "$ZSH_CUSTOM/plugins/git-open"
    
    echo -e "${BLUE}🎨 Instalando tema powerlevel10k...${NC}"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
    
    echo -e "${BLUE}⚙️ Configurando .zshrc...${NC}"
    
    cp ~/.zshrc ~/.zshrc.backup.$(date +%Y%m%d_%H%M%S)
    
    sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
    
    if grep -q "^plugins=" ~/.zshrc; then
        sed -i 's/^plugins=.*/plugins=(git docker z npm sudo zsh-autosuggestions zsh-syntax-highlighting zsh-completions git-open)/' ~/.zshrc
    else
        echo 'plugins=(git docker z npm sudo zsh-autosuggestions zsh-syntax-highlighting zsh-completions git-open)' >> ~/.zshrc
    fi
    
    cat >> ~/.zshrc << 'EOF'

# Aliases úteis
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Docker aliases
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dex='docker exec -it'
alias show='docker logs -f'
alias show_last='docker logs -f --tail 100'
alias rebilda='docker compose up -d --build'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
alias gco='git checkout'
alias gcb='git checkout -b'

# Node.js aliases
alias n='node'
alias nr='npm run'
alias nrd='npm run dev'
alias nrb='npm run build'
alias nrt='npm run test'

# Função para navegar rapidamente
function mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Função para encontrar arquivos
function findf() {
    find . -name "*$1*" -type f
}

# Função para encontrar diretórios
function findd() {
    find . -name "*$1*" -type d
}

# Configuração do NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Configuração do Docker (se não estiver no grupo docker)
if ! groups $USER | grep -q docker; then
    echo "⚠️  Você precisa fazer logout e login novamente para usar Docker sem sudo"
fi
EOF
}

install_fonts() {
    echo -e "${BLUE}🔤 Instalando fontes...${NC}"
    
    mkdir -p ~/.local/share/fonts
    
    cd ~/.local/share/fonts
    curl -fLo "MesloLGS NF Regular.ttf" https://github.com/romkatv/powerlevel10k/raw/master/font/MesloLGS%20NF%20Regular.ttf
    curl -fLo "MesloLGS NF Bold.ttf" https://github.com/romkatv/powerlevel10k/raw/master/font/MesloLGS%20NF%20Bold.ttf
    curl -fLo "MesloLGS NF Italic.ttf" https://github.com/romkatv/powerlevel10k/raw/master/font/MesloLGS%20NF%20Italic.ttf
    curl -fLo "MesloLGS NF Bold Italic.ttf" https://github.com/romkatv/powerlevel10k/raw/master/font/MesloLGS%20NF%20Bold%20Italic.ttf
    
    fc-cache -f -v
    
    cd ~
}

main() {
    detect_os
    
    echo -e "${GREEN}🚀 Iniciando configuração inicial da máquina...${NC}"
    echo -e "${YELLOW}📋 Sistema detectado: $OS $VER${NC}"
    echo ""
    
    if [ "$EUID" -eq 0 ]; then
        echo -e "${RED}❌ Não execute este script como root!${NC}"
        exit 1
    fi
    
    install_base_packages
    
    install_docker
    
    install_nodejs
    
    install_dev_tools
    
    setup_zsh
    
    install_fonts
    
    echo ""
    echo -e "${GREEN}✅ Configuração concluída com sucesso!${NC}"
    echo ""
    echo -e "${YELLOW}📝 Próximos passos:${NC}"
    echo "1. Faça logout e login novamente para aplicar as mudanças"
    echo "2. Configure a fonte 'MesloLGS NF' no seu terminal"
    echo "3. Execute 'p10k configure' para personalizar o Powerlevel10k"
    echo "4. Para usar Docker sem sudo, faça logout/login ou execute: newgrp docker"
    echo ""
    echo -e "${BLUE}🔧 Ferramentas instaladas:${NC}"
    echo "• ZSH com Oh My Zsh"
    echo "• Powerlevel10k theme"
    echo "• Docker"
    echo "• Node.js (via NVM)"
    echo "• Make, CMake, pkg-config"
    echo "• Yarn, pnpm, TypeScript"
    echo "• Plugins úteis para ZSH"
    echo ""
    echo -e "${GREEN}🎉 Sua máquina está pronta para desenvolvimento!${NC}"
}

main