# 🚀 Guia de Deploy - Projeto CBC

## 📋 Pré-requisitos

- Git instalado
- Docker e Docker Compose (para deploy com containers)
- Acesso ao servidor de produção
- Node.js 20+ (para build local)

## 🔧 Setup Inicial do Git

### 1. Inicializar Repositório Git

```bash
cd /Users/renatohirata/Desktop/dev/cbc

# Inicializar Git
git init

# Adicionar todos os arquivos
git add .

# Primeiro commit
git commit -m "Initial commit: CBC project setup"
```

### 2. Adicionar Remote (seu repositório)

```bash
# Adicionar seu repositório remoto
git remote add origin https://github.com/seu-usuario/cbc.git

# Ou se já existe:
git remote set-url origin https://github.com/seu-usuario/cbc.git

# Verificar
git remote -v
```

### 3. Primeiro Push

```bash
# Criar branch main (se necessário)
git branch -M main

# Push inicial
git push -u origin main
```

## 🐳 Deploy com Docker

### Opção 1: Docker Compose (Recomendado)

```bash
# 1. Criar arquivo .env na raiz
cat > .env << EOF
DATABASE_URL=postgresql://user:pass@host:5432/db
PORT=3002
JWT_SECRET=your-secret-key
JWT_EXPIRES_IN=7d
EOF

# 2. Build e subir containers
docker-compose build
docker-compose up -d

# 3. Ver logs
docker-compose logs -f

# 4. Parar serviços
docker-compose down
```

### Opção 2: Deploy Manual

```bash
# 1. Preparar build
./deploy.sh production

# 2. Copiar para servidor
scp -r deploy/ user@server:/path/to/deploy/

# 3. No servidor, instalar dependências e rodar
cd /path/to/deploy/backend
npm install --production
npm run start:prod
```

## 📦 Estrutura de Deploy

Após executar `./deploy.sh`, você terá:

```
deploy/
├── backend/          # Backend compilado
│   ├── dist/         # Código compilado
│   ├── package.json
│   └── prisma/       # Schema Prisma
├── admin/            # Frontend admin compilado
│   └── dist/         # Arquivos estáticos
├── site/             # Frontend site compilado
│   └── dist/         # Arquivos estáticos
└── deploy-config.json # Configuração de deploy
```

## 🔐 Variáveis de Ambiente no Servidor

### Backend

No servidor, crie `.env` em `deploy/backend/`:

```env
DATABASE_URL=postgresql://user:pass@host:5432/db
PORT=3002
JWT_SECRET=your-production-secret-key
JWT_EXPIRES_IN=7d
NODE_ENV=production
```

### Frontend Site

Se usar variáveis de ambiente no frontend, configure no servidor web (nginx/apache) ou use variáveis de build.

## 🌐 Configuração Nginx (Opcional)

Se usar Nginx como reverse proxy:

```nginx
# Backend API
server {
    listen 80;
    server_name api.cbc.com.br;

    location / {
        proxy_pass http://localhost:3002;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}

# Admin
server {
    listen 80;
    server_name admin.cbc.com.br;

    root /path/to/deploy/admin/dist;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}

# Site
server {
    listen 80;
    server_name cbc.com.br;

    root /path/to/deploy/site/dist;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

## 🔄 Processo de Deploy Contínuo

### 1. Desenvolvimento

```bash
# Fazer alterações
git add .
git commit -m "feat: nova funcionalidade"
git push
```

### 2. No Servidor

```bash
# Pull das alterações
git pull origin main

# Rebuild (se necessário)
./deploy.sh production

# Restart serviços
docker-compose restart
# ou
pm2 restart cbc-backend
```

## 📝 Checklist de Deploy

- [ ] Variáveis de ambiente configuradas
- [ ] Banco de dados acessível
- [ ] Builds compilados sem erros
- [ ] Portas configuradas corretamente
- [ ] CORS configurado para domínios de produção
- [ ] SSL/HTTPS configurado (se necessário)
- [ ] Logs configurados
- [ ] Backup do banco de dados

## 🐛 Troubleshooting

### Erro de conexão com banco
- Verifique `DATABASE_URL` no `.env`
- Verifique se o banco está acessível do servidor
- Verifique firewall/security groups

### Erro de CORS
- Atualize `main.ts` do backend com domínios de produção
- Verifique headers no servidor web

### Build falha
- Verifique versão do Node.js (20+)
- Limpe cache: `rm -rf node_modules dist`
- Reinstale: `npm ci`

## 📚 Recursos

- [Docker Documentation](https://docs.docker.com/)
- [NestJS Deployment](https://docs.nestjs.com/deployment)
- [Vite Build](https://vitejs.dev/guide/build.html)
