#!/bin/bash

echo "📦 Preparando arquivos para download - Supabase Chat"
echo "=================================================="

# Criar diretório para o projeto
mkdir -p supabase-chat-download

# Copiar arquivos principais
echo "📋 Copiando arquivos principais..."
cp README.md supabase-chat-download/
cp docker-compose.yml supabase-chat-download/
cp env.example supabase-chat-download/
cp .gitignore supabase-chat-download/
cp reset.sh supabase-chat-download/
cp deploy_git.sh supabase-chat-download/
cp fix_git_commit.sh supabase-chat-download/
cp finalizar_push.sh supabase-chat-download/
cp INSTRUÇÕES_DEPLOY.md supabase-chat-download/
cp SOLUÇÃO_PROBLEMAS_GIT.md supabase-chat-download/
cp comandos_push.txt supabase-chat-download/

# Tornar scripts executáveis
echo "🔧 Configurando permissões..."
chmod +x supabase-chat-download/*.sh

# Criar arquivo compactado
echo "📦 Criando arquivo compactado..."
tar -czf supabase-chat-project.tar.gz supabase-chat-download/

# Verificar tamanho
echo "📊 Informações do arquivo:"
ls -lh supabase-chat-project.tar.gz

echo ""
echo "✅ Arquivo preparado: supabase-chat-project.tar.gz"
echo ""
echo "📥 Para fazer download:"
echo "1. Use SCP: scp root@66.94.126.120:/root/supabase/supabase-chat-project.tar.gz ."
echo "2. Use SFTP ou WinSCP"
echo "3. Use wget se tiver servidor web configurado"
echo ""
echo "📂 Conteúdo do arquivo:"
echo "- README.md (documentação)"
echo "- docker-compose.yml (configuração Supabase)"
echo "- env.example (variáveis de ambiente)"
echo "- .gitignore (exclusões git)"
echo "- Scripts de deploy e automação"
echo "- Documentação de troubleshooting" 