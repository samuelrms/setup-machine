#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

show_banner() {
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                    CONFIGURADOR DE MÁQUINA                   ║"
    echo "║                    Ubuntu & Rocky Linux 9                    ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

check_dependencies() {
    echo -e "${BLUE}🔍 Verificando dependências...${NC}"
    
    if [ "$EUID" -eq 0 ]; then
        echo -e "${RED}❌ Não execute este script como root!${NC}"
        exit 1
    fi
    
    if ! command -v curl &> /dev/null; then
        echo -e "${YELLOW}⚠️  curl não encontrado. Tentando instalar...${NC}"
        if command -v apt &> /dev/null; then
            sudo apt update && sudo apt install -y curl
        elif command -v dnf &> /dev/null; then
            sudo dnf install -y curl
        else
            echo -e "${RED}❌ Não foi possível instalar curl automaticamente${NC}"
            exit 1
        fi
    fi
    
    if ! command -v git &> /dev/null; then
        echo -e "${YELLOW}⚠️  git não encontrado. Tentando instalar...${NC}"
        if command -v apt &> /dev/null; then
            sudo apt update && sudo apt install -y git
        elif command -v dnf &> /dev/null; then
            sudo dnf install -y git
        else
            echo -e "${RED}❌ Não foi possível instalar git automaticamente${NC}"
            exit 1
        fi
    fi
    
    echo -e "${GREEN}✅ Dependências verificadas${NC}"
}

run_backup() {
    echo -e "${BLUE}💾 Executando backup automático...${NC}"
    
    if [ -f "./backup-config.sh" ]; then
        chmod +x ./backup-config.sh
        ./backup-config.sh
    else
        echo -e "${YELLOW}⚠️  Script de backup não encontrado. Criando backup manual...${NC}"
        
        BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d_%H%M%S)"
        mkdir -p "$BACKUP_DIR"
        
        for file in .zshrc .bashrc .bash_profile .profile .gitconfig .npmrc; do
            if [ -f ~/$file ]; then
                cp ~/$file "$BACKUP_DIR/"
                echo -e "${GREEN}✅ Backup de ~/$file criado${NC}"
            fi
        done
        
        for dir in .oh-my-zsh .nvm .docker .ssh; do
            if [ -d ~/$dir ]; then
                cp -r ~/$dir "$BACKUP_DIR/"
                echo -e "${GREEN}✅ Backup de ~/$dir criado${NC}"
            fi
        done
        
        echo -e "${GREEN}✅ Backup manual criado em: $BACKUP_DIR${NC}"
    fi
}

run_installation() {
    echo -e "${BLUE}🚀 Iniciando instalação...${NC}"
    
    if [ -f "./setup-zsh.sh" ]; then
        chmod +x ./setup-zsh.sh
        ./setup-zsh.sh
    else
        echo -e "${RED}❌ Script setup-zsh.sh não encontrado!${NC}"
        exit 1
    fi
}

show_post_install_info() {
    echo ""
    echo -e "${GREEN}🎉 Instalação concluída!${NC}"
    echo ""
    echo -e "${YELLOW}📋 Próximos passos importantes:${NC}"
    echo "1. Faça logout e login novamente para aplicar todas as mudanças"
    echo "2. Configure a fonte 'MesloLGS NF' no seu terminal"
    echo "3. Execute 'p10k configure' para personalizar o Powerlevel10k"
    echo "4. Para usar Docker sem sudo: newgrp docker"
    echo ""
    echo -e "${BLUE}🔧 Ferramentas instaladas:${NC}"
    echo "• ZSH com Oh My Zsh e Powerlevel10k"
    echo "• Docker com Docker Compose"
    echo "• Node.js (via NVM) com Yarn e pnpm"
    echo "• TypeScript, ts-node, nodemon"
    echo "• Make, CMake, pkg-config"
    echo "• VS Code (se disponível via snap)"
    echo "• Plugins úteis para ZSH"
    echo ""
    echo -e "${GREEN}💡 Dicas úteis:${NC}"
    echo "• Use 'gs' para git status"
    echo "• Use 'dps' para docker ps"
    echo "• Use 'nrd' para npm run dev"
    echo "• Use 'mkcd nome' para criar e entrar em um diretório"
    echo ""
    echo -e "${BLUE}📚 Documentação útil:${NC}"
    echo "• Oh My Zsh: https://ohmyz.sh/"
    echo "• Powerlevel10k: https://github.com/romkatv/powerlevel10k"
    echo "• NVM: https://github.com/nvm-sh/nvm"
    echo "• Docker: https://docs.docker.com/"
    echo ""
}

main() {
    show_banner
    
    echo -e "${YELLOW}⚠️  Este script irá configurar sua máquina para desenvolvimento${NC}"
    echo -e "${YELLOW}⚠️  Ele instalará Docker, Node.js, ZSH e outras ferramentas${NC}"
    echo ""
    
    read -p "Deseja continuar? (s/N): " -n 1 -r
    echo ""
    
    if [[ ! $REPLY =~ ^[Ss]$ ]]; then
        echo -e "${YELLOW}❌ Instalação cancelada${NC}"
        exit 0
    fi
    
    echo ""
    
    check_dependencies
    
    run_backup
    
    echo ""
    echo -e "${YELLOW}⚠️  Backup concluído. Iniciando instalação...${NC}"
    echo ""
    
    run_installation
    
    show_post_install_info
}

main 