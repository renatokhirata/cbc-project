# 🔧 Setup Git - Projeto CBC

## Passo a Passo para Inicializar Git e Fazer Deploy

### 1. Inicializar Repositório Git

```bash
cd /Users/renatohirata/Desktop/dev/cbc

# Inicializar Git
git init

# Verificar status
git status
```

### 2. Configurar .gitignore

O arquivo `.gitignore` já foi criado e inclui:
- `node_modules/`
- `.env` (arquivos de ambiente)
- `dist/` e `build/`
- Logs e arquivos temporários

### 3. Adicionar Arquivos ao Git

```bash
# Adicionar todos os arquivos (exceto os ignorados)
git add .

# Verificar o que será commitado
git status
```

### 4. Primeiro Commit

```bash
git commit -m "feat: initial commit - CBC project setup

- Backend API (NestJS + PostgreSQL)
- Frontend Admin (React + Vite)
- Frontend Site (React + Vite)
- Docker configuration
- Deploy scripts"
```

### 5. Criar Repositório no GitHub/GitLab

1. Acesse GitHub/GitLab
2. Crie um novo repositório (ex: `cbc-project`)
3. **NÃO** inicialize com README (já temos)

### 6. Conectar ao Repositório Remoto

```bash
# Adicionar remote (substitua pela sua URL)
git remote add origin https://github.com/seu-usuario/cbc-project.git

# Verificar
git remote -v
```

### 7. Push Inicial

```bash
# Renomear branch para main (se necessário)
git branch -M main

# Push inicial
git push -u origin main
```

### 8. Verificar no GitHub/GitLab

Acesse seu repositório e verifique se todos os arquivos foram enviados.

## 📝 Estrutura que será commitada

```
cbc/
├── .gitignore          ✅
├── README.md           ✅
├── SETUP.md            ✅
├── DEPLOY.md           ✅
├── docker-compose.yml  ✅
├── Dockerfile.*        ✅
├── deploy.sh           ✅
├── nestjs-cbc-api/     ✅ (sem node_modules, dist, .env)
├── cbc-admin/          ✅ (sem node_modules, dist)
└── cbc-site/           ✅ (sem node_modules, dist)
```

## ⚠️ Arquivos que NÃO serão commitados

- `.env` (variáveis de ambiente)
- `node_modules/` (dependências)
- `dist/` e `build/` (builds)
- `dump_homolog.sql` (dump do banco - muito grande)

## 🔄 Workflow de Desenvolvimento

### Fazer alterações

```bash
# 1. Criar branch para feature
git checkout -b feature/nova-funcionalidade

# 2. Fazer alterações
# ... editar arquivos ...

# 3. Adicionar alterações
git add .

# 4. Commit
git commit -m "feat: descrição da funcionalidade"

# 5. Push
git push origin feature/nova-funcionalidade

# 6. Criar Pull Request no GitHub/GitLab
```

### Atualizar código

```bash
# Pull das alterações
git pull origin main

# Ou de uma branch específica
git pull origin feature/nome-da-branch
```

## 🚀 Deploy após Push

Após fazer push, no servidor:

```bash
# 1. Pull das alterações
git pull origin main

# 2. Rebuild (se necessário)
cd nestjs-cbc-api && npm run build && cd ..
cd cbc-admin && npm run build && cd ..
cd cbc-site && npm run build && cd ..

# 3. Restart serviços
docker-compose restart
# ou
pm2 restart all
```

## 📋 Comandos Úteis

```bash
# Ver histórico
git log --oneline

# Ver diferenças
git diff

# Ver status
git status

# Desfazer alterações não commitadas
git checkout -- arquivo.txt

# Ver branches
git branch -a
```
