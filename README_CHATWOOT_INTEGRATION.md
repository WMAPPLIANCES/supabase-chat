# 🚀 Supabase + Chatwoot Integration

Este projeto fornece uma configuração completa e otimizada do Supabase para integração com o Chatwoot.

## 📋 Pré-requisitos

- Docker e Docker Compose instalados
- Git instalado
- OpenSSL para geração de chaves seguras

## 🛠️ Configuração Rápida

### 1. Executar o Script de Setup

```bash
chmod +x setup_chatwoot_integration.sh
./setup_chatwoot_integration.sh
```

### 2. Iniciar o Supabase

```bash
docker compose up -d
```

### 3. Verificar se todos os serviços estão funcionando

```bash
docker compose ps
```

## 🔗 Conectando com o Chatwoot

### Configuração no Chatwoot

1. **URL do Supabase**: `http://localhost:8000`
2. **Anon Key**: Encontre no arquivo `.env` ou `chatwoot_config.json`
3. **Service Role Key**: Encontre no arquivo `.env` ou `chatwoot_config.json`

### Exemplo de Configuração

O arquivo `chatwoot_config.json` é gerado automaticamente com as configurações necessárias:

```json
{
  "supabase_url": "http://localhost:8000",
  "supabase_anon_key": "your-anon-key",
  "supabase_service_key": "your-service-key",
  "database_url": "postgresql://postgres:password@localhost:5432/postgres"
}
```

## 🌐 Serviços Disponíveis

| Serviço | Porta | URL | Descrição |
|---------|-------|-----|-----------|
| Kong Gateway | 8000 | http://localhost:8000 | API Gateway principal |
| Supabase Studio | 3001 | http://localhost:3001 | Interface de administração |
| PostgreSQL | 5432 | localhost:5432 | Banco de dados |

## 📊 Monitoramento

### Verificar Status dos Serviços

```bash
# Ver logs de todos os serviços
docker compose logs -f

# Ver logs de um serviço específico
docker compose logs -f studio
docker compose logs -f db
docker compose logs -f auth
```

### Health Checks

```bash
# Verificar saúde da API
curl http://localhost:8000/health

# Verificar Studio
curl http://localhost:3001/api/platform/profile
```

## 🔧 Configurações Avançadas

### Variáveis de Ambiente Principais

```env
# API
SUPABASE_PUBLIC_URL=http://localhost:8000
API_EXTERNAL_URL=http://localhost:8000

# Database
POSTGRES_PASSWORD=your-secure-password
POSTGRES_DB=postgres

# JWT
JWT_SECRET=your-jwt-secret
ANON_KEY=your-anon-key
SERVICE_ROLE_KEY=your-service-role-key
```

### Personalização para Produção

1. **Altere as senhas** no arquivo `.env`
2. **Configure SSL/HTTPS** para produção
3. **Configure SMTP** para emails
4. **Configure backup** do banco de dados

## 🗃️ Estrutura de Dados para Chatwoot

### Tabelas Recomendadas

```sql
-- Usuários do Chatwoot
CREATE TABLE chatwoot_users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  name VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Conversas
CREATE TABLE chatwoot_conversations (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES chatwoot_users(id),
  status VARCHAR(50) DEFAULT 'open',
  created_at TIMESTAMP DEFAULT NOW()
);

-- Mensagens
CREATE TABLE chatwoot_messages (
  id SERIAL PRIMARY KEY,
  conversation_id INTEGER REFERENCES chatwoot_conversations(id),
  content TEXT NOT NULL,
  sender_type VARCHAR(50) NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);
```

## 🔄 Backup e Restore

### Backup

```bash
# Backup do banco de dados
docker compose exec db pg_dump -U postgres postgres > backup.sql

# Backup dos volumes
docker run --rm -v supabase_db-config:/volume -v $(pwd):/backup alpine tar czf /backup/volumes-backup.tar.gz -C /volume .
```

### Restore

```bash
# Restore do banco de dados
docker compose exec -T db psql -U postgres postgres < backup.sql
```

## 🚨 Troubleshooting

### Problemas Comuns

1. **Serviços não iniciam**
   ```bash
   docker compose down
   docker compose up -d
   ```

2. **Erro de conexão com banco**
   - Verifique se a senha está correta no `.env`
   - Verifique se a porta 5432 não está em uso

3. **Studio não carrega**
   - Verifique os logs: `docker compose logs studio`
   - Verifique se a porta 3001 está disponível

### Logs Úteis

```bash
# Analytics
docker compose logs analytics

# Auth
docker compose logs auth

# Database
docker compose logs db
```

## 📈 Performance

### Configurações Otimizadas

- **Connection Pooling**: Supavisor configurado para 25 conexões por pool
- **Analytics**: Logflare com backend PostgreSQL
- **Storage**: Configurado com ImageProxy para otimização
- **Realtime**: Configurado para alta performance

### Monitoramento de Performance

```bash
# Ver uso de recursos
docker stats

# Ver conexões ativas no banco
docker compose exec db psql -U postgres -c "SELECT count(*) FROM pg_stat_activity;"
```

## 🔐 Segurança

### Checklist de Segurança

- [ ] Senhas fortes configuradas
- [ ] JWT secrets únicos
- [ ] HTTPS configurado (produção)
- [ ] Firewall configurado
- [ ] Backup regular configurado

### Regenerar Chaves

```bash
# Gerar nova chave JWT
openssl rand -base64 32

# Gerar novas chaves Supabase
# Use o Supabase CLI ou o script setup
```

## 📞 Suporte

Para problemas específicos da integração:

1. Verifique os logs: `docker compose logs`
2. Consulte a documentação do Chatwoot
3. Verifique a documentação do Supabase
4. Abra uma issue no repositório

---

**Última atualização**: $(date)
**Timezone**: Los Angeles
**Versão**: 1.0.0