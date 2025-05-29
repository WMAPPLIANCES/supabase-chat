# 📥 Guia para Download dos Arquivos - Supabase Chat

## 🎯 Objetivo
Fazer download dos arquivos do projeto Supabase para o seu computador e fazer commit do GitHub local.

## 📋 Arquivos Necessários

### Arquivos Principais:
1. **README.md** - Documentação completa
2. **docker-compose.yml** - Configuração do Supabase
3. **env.example** - Variáveis de ambiente
4. **.gitignore** - Exclusões do git
5. **reset.sh** - Script de reset
6. **deploy_git.sh** - Script de deploy
7. **fix_git_commit.sh** - Script de correção
8. **finalizar_push.sh** - Script de push
9. **INSTRUÇÕES_DEPLOY.md** - Instruções de deploy
10. **SOLUÇÃO_PROBLEMAS_GIT.md** - Troubleshooting
11. **comandos_push.txt** - Comandos de push

## 🔧 Métodos de Download

### Método 1: SCP (Recomendado)
```bash
# No seu computador (Windows/Linux/Mac)
scp root@66.94.126.120:/root/supabase/README.md .
scp root@66.94.126.120:/root/supabase/docker-compose.yml .
scp root@66.94.126.120:/root/supabase/env.example .
scp root@66.94.126.120:/root/supabase/.gitignore .
scp root@66.94.126.120:/root/supabase/reset.sh .
scp root@66.94.126.120:/root/supabase/deploy_git.sh .
scp root@66.94.126.120:/root/supabase/fix_git_commit.sh .
scp root@66.94.126.120:/root/supabase/finalizar_push.sh .
scp root@66.94.126.120:/root/supabase/INSTRUÇÕES_DEPLOY.md .
scp root@66.94.126.120:/root/supabase/SOLUÇÃO_PROBLEMAS_GIT.md .
scp root@66.94.126.120:/root/supabase/comandos_push.txt .
```

### Método 2: WinSCP (Windows)
1. Abra o WinSCP
2. Conecte em: `66.94.126.120`
3. Usuário: `root`
4. Navegue para: `/root/supabase/`
5. Selecione os arquivos listados acima
6. Faça download para uma pasta local

### Método 3: SFTP
```bash
sftp root@66.94.126.120
cd /root/supabase
get README.md
get docker-compose.yml
get env.example
get .gitignore
get reset.sh
get deploy_git.sh
get fix_git_commit.sh
get finalizar_push.sh
get INSTRUÇÕES_DEPLOY.md
get SOLUÇÃO_PROBLEMAS_GIT.md
get comandos_push.txt
exit
```

### Método 4: Criar Arquivo Compactado na VPS
Execute na VPS:
```bash
cd /root/supabase
tar -czf supabase-chat.tar.gz README.md docker-compose.yml env.example .gitignore reset.sh deploy_git.sh fix_git_commit.sh finalizar_push.sh INSTRUÇÕES_DEPLOY.md SOLUÇÃO_PROBLEMAS_GIT.md comandos_push.txt

# Depois faça download do arquivo compactado
scp root@66.94.126.120:/root/supabase/supabase-chat.tar.gz .
```

## 🚀 Após o Download

### 1. Criar Pasta Local
```bash
mkdir supabase-chat
cd supabase-chat
```

### 2. Extrair Arquivos (se usou método 4)
```bash
tar -xzf supabase-chat.tar.gz
```

### 3. Inicializar Git Local
```bash
git init
git config user.name "WMAPPLIANCES"
git config user.email "support@wmappliances.net"
```

### 4. Adicionar Arquivos
```bash
git add .
git commit -m "🚀 Deploy inicial do Supabase Self-Hosted - WM Appliances"
```

### 5. Conectar ao GitHub
```bash
git remote add origin https://github.com/WMAPPLIANCES/supabase-chat.git
git branch -M main
git push -u origin main
```

## ✅ Verificação Final

Após o push, verifique no GitHub:
- [ ] Todos os arquivos estão presentes
- [ ] README.md está sendo exibido
- [ ] Não há dados sensíveis (.env, volumes/)

## 🔧 Comandos de Preparação na VPS

Se quiser preparar tudo na VPS primeiro:

```bash
cd /root/supabase
chmod +x preparar_download.sh
./preparar_download.sh
```

## 📞 Suporte

Se tiver problemas:
1. Verifique conexão SSH
2. Confirme permissões de arquivo
3. Use método alternativo de download

---

**WM Appliances** - Supabase Chat Project 