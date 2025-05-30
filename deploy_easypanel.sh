#!/bin/bash

echo "🚀 Deploy Supabase no Easypanel - WM Appliances"
echo "==============================================="

echo "✅ Correções aplicadas:"
echo "- Versão do GoTrue corrigida: v2.151.0"
echo "- Variáveis de ambiente configuradas"
echo "- URLs configuradas para selfapi.wmappliances.cloud"

echo ""
echo "📋 Próximos passos no Easypanel:"
echo ""
echo "1. 🔧 Configure as variáveis de ambiente:"
echo "   - Copie o conteúdo de 'env_easypanel_completo.txt'"
echo "   - Cole na seção 'Environment Variables'"
echo ""
echo "2. 🐳 Configurações Docker:"
echo "   - Repository: https://github.com/WMAPPLIANCES/supabase-chat"
echo "   - Branch: main"
echo "   - Docker Compose File: docker-compose.yml"
echo ""
echo "3. 🌐 Configurar domínio:"
echo "   - Domain: selfapi.wmappliances.cloud"
echo "   - Port: 8000 (Kong Gateway)"
echo ""
echo "4. 📦 Volumes necessários:"
echo "   - ./volumes/db/data:/var/lib/postgresql/data"
echo "   - ./volumes/storage:/var/lib/storage"
echo ""
echo "5. 🔄 Fazer Deploy"
echo ""
echo "🎯 URLs após deploy:"
echo "- API: https://selfapi.wmappliances.cloud"
echo "- Studio: https://selfapi.wmappliances.cloud:3000"
echo "- Dashboard: supabase / WMApp2024DashboardSecure!"
echo ""
echo "✅ Versões corrigidas:"
echo "- supabase/gotrue: v2.151.0 (versão estável)"
echo "- supabase/studio: 2025.05.19-sha-3487831"
echo "- postgrest/postgrest: v12.2.3"
echo "- supabase/realtime: v2.33.53"
echo ""
echo "🔧 Problemas resolvidos:"
echo "- ❌ Erro: manifest for supabase/gotrue:v2.175.0 not found"
echo "- ✅ Solução: Atualizado para v2.151.0 (versão válida)"
echo ""
echo "📞 Suporte: Se houver problemas, verifique:"
echo "- Variáveis de ambiente estão todas configuradas"
echo "- Domínio está apontando para o servidor"
echo "- Portas 8000 e 3000 estão liberadas"

echo "🚀 Script de Deploy - Supabase WM Appliances no EasyPanel"
echo "=========================================================="

# Verificar se estamos no diretório correto
if [ ! -f "docker-compose.yml" ]; then
    echo "❌ Erro: docker-compose.yml não encontrado!"
    echo "Execute este script na pasta supabase-project"
    exit 1
fi

if [ ! -f ".env" ]; then
    echo "❌ Erro: arquivo .env não encontrado!"
    exit 1
fi

echo "✅ Arquivos necessários encontrados"

# Verificar se as variáveis importantes estão definidas
echo "🔍 Verificando configurações..."

if grep -q "ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9" .env; then
    echo "✅ ANON_KEY configurada"
else
    echo "❌ ANON_KEY não configurada corretamente"
    exit 1
fi

if grep -q "SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9" .env; then
    echo "✅ SERVICE_ROLE_KEY configurada"
else
    echo "❌ SERVICE_ROLE_KEY não configurada corretamente"
    exit 1
fi

if grep -q "selfapi.wmappliances.cloud" .env; then
    echo "✅ Domínio configurado"
else
    echo "❌ Domínio não configurado corretamente"
    exit 1
fi

echo ""
echo "🎯 INFORMAÇÕES DO DEPLOY"
echo "========================"
echo "📡 Domain: selfapi.wmappliances.cloud"
echo "🔐 Dashboard User: wmappliances"
echo "🔑 Dashboard Pass: WMAppliances2024Dashboard!Secure"
echo ""

echo "📋 ENDPOINTS APÓS DEPLOY:"
echo "========================="
echo "• REST API: https://selfapi.wmappliances.cloud/rest/v1/"
echo "• Auth API: https://selfapi.wmappliances.cloud/auth/v1/"
echo "• Storage API: https://selfapi.wmappliances.cloud/storage/v1/"
echo "• Realtime API: https://selfapi.wmappliances.cloud/realtime/v1/"
echo "• Dashboard: https://selfapi.wmappliances.cloud/"
echo ""

echo "🔑 CHAVES PARA INTEGRAÇÃO:"
echo "=========================="
echo "ANON_KEY:"
grep "ANON_KEY=" .env | cut -d'=' -f2
echo ""
echo "SERVICE_ROLE_KEY:"
grep "SERVICE_ROLE_KEY=" .env | cut -d'=' -f2
echo ""

echo "📝 PRÓXIMOS PASSOS PARA EASYPANEL:"
echo "=================================="
echo "1. Acesse seu EasyPanel"
echo "2. Crie um novo projeto: 'supabase-wm'"
echo "3. Selecione 'Docker Compose'"
echo "4. Faça upload dos arquivos:"
echo "   - docker-compose.yml"
echo "   - .env"
echo "   - pasta volumes/ (completa)"
echo "5. Configure o domínio: selfapi.wmappliances.cloud"
echo "6. Aponte para o serviço 'kong' na porta 8000"
echo "7. Execute o deploy"
echo ""

echo "🧪 TESTES APÓS DEPLOY:"
echo "======================"
echo "curl https://selfapi.wmappliances.cloud/rest/v1/"
echo "curl https://selfapi.wmappliances.cloud/auth/v1/health"
echo "curl https://selfapi.wmappliances.cloud/storage/v1/status"
echo ""

echo "✅ Configuração pronta para deploy no EasyPanel!"
echo "📖 Consulte README_EASYPANEL.md para mais detalhes" 