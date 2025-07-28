#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

check_command() {
    local cmd=$1
    local name=$2
    local version_flag=${3:-"--version"}
    
    if command -v "$cmd" &> /dev/null; then
        local version=$($cmd $version_flag 2>/dev/null | head -n1)
        echo -e "${GREEN}✅ $name${NC}"
        echo -e "   Versão: $version"
        return 0
    else
        echo -e "${RED}❌ $name não encontrado${NC}"
        return 1
    fi
}

check_path() {
    local path=$1
    local name=$2
    
    if [ -e "$path" ]; then
        echo -e "${GREEN}✅ $name${NC}"
        return 0
    else
        echo -e "${RED}❌ $name não encontrado${NC}"
        return 1
    fi
}

check_group() {
    local group=$1
    local name=$2
    
    if groups $USER | grep -q "$group"; then
        echo -e "${GREEN}✅ $name${NC}"
        return 0
    else
        echo -e "${YELLOW}⚠️  $name (usuário não está no grupo)${NC}"
        return 1
    fi
}

main() {
    echo -e "${BLUE}🔍 Verificando instalação...${NC}"
    echo ""
    
    total=0
    success=0
    
    echo -e "${BLUE}📋 Verificando ferramentas do sistema:${NC}"
    echo ""
    
    ((total++))
    if check_command "zsh" "ZSH"; then
        ((success++))
    fi
    
    ((total++))
    if check_command "git" "Git"; then
        ((success++))
    fi
    
    ((total++))
    if check_command "curl" "Curl"; then
        ((success++))
    fi
    
    ((total++))
    if check_command "make" "Make"; then
        ((success++))
    fi
    
    ((total++))
    if check_command "cmake" "CMake"; then
        ((success++))
    fi
    
    echo ""
    echo -e "${BLUE}🐳 Verificando Docker:${NC}"
    echo ""
    
    ((total++))
    if check_command "docker" "Docker"; then
        ((success++))
    fi
    
    ((total++))
    if check_command "docker-compose" "Docker Compose"; then
        ((success++))
    fi
    
    ((total++))
    if check_group "docker" "Usuário no grupo docker"; then
        ((success++))
    fi
    
    echo ""
    echo -e "${BLUE}📦 Verificando Node.js:${NC}"
    echo ""
    
    ((total++))
    if check_path "$HOME/.nvm" "NVM"; then
        ((success++))
    fi
    
    ((total++))
    if check_command "node" "Node.js"; then
        ((success++))
    fi
    
    ((total++))
    if check_command "npm" "NPM"; then
        ((success++))
    fi
    
    ((total++))
    if check_command "yarn" "Yarn"; then
        ((success++))
    fi
    
    ((total++))
    if check_command "pnpm" "PNPM"; then
        ((success++))
    fi
    
    ((total++))
    if check_command "bun" "Bun"; then
        ((success++))
    fi
    
    ((total++))
    if check_command "tsc" "TypeScript"; then
        ((success++))
    fi
    
    echo ""
    echo -e "${BLUE}⚙️ Verificando ZSH e plugins:${NC}"
    echo ""
    
    ((total++))
    if check_path "$HOME/.oh-my-zsh" "Oh My Zsh"; then
        ((success++))
    fi
    
    ((total++))
    if check_path "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" "Powerlevel10k"; then
        ((success++))
    fi
    
    ((total++))
    if check_path "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" "Plugin zsh-autosuggestions"; then
        ((success++))
    fi
    
    ((total++))
    if check_path "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" "Plugin zsh-syntax-highlighting"; then
        ((success++))
    fi
    
    ((total++))
    if check_path "$HOME/.oh-my-zsh/custom/plugins/zsh-completions" "Plugin zsh-completions"; then
        ((success++))
    fi
    
    ((total++))
    if check_path "$HOME/.zshrc" "Arquivo .zshrc"; then
        ((success++))
    fi
    
    echo ""
    echo -e "${BLUE}🔤 Verificando fontes:${NC}"
    echo ""
    
    ((total++))
    if fc-list | grep -q "MesloLGS NF"; then
        echo -e "${GREEN}✅ Fontes MesloLGS NF${NC}"
        ((success++))
    else
        echo -e "${YELLOW}⚠️  Fontes MesloLGS NF (pode precisar reiniciar o terminal)${NC}"
    fi
    
    echo ""
    echo -e "${BLUE}📊 Resumo:${NC}"
    echo ""
    echo -e "Total de verificações: $total"
    echo -e "Sucessos: $success"
    echo -e "Falhas: $((total - success))"
    
    if [ $success -eq $total ]; then
        echo ""
        echo -e "${GREEN}🎉 Todas as verificações passaram!${NC}"
        echo -e "${GREEN}✅ Sua máquina está configurada corretamente!${NC}"
    else
        echo ""
        echo -e "${YELLOW}⚠️  Algumas verificações falharam${NC}"
        echo -e "${YELLOW}💡 Verifique os itens com ❌ ou ⚠️${NC}"
    fi
    
    echo ""
    echo -e "${BLUE}💡 Próximos passos:${NC}"
    echo "1. Faça logout e login novamente"
    echo "2. Configure a fonte 'MesloLGS NF' no terminal"
    echo "3. Execute 'p10k configure' para personalizar o tema"
    echo "4. Teste os aliases: gs, dps, nrd, etc."
}

main 