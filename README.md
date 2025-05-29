# Supabase Self-Hosted - WM Appliances

Este repositório contém a configuração completa para deploy do Supabase self-hosted para a WM Appliances.

## 🚀 Características

- **Supabase completo self-hosted** com todos os serviços
- **Configuração de segurança** com credenciais personalizadas
- **Integração com domínio** `selfapi.wmappliances.cloud`
- **Suporte a S3** para storage de arquivos
- **Scripts de automação** para deploy e reset

## 📋 Serviços Incluídos

- **Studio** - Interface web do Supabase
- **Kong** - API Gateway
- **Auth** - Autenticação e autorização
- **REST** - API REST automática
- **Realtime** - WebSockets em tempo real
- **Storage** - Armazenamento de arquivos
- **Meta** - API de metadados do Postgres
- **Functions** - Edge Functions
- **Analytics** - Análise de dados
- **Database** - PostgreSQL
- **Vector** - Suporte a embeddings
- **Pooler** - Pool de conexões

## 🛠️ Instalação

1. Clone este repositório:
```bash
git clone https://github.com/WMAPPLIANCES/supabase-selfhosted.git
cd supabase-selfhosted
```

2. Configure as variáveis de ambiente:
```bash
cp .env.example .env
# Edite o arquivo .env com suas configurações
```

3. Execute o deploy:
```bash
docker compose up -d
```

## 🔧 Configuração

### URLs de Acesso

- **Studio**: `https://selfapi.wmappliances.cloud`
- **API REST**: `https://selfapi.wmappliances.cloud/rest/v1/`
- **Auth**: `https://selfapi.wmappliances.cloud/auth/v1/`
- **Storage**: `https://selfapi.wmappliances.cloud/storage/v1/`
- **Realtime**: `https://selfapi.wmappliances.cloud/realtime/v1/`

### Credenciais Padrão

- **Username**: `supabase`
- **Password**: `this_password_is_insecure_and_should_be_updated`

## 🔒 Segurança

Este projeto inclui configurações de segurança personalizadas:

- JWT Secret personalizado
- Senhas seguras para PostgreSQL
- Configuração de domínio externo
- Exclusão de dados sensíveis do versionamento

## 📁 Estrutura do Projeto

```
├── docker-compose.yml          # Configuração principal
├── docker-compose.s3.yml       # Configuração S3
├── .env.example                # Exemplo de variáveis
├── reset.sh                    # Script de reset
├── .gitignore                  # Exclusões do git
└── README.md                   # Este arquivo
```

## 🤝 Integração com Chatwoot

Este Supabase está configurado para integração com Chatwoot:

1. Configure as URLs da API no Chatwoot
2. Use as credenciais de autenticação
3. Configure webhooks se necessário

## 📞 Suporte

Para suporte técnico, entre em contato com a equipe WM Appliances.

---

**WM Appliances** - Soluções em Tecnologia
