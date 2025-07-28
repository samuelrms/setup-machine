#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

create_backup() {
    echo -e "${BLUE}💾 Criando backup das configurações existentes...${NC}"
    
    BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    
    if [ -f ~/.zshrc ]; then
        cp ~/.zshrc "$BACKUP_DIR/"
        echo -e "${GREEN}✅ Backup do .zshrc criado${NC}"
    fi
    
    if [ -f ~/.bashrc ]; then
        cp ~/.bashrc "$BACKUP_DIR/"
        echo -e "${GREEN}✅ Backup do .bashrc criado${NC}"
    fi
    
    if [ -f ~/.bash_profile ]; then
        cp ~/.bash_profile "$BACKUP_DIR/"
        echo -e "${GREEN}✅ Backup do .bash_profile criado${NC}"
    fi
    
    if [ -f ~/.profile ]; then
        cp ~/.profile "$BACKUP_DIR/"
        echo -e "${GREEN}✅ Backup do .profile criado${NC}"
    fi
    
    if [ -d ~/.docker ]; then
        cp -r ~/.docker "$BACKUP_DIR/"
        echo -e "${GREEN}✅ Backup das configurações do Docker criado${NC}"
    fi
    
    if [ -f ~/.npmrc ]; then
        cp ~/.npmrc "$BACKUP_DIR/"
        echo -e "${GREEN}✅ Backup do .npmrc criado${NC}"
    fi
    
    if [ -f ~/.gitconfig ]; then
        cp ~/.gitconfig "$BACKUP_DIR/"
        echo -e "${GREEN}✅ Backup do .gitconfig criado${NC}"
    fi
    
    if [ -d ~/.ssh ]; then
        cp -r ~/.ssh "$BACKUP_DIR/"
        echo -e "${GREEN}✅ Backup das configurações SSH criado${NC}"
    fi
    
    cat > "$BACKUP_DIR/backup-info.txt" << EOF
Backup criado em: $(date)
Sistema: $(uname -a)
Usuário: $USER
Diretório: $BACKUP_DIR

Arquivos incluídos no backup:
$(ls -la "$BACKUP_DIR" | grep -v "backup-info.txt")

Para restaurar um arquivo específico:
cp "$BACKUP_DIR/nome_do_arquivo" ~/

Para restaurar todos os arquivos:
cp "$BACKUP_DIR"/* ~/
EOF
    
    echo -e "${GREEN}✅ Backup completo criado em: $BACKUP_DIR${NC}"
    echo -e "${YELLOW}📋 Informações do backup salvas em: $BACKUP_DIR/backup-info.txt${NC}"
    
    return 0
}

check_existing_config() {
    echo -e "${BLUE}🔍 Verificando configurações existentes...${NC}"
    
    EXISTING_CONFIGS=()
    
    if [ -f ~/.zshrc ]; then
        EXISTING_CONFIGS+=("~/.zshrc")
    fi
    
    if [ -f ~/.bashrc ]; then
        EXISTING_CONFIGS+=("~/.bashrc")
    fi
    
    if [ -d ~/.oh-my-zsh ]; then
        EXISTING_CONFIGS+=("~/.oh-my-zsh")
    fi
    
    if [ -d ~/.nvm ]; then
        EXISTING_CONFIGS+=("~/.nvm")
    fi
    
    if [ -d ~/.docker ]; then
        EXISTING_CONFIGS+=("~/.docker")
    fi
    
    if [ ${#EXISTING_CONFIGS[@]} -gt 0 ]; then
        echo -e "${YELLOW}⚠️  Configurações existentes encontradas:${NC}"
        for config in "${EXISTING_CONFIGS[@]}"; do
            echo -e "   • $config"
        done
        echo ""
        return 0
    else
        echo -e "${GREEN}✅ Nenhuma configuração existente encontrada${NC}"
        return 1
    fi
}

main() {
    echo -e "${GREEN}🔧 Script de Backup de Configurações${NC}"
    echo ""
    
    if [ "$EUID" -eq 0 ]; then
        echo -e "${RED}❌ Não execute este script como root!${NC}"
        exit 1
    fi
    
    if check_existing_config; then
        echo -e "${YELLOW}💡 Recomendamos fazer backup antes de prosseguir${NC}"
        echo ""
        read -p "Deseja criar um backup das configurações existentes? (s/N): " -n 1 -r
        echo ""
        
        if [[ $REPLY =~ ^[Ss]$ ]]; then
            create_backup
        else
            echo -e "${YELLOW}⚠️  Backup não foi criado. Prosseguindo sem backup...${NC}"
        fi
    else
        echo -e "${GREEN}✅ Não há configurações para fazer backup${NC}"
    fi
    
    echo ""
    echo -e "${GREEN}✅ Verificação concluída!${NC}"
    echo -e "${BLUE}💡 Agora você pode executar o script setup-zsh.sh com segurança${NC}"
}

main 