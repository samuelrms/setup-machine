# 🚀 Configurador de Máquina - Ubuntu & Rocky Linux 9

Scripts para configuração inicial de máquinas de desenvolvimento, compatíveis com Ubuntu e Rocky Linux 9.

> **Desenvolvido para facilitar a configuração inicial de máquinas de desenvolvimento** 🚀

## 📋 Índice

- [Sobre o Projeto](#-sobre-o-projeto)
- [O que é Instalado](#-o-que-é-instalado)
- [Estrutura dos Scripts](#-estrutura-dos-scripts)
- [Instalação](#-instalação)
- [Pré-requisitos](#-pré-requisitos)
- [Backup Automático](#-backup-automático)
- [Uso](#-uso)
- [Pós-Instalação](#-pós-instalação)
- [Aliases e Funções](#-aliases-e-funções)
- [Verificação da Instalação](#-verificação-da-instalação)
- [Solução de Problemas](#-solução-de-problemas)
- [Documentação Útil](#-documentação-útil)
- [Contribuindo](#-contribuindo)
- [Documentação de Referência](#-documentação-de-referência)
- [Contribuições](#-contribuições)
- [Licença](#-licença)

## 🎯 Sobre o Projeto

Este projeto consiste em um conjunto de scripts bash para automatizar a configuração inicial de máquinas de desenvolvimento. Ele foi projetado para funcionar tanto em sistemas Ubuntu quanto Rocky Linux 9, instalando e configurando todas as ferramentas essenciais para desenvolvimento moderno.

### ✨ Características Principais

- **Multi-plataforma**: Compatível com Ubuntu e Rocky Linux 9
- **Backup automático**: Preserva configurações existentes
- **Instalação modular**: Execute apenas o que precisa
- **Interface interativa**: Menu amigável para seleção de opções
- **Verificação completa**: Confirma se tudo foi instalado corretamente
- **Aliases úteis**: Comandos abreviados para produtividade
- **Documentação detalhada**: Guias completos de uso

### 🎨 Interface

O projeto oferece uma interface colorida e intuitiva, com:

- Cores diferenciadas para diferentes tipos de mensagens
- Emojis para facilitar a identificação visual
- Progresso detalhado durante a instalação
- Confirmações para operações importantes

## 📋 O que é Instalado

### 🐧 Sistema e Shell

- **ZSH** com Oh My Zsh
  - Shell avançado com autocompletar inteligente
  - Histórico de comandos persistente
  - Navegação por diretórios otimizada
- **Powerlevel10k** theme
  - Tema moderno e altamente customizável
  - Informações em tempo real (git status, tempo de execução, etc.)
  - Ícones e cores para melhor visualização
- **Plugins úteis**:
  - `zsh-autosuggestions`: Sugestões baseadas no histórico
  - `zsh-syntax-highlighting`: Destaque de sintaxe em tempo real
  - `zsh-completions`: Completar avançado para comandos
  - `git-open`: Abrir repositórios no navegador
- **Aliases úteis** para comandos comuns
- **Fontes Nerd Fonts** (MesloLGS NF) para ícones

### 🐳 Docker

- **Docker Engine** (versão mais recente)
  - Containerização de aplicações
  - Isolamento de ambientes
  - Deploy consistente entre ambientes
- **Docker Compose** plugin
  - Orquestração de múltiplos containers
  - Definição de serviços em YAML
  - Gerenciamento de redes e volumes
- **Configuração automática** do grupo docker
  - Permite usar Docker sem sudo
  - Configuração de segurança adequada
- **Aliases úteis**:
  - `d`: Comando docker principal
  - `dc`: Docker Compose
  - `dps`: Listar containers ativos
  - `dpsa`: Listar todos os containers
  - `di`: Listar imagens
  - `dex`: Executar comando em container
  - `show`: Ver logs em tempo real
  - `show_last`: Ver logs das últimas 100 linhas
  - `rebilda`: Rebuildar e iniciar containers

### 📦 Node.js & Ferramentas

- **NVM** (Node Version Manager)
  - Gerenciamento de múltiplas versões do Node.js
  - Mudança rápida entre versões
  - Instalação isolada por projeto
- **Node.js LTS** (versão estável)
  - Runtime JavaScript no servidor
  - Suporte a longo prazo
  - Estabilidade para produção
- **Gerenciadores de pacotes**:
  - **Yarn**: Gerenciador rápido e seguro
  - **pnpm**: Gerenciador eficiente em espaço
- **Ferramentas de desenvolvimento**:
  - **TypeScript**: Superset tipado do JavaScript
  - **ts-node**: Executar TypeScript diretamente
  - **nodemon**: Reiniciar automaticamente em mudanças
- **Aliases úteis**:
  - `n`: Comando node principal
  - `nr`: npm run
  - `nrd`: npm run dev
  - `nrb`: npm run build
  - `nrt`: npm run test

### 🔧 Ferramentas de Desenvolvimento

- **Ferramentas de build**:
  - **Make**: Sistema de build tradicional
  - **CMake**: Sistema de build multiplataforma
  - **pkg-config**: Configuração de bibliotecas
- **Git** com configurações otimizadas
  - Controle de versão distribuído
  - Configurações de segurança
  - Aliases para comandos comuns
- **VS Code** (se disponível via snap)
  - Editor de código moderno
  - Extensões para desenvolvimento
  - Integração com ferramentas
- **Fontes Nerd Fonts** (MesloLGS NF)
  - Suporte a ícones no terminal
  - Compatibilidade com Powerlevel10k
  - Melhor experiência visual

## 📁 Estrutura dos Scripts

```bash
.
├── menu.sh             # Script interativo (recomendado)
├── install.sh          # Script principal (executa tudo)
├── setup-zsh.sh        # Script de instalação principal
├── backup-config.sh    # Script de backup
├── verify-install.sh   # Script de verificação
├── README.md          # Documentação do projeto
└── LICENSE            # Licença MIT
```

## 🚀 Instalação

### 📋 Pré-requisitos

Antes de começar, certifique-se de que:

1. **Você não está logado como root**
2. **Tem conexão com internet**
3. **Tem privilégios sudo**
4. **Está em um sistema suportado** (Ubuntu ou Rocky Linux)

### 🔍 Verificação Rápida

Execute este comando para verificar se seu sistema é compatível:

```bash
# Verificar sistema operacional
cat /etc/os-release | grep -E "(Ubuntu|Rocky|CentOS|RHEL)"

# Verificar se não é root
whoami

# Verificar se tem sudo
sudo -l
```

### 📦 Opções de Instalação

#### Opção 1: Script Interativo (Mais Recomendado)

```bash
# 1. Clonar ou baixar o repositório
git clone <url-do-repositorio>
cd setup-zsh

# 2. Dar permissão de execução
chmod +x menu.sh

# 3. Executar o menu interativo
./menu.sh
```

**Vantagens do menu interativo:**

- ✅ Interface amigável e colorida
- ✅ Opções modulares (execute apenas o que precisa)
- ✅ Confirmações para operações importantes
- ✅ Execução em sequência automática
- ✅ Documentação integrada

**Opções disponíveis:**

- **1** - Verificar dependências
- **2** - Fazer backup das configurações
- **3** - Instalar tudo (backup + instalação)
- **4** - Instalar apenas (sem backup)
- **5** - Verificar instalação
- **6** - Mostrar documentação
- **7** - Executar tudo em sequência
- **0** - Sair

#### Opção 2: Instalação Completa (Recomendado)

```bash
# 1. Dar permissão de execução
chmod +x install.sh

# 2. Executar o script principal
./install.sh
```

**Características:**

- ✅ Backup automático antes da instalação
- ✅ Instalação completa em uma execução
- ✅ Verificação de dependências
- ✅ Interface com cores e progresso

#### Opção 3: Instalação Manual (Avançado)

```bash
# 1. Fazer backup primeiro
chmod +x backup-config.sh
./backup-config.sh

# 2. Executar instalação
chmod +x setup-zsh.sh
./setup-zsh.sh

# 3. Verificar instalação (opcional)
chmod +x verify-install.sh
./verify-install.sh
```

**Características:**

- ✅ Controle total sobre cada etapa
- ✅ Execução individual de scripts
- ✅ Útil para debugging ou instalações parciais
- ✅ Permite pausar entre etapas

### 🚀 Instalação Rápida (One-liner)

Para usuários experientes que querem instalar tudo rapidamente:

```bash
# Download e execução em uma linha
curl -fsSL https://raw.githubusercontent.com/samuelrms/setup-machine/main/install.sh | bash
```

**⚠️ Aviso:** Esta opção não faz backup automático!

## ⚠️ Requisitos

### 🔧 Requisitos do Sistema

- **Sistema Operacional**: Ubuntu 18.04+ ou Rocky Linux 9+
- **Arquitetura**: x86_64 (64 bits)
- **Memória RAM**: Mínimo 2GB (recomendado 4GB+)
- **Espaço em disco**: Mínimo 5GB livre

### 🔐 Requisitos de Permissões

- **Não execute como root** (o script verifica isso automaticamente)
- **Privilégios sudo** para instalar pacotes do sistema
- **Permissões de escrita** no diretório home do usuário

### 🌐 Requisitos de Rede

- **Conexão com internet** estável para baixar pacotes
- **Acesso a repositórios** oficiais (Ubuntu/Debian, EPEL)
- **Porta 443** (HTTPS) para downloads seguros

### 📦 Dependências Mínimas

O script verifica e instala automaticamente:

- `curl` - Para downloads
- `git` - Para clonar repositórios
- `sudo` - Para instalação de pacotes
- `wget` - Alternativa para downloads
- `unzip` - Para extrair arquivos

## 🔄 Backup Automático

### 📁 O que é Backupado

O script faz backup automático das seguintes configurações:

**Arquivos de configuração:**

- `~/.zshrc` - Configurações do ZSH
- `~/.bashrc` - Configurações do Bash
- `~/.bash_profile` - Perfil do Bash
- `~/.profile` - Perfil do sistema
- `~/.gitconfig` - Configurações do Git
- `~/.npmrc` - Configurações do NPM

**Diretórios de configuração:**

- `~/.oh-my-zsh/` - Oh My Zsh e plugins
- `~/.nvm/` - Node Version Manager
- `~/.docker/` - Configurações do Docker
- `~/.ssh/` - Chaves SSH

### 📍 Localização do Backup

**Formato**: `~/.config-backup-YYYYMMDD_HHMMSS/`

**Exemplo**: `~/.config-backup-20250115_143022/`

### 🔄 Restauração

Para restaurar configurações:

```bash
# Restaurar arquivo específico
cp ~/.config-backup-YYYYMMDD_HHMMSS/.zshrc ~/

# Restaurar todos os arquivos
cp ~/.config-backup-YYYYMMDD_HHMMSS/* ~/

# Restaurar diretórios
cp -r ~/.config-backup-YYYYMMDD_HHMMSS/.oh-my-zsh ~/
```

## 🎯 Uso

### 🚀 Primeiro Uso

Após a instalação, execute estes passos:

1. **Logout e login** para aplicar mudanças do shell
2. **Configure a fonte** 'MesloLGS NF' no terminal
3. **Personalize o tema**: `p10k configure`
4. **Use Docker sem sudo**: `newgrp docker`

### 🎨 Configuração do Terminal

Para uma experiência completa, configure seu terminal:

1. **Instale a fonte MesloLGS NF**
2. **Configure a fonte no terminal**
3. **Ajuste o tema Powerlevel10k**: `p10k configure`

### 🔧 Comandos Úteis

```bash
# Recarregar configurações do ZSH
source ~/.zshrc

# Verificar versão do Node.js
node --version

# Verificar versão do Docker
docker --version

# Listar aliases disponíveis
alias | grep -E "(git|docker|node)"
```

## 🎨 Pós-Instalação

Após a instalação, execute:

1. **Logout e login** para aplicar mudanças
2. **Configure a fonte** 'MesloLGS NF' no terminal
3. **Personalize o tema**: `p10k configure`
4. **Use Docker sem sudo**: `newgrp docker`

## 🎯 Aliases e Funções

### 🐙 Git Aliases

```bash
gs    # git status
ga    # git add
gc    # git commit
gp    # git push
gl    # git log --oneline
gco   # git checkout
gcb   # git checkout -b
```

**Exemplos de uso:**

```bash
gs          # Ver status do repositório
ga .        # Adicionar todas as mudanças
gc -m "feat: nova funcionalidade"
gp origin main
gl          # Ver histórico compacto
gco feature/nova-funcionalidade
gcb hotfix/correcao-urgente
```

### 🐳 Docker Aliases

```bash
d         # docker
dc        # docker-compose
dps       # docker ps
dpsa      # docker ps -a
di        # docker images
dex       # docker exec -it
show      # docker logs -f
show_last # docker logs -f --tail 100
rebilda   # docker compose up -d --build
```

**Exemplos de uso:**

```bash
dps                    # Listar containers ativos
dpsa                   # Listar todos os containers
di                     # Listar imagens
dex meu-container bash # Entrar no container
show meu-container     # Ver logs em tempo real
show_last meu-container # Ver últimas 100 linhas
rebilda                # Rebuildar e iniciar
```

### 📦 Node.js Aliases

```bash
n     # node
nr    # npm run
nrd   # npm run dev
nrb   # npm run build
nrt   # npm run test
```

**Exemplos de uso:**

```bash
n app.js              # Executar arquivo
nr start              # npm run start
nrd                   # npm run dev
nrb                   # npm run build
nrt                   # npm run test
```

### 🗂️ Navegação Aliases

```bash
ll    # ls -la
la    # ls -A
l     # ls -CF
..    # cd ..
...   # cd ../..
....  # cd ../../..
```

### 🔧 Funções Úteis

```bash
mkcd nome    # Criar diretório e entrar nele
findf nome   # Encontrar arquivos
findd nome   # Encontrar diretórios
```

**Exemplos de uso:**

```bash
mkcd projeto-novo     # Criar e entrar no diretório
findf config          # Encontrar arquivos com "config"
findd src             # Encontrar diretórios com "src"
```

### 🎨 Aliases de Cores

```bash
grep='grep --color=auto'
fgrep='fgrep --color=auto'
egrep='egrep --color=auto'
```

### 📋 Comandos Úteis Adicionais

```bash
# Verificar espaço em disco
df -h

# Verificar uso de memória
free -h

# Verificar processos
ps aux | grep nome

# Verificar portas em uso
netstat -tulpn | grep :porta
```

## 🔍 Verificação da Instalação

Após a instalação, você pode verificar se tudo foi instalado corretamente:

```bash
chmod +x verify-install.sh
./verify-install.sh
```

Este script verifica:

- Ferramentas do sistema (ZSH, Git, Make, CMake)
- Docker e Docker Compose
- Node.js, NVM, NPM, Yarn, PNPM, TypeScript
- Oh My Zsh e plugins
- Fontes Nerd Fonts

## 🐛 Solução de Problemas

### 🔧 Problemas Comuns

#### Docker sem sudo não funciona

**Sintoma**: Erro "permission denied" ao executar comandos docker

**Solução**:

```bash
# Adicionar usuário ao grupo docker
sudo usermod -aG docker $USER

# Recarregar grupos (ou fazer logout/login)
newgrp docker

# Verificar se funcionou
docker ps
```

#### Fonte não aparece no terminal

**Sintoma**: Ícones aparecem como quadrados ou caracteres estranhos

**Solução**:

```bash
# Atualizar cache de fontes
fc-cache -f -v

# Reiniciar terminal
# Ou configurar fonte manualmente no terminal
```

#### NVM não funciona

**Sintoma**: Comando `nvm` não encontrado

**Solução**:

```bash
# Recarregar configurações
source ~/.zshrc

# Ou instalar manualmente
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Verificar instalação
nvm --version
```

#### Tema Powerlevel10k não carrega

**Sintoma**: Tema não aparece ou aparece com erro

**Solução**:

```bash
# Reinstalar tema
cd ~/.oh-my-zsh/custom/themes/
rm -rf powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git

# Recarregar configurações
source ~/.zshrc
```

### 🚨 Problemas Avançados

#### Script não executa

**Sintoma**: "Permission denied" ao executar scripts

**Solução**:

```bash
# Dar permissão de execução
chmod +x *.sh

# Ou executar com bash
bash script.sh
```

#### Falha na instalação de pacotes

**Sintoma**: Erro ao instalar Docker, Node.js, etc.

**Solução**:

```bash
# Atualizar repositórios
sudo apt update  # Ubuntu
sudo dnf update  # Rocky Linux

# Verificar conexão com internet
ping google.com

# Verificar espaço em disco
df -h
```

#### ZSH não é o shell padrão

**Sintoma**: Terminal ainda abre com bash

**Solução**:

```bash
# Verificar shell atual
echo $SHELL

# Definir ZSH como padrão
chsh -s $(which zsh)

# Fazer logout e login novamente
```

### 🔍 Debugging

#### Verificar logs de instalação

```bash
# Verificar se scripts foram executados
ls -la ~/.config-backup-*

# Verificar instalações
which docker
which node
which zsh

# Verificar configurações
cat ~/.zshrc | grep -E "(theme|plugins)"
```

#### Verificar dependências

```bash
# Verificar se curl está disponível
which curl

# Verificar se git está disponível
which git

# Verificar se sudo funciona
sudo -l
```

### 📞 Suporte

Se você ainda tiver problemas:

1. **Verifique os logs** de instalação
2. **Execute o script de verificação**: `./verify-install.sh`
3. **Consulte a documentação** das ferramentas
4. **Abra uma issue** no repositório

## 📚 Documentação Útil

- [Oh My Zsh](https://ohmyz.sh/)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [NVM](https://github.com/nvm-sh/nvm)
- [Docker](https://docs.docker.com/)
- [Node.js](https://nodejs.org/)

## 🤝 Contribuindo

Para melhorar os scripts:

1. Teste em diferentes versões do Ubuntu e Rocky Linux
2. Adicione novas ferramentas úteis
3. Mantenha a compatibilidade com ambos os sistemas
4. Documente mudanças importantes

## 📚 Documentação de Referência

### 🔗 Links Importantes

- [Oh My Zsh](https://ohmyz.sh/) - Framework para ZSH
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) - Tema para ZSH
- [NVM](https://github.com/nvm-sh/nvm) - Node Version Manager
- [Docker](https://docs.docker.com/) - Containerização
- [Node.js](https://nodejs.org/) - Runtime JavaScript
- [TypeScript](https://www.typescriptlang.org/) - Superset do JavaScript

### 📖 Guias de Configuração

- [Configuração do ZSH](https://ohmyz.sh/#install)
- [Personalização do Powerlevel10k](https://github.com/romkatv/powerlevel10k#configuration)
- [Uso do Docker](https://docs.docker.com/get-started/)
- [Desenvolvimento com Node.js](https://nodejs.org/en/learn/)

## 🤝 Contribuições

### 📋 Como Contribuir

1. **Fork o repositório**
2. **Crie uma branch** para sua feature (`git checkout -b feature/nova-funcionalidade`)
3. **Commit suas mudanças** (`git commit -am 'Adiciona nova funcionalidade'`)
4. **Push para a branch** (`git push origin feature/nova-funcionalidade`)
5. **Abra um Pull Request**

### 🧪 Testando

Para testar os scripts:

1. **Use uma VM** ou container limpo
2. **Teste em diferentes sistemas** (Ubuntu, Rocky Linux)
3. **Verifique compatibilidade** com diferentes versões
4. **Execute o script de verificação** após instalação

### 📝 Diretrizes

- **Mantenha compatibilidade** com Ubuntu e Rocky Linux
- **Sempre faça backup** antes de aplicar mudanças
- **Documente novas funcionalidades**
- **Teste em ambientes limpos**
- **Siga as boas práticas** de shell scripting

## 📄 Licença

Este projeto está licenciado sob a [MIT License](LICENSE).

---

**Desenvolvido para facilitar a configuração inicial de máquinas de desenvolvimento** 🚀

**Autor**: Samuel Ramos  
**Ano**: 2025  
**Licença**: MIT
