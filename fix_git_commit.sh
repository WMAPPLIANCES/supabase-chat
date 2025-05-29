#!/bin/bash

echo "🔧 Script de Diagnóstico e Correção do Git - WM Appliances"
echo "============================================================"

# Função para verificar se um comando existe
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Verificar se git está instalado
echo "1. Verificando se git está instalado..."
if command_exists git; then
    echo "✅ Git está instalado: $(git --version)"
else
    echo "❌ Git não está instalado. Instalando..."
    apt-get update && apt-get install -y git
fi

# Verificar diretório atual
echo ""
echo "2. Verificando diretório atual..."
echo "📁 Diretório: $(pwd)"
echo "📋 Arquivos:"
ls -la

# Verificar se é um repositório git
echo ""
echo "3. Verificando status do repositório..."
if [ -d ".git" ]; then
    echo "✅ Repositório git já existe"
    git status
else
    echo "❌ Não é um repositório git. Inicializando..."
    git init
    echo "✅ Repositório git inicializado"
fi

# Configurar git com o email correto
echo ""
echo "4. Configurando git com email correto..."
git config --global user.name "WM Appliances" 2>/dev/null || echo "❌ Erro ao configurar nome"
git config --global user.email "support@wmappliances.net" 2>/dev/null || echo "❌ Erro ao configurar email"
echo "✅ Git configurado com email: support@wmappliances.net"

# Verificar configuração atual
echo ""
echo "📧 Configuração atual do git:"
echo "Nome: $(git config user.name)"
echo "Email: $(git config user.email)"

# Verificar arquivos para commit
echo ""
echo "5. Verificando arquivos para commit..."
if [ -f "README.md" ]; then echo "✅ README.md encontrado"; else echo "❌ README.md não encontrado"; fi
if [ -f "docker-compose.yml" ]; then echo "✅ docker-compose.yml encontrado"; else echo "❌ docker-compose.yml não encontrado"; fi
if [ -f "env.example" ]; then echo "✅ env.example encontrado"; else echo "❌ env.example não encontrado"; fi
if [ -f ".gitignore" ]; then echo "✅ .gitignore encontrado"; else echo "❌ .gitignore não encontrado"; fi
if [ -f "reset.sh" ]; then echo "✅ reset.sh encontrado"; else echo "❌ reset.sh não encontrado"; fi

# Adicionar arquivos ao git
echo ""
echo "6. Adicionando arquivos ao git..."
git add . 2>/dev/null || echo "❌ Erro ao adicionar arquivos"
echo "✅ Arquivos adicionados"

# Verificar status
echo ""
echo "7. Status do git:"
git status

# Fazer commit
echo ""
echo "8. Fazendo commit..."
git commit -m "🚀 Deploy inicial do Supabase Self-Hosted - WM Appliances

Configuração completa do Supabase self-hosted para WM Appliances:
- Docker Compose com todos os serviços
- Configurações de segurança personalizadas  
- Integração com domínio selfapi.wmappliances.cloud
- Scripts de automação e documentação completa

Pronto para integração com Chatwoot!" 2>/dev/null || echo "❌ Erro no commit"

echo "✅ Commit realizado"

# Verificar se há repositório remoto
echo ""
echo "9. Verificando repositório remoto..."
git remote -v 2>/dev/null || echo "❌ Nenhum repositório remoto configurado"

echo ""
echo "🎯 Próximos passos:"
echo "1. Crie o repositório no GitHub: https://github.com/WMAPPLIANCES/supabase-selfhosted"
echo "2. Execute: git remote add origin https://github.com/WMAPPLIANCES/supabase-selfhosted.git"
echo "3. Execute: git branch -M main"
echo "4. Execute: git push -u origin main"

echo ""
echo "✅ Diagnóstico concluído!" 