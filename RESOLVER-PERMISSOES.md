# Resolver Problemas de Permissão no Artifact Registry

## Problema
Erro: `Permission "artifactregistry.repositories.uploadArtifacts" denied`

## Possíveis Causas

1. **Política Organizacional**: A organização pode ter políticas que bloqueiam uploads
2. **Service Account sem permissões**: O Cloud Build pode estar usando uma service account sem permissões adequadas
3. **Cache de permissões**: Pode haver um delay na propagação de permissões

## Soluções

### Solução 1: Verificar e Configurar Permissões no Console

1. Acesse: https://console.cloud.google.com/artifacts
2. Selecione o repositório `chaveiro-express-repo`
3. Clique em "Permissions" (Permissões)
4. Adicione as seguintes service accounts com role `Artifact Registry Writer`:
   - `81113926722-compute@developer.gserviceaccount.com`
   - `81113926722@cloudbuild.gserviceaccount.com`

### Solução 2: Usar Service Account Customizada

Crie uma service account específica para Cloud Build:

```bash
# Criar service account
gcloud iam service-accounts create cloud-build-sa \
    --display-name="Cloud Build Service Account"

# Dar permissões
gcloud projects add-iam-policy-binding 81113926722 \
    --member="serviceAccount:cloud-build-sa@81113926722.iam.gserviceaccount.com" \
    --role="roles/artifactregistry.writer"

gcloud artifacts repositories add-iam-policy-binding chaveiro-express-repo \
    --location=us-central1 \
    --member="serviceAccount:cloud-build-sa@81113926722.iam.gserviceaccount.com" \
    --role="roles/artifactregistry.writer"

# Usar no build
gcloud builds submit --tag us-central1-docker.pkg.dev/81113926722/chaveiro-express-repo/chaveiro-express:latest \
    --service-account=cloud-build-sa@81113926722.iam.gserviceaccount.com .
```

### Solução 3: Verificar Políticas Organizacionais

Se você tem acesso de administrador:

1. Acesse: https://console.cloud.google.com/iam-admin/org-policy
2. Procure por políticas relacionadas a Artifact Registry
3. Verifique se há restrições que possam estar bloqueando

### Solução 4: Alternativa - Usar Container Registry (GCR) Temporariamente

Embora esteja deprecado, ainda funciona:

```bash
# Build e push para GCR
docker build -t gcr.io/81113926722/chaveiro-express .
docker push gcr.io/81113926722/chaveiro-express

# Deploy no Cloud Run usando GCR
gcloud run deploy chaveiro-express \
  --image gcr.io/81113926722/chaveiro-express \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated
```

### Solução 5: Deploy Direto sem Artifact Registry

Use Cloud Build para fazer build e deploy direto:

```bash
gcloud run deploy chaveiro-express \
  --source . \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated
```

Isso usa Cloud Build internamente e pode contornar problemas de permissão.

## Recomendação

**Tente primeiro a Solução 5** (deploy direto), que é a mais simples e pode contornar os problemas de permissão.

