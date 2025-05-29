#!/bin/bash

echo "🚀 Finalizando Push para GitHub - WM Appliances"
echo "==============================================="

# Verificar se há repositório remoto
echo "1. Verificando repositórios remotos..."
git remote -v

# Remover repositório remoto se existir
echo ""
echo "2. Removendo repositório remoto anterior (se existir)..."
git remote remove origin 2>/dev/null || echo "Nenhum repositório remoto para remover"

# Adicionar o repositório correto
echo ""
echo "3. Adicionando repositório GitHub..."
git remote add origin https://github.com/WMAPPLIANCES/supabase-chat.git
echo "✅ Repositório adicionado"

# Verificar se foi adicionado
echo ""
echo "4. Verificando repositório remoto..."
git remote -v

# Renomear branch para main (se necessário)
echo ""
echo "5. Configurando branch principal..."
git branch -M main
echo "✅ Branch configurada como main"

# Fazer push
echo ""
echo "6. Fazendo push para GitHub..."
git push -u origin main

echo ""
echo "✅ Push concluído!"
echo "📍 Repositório: https://github.com/WMAPPLIANCES/supabase-chat"
echo ""
echo "🎯 Verifique no GitHub se todos os arquivos foram enviados:"
echo "- README.md"
echo "- docker-compose.yml" 
echo "- env.example"
echo "- .gitignore"
echo "- reset.sh"
echo "- Scripts de deploy" 