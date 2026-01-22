# Guia de Setup Local - Projeto CBC

Este guia explica como configurar e executar os projetos **cbc-site** e **cbc-admin** localmente.

## 📋 Pré-requisitos

- Node.js (versão 20 ou superior recomendada)
- npm ou yarn
- Git
- Acesso ao banco de dados PostgreSQL (se necessário)

## 🚀 Setup Inicial

### 1. Clonar os Repositórios

Os repositórios já foram clonados:
- `cbc-site` - Site público
- `cbc-admin` - Painel administrativo

### 2. Instalar Dependências

#### cbc-admin
```bash
cd cbc-admin
npm install
```

#### cbc-site
```bash
cd cbc-site
npm install
```

## ⚙️ Configuração

### cbc-admin

O projeto **cbc-admin** está configurado para se conectar à API em:
- **URL da API**: `http://localhost:3000/api` (hardcoded em `src/infrastructure/http/CBCApiClient.ts`)

**Observação**: Se você precisar alterar a URL da API, edite o arquivo:
```
cbc-admin/src/infrastructure/http/CBCApiClient.ts
```

### cbc-site

O projeto **cbc-site** atualmente usa um **MockApiClient** por padrão (dados mockados).

Para usar a API real:
1. Edite o arquivo `src/domains/cbc-site/services/index.ts`
2. Descomente a linha do `CBCApiClient` e comente o `MockApiClient`
3. Crie um arquivo `.env` na raiz do projeto `cbc-site` com:
   ```
   VITE_API_URL=http://localhost:3000/api
   ```

**Arquivo de configuração**: `cbc-site/src/domains/cbc-site/services/index.ts`

## 🏃 Executando os Projetos

### cbc-admin

```bash
cd cbc-admin
npm run dev
```

O projeto estará disponível em: `http://localhost:5173` (porta padrão do Vite)

### cbc-site

```bash
cd cbc-site
npm run dev
```

O projeto estará disponível em: `http://localhost:5173` (porta padrão do Vite)

**Nota**: Se ambos estiverem rodando simultaneamente, o Vite usará a próxima porta disponível (5174, 5175, etc.)

## 📝 Scripts Disponíveis

### cbc-admin

| Comando | Descrição |
|---------|-----------|
| `npm run dev` | Inicia servidor de desenvolvimento |
| `npm run build` | Build de produção |
| `npm run preview` | Preview do build de produção |
| `npm run lint` | Verifica problemas de lint |
| `npm run lint:fix` | Corrige problemas de lint automaticamente |
| `npm run typecheck` | Verifica tipos TypeScript |
| `npm run format` | Formata código com Prettier |

### cbc-site

| Comando | Descrição |
|---------|-----------|
| `npm run dev` | Inicia servidor de desenvolvimento |
| `npm run build` | Build de produção |
| `npm run preview` | Preview do build de produção |
| `npm run lint` | Verifica problemas de lint |
| `npm run test` | Executa testes Jest |
| `npm run test:e2e` | Executa testes E2E com Playwright |
| `npm run format` | Formata código com Prettier |

## 🗄️ Banco de Dados

O dump do banco de dados de homologação está disponível em:
- `dump_homolog.sql`

Para restaurar o banco localmente:
```bash
psql -U postgres -d homolog < dump_homolog.sql
```

Ou usando a string de conexão:
```bash
psql "postgresql://postgres:a3swgw8YWG7EqhA8MS9k@cbc.cgxesa4aiclm.us-east-1.rds.amazonaws.com:5432/homolog" < dump_homolog.sql
```

## 🔧 Backend API (nestjs-cbc-api)

### Setup do Backend

```bash
cd nestjs-cbc-api
npm install
```

### Configuração

1. **Criar arquivo `.env`** na raiz do projeto `nestjs-cbc-api`:
```env
DATABASE_URL="postgresql://postgres:a3swgw8YWG7EqhA8MS9k@cbc.cgxesa4aiclm.us-east-1.rds.amazonaws.com:5432/homolog"
PORT=3000
JWT_SECRET=your-secret-key-here
JWT_EXPIRES_IN=7d
```

2. **Gerar Prisma Client** (após atualizar o schema):
```bash
npx prisma generate
```

3. **Rodar migrações** (se necessário):
```bash
npx prisma migrate dev
```

### Executando o Backend

```bash
cd nestjs-cbc-api
npm run start:dev
```

O backend estará disponível em: `http://localhost:3000`
- API: `http://localhost:3000/api`
- Swagger Docs: `http://localhost:3000/docs`

### Ajustes Realizados

✅ Prisma configurado para PostgreSQL (era MySQL)
✅ CORS configurado para permitir frontends
✅ Rotas ajustadas: `/api/news` (era `/noticias`)
✅ Prefixo global `/api` adicionado
✅ Schema do Prisma atualizado para modelo `News`

### ⚠️ Ajustes Pendentes

⚠️ **Mapper e DTOs** precisam ser atualizados para corresponder ao modelo `News` do banco
⚠️ **Autenticação** ainda não implementada (frontends esperam `/api/auth/login`)
⚠️ **Outros módulos** (events, medias, links, pages) ainda não implementados

### Estrutura do Backend

- **Framework**: NestJS + TypeScript
- **ORM**: Prisma
- **Database**: PostgreSQL
- **Documentação**: Swagger em `/docs`

## 🔧 Estrutura dos Projetos

### cbc-admin
- **Framework**: React 19 + TypeScript + Vite
- **UI**: Material-UI (MUI) 7
- **State Management**: TanStack Query (React Query)
- **Roteamento**: React Router DOM 7
- **Validação**: Zod 4
- **Arquitetura**: Separação em camadas (application, infrastructure, presentation)

### cbc-site
- **Framework**: React 19 + TypeScript + Vite
- **UI**: Material-UI (MUI) + Mantine
- **State Management**: TanStack Query (React Query)
- **Roteamento**: React Router DOM
- **Validação**: Zod 4
- **Features**: Mapas (Leaflet, Google Maps), Carrosséis, Markdown

## 🐛 Troubleshooting

### Problemas com npm install

Se encontrar erros de permissão ao instalar dependências:
```bash
# Verificar permissões do diretório node_modules
sudo chown -R $(whoami) node_modules

# Ou limpar cache do npm
npm cache clean --force
```

### Porta já em uso

Se a porta 5173 estiver em uso, o Vite automaticamente usará a próxima disponível. Você verá a porta correta no terminal.

### Erros de conexão com API

- Verifique se o backend está rodando na porta 3000
- Verifique as configurações de CORS no backend
- Confirme a URL da API nos arquivos de configuração

## 📚 Recursos Adicionais

- **cbc-admin README**: `cbc-admin/README.md`
- **cbc-site**: Template padrão do Vite + React

## 🔐 Variáveis de Ambiente

### cbc-site
Crie um arquivo `.env` na raiz do projeto:
```
VITE_API_URL=http://localhost:3000/api
VITE_GOOGLE_MAPS_API_KEY=sua_chave_aqui
```

### cbc-admin
Atualmente não usa variáveis de ambiente, mas a URL da API pode ser configurada via código ou futuramente via `.env`.

---

**Última atualização**: Janeiro 2025
