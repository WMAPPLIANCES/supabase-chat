#!/usr/bin/env python3

import jwt
import time
import json

# JWT Secret do arquivo .env
JWT_SECRET = "WMAppliances2024SecureJWTSecretKey123456"

# Timestamps
current_time = int(time.time())
expiry_time = current_time + (10 * 365 * 24 * 60 * 60)  # 10 anos

# Payload para ANON_KEY
anon_payload = {
    "iss": "supabase",
    "ref": "selfapi",
    "role": "anon",
    "iat": current_time,
    "exp": expiry_time
}

# Payload para SERVICE_ROLE_KEY
service_payload = {
    "iss": "supabase", 
    "ref": "selfapi",
    "role": "service_role",
    "iat": current_time,
    "exp": expiry_time
}

# Gerar tokens
anon_key = jwt.encode(anon_payload, JWT_SECRET, algorithm="HS256")
service_key = jwt.encode(service_payload, JWT_SECRET, algorithm="HS256")

print("🔑 CHAVES JWT GERADAS COM SUCESSO!")
print("=" * 60)
print(f"JWT_SECRET: {JWT_SECRET}")
print("=" * 60)
print(f"ANON_KEY: {anon_key}")
print("=" * 60)
print(f"SERVICE_ROLE_KEY: {service_key}")
print("=" * 60)

# Verificar se as chaves são válidas
try:
    anon_decoded = jwt.decode(anon_key, JWT_SECRET, algorithms=["HS256"])
    service_decoded = jwt.decode(service_key, JWT_SECRET, algorithms=["HS256"])
    
    print("✅ VERIFICAÇÃO DAS CHAVES:")
    print(f"ANON role: {anon_decoded['role']}")
    print(f"SERVICE role: {service_decoded['role']}")
    print("✅ Todas as chaves são válidas!")
    
except Exception as e:
    print(f"❌ Erro na verificação: {e}")

print("\n📝 PRÓXIMOS PASSOS:")
print("1. Copie as chaves acima")
print("2. Substitua no arquivo .env:")
print("   - ANON_KEY=<cole_aqui_a_anon_key>")
print("   - SERVICE_ROLE_KEY=<cole_aqui_a_service_key>")
print("3. Execute: docker compose down && docker compose up -d") 