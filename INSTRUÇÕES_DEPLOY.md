# 🚀 Instruções para Deploy no GitHub

## Repositório Criado: Supabase Self-Hosted - WM Appliances

### 📁 Arquivos Preparados:

1. **README.md** - Documentação completa do projeto
2. **docker-compose.yml** - Configuração completa do Supabase
3. **env.example** - Exemplo de variáveis de ambiente
4. **.gitignore** - Exclusões de arquivos sensíveis
5. **reset.sh** - Script para resetar o ambiente
6. **deploy_git.sh** - Script automatizado de deploy

### 🔧 Comandos para Executar:

```bash
# 1. Navegar para o diretório do projeto
cd /root/supabase

# 2. Tornar scripts executáveis
chmod +x deploy_git.sh
chmod +x reset.sh

# 3. Executar o script de deploy
./deploy_git.sh
```

### 📝 Ou Execute Manualmente:

```bash
# 1. Configurar git
git config --global user.name "WM Appliances"
git config --global user.email "admin@wmappliances.cloud"

# 2. Inicializar repositório
git init

# 3. Adicionar arquivos
git add README.md
git add docker-compose.yml
git add env.example
git add .gitignore
git add reset.sh
git add deploy_git.sh
git add INSTRUÇÕES_DEPLOY.md

# 4. Fazer commit
git commit -m "🚀 Deploy inicial do Supabase Self-Hosted - WM Appliances"

# 5. Configurar repositório remoto
git remote add origin https://github.com/WMAPPLIANCES/supabase-selfhosted.git

# 6. Fazer push
git branch -M main
git push -u origin main
```

### 🌐 Criar Repositório no GitHub:

1. Acesse: https://github.com/WMAPPLIANCES
2. Clique em "New repository"
3. Nome: `supabase-selfhosted`
4. Descrição: `Supabase Self-Hosted configuration for WM Appliances`
5. Marque como **Private** (recomendado)
6. **NÃO** inicialize com README (já temos um)
7. Clique em "Create repository"

### ✅ Resultado Esperado:

- Repositório: `https://github.com/WMAPPLIANCES/supabase-selfhosted`
- Branch principal: `main`
- Todos os arquivos de configuração versionados
- Dados sensíveis excluídos pelo .gitignore

### 🔒 Segurança:

- ✅ Volumes excluídos do git
- ✅ Arquivos .env excluídos
- ✅ Dados do banco excluídos
- ✅ Logs e temporários excluídos
- ✅ Apenas configurações versionadas

### 📞 Suporte:

Se houver algum erro, execute os comandos um por vez e verifique as mensagens de erro.