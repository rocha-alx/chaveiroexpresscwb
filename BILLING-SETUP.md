# Configuração de Billing no Google Cloud

## Situação Atual
O projeto precisa de billing habilitado para usar alguns serviços como Cloud Build, Cloud Run, etc.

## Opções Disponíveis

### Opção 1: Habilitar Billing (Recomendado para produção)

1. **Acesse o Console do Google Cloud:**
   - Vá para: https://console.cloud.google.com/billing
   - Faça login com sua conta Google

2. **Criar ou selecionar uma conta de billing:**
   - Se não tiver, crie uma nova conta de billing
   - Você precisará de um cartão de crédito (mas há free tier generoso)

3. **Associar billing ao projeto:**
   ```bash
   # Listar contas de billing disponíveis
   gcloud billing accounts list
   
   # Associar billing ao projeto (substitua BILLING_ACCOUNT_ID)
   gcloud billing projects link 81113926722 --billing-account=BILLING_ACCOUNT_ID
   ```

4. **Verificar free tier:**
   - Google Cloud oferece $300 de crédito grátis por 90 dias
   - Muitos serviços têm free tier permanente

### Opção 2: Usar Cloud Storage (Mais Econômico - Free Tier Generoso)

**IMPORTANTE:** Mesmo o Cloud Storage precisa de billing habilitado para criar buckets, mas o free tier é muito generoso:

**Free Tier do Cloud Storage:**
- 5 GB de armazenamento/mês
- 5.000 operações de classe A/mês
- 50.000 operações de classe B/mês
- 1 GB de saída de rede/mês

Para um site estático Angular, isso é mais que suficiente!

**Deploy no Cloud Storage (sem billing):**
```bash
# Build da aplicação
npm run build:prod

# Criar bucket
gsutil mb -p 81113926722 -c STANDARD -l us-central1 gs://chaveiro-express-website

# Configurar como website
gsutil web set -m index.html -e index.html gs://chaveiro-express-website

# Upload dos arquivos
gsutil -m rsync -r -d dist/chaveiro-express/browser gs://chaveiro-express-website

# Tornar público
gsutil iam ch allUsers:objectViewer gs://chaveiro-express-website
```

### Opção 3: App Engine (Free Tier Limitado)

App Engine tem free tier, mas limitado:
- 28 horas/dia de instância F1
- 1 GB de saída/dia

**Deploy no App Engine:**
```bash
npm run build:prod
gcloud app deploy app.yaml
```

## Comparação de Custos

### Cloud Storage (Recomendado para sites estáticos)
- **Custo estimado:** $0-2/mês (dentro do free tier)
- **Sem billing necessário inicialmente**
- **Ideal para:** Sites estáticos, baixo tráfego

### Cloud Run
- **Custo:** ~$0.40 por milhão de requisições
- **Free tier:** 2 milhões de requisições/mês
- **Precisa billing:** Sim

### App Engine
- **Custo:** ~$0.05/hora para F1 (após free tier)
- **Free tier:** 28 horas/dia
- **Precisa billing:** Sim

## Recomendação

Para seu site Angular estático, **recomendo Cloud Storage** porque:
1. ✅ Não precisa de billing inicialmente
2. ✅ Free tier generoso
3. ✅ Muito barato mesmo após free tier
4. ✅ Performance excelente
5. ✅ Fácil de configurar

## Próximos Passos

Se escolher Cloud Storage (recomendado):
```bash
# 1. Build
npm run build:prod

# 2. Criar bucket
gsutil mb -p 81113926722 -c STANDARD -l us-central1 gs://chaveiro-express-website

# 3. Configurar website
gsutil web set -m index.html -e index.html gs://chaveiro-express-website

# 4. Upload
gsutil -m rsync -r -d dist/chaveiro-express/browser gs://chaveiro-express-website

# 5. Tornar público
gsutil iam ch allUsers:objectViewer gs://chaveiro-express-website

# 6. Acessar
# URL: https://storage.googleapis.com/chaveiro-express-website/index.html
```

Se preferir habilitar billing:
1. Acesse: https://console.cloud.google.com/billing
2. Crie/associe uma conta de billing
3. Execute: `gcloud billing projects link 81113926722 --billing-account=BILLING_ACCOUNT_ID`

