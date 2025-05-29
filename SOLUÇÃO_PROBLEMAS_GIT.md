# 🔧 Solução de Problemas - Git e Commit

## ❌ Problema: Commit não está funcionando

### 🔍 Diagnóstico Rápido

Execute estes comandos para identificar o problema:

```bash
# 1. Verificar se está no diretório correto
pwd
ls -la

# 2. Verificar se git está instalado
git --version

# 3. Verificar se é um repositório git
ls -la .git

# 4. Verificar status do git
git status

# 5. Verificar configuração do git
git config user.name
git config user.email
```

### 🛠️ Soluções por Problema

#### Problema 1: Git não instalado
```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install -y git

# CentOS/RHEL
sudo yum install -y git
```

#### Problema 2: Não é um repositório git
```bash
cd /root/supabase
git init
```

#### Problema 3: Git não configurado OU email incorreto
```bash
git config --global user.name "WM Appliances"
git config --global user.email "support@wmappliances.net"

# Verificar se foi configurado corretamente
git config user.name
git config user.email
```

#### Problema 4: Arquivos não adicionados
```bash
git add README.md
git add docker-compose.yml
git add env.example
git add .gitignore
git add reset.sh
git add deploy_git.sh
git add INSTRUÇÕES_DEPLOY.md
git add fix_git_commit.sh
```

#### Problema 5: Commit com erro
```bash
# Commit simples
git commit -m "Deploy inicial Supabase Self-Hosted WM Appliances"
```

### 🚀 Script Automático de Correção

Execute o script de diagnóstico:

```bash
chmod +x fix_git_commit.sh
./fix_git_commit.sh
```

### 📋 Checklist de Verificação

- [ ] Git instalado e funcionando
- [ ] Diretório correto (/root/supabase)
- [ ] Repositório git inicializado
- [ ] Git configurado com nome e **email correto: support@wmappliances.net**
- [ ] Arquivos adicionados ao staging
- [ ] Commit realizado com sucesso

### 🌐 Criar Repositório no GitHub

1. **Acesse:** https://github.com/WMAPPLIANCES
2. **Clique:** "New repository"
3. **Nome:** `supabase-selfhosted`
4. **Descrição:** `Supabase Self-Hosted configuration for WM Appliances`
5. **Visibilidade:** Private (recomendado)
6. **NÃO marque:** "Initialize with README"
7. **Clique:** "Create repository"

### 🔗 Conectar ao GitHub

Após criar o repositório:

```bash
# Adicionar repositório remoto
git remote add origin https://github.com/WMAPPLIANCES/supabase-selfhosted.git

# Verificar se foi adicionado
git remote -v

# Renomear branch para main
git branch -M main

# Fazer push inicial
git push -u origin main
```

### ⚠️ Problemas Comuns e Soluções

#### Erro: "Permission denied"
```bash
# Verificar permissões
ls -la
chmod +x *.sh
```

#### Erro: "Repository not found"
- Verifique se o repositório foi criado no GitHub
- Verifique se o nome está correto
- Verifique se você tem acesso ao repositório

#### Erro: "Authentication failed"
- Use token de acesso pessoal em vez de senha
- Configure SSH keys
- Ou use HTTPS com token

#### Erro: "Nothing to commit"
```bash
# Verificar se há arquivos modificados
git status

# Adicionar arquivos específicos
git add .

# Verificar novamente
git status
```

### 🔐 Configuração de Autenticação

#### Opção 1: Token de Acesso Pessoal
1. GitHub → Settings → Developer settings → Personal access tokens
2. Generate new token (classic)
3. Selecione scopes: repo, workflow
4. Use o token como senha

#### Opção 2: SSH Keys
```bash
# Gerar chave SSH
ssh-keygen -t ed25519 -C "support@wmappliances.net"

# Adicionar ao ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Copiar chave pública
cat ~/.ssh/id_ed25519.pub

# Adicionar no GitHub: Settings → SSH and GPG keys
```

### 📞 Suporte de Emergência

Se nada funcionar, execute estes comandos em sequência:

```bash
# Reset completo com email correto
cd /root/supabase
rm -rf .git
git init
git config user.name "WM Appliances"
git config user.email "support@wmappliances.net"
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/WMAPPLIANCES/supabase-selfhosted.git
git push -u origin main
```

### ✅ Verificação Final

Após o push bem-sucedido, verifique:
- [ ] Repositório visível no GitHub
- [ ] Todos os arquivos presentes
- [ ] README.md sendo exibido
- [ ] Dados sensíveis NÃO presentes (.env, volumes/)

---

**WM Appliances** - Suporte Técnico 