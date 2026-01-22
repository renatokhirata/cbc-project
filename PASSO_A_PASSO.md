# 🚀 Passo a Passo - Setup Completo do Projeto CBC

## ✅ O que já foi feito

1. ✅ Repositórios clonados (cbc-site, cbc-admin, nestjs-cbc-api)
2. ✅ Dependências instaladas (cbc-site e cbc-admin)
3. ✅ Prisma configurado para PostgreSQL
4. ✅ CORS configurado no backend
5. ✅ Rotas ajustadas para `/api/news`
6. ✅ Schema do Prisma atualizado

## 📋 Passo a Passo para Rodar Tudo

### PASSO 1: Configurar o Backend (nestjs-cbc-api)

#### 1.1. Criar arquivo `.env`

```bash
cd nestjs-cbc-api
```

Crie um arquivo `.env` na raiz do projeto com:

```env
DATABASE_URL="postgresql://postgres:a3swgw8YWG7EqhA8MS9k@cbc.cgxesa4aiclm.us-east-1.rds.amazonaws.com:5432/homolog"
PORT=3000
JWT_SECRET=your-secret-key-here-change-this
JWT_EXPIRES_IN=7d
```

#### 1.2. Instalar dependências do backend

```bash
cd nestjs-cbc-api
npm install
```

#### 1.3. Gerar Prisma Client

```bash
cd nestjs-cbc-api
npx prisma generate
```

Isso vai gerar o cliente Prisma baseado no schema atualizado.

#### 1.4. Testar conexão com o banco (opcional)

```bash
cd nestjs-cbc-api
npx prisma db pull
```

Isso vai sincronizar o schema com o banco real (pode dar alguns avisos, mas é normal).

---

### PASSO 2: Atualizar Mapper e DTOs

⚠️ **IMPORTANTE**: O mapper e DTOs ainda estão usando a estrutura antiga. Precisam ser atualizados para corresponder ao modelo `News` do banco.

**Estrutura atual do banco (tabela `news`):**
- `id` (text/uuid)
- `title` (string)
- `subtitle` (string, nullable)
- `content` (text)
- `main_image_url` (string, nullable)
- `main_image_caption` (string, nullable)
- `featured` (boolean)
- `slug` (text)
- `status` (PublishStatus: DRAFT | PUBLISHED)
- `published_at` (timestamp, nullable)
- `author_id` (text)
- `created_at` (timestamp)
- `updated_at` (timestamp)
- `link` (string, nullable)
- `modality_id` (text, nullable)
- `source` (string, nullable)

**O que precisa ser atualizado:**
1. `dto/create-noticia.dto.ts` - campos para criar notícia
2. `dto/noticia-response.dto.ts` - campos de resposta
3. `noticias.mapper.ts` - mapeamento entre DTOs e modelo

---

### PASSO 3: Rodar o Backend

```bash
cd nestjs-cbc-api
npm run start:dev
```

Você deve ver:
```
🚀 API rodando em http://localhost:3000
📚 Documentação Swagger em http://localhost:3000/docs
```

**Testar se está funcionando:**
- Abra no navegador: `http://localhost:3000/docs`
- Deve aparecer a documentação Swagger
- Teste o endpoint `GET /api/news`

---

### PASSO 4: Rodar os Frontends

#### Terminal 1 - cbc-admin

```bash
cd cbc-admin
npm run dev
```

Vai rodar em: `http://localhost:5173` (ou próxima porta disponível)

#### Terminal 2 - cbc-site

```bash
cd cbc-site
npm run dev
```

Vai rodar em: `http://localhost:5174` (ou próxima porta disponível)

---

### PASSO 5: Verificar se está tudo conectado

1. **Backend rodando?**
   - Acesse: `http://localhost:3000/docs`
   - Deve ver a documentação Swagger

2. **cbc-admin conectando?**
   - Abra: `http://localhost:5173`
   - Abra o DevTools (F12) → Network
   - Tente fazer login ou acessar notícias
   - Deve fazer requisições para `http://localhost:3000/api/news`

3. **cbc-site conectando?**
   - Abra: `http://localhost:5174`
   - Atualmente usa MockApiClient (dados mockados)
   - Para usar API real, edite: `cbc-site/src/domains/cbc-site/services/index.ts`

---

## 🔧 Comandos Rápidos

### Backend
```bash
# Rodar em desenvolvimento
cd nestjs-cbc-api && npm run start:dev

# Gerar Prisma Client
cd nestjs-cbc-api && npx prisma generate

# Ver schema do banco
cd nestjs-cbc-api && npx prisma studio
```

### Frontends
```bash
# cbc-admin
cd cbc-admin && npm run dev

# cbc-site
cd cbc-site && npm run dev
```

---

## ⚠️ Problemas Comuns

### Erro: "Cannot find module '@prisma/client'"
**Solução:**
```bash
cd nestjs-cbc-api
npx prisma generate
```

### Erro: "Connection refused" ou erro de conexão com banco
**Solução:**
- Verifique se o arquivo `.env` está correto
- Verifique se a string de conexão está correta
- Teste a conexão: `npx prisma db pull`

### Erro: "CORS policy"
**Solução:**
- Verifique se o CORS está configurado no `main.ts`
- Verifique se o backend está rodando na porta 3000
- Verifique se os frontends estão nas portas permitidas

### Erro: "Route not found" ou 404
**Solução:**
- Verifique se o backend está rodando
- Verifique se a rota está correta: `/api/news` (não `/noticias`)
- Verifique o console do backend para ver os logs

---

## 📝 Checklist Final

- [ ] Backend instalado e `.env` configurado
- [ ] Prisma Client gerado (`npx prisma generate`)
- [ ] Backend rodando (`npm run start:dev`)
- [ ] Swagger acessível em `http://localhost:3000/docs`
- [ ] cbc-admin rodando e conectando ao backend
- [ ] cbc-site rodando (pode usar mock por enquanto)

---

## 🎯 Próximos Passos (Após tudo rodar)

1. **Atualizar Mapper e DTOs** para corresponder ao modelo News
2. **Implementar Autenticação** (`/api/auth/login`, `/api/auth/refresh`)
3. **Criar outros módulos** (events, medias, links, pages)
4. **Testar integração completa** entre frontends e backend

---

**Última atualização**: Janeiro 2025
