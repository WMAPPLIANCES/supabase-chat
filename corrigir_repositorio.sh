#!/bin/bash

echo "🔧 Corrigindo repositório GitHub - Supabase Chat"
echo "==============================================="

# Verificar se estamos no diretório correto
pwd

# Remover .git se existir
if [ -d ".git" ]; then
    echo "🗑️ Removendo .git antigo..."
    rm -rf .git
fi

# Inicializar repositório limpo
echo "🆕 Inicializando repositório limpo..."
git init

# Configurar usuário
echo "👤 Configurando usuário..."
git config user.name "WMAPPLIANCES"
git config user.email "support@wmappliances.net"

# Adicionar arquivos essenciais
echo "📁 Adicionando arquivos..."
git add README.md docker-compose.yml env.example .gitignore

# Fazer commit inicial
echo "💾 Fazendo commit inicial..."
git commit -m "🚀 Deploy inicial do Supabase Self-Hosted - WM Appliances"

# Configurar branch main
echo "🌿 Configurando branch main..."
git branch -M main

# Adicionar repositório remoto
echo "🔗 Conectando ao GitHub..."
git remote add origin https://github.com/WMAPPLIANCES/supabase-chat.git

# Fazer push forçado
echo "⬆️ Fazendo push para GitHub..."
git push -f -u origin main

echo ""
echo "✅ Repositório corrigido com sucesso!"
echo "🔗 URL: https://github.com/WMAPPLIANCES/supabase-chat" 