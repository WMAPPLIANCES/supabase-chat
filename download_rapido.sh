#!/bin/bash

echo "🚀 Criando download SUPER RÁPIDO - Apenas arquivos essenciais"
echo "============================================================"

# Criar arquivo compactado MÍNIMO com apenas os arquivos essenciais
tar -czf supabase-essencial.tar.gz \
    README.md \
    docker-compose.yml \
    env.example \
    .gitignore

# Verificar tamanho
echo "📊 Arquivo criado:"
ls -lh supabase-essencial.tar.gz

echo ""
echo "✅ Download RÁPIDO pronto: supabase-essencial.tar.gz"
echo ""
echo "📥 Comando para download:"
echo "scp root@66.94.126.120:/root/supabase/supabase-essencial.tar.gz ."
echo ""
echo "📋 Contém apenas:"
echo "- README.md"
echo "- docker-compose.yml" 
echo "- env.example"
echo "- .gitignore" 