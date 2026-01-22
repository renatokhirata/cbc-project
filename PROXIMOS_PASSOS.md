# 🎯 Próximos Passos - Projeto CBC

## ✅ Status Atual

- ✅ Backend rodando na porta **3002**
- ✅ API respondendo: `http://localhost:3002/api`
- ✅ Swagger disponível: `http://localhost:3002/docs`
- ✅ cbc-admin configurado para porta 3002
- ✅ Conexão com banco de dados funcionando

---

## 🚀 Passo 1: Rodar os Frontends

### Terminal 1 - cbc-admin (Painel Administrativo)

```bash
cd cbc-admin
npm run dev
```

**Acesse:** `http://localhost:5173` (ou próxima porta disponível)

**O que testar:**
- Login (se implementado)
- Listagem de notícias
- Criar/editar notícias
- Verificar se está fazendo requisições para `http://localhost:3002/api/news`

### Terminal 2 - cbc-site (Site Público)

```bash
cd cbc-site
npm run dev
```

**Acesse:** `http://localhost:5174` (ou próxima porta disponível)

**Nota:** Atualmente usa `MockApiClient` (dados mockados). Para usar a API real:
1. Edite: `cbc-site/src/domains/cbc-site/services/index.ts`
2. Descomente `CBCApiClient` e comente `MockApiClient`
3. Crie `.env` com: `VITE_API_URL=http://localhost:3002/api`

---

## 🧪 Passo 2: Testar a Integração

### Teste 1: Backend está respondendo?

```bash
curl http://localhost:3002/api/news
```

Deve retornar JSON com notícias.

### Teste 2: Swagger está funcionando?

Abra no navegador: `http://localhost:3002/docs`

Deve mostrar a documentação da API.

### Teste 3: Frontends conectando?

1. Abra `cbc-admin` no navegador
2. Abra DevTools (F12) → Aba **Network**
3. Navegue pela aplicação
4. Verifique se há requisições para `http://localhost:3002/api/news`
5. Verifique se não há erros de CORS no console

---

## 🔍 Passo 3: Verificações

### ✅ Checklist

- [ ] Backend rodando na porta 3002
- [ ] Swagger acessível em `/docs`
- [ ] cbc-admin rodando e conectando ao backend
- [ ] cbc-site rodando (pode usar mock por enquanto)
- [ ] Sem erros de CORS no console
- [ ] Requisições sendo feitas corretamente

### 🐛 Problemas Comuns

**Erro de CORS:**
- Verifique se o backend está rodando
- Verifique se a porta está correta (3002)
- Verifique o console do navegador

**404 Not Found:**
- Verifique se a rota está correta: `/api/news` (não `/noticias`)
- Verifique se o prefixo `/api` está sendo usado

**Erro de conexão:**
- Verifique se o backend está rodando
- Teste: `curl http://localhost:3002/api/news`

---

## 📋 Passo 4: Próximas Implementações

### 🔐 Autenticação (Prioridade Alta)

Os frontends esperam:
- `POST /api/auth/login` - Login
- `POST /api/auth/refresh` - Refresh token

**Status:** ⚠️ Não implementado ainda

### 📰 Outros Módulos (Prioridade Média)

Frontends esperam:
- `GET /api/events` - Eventos
- `GET /api/medias` - Mídias/Galeria
- `GET /api/links/:menuType` - Links de navegação
- `GET /api/pages/:slug` - Páginas
- `GET /api/info-data` - Dados de informação
- `GET /api/modalities/:id` - Modalidades

**Status:** ⚠️ Não implementados ainda

### 🧪 Testes (Prioridade Baixa)

- Testes unitários
- Testes de integração
- Testes E2E

---

## 🎯 Resumo dos Comandos

### Rodar tudo (3 terminais)

**Terminal 1 - Backend:**
```bash
cd nestjs-cbc-api
npm run start:dev
```

**Terminal 2 - cbc-admin:**
```bash
cd cbc-admin
npm run dev
```

**Terminal 3 - cbc-site:**
```bash
cd cbc-site
npm run dev
```

### URLs Importantes

- **Backend API:** `http://localhost:3002/api`
- **Swagger Docs:** `http://localhost:3002/docs`
- **cbc-admin:** `http://localhost:5173` (ou próxima porta)
- **cbc-site:** `http://localhost:5174` (ou próxima porta)

---

## 📝 Notas

- O backend está configurado para porta **3002** (não 3000)
- O cbc-admin já está configurado para usar a porta 3002
- O cbc-site ainda usa dados mockados por padrão
- A autenticação ainda não está implementada

---

**Última atualização:** Janeiro 2025
