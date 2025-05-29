#!/bin/bash

# Script para deploy do Supabase Self-Hosted no GitHub
# WM Appliances - 2025

echo "🚀 Iniciando deploy do Supabase Self-Hosted para GitHub..."

# Configurar git se necessário
git config --global user.name "WM Appliances"
git config --global user.email "admin@wmappliances.cloud"

# Inicializar repositório se não existir
if [ ! -d ".git" ]; then
    echo "📁 Inicializando repositório git..."
    git init
fi

# Adicionar arquivos
echo "📝 Adicionando arquivos ao git..."
git add README.md
git add docker-compose.yml
git add env.example
git add .gitignore
git add reset.sh
git add deploy_git.sh

# Fazer commit
echo "💾 Fazendo commit..."
git commit -m "🚀 Deploy inicial do Supabase Self-Hosted - WM Appliances

- Configuração completa do Supabase self-hosted
- Docker Compose com todos os serviços
- Configurações de segurança personalizadas
- Integração com domínio selfapi.wmappliances.cloud
- Scripts de automação e reset
- Documentação completa

Serviços incluídos:
- Studio, Kong, Auth, REST, Realtime
- Storage, Meta, Functions, Analytics
- Database (PostgreSQL), Vector, Pooler

Pronto para integração com Chatwoot!"

# Configurar repositório remoto
echo "🌐 Configurando repositório remoto..."
git remote add origin https://github.com/WMAPPLIANCES/supabase-selfhosted.git

# Fazer push
echo "⬆️ Enviando para GitHub..."
git branch -M main
git push -u origin main

echo "✅ Deploy concluído com sucesso!"
echo "📍 Repositório: https://github.com/WMAPPLIANCES/supabase-selfhosted" 