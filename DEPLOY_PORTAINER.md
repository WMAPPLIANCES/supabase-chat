# 🚀 Deploy Supabase no Portainer - Guia Completo

Este guia te mostra como fazer deploy do Supabase no Portainer para conectar com Chatwoot em VPS externa.

## 📋 Pré-requisitos

- Portainer instalado e funcionando
- Domínio configurado: `selfapi.wmappliances.cloud`
- VPS com portas liberadas: 3001, 8000, 5432

## 🛠️ Passo a Passo no Portainer

### 1. Criar Stack no Portainer

1. **Acesse o Portainer** da sua VPS
2. **Vá em "Stacks"**
3. **Clique em "Add Stack"**
4. **Nome da Stack**: `supabase-chat`

### 2. Configurar Variables de Ambiente

Na seção **Environment Variables**, adicione:

```env
POSTGRES_PASSWORD=WMApp2024PostgresSecurePassword123!
POSTGRES_HOST=db
POSTGRES_PORT=5433
POSTGRES_DB=postgres
JWT_SECRET=WMAppliances2024SecureJWTSecretKey123456
JWT_EXPIRY=3600
ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOuoJuXMiQTgr8VNjQQNMqZly4ox-PQdALPo
SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImV4cCI6MTk4MzgxMjk5Nn0.EGIM96RAZx35lJzdJsyH-qQwv8Hdp7fsn3W0YpN81IU
SITE_URL=https://selfapi.wmappliances.cloud
API_EXTERNAL_URL=https://selfapi.wmappliances.cloud
SUPABASE_PUBLIC_URL=https://selfapi.wmappliances.cloud
KONG_HTTP_PORT=8000
KONG_HTTPS_PORT=8443
DASHBOARD_USERNAME=supabase
DASHBOARD_PASSWORD=WMApp2024DashboardSecure!
STUDIO_DEFAULT_ORGANIZATION=WM Appliances
STUDIO_DEFAULT_PROJECT=Supabase Chat
ENABLE_EMAIL_SIGNUP=true
ENABLE_EMAIL_AUTOCONFIRM=true
ENABLE_PHONE_SIGNUP=false
ENABLE_PHONE_AUTOCONFIRM=false
DISABLE_SIGNUP=false
ENABLE_ANONYMOUS_USERS=false
PGRST_DB_SCHEMAS=public,storage,graphql_public
FUNCTIONS_VERIFY_JWT=false
IMGPROXY_ENABLE_WEBP_DETECTION=true
SMTP_HOST=
SMTP_PORT=587
SMTP_USER=
SMTP_PASS=
SMTP_ADMIN_EMAIL=admin@wmappliances.cloud
SMTP_SENDER_NAME=WM Appliances
MAILER_URLPATHS_CONFIRMATION=/auth/confirm
MAILER_URLPATHS_INVITE=/auth/invite
MAILER_URLPATHS_RECOVERY=/auth/reset-password
MAILER_URLPATHS_EMAIL_CHANGE=/auth/confirm
ADDITIONAL_REDIRECT_URLS=
LOGFLARE_API_KEY=WMApp2024LogflareSecureKey123456789
DOCKER_SOCKET_LOCATION=/var/run/docker.sock
SECRET_KEY_BASE=WMAppliances2024SuperSecureKeyForSupavisorPoolingSystem123456789
VAULT_ENC_KEY=WMApp2024VaultEncryptionKey32
POOLER_MAX_CLIENT_CONN=100
POOLER_TENANT_ID=default
POOLER_DEFAULT_POOL_SIZE=10
OPENAI_API_KEY=
```

### 3. Colar o Docker Compose

Na seção **Web Editor**, copie o conteúdo do arquivo `docker-compose.portainer.yml`

### 4. Deploy da Stack

1. **Clique em "Deploy the Stack"**
2. **Aguarde o deploy** (pode levar alguns minutos)
3. **Verifique os logs** se houver algum erro

## 🌐 Configurar Proxy Reverso (Opcional)

Se você usar Nginx Proxy Manager ou similar:

```nginx
# Supabase API
server {
    listen 80;
    server_name selfapi.wmappliances.cloud;
    
    location / {
        proxy_pass http://localhost:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

# Supabase Studio (Opcional - para acesso externo)
server {
    listen 80;
    server_name studio.selfapi.wmappliances.cloud;
    
    location / {
        proxy_pass http://localhost:3001;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

## 🔗 Conectar com Chatwoot (VPS Externa)

### Configurações para o Chatwoot

Use essas informações no seu Chatwoot (na outra VPS):

```json
{
  "supabase_url": "https://selfapi.wmappliances.cloud",
  "supabase_anon_key": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOuoJuXMiQTgr8VNjQQNMqZly4ox-PQdALPo",
  "supabase_service_key": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImV4cCI6MTk4MzgxMjk5Nn0.EGIM96RAZx35lJzdJsyH-qQwv8Hdp7fsn3W0YpN81IU",
  "database_url": "postgresql://postgres:WMApp2024PostgresSecurePassword123!@IP_DA_VPS_SUPABASE:5432/postgres"
}
```

**⚠️ IMPORTANTE**: Substitua `IP_DA_VPS_SUPABASE` pelo IP real da VPS onde o Supabase está rodando.

## 📊 Verificar Deploy

### 1. Verificar Containers

No Portainer, vá em **Containers** e verifique se todos estão com status "running":

- ✅ supabase-chat_db
- ✅ supabase-chat_kong  
- ✅ supabase-chat_auth
- ✅ supabase-chat_rest
- ✅ supabase-chat_realtime
- ✅ supabase-chat_storage
- ✅ supabase-chat_meta
- ✅ supabase-chat_functions
- ✅ supabase-chat_analytics
- ✅ supabase-chat_studio
- ✅ supabase-chat_vector
- ✅ supabase-chat_supavisor
- ✅ supabase-chat_imgproxy

### 2. Testar Endpoints

```bash
# Testar API principal
curl https://selfapi.wmappliances.cloud/health

# Testar Studio (se configurado proxy)
curl https://studio.selfapi.wmappliances.cloud

# Testar conexão direta (se porta estiver aberta)
curl http://IP_DA_VPS:8000/health
curl http://IP_DA_VPS:3001
```

## 🔧 Configurações de Firewall

Certifique-se de que essas portas estão abertas:

```bash
# Principais portas
8000  # API Supabase (OBRIGATÓRIA)
3001  # Studio (Opcional)
5432  # PostgreSQL (se Chatwoot for conectar diretamente)

# Comando para abrir portas (Ubuntu/Debian)
sudo ufw allow 8000
sudo ufw allow 3001  
sudo ufw allow 5432
```

## 🚨 Troubleshooting

### Problema 1: Containers não iniciam
```bash
# Verificar logs no Portainer ou via CLI
docker logs supabase-chat_db
docker logs supabase-chat_kong
```

### Problema 2: Erro de conexão externa
1. Verificar se as portas estão abertas no firewall
2. Verificar se o domínio aponta para o IP correto
3. Verificar configuração do proxy reverso

### Problema 3: Chatwoot não conecta
1. Verificar se as chaves estão corretas
2. Testar conectividade entre VPS
3. Verificar logs do Chatwoot para erros específicos

## 📝 URLs de Acesso

Após o deploy:

- **API Supabase**: `https://selfapi.wmappliances.cloud`
- **Studio**: `http://IP_DA_VPS:3001` 
- **PostgreSQL**: `IP_DA_VPS:5432`

## 🔐 Credenciais

- **Studio Login**: `supabase` / `WMApp2024DashboardSecure!`
- **Database**: `postgres` / `WMApp2024PostgresSecurePassword123!`

---

## 🎯 Resumo para Chatwoot

Para conectar o Chatwoot (na outra VPS), use:

1. **URL**: `https://selfapi.wmappliances.cloud`
2. **Anon Key**: (ver variáveis acima)
3. **Service Key**: (ver variáveis acima)

O Supabase estará rodando e pronto para receber conexões do Chatwoot! 🚀 