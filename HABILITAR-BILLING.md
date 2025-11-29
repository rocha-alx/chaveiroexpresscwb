# Como Habilitar Billing no Google Cloud

## Por que é necessário?

Mesmo serviços com free tier (como Cloud Storage) precisam de billing habilitado no Google Cloud. Isso é uma política do Google para:
- Prevenir abusos
- Permitir uso além do free tier quando necessário
- Garantir que você pode ser cobrado apenas se exceder os limites gratuitos

## Passo a Passo

### 1. Acesse o Console do Google Cloud
Vá para: https://console.cloud.google.com/billing

### 2. Criar ou Selecionar Conta de Billing

**Se você já tem uma conta de billing:**
- Selecione a conta existente
- Clique em "Associar projeto"

**Se você não tem uma conta de billing:**
- Clique em "Criar conta de faturamento"
- Preencha os dados solicitados
- Adicione um método de pagamento (cartão de crédito)
- **Não se preocupe:** Você recebe $300 de crédito grátis por 90 dias!

### 3. Associar Billing ao Projeto via CLI

Depois de criar/selecionar a conta de billing:

```bash
# Listar contas de billing disponíveis
gcloud billing accounts list

# Associar billing ao projeto (substitua BILLING_ACCOUNT_ID pelo ID da sua conta)
gcloud billing projects link 81113926722 --billing-account=BILLING_ACCOUNT_ID
```

### 4. Verificar se foi associado

```bash
gcloud billing projects describe 81113926722
```

## Free Tier e Créditos

### Crédito Inicial
- **$300 de crédito grátis** por 90 dias para novos usuários
- Pode ser usado em qualquer serviço do Google Cloud

### Cloud Storage Free Tier (Permanente)
- **5 GB** de armazenamento/mês
- **5.000** operações classe A/mês
- **50.000** operações classe B/mês  
- **1 GB** de saída de rede/mês

Para um site estático Angular, isso é mais que suficiente e você provavelmente não pagará nada!

### Cloud Run Free Tier (Permanente)
- **2 milhões** de requisições/mês
- **360.000 GB-segundos** de memória
- **180.000 vCPU-segundos**

## Alternativas Sem Billing

Se você realmente não quiser habilitar billing, as alternativas são:

1. **GitHub Pages** (Grátis, sem billing)
2. **Netlify** (Grátis, sem billing)
3. **Vercel** (Grátis, sem billing)
4. **Firebase Hosting** (Grátis, mas também precisa de billing do Google)

## Recomendação

**Recomendo habilitar billing** porque:
- ✅ Você recebe $300 grátis (90 dias)
- ✅ Free tier é muito generoso
- ✅ Para um site estático, provavelmente não pagará nada
- ✅ Você só paga se exceder os limites gratuitos
- ✅ Pode definir alertas de orçamento para não ter surpresas

## Configurar Alertas de Orçamento (Recomendado)

Para evitar surpresas, configure alertas:

1. Acesse: https://console.cloud.google.com/billing/budgets
2. Clique em "Criar orçamento"
3. Configure um limite (ex: $5/mês)
4. Configure alertas por email

## Próximos Passos

Após habilitar billing:

```bash
# 1. Criar bucket
gsutil mb -p 81113926722 -c STANDARD -l us-central1 gs://chaveiro-express-website

# 2. Executar deploy
./deploy-storage.sh
```

