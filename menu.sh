#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

show_banner() {
    clear
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                    CONFIGURADOR DE MÁQUINA                   ║"
    echo "║                    Ubuntu & Rocky Linux 9                    ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

show_menu() {
    echo -e "${CYAN}📋 Escolha uma opção:${NC}"
    echo ""
    echo -e "${YELLOW}1.${NC} 🔍 Verificar dependências"
    echo -e "${YELLOW}2.${NC} 💾 Fazer backup das configurações"
    echo -e "${YELLOW}3.${NC} 🚀 Instalar tudo (backup + instalação)"
    echo -e "${YELLOW}4.${NC} ⚙️  Instalar apenas (sem backup)"
    echo -e "${YELLOW}5.${NC} 🔍 Verificar instalação"
    echo -e "${YELLOW}6.${NC} 📚 Mostrar documentação"
    echo -e "${YELLOW}7.${NC} 🔄 Executar tudo em sequência"
    echo -e "${YELLOW}0.${NC} 🚪 Sair"
    echo ""
}

check_dependencies() {
    echo -e "${BLUE}🔍 Verificando dependências...${NC}"
    echo ""
    
    if [ "$EUID" -eq 0 ]; then
        echo -e "${RED}❌ Não execute este script como root!${NC}"
        return 1
    fi
    
    if command -v curl &> /dev/null; then
        echo -e "${GREEN}✅ curl encontrado${NC}"
    else
        echo -e "${RED}❌ curl não encontrado${NC}"
        return 1
    fi
    
    if command -v git &> /dev/null; then
        echo -e "${GREEN}✅ git encontrado${NC}"
    else
        echo -e "${RED}❌ git não encontrado${NC}"
        return 1
    fi
    
    if command -v sudo &> /dev/null; then
        echo -e "${GREEN}✅ sudo encontrado${NC}"
    else
        echo -e "${RED}❌ sudo não encontrado${NC}"
        return 1
    fi
    
    echo ""
    echo -e "${GREEN}✅ Todas as dependências estão disponíveis!${NC}"
    return 0
}

run_backup() {
    echo -e "${BLUE}💾 Executando backup...${NC}"
    echo ""
    
    if [ -f "./backup-config.sh" ]; then
        chmod +x ./backup-config.sh
        ./backup-config.sh
    else
        echo -e "${RED}❌ Script backup-config.sh não encontrado!${NC}"
        return 1
    fi
}

run_installation() {
    echo -e "${BLUE}🚀 Executando instalação...${NC}"
    echo ""
    
    if [ -f "./setup-zsh.sh" ]; then
        chmod +x ./setup-zsh.sh
        ./setup-zsh.sh
    else
        echo -e "${RED}❌ Script setup-zsh.sh não encontrado!${NC}"
        return 1
    fi
}

run_verification() {
    echo -e "${BLUE}🔍 Verificando instalação...${NC}"
    echo ""
    
    if [ -f "./verify-install.sh" ]; then
        chmod +x ./verify-install.sh
        ./verify-install.sh
    else
        echo -e "${RED}❌ Script verify-install.sh não encontrado!${NC}"
        return 1
    fi
}

show_documentation() {
    echo -e "${BLUE}📚 Documentação:${NC}"
    echo ""
    echo -e "${CYAN}📋 O que é instalado:${NC}"
    echo "• ZSH com Oh My Zsh e Powerlevel10k"
    echo "• Docker Engine com Docker Compose"
    echo "• Node.js LTS via NVM"
    echo "• Yarn, pnpm, TypeScript, ts-node, nodemon"
    echo "• Make, CMake, pkg-config"
    echo "• VS Code (se disponível via snap)"
    echo "• Fontes Nerd Fonts"
    echo "• Plugins úteis para ZSH"
    echo ""
    echo -e "${CYAN}🎯 Aliases úteis:${NC}"
    echo "• Git: gs, ga, gc, gp, gl, gco, gcb"
    echo "• Docker: d, dc, dps, dpsa, di, dex, show, show_last, rebilda"
    echo "• Node.js: n, nr, nrd, nrb, nrt"
    echo "• Navegação: ll, la, .., ..., ...., mkcd"
    echo ""
    echo -e "${CYAN}📁 Scripts disponíveis:${NC}"
    echo "• install.sh - Script principal (executa tudo)"
    echo "• setup-zsh.sh - Script de instalação"
    echo "• backup-config.sh - Script de backup"
    echo "• verify-install.sh - Script de verificação"
    echo ""
    echo -e "${YELLOW}💡 Dica: Execute a opção 7 para fazer tudo em sequência!${NC}"
}

run_all_sequence() {
    echo -e "${BLUE}🔄 Executando tudo em sequência...${NC}"
    echo ""
    
    echo -e "${YELLOW}1. Verificando dependências...${NC}"
    if ! check_dependencies; then
        echo -e "${RED}❌ Falha na verificação de dependências${NC}"
        return 1
    fi
    
    echo ""
    echo -e "${YELLOW}2. Fazendo backup...${NC}"
    if ! run_backup; then
        echo -e "${RED}❌ Falha no backup${NC}"
        return 1
    fi
    
    echo ""
    echo -e "${YELLOW}3. Instalando...${NC}"
    if ! run_installation; then
        echo -e "${RED}❌ Falha na instalação${NC}"
        return 1
    fi
    
    echo ""
    echo -e "${YELLOW}4. Verificando instalação...${NC}"
    if ! run_verification; then
        echo -e "${RED}❌ Falha na verificação${NC}"
        return 1
    fi
    
    echo ""
    echo -e "${GREEN}🎉 Tudo executado com sucesso!${NC}"
}

process_choice() {
    local choice=$1
    
    case $choice in
        1)
            echo ""
            check_dependencies
            ;;
        2)
            echo ""
            run_backup
            ;;
        3)
            echo ""
            echo -e "${YELLOW}⚠️  Esta opção fará backup e depois instalará tudo${NC}"
            read -p "Deseja continuar? (s/N): " -n 1 -r
            echo ""
            if [[ $REPLY =~ ^[Ss]$ ]]; then
                run_backup
                echo ""
                run_installation
            else
                echo -e "${YELLOW}❌ Operação cancelada${NC}"
            fi
            ;;
        4)
            echo ""
            echo -e "${YELLOW}⚠️  Esta opção instalará sem fazer backup${NC}"
            read -p "Deseja continuar? (s/N): " -n 1 -r
            echo ""
            if [[ $REPLY =~ ^[Ss]$ ]]; then
                run_installation
            else
                echo -e "${YELLOW}❌ Operação cancelada${NC}"
            fi
            ;;
        5)
            echo ""
            run_verification
            ;;
        6)
            echo ""
            show_documentation
            ;;
        7)
            echo ""
            echo -e "${YELLOW}⚠️  Esta opção executará tudo em sequência${NC}"
            read -p "Deseja continuar? (s/N): " -n 1 -r
            echo ""
            if [[ $REPLY =~ ^[Ss]$ ]]; then
                run_all_sequence
            else
                echo -e "${YELLOW}❌ Operação cancelada${NC}"
            fi
            ;;
        0)
            echo ""
            echo -e "${GREEN}👋 Até logo!${NC}"
            exit 0
            ;;
        *)
            echo ""
            echo -e "${RED}❌ Opção inválida!${NC}"
            ;;
    esac
}

main() {
    while true; do
        show_banner
        show_menu
        
        read -p "Digite sua escolha (0-7): " choice
        echo ""
        
        process_choice $choice
        
        echo ""
        echo -e "${CYAN}⏳ Pressione Enter para continuar...${NC}"
        read -r
    done
}

main 