# 🚀 Supabase Self-Hosted no EasyPanel - WM Appliances

## 📋 Pré-requisitos

- Servidor com EasyPanel instalado
- Domínio configurado: `selfapi.wmappliances.cloud`
- Mínimo 4GB RAM, 2 CPU cores, 40GB storage

## 🔧 Configuração Inicial

### 1. Clone do Repositório
```bash
git clone https://github.com/WMAPPLIANCES/supabase-wm.git
cd supabase-wm/supabase-project
```

### 2. Configuração das Variáveis de Ambiente

O arquivo `.env` já está configurado com todas as credenciais necessárias:

#### 🔑 Credenciais Principais
- **PostgreSQL Password**: `WMApp2024PostgresSecurePassword123!`
- **JWT Secret**: `WMAppliances2024SecureJWTSecretKey123456`
- **Dashboard User**: `wmappliances`
- **Dashboard Password**: `WMAppliances2024Dashboard!Secure`

#### 🌐 URLs Configuradas
- **Site URL**: `https://selfapi.wmappliances.cloud`
- **API External URL**: `https://selfapi.wmappliances.cloud`
- **Public URL**: `https://selfapi.wmappliances.cloud`

#### 📧 Configuração de Email
- **Admin Email**: `admin@wmappliances.cloud`
- **Sender Name**: `WM Appliances`

## 🐳 Deploy no EasyPanel

### 1. Criar Novo Projeto
1. Acesse o EasyPanel
2. Clique em "Create Project"
3. Nome: `supabase-wm`
4. Selecione "Docker Compose"

### 2. Upload dos Arquivos
1. Faça upload do `docker-compose.yml`
2. Faça upload do arquivo `.env`
3. Faça upload da pasta `volumes/` completa

### 3. Configuração de Domínio
1. Vá para "Domains"
2. Adicione: `selfapi.wmappliances.cloud`
3. Configure para apontar para o serviço `kong` na porta `8000`

### 4. Deploy
1. Clique em "Deploy"
2. Aguarde todos os containers ficarem "Healthy"

## 🔗 Endpoints da API

Após o deploy, os seguintes endpoints estarão disponíveis:

### 📡 APIs Principais
- **REST API**: `https://selfapi.wmappliances.cloud/rest/v1/`
- **Auth API**: `https://selfapi.wmappliances.cloud/auth/v1/`
- **Storage API**: `https://selfapi.wmappliances.cloud/storage/v1/`
- **Realtime API**: `https://selfapi.wmappliances.cloud/realtime/v1/`

### 🎛️ Dashboard
- **URL**: `https://selfapi.wmappliances.cloud/` (porta 3000 via proxy)
- **Usuário**: `wmappliances`
- **Senha**: `WMAppliances2024Dashboard!Secure`

## 🔐 Chaves de API

### Chave Anônima (ANON_KEY)
```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNlbGZhcGkiLCJyb2xlIjoiYW5vbiIsImlhdCI6MTc0ODU1NzE0MSwiZXhwIjoyMDYzOTE3MTQxfQ.H073bpFRf0c5cpjPPBtLdbgYchz-iEs5Oba5xePNbrA
```

### Chave de Serviço (SERVICE_ROLE_KEY)
```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNlbGZhcGkiLCJyb2xlIjoic2VydmljZV9yb2xlIiwiaWF0IjoxNzQ4NTU3MTQxLCJleHAiOjIwNjM5MTcxNDF9.TsPTOdFh5TiPT0dqweDlJTVD-varmUo6E7q9hxMzZ5k
```

## 🔍 Verificação do Deploy

### Status dos Serviços
```bash
docker ps
```

### Teste das APIs
```bash
# Teste da API REST
curl https://selfapi.wmappliances.cloud/rest/v1/

# Teste da API Auth
curl https://selfapi.wmappliances.cloud/auth/v1/health

# Teste da API Storage
curl https://selfapi.wmappliances.cloud/storage/v1/status
```

## 🌐 Integração com Chatwoot

### Configuração no Chatwoot
1. Vá para Configurações > Aplicativos > Supabase
2. Configure:
   - **URL**: `https://selfapi.wmappliances.cloud`
   - **Anon Key**: [use a chave acima]
   - **Service Role Key**: [use a chave acima]

### Exemplo de Conexão JavaScript
```javascript
import { createClient } from '@supabase/supabase-js'

const supabaseUrl = 'https://selfapi.wmappliances.cloud'
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNlbGZhcGkiLCJyb2xlIjoiYW5vbiIsImlhdCI6MTc0ODU1NzE0MSwiZXhwIjoyMDYzOTE3MTQxfQ.H073bpFRf0c5cpjPPBtLdbgYchz-iEs5Oba5xePNbrA'

const supabase = createClient(supabaseUrl, supabaseKey)
```

## 🛠️ Troubleshooting

### Logs dos Containers
```bash
docker logs <container_name>
```

### Restart dos Serviços
```bash
docker compose down
docker compose up -d
```

### Verificar Conectividade
```bash
# Teste interno
docker exec -it <postgres_container> psql -U postgres

# Teste externo
curl -I https://selfapi.wmappliances.cloud
```

## 📈 Monitoramento

### Recursos do Sistema
- **CPU**: Monitor via EasyPanel dashboard
- **RAM**: Mínimo 4GB recomendado
- **Storage**: Crescimento conforme uso do banco

### Logs
- **Analytics**: Disponível no dashboard do Supabase
- **Postgres**: Via logs do container
- **Kong**: Via logs do proxy

## 🔄 Backup e Restauração

### Backup do Banco
```bash
docker exec <postgres_container> pg_dump -U postgres postgres > backup.sql
```

### Backup dos Volumes
```bash
tar -czf volumes_backup.tar.gz volumes/
```

## 🚀 Atualizações

Para atualizar o Supabase:
1. Atualize as versões no `docker-compose.yml`
2. Execute `docker compose pull`
3. Execute `docker compose up -d`

---

**🎯 Configurado para WM Appliances**  
Domain: `selfapi.wmappliances.cloud`  
Timezone: Los Angeles  
Última atualização: Janeiro 2025 