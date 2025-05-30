#!/bin/bash

# =================================================================
# Script para criar volumes necessários para Portainer Deploy
# =================================================================

echo "🚀 Preparando volumes para deploy no Portainer..."

# Criar estrutura de diretórios
echo "📁 Criando estrutura de diretórios..."
mkdir -p volumes/{db,api,logs,functions/main,pooler,storage}

# Verificar se arquivos SQL existem, se não, criar
if [ ! -f "volumes/db/realtime.sql" ]; then
    echo "📄 Criando arquivo realtime.sql..."
    cat > volumes/db/realtime.sql << 'EOF'
-- Realtime configuration
CREATE SCHEMA IF NOT EXISTS _realtime;
EOF
fi

if [ ! -f "volumes/db/webhooks.sql" ]; then
    echo "📄 Criando arquivo webhooks.sql..."
    cat > volumes/db/webhooks.sql << 'EOF'
-- Webhooks configuration
-- This will be populated by Supabase
EOF
fi

if [ ! -f "volumes/db/roles.sql" ]; then
    echo "📄 Criando arquivo roles.sql..."
    cat > volumes/db/roles.sql << 'EOF'
-- Database roles configuration
-- Create necessary roles for Supabase

-- Create authenticator role
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'authenticator') THEN
    CREATE ROLE authenticator NOINHERIT LOGIN PASSWORD 'your-password';
  END IF;
END
$$;

-- Create anon role
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'anon') THEN
    CREATE ROLE anon NOLOGIN;
    GRANT anon TO authenticator;
  END IF;
END
$$;

-- Create authenticated role
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'authenticated') THEN
    CREATE ROLE authenticated NOLOGIN;
    GRANT authenticated TO authenticator;
  END IF;
END
$$;

-- Create service_role
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'service_role') THEN
    CREATE ROLE service_role NOLOGIN BYPASSRLS;
    GRANT service_role TO authenticator;
  END IF;
END
$$;

-- Create supabase_admin role
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'supabase_admin') THEN
    CREATE ROLE supabase_admin LOGIN SUPERUSER PASSWORD 'your-password';
  END IF;
END
$$;

-- Create storage admin roles
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'supabase_storage_admin') THEN
    CREATE ROLE supabase_storage_admin LOGIN PASSWORD 'your-password';
  END IF;
END
$$;

DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'supabase_auth_admin') THEN
    CREATE ROLE supabase_auth_admin LOGIN PASSWORD 'your-password';
  END IF;
END
$$;
EOF
fi

if [ ! -f "volumes/db/jwt.sql" ]; then
    echo "📄 Criando arquivo jwt.sql..."
    cat > volumes/db/jwt.sql << 'EOF'
-- JWT configuration
-- This sets up JWT secrets
ALTER DATABASE postgres SET "app.settings.jwt_secret" TO 'your-jwt-secret';
ALTER DATABASE postgres SET "app.settings.jwt_exp" TO '3600';
EOF
fi

if [ ! -f "volumes/db/_supabase.sql" ]; then
    echo "📄 Criando arquivo _supabase.sql..."
    cat > volumes/db/_supabase.sql << 'EOF'
-- Create the _supabase database for internal Supabase data
SELECT 'CREATE DATABASE _supabase' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = '_supabase')\gexec
\c _supabase
CREATE SCHEMA IF NOT EXISTS _analytics;
EOF
fi

if [ ! -f "volumes/db/logs.sql" ]; then
    echo "📄 Criando arquivo logs.sql..."
    cat > volumes/db/logs.sql << 'EOF'
-- Logs configuration for analytics
\c _supabase;
CREATE SCHEMA IF NOT EXISTS _analytics;
EOF
fi

if [ ! -f "volumes/db/pooler.sql" ]; then
    echo "📄 Criando arquivo pooler.sql..."
    cat > volumes/db/pooler.sql << 'EOF'
-- Pooler configuration for Supavisor
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'supavisor') THEN
    CREATE ROLE supavisor WITH LOGIN PASSWORD 'supavisor';
  END IF;
END
$$;

GRANT CONNECT ON DATABASE postgres TO supavisor;
GRANT USAGE ON SCHEMA public TO supavisor;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO supavisor;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO supavisor;
ALTER ROLE supavisor CONNECTION LIMIT -1;
EOF
fi

# Verificar arquivo Kong
if [ ! -f "volumes/api/kong.yml" ]; then
    echo "📄 Criando arquivo kong.yml..."
    cat > volumes/api/kong.yml << 'EOF'
_format_version: "1.1"
_transform: true

consumers:
  - username: anon
    keyauth_credentials:
      - key: ${SUPABASE_ANON_KEY}
  - username: service_role
    keyauth_credentials:
      - key: ${SUPABASE_SERVICE_KEY}

acls:
  - consumer: anon
    group: anon
  - consumer: service_role
    group: admin

services:
  - name: auth-v1-open
    url: http://auth:9999/verify
    routes:
      - name: auth-v1-open
        strip_path: true
        paths:
          - /auth/v1/verify
    plugins:
      - name: cors
  - name: auth-v1-open-callback
    url: http://auth:9999/callback
    routes:
      - name: auth-v1-open-callback
        strip_path: true
        paths:
          - /auth/v1/callback
    plugins:
      - name: cors
  - name: auth-v1-open-authorize
    url: http://auth:9999/authorize
    routes:
      - name: auth-v1-open-authorize
        strip_path: true
        paths:
          - /auth/v1/authorize
    plugins:
      - name: cors

  - name: auth-v1
    _comment: "GoTrue: /auth/v1/* -> http://auth:9999/*"
    url: http://auth:9999/
    routes:
      - name: auth-v1-all
        strip_path: true
        paths:
          - /auth/v1/
    plugins:
      - name: cors
      - name: key-auth
        config:
          hide_credentials: false
      - name: acl
        config:
          hide_groups_header: true
          allow:
            - admin
            - anon

  - name: rest-v1
    _comment: "PostgREST: /rest/v1/* -> http://rest:3000/*"
    url: http://rest:3000/
    routes:
      - name: rest-v1-all
        strip_path: true
        paths:
          - /rest/v1/
    plugins:
      - name: cors
      - name: key-auth
        config:
          hide_credentials: true
      - name: acl
        config:
          hide_groups_header: true
          allow:
            - admin
            - anon

  - name: realtime-v1
    _comment: "Realtime: /realtime/v1/* -> ws://realtime:4000/socket/*"
    url: http://realtime:4000/socket/
    routes:
      - name: realtime-v1-all
        strip_path: true
        paths:
          - /realtime/v1/
    plugins:
      - name: cors
      - name: key-auth
        config:
          hide_credentials: false
      - name: acl
        config:
          hide_groups_header: true
          allow:
            - admin
            - anon

  - name: storage-v1
    _comment: "Storage: /storage/v1/* -> http://storage:5000/*"
    url: http://storage:5000/
    routes:
      - name: storage-v1-all
        strip_path: true
        paths:
          - /storage/v1/
    plugins:
      - name: cors

  - name: edge-functions-v1
    _comment: "Edge Functions: /functions/v1/* -> http://functions:9000/*"
    url: http://functions:9000/
    routes:
      - name: edge-functions-v1-all
        strip_path: true
        paths:
          - /functions/v1/
    plugins:
      - name: cors

plugins:
  - name: cors
    config:
      origins:
        - "*"
      methods:
        - GET
        - HEAD
        - PUT
        - PATCH
        - POST
        - DELETE
        - OPTIONS
      headers:
        - Accept
        - Accept-Version
        - Content-Length
        - Content-MD5
        - Content-Type
        - Date
        - X-Api-Version
        - Authorization
EOF
fi

# Verificar arquivo Vector
if [ ! -f "volumes/logs/vector.yml" ]; then
    echo "📄 Criando arquivo vector.yml..."
    cat > volumes/logs/vector.yml << 'EOF'
api:
  enabled: true
  address: 0.0.0.0:9001

sources:
  docker_logs:
    type: docker_logs
    include_containers:
      - supabase

transforms:
  parse_logs:
    type: json_parser
    inputs: ["docker_logs"]

sinks:
  logflare:
    type: http
    inputs: ["parse_logs"]
    uri: http://analytics:4000/api/logs
    encoding:
      codec: json
EOF
fi

# Criar Edge Function exemplo
if [ ! -f "volumes/functions/main/index.ts" ]; then
    echo "📄 Criando Edge Function de exemplo..."
    cat > volumes/functions/main/index.ts << 'EOF'
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";

serve(async (req) => {
  return new Response(
    JSON.stringify({ message: "Hello from Supabase Edge Functions!" }),
    { headers: { "Content-Type": "application/json" } },
  );
});
EOF
fi

# Criar configuração do pooler
if [ ! -f "volumes/pooler/pooler.exs" ]; then
    echo "📄 Criando configuração do pooler..."
    cat > volumes/pooler/pooler.exs << 'EOF'
defmodule Supavisor.Config do
  def setup do
    tenant_id = System.get_env("POOLER_TENANT_ID") || "default"
    
    Supavisor.Tenants.create_tenant(%{
      external_id: tenant_id,
      name: "Default Tenant",
      db_host: System.get_env("POSTGRES_HOST") || "db",
      db_port: String.to_integer(System.get_env("POSTGRES_PORT") || "5432"),
      db_name: System.get_env("POSTGRES_DB") || "postgres",
      db_user: "postgres",
      db_password: System.get_env("POSTGRES_PASSWORD"),
      pool_size: String.to_integer(System.get_env("POOLER_DEFAULT_POOL_SIZE") || "25"),
      max_clients: String.to_integer(System.get_env("POOLER_MAX_CLIENT_CONN") || "100")
    })
  end
end

Supavisor.Config.setup()
EOF
fi

# Configurar permissões
echo "🔒 Configurando permissões..."
find volumes -type f -name "*.sql" -exec chmod 644 {} \;
find volumes -type f -name "*.yml" -exec chmod 644 {} \;
find volumes -type f -name "*.ts" -exec chmod 644 {} \;
find volumes -type f -name "*.exs" -exec chmod 644 {} \;
find volumes -type d -exec chmod 755 {} \;

echo ""
echo "✅ Volumes preparados com sucesso!"
echo ""
echo "📋 Arquivos criados:"
echo "   - volumes/db/*.sql (configurações do banco)"
echo "   - volumes/api/kong.yml (configuração do gateway)"
echo "   - volumes/logs/vector.yml (configuração de logs)"
echo "   - volumes/functions/main/index.ts (edge function)"
echo "   - volumes/pooler/pooler.exs (configuração do pooler)"
echo ""
echo "🚀 Próximos passos:"
echo "1. Copie a pasta 'volumes' para a VPS onde irá rodar o Portainer"
echo "2. Use o arquivo 'docker-compose.portainer.yml' no Portainer"
echo "3. Configure as variáveis de ambiente conforme o guia"
echo "4. Faça o deploy da stack!"
echo "" 