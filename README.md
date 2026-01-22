# 🚴 Projeto CBC - Confederação Brasileira de Ciclismo

Sistema completo com backend API, painel administrativo e site público.

## 📁 Estrutura do Projeto

```
cbc/
├── nestjs-cbc-api/    # Backend API (NestJS + PostgreSQL)
├── cbc-admin/         # Painel Administrativo (React + Vite)
├── cbc-site/          # Site Público (React + Vite)
├── docker-compose.yml # Orquestração Docker
├── Dockerfile.*       # Dockerfiles para cada serviço
└── deploy.sh          # Script de deploy
```

## 🚀 Setup Local

Veja o arquivo [SETUP.md](./SETUP.md) para instruções detalhadas.

### Quick Start

```bash
# Backend
cd nestjs-cbc-api
npm install
npm run start:dev

# Admin (Terminal 2)
cd cbc-admin
npm install
npm run dev

# Site (Terminal 3)
cd cbc-site
npm install
npm run dev
```

## 🐳 Deploy com Docker

### Desenvolvimento

```bash
# Criar arquivo .env na raiz
cp .env.example .env
# Editar .env com suas configurações

# Subir todos os serviços
docker-compose up -d

# Ver logs
docker-compose logs -f
```

### Produção

```bash
# Build e deploy
./deploy.sh production

# Ou usar Docker Compose
docker-compose -f docker-compose.prod.yml up -d
```

## 📦 Estrutura de Deploy

O script `deploy.sh` prepara:
- `deploy/backend/` - Backend compilado
- `deploy/admin/` - Frontend admin compilado
- `deploy/site/` - Frontend site compilado

## 🔧 Variáveis de Ambiente

### Backend (.env em nestjs-cbc-api/)

```env
DATABASE_URL="postgresql://user:pass@host:5432/db"
PORT=3002
JWT_SECRET=your-secret-key
JWT_EXPIRES_IN=7d
```

### Frontend Site (.env em cbc-site/)

```env
VITE_API_URL=http://localhost:3002/api
VITE_GOOGLE_MAPS_API_KEY=your-key
```

## 📚 Documentação

- [SETUP.md](./SETUP.md) - Setup local completo
- [PASSO_A_PASSO.md](./PASSO_A_PASSO.md) - Guia passo a passo
- [PROXIMOS_PASSOS.md](./PROXIMOS_PASSOS.md) - Próximos passos

## 🛠️ Tecnologias

- **Backend**: NestJS, TypeScript, Prisma, PostgreSQL
- **Frontend Admin**: React 19, TypeScript, Vite, MUI
- **Frontend Site**: React 19, TypeScript, Vite, MUI, Mantine
- **Deploy**: Docker, Docker Compose

## 📝 Licença

Proprietário - Confederação Brasileira de Ciclismo
