#!/bin/bash

# =================================================================
# Supabase + Chatwoot Integration Setup Script
# =================================================================

echo "🚀 Configurando integração Supabase + Chatwoot..."

# Gerar chaves aleatórias seguras
generate_key() {
    openssl rand -base64 32 | tr -d "=+/" | cut -c1-25
}

# Verificar se o arquivo .env existe
if [ ! -f .env ]; then
    echo "❌ Arquivo .env não encontrado. Copiando do env.example..."
    cp env.example .env
fi

# Substituir chaves por valores seguros
echo "🔑 Gerando chaves seguras..."

SECRET_KEY_BASE=$(generate_key)
VAULT_ENC_KEY=$(generate_key)
POOLER_TENANT_ID=$(generate_key)
LOGFLARE_API_KEY=$(generate_key)

# Atualizar arquivo .env
sed -i "s/your-secret-key-base-here/$SECRET_KEY_BASE/g" .env
sed -i "s/your-vault-encryption-key-here/$VAULT_ENC_KEY/g" .env
sed -i "s/your-tenant-id-here/$POOLER_TENANT_ID/g" .env
sed -i "s/your-logflare-api-key/$LOGFLARE_API_KEY/g" .env

echo "✅ Chaves geradas e configuradas no arquivo .env"

# Criar diretórios necessários
echo "📁 Criando estrutura de diretórios..."
mkdir -p volumes/{storage,functions/main,pooler}

# Configurar permissões
echo "🔒 Configurando permissões..."
chmod +x setup_chatwoot_integration.sh
chmod 755 volumes/storage

echo ""
echo "🎉 Configuração concluída!"
echo ""
echo "🔧 Para conectar com o Chatwoot:"
echo "1. Configure a URL do Supabase no Chatwoot: http://localhost:8000"
echo "2. Use as seguintes credenciais:"
echo "   - URL: http://localhost:8000"
echo "   - Anon Key: $(grep ANON_KEY .env | cut -d'=' -f2)"
echo "   - Service Key: $(grep SERVICE_ROLE_KEY .env | cut -d'=' -f2)"
echo ""
echo "🚀 Para iniciar o Supabase:"
echo "   docker compose up -d"
echo ""
echo "📊 Para acessar o Studio:"
echo "   http://localhost:3001"
echo ""

# Criar arquivo de configuração do Chatwoot
cat > chatwoot_config.json << EOF
{
  "supabase_url": "http://localhost:8000",
  "supabase_anon_key": "$(grep ANON_KEY .env | cut -d'=' -f2)",
  "supabase_service_key": "$(grep SERVICE_ROLE_KEY .env | cut -d'=' -f2)",
  "database_url": "postgresql://postgres:$(grep POSTGRES_PASSWORD .env | cut -d'=' -f2)@localhost:5432/postgres",
  "setup_date": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
}
EOF

echo "📄 Configuração do Chatwoot salva em: chatwoot_config.json" 