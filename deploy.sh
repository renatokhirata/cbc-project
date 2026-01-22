#!/bin/bash

# Script de deploy para servidor
# Uso: ./deploy.sh [ambiente]
# Exemplo: ./deploy.sh production

set -e

ENVIRONMENT=${1:-production}
echo "🚀 Iniciando deploy para ambiente: $ENVIRONMENT"

# Cores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 1. Build dos projetos
echo -e "${YELLOW}📦 Building projetos...${NC}"
cd nestjs-cbc-api && npm run build && cd ..
cd cbc-admin && npm run build && cd ..
cd cbc-site && npm run build && cd ..

# 2. Preparar arquivos para deploy
echo -e "${YELLOW}📋 Preparando arquivos...${NC}"

# Criar diretório de deploy
mkdir -p deploy
rm -rf deploy/*

# Backend
cp -r nestjs-cbc-api/dist deploy/backend
cp nestjs-cbc-api/package*.json deploy/backend/
cp nestjs-cbc-api/prisma deploy/backend/ -r
cp nestjs-cbc-api/.env.example deploy/backend/.env

# Frontends
cp -r cbc-admin/dist deploy/admin
cp -r cbc-site/dist deploy/site

# 3. Criar arquivo de configuração
cat > deploy/deploy-config.json << EOF
{
  "environment": "$ENVIRONMENT",
  "backend": {
    "port": 3002,
    "path": "./backend"
  },
  "admin": {
    "port": 80,
    "path": "./admin"
  },
  "site": {
    "port": 81,
    "path": "./site"
  }
}
EOF

echo -e "${GREEN}✅ Deploy preparado em ./deploy${NC}"
echo -e "${YELLOW}📝 Próximos passos:${NC}"
echo "1. Copie a pasta ./deploy para o servidor"
echo "2. Configure as variáveis de ambiente no servidor"
echo "3. Execute os comandos de deploy no servidor"
