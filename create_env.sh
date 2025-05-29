#!/bin/bash

# Script para criar arquivo .env do Supabase com configurações de segurança

echo "🔐 Criando arquivo .env com configurações de segurança..."

# Navegar para o diretório correto
cd /root/supabase/supabase-project

# Criar arquivo .env com configurações seguras
cat > .env << 'EOF'
############
# Secrets
# CONFIGURAÇÕES DE SEGURANÇA - PRODUÇÃO
############

# Senhas e chaves principais
POSTGRES_PASSWORD=WMApp2024PostgresSecurePassword123!
JWT_SECRET=WMAppliances2024SecureJWTSecretKey123456

# API Keys (geradas com JWT Secret acima)
ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNlbGZhcGkiLCJyb2xlIjoiYW5vbiIsImlhdCI6MTcwNDY3MjAwMCwiZXhwIjoyMDIwMjQ4MDAwfQ.YourGeneratedAnonKeyHere
SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNlbGZhcGkiLCJyb2xlIjoic2VydmljZV9yb2xlIiwiaWF0IjoxNzA0NjcyMDAwLCJleHAiOjIwMjAyNDgwMDB9.YourGeneratedServiceRoleKeyHere

############
# Database
############
POSTGRES_HOST=db
POSTGRES_DB=postgres
POSTGRES_PORT=5432

############
# API Proxy - Kong
############
KONG_HTTP_PORT=8000
KONG_HTTPS_PORT=8443

############
# API - PostgREST
############
PGRST_DB_SCHEMAS=public,storage,graphql_public

############
# Auth - GoTrue
############
# URLs para acesso externo
SITE_URL=https://selfapi.wmappliances.cloud
API_EXTERNAL_URL=https://selfapi.wmappliances.cloud
ADDITIONAL_REDIRECT_URLS=
JWT_EXPIRY=3600
DISABLE_SIGNUP=false

# Email auth
ENABLE_EMAIL_SIGNUP=true
ENABLE_EMAIL_AUTOCONFIRM=false
ENABLE_ANONYMOUS_USERS=false

# Phone auth
ENABLE_PHONE_SIGNUP=true
ENABLE_PHONE_AUTOCONFIRM=true

# SMTP Configuration
SMTP_ADMIN_EMAIL=admin@wmappliances.cloud
SMTP_HOST=
SMTP_PORT=587
SMTP_USER=
SMTP_PASS=
SMTP_SENDER_NAME=WM Appliances

# Mailer URLs
MAILER_URLPATHS_INVITE="/auth/v1/verify"
MAILER_URLPATHS_CONFIRMATION="/auth/v1/verify"
MAILER_URLPATHS_RECOVERY="/auth/v1/verify"
MAILER_URLPATHS_EMAIL_CHANGE="/auth/v1/verify"

############
# Studio - Dashboard
############
STUDIO_DEFAULT_ORGANIZATION=WM Appliances
STUDIO_DEFAULT_PROJECT=WM Appliances API
STUDIO_PORT=3000

# Dashboard Authentication
DASHBOARD_USERNAME=wmappliances
DASHBOARD_PASSWORD=WMAppliances2024Dashboard!Secure

# Public URL para acesso externo
SUPABASE_PUBLIC_URL=https://selfapi.wmappliances.cloud

############
# Storage
############
IMGPROXY_ENABLE_WEBP_DETECTION=true

############
# Functions
############
FUNCTIONS_VERIFY_JWT=false

############
# Logs - Analytics
############
LOGFLARE_API_KEY=WMApp2024LogflareAPIKey567890123456789
LOGFLARE_LOGGER_BACKEND_API_KEY=WMApp2024LogflareBackendKey567890

############
# Pooler
############
POOLER_TENANT_ID=wmappliances-tenant-2024
POOLER_DEFAULT_POOL_SIZE=15
POOLER_MAX_CLIENT_CONN=100
POOLER_PROXY_PORT_TRANSACTION=6543

############
# Secrets adicionais
############
SECRET_KEY_BASE=WMAppliances2024SecretKeyBaseForRealtime567890
VAULT_ENC_KEY=WMApp2024VaultEncryptionKey567890123456789

############
# Docker
############
DOCKER_SOCKET_LOCATION=/var/run/docker.sock

############
# OpenAI (opcional)
############
OPENAI_API_KEY=

EOF

echo "✅ Arquivo .env criado com sucesso!"
echo "📍 Localização: /root/supabase/supabase-project/.env"
echo ""
echo "🔑 IMPORTANTE: Você precisa gerar as chaves ANON_KEY e SERVICE_ROLE_KEY"
echo "   usando o JWT_SECRET no site: https://supabase.com/docs/guides/self-hosting/docker#generate-api-keys"
echo ""
echo "🌐 URLs configuradas para: https://selfapi.wmappliances.cloud"
echo "👤 Dashboard: usuário 'wmappliances' / senha 'WMAppliances2024Dashboard!Secure'" 