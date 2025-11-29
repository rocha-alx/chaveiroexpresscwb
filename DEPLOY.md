# Guia de Deploy no Google Cloud

Este projeto está configurado para deploy no Google Cloud Platform. Existem duas opções principais:

## Opção 1: Google Cloud Run (Recomendado)

### Pré-requisitos
- Google Cloud SDK instalado (`gcloud`)
- Docker instalado
- Projeto criado no Google Cloud

### Passos para Deploy

1. **Autenticar no Google Cloud:**
```bash
gcloud auth login
gcloud config set project SEU_PROJECT_ID
```

2. **Configurar Docker para usar gcloud:**
```bash
gcloud auth configure-docker
```

3. **Build e Push da imagem:**
```bash
# Build da imagem
docker build -t gcr.io/SEU_PROJECT_ID/chaveiro-express .

# Push da imagem
docker push gcr.io/SEU_PROJECT_ID/chaveiro-express
```

4. **Deploy no Cloud Run:**
```bash
gcloud run deploy chaveiro-express \
  --image gcr.io/SEU_PROJECT_ID/chaveiro-express \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated
```

### Usando Cloud Build (CI/CD)

1. **Habilitar APIs necessárias:**
```bash
gcloud services enable cloudbuild.googleapis.com
gcloud services enable run.googleapis.com
```

2. **Fazer deploy usando Cloud Build:**
```bash
gcloud builds submit --config cloudbuild.yaml
```

## Opção 2: Google App Engine

### Pré-requisitos
- Google Cloud SDK instalado
- Projeto criado no Google Cloud

### Passos para Deploy

1. **Build da aplicação:**
```bash
npm install
npm run build:prod
```

2. **Deploy no App Engine:**
```bash
gcloud app deploy app.yaml
```

## Opção 3: Google Compute Engine (VM)

1. **Criar uma VM:**
```bash
gcloud compute instances create chaveiro-express-vm \
  --image-family=cos-stable \
  --image-project=cos-cloud \
  --machine-type=e2-micro
```

2. **SSH na VM e instalar Docker:**
```bash
gcloud compute ssh chaveiro-express-vm
```

3. **Na VM, fazer pull da imagem e rodar:**
```bash
docker pull gcr.io/SEU_PROJECT_ID/chaveiro-express
docker run -d -p 80:80 gcr.io/SEU_PROJECT_ID/chaveiro-express
```

## Variáveis de Ambiente

Se precisar configurar variáveis de ambiente no Cloud Run:

```bash
gcloud run services update chaveiro-express \
  --set-env-vars "VAR_NAME=value" \
  --region us-central1
```

## Monitoramento

Após o deploy, você pode monitorar a aplicação no Console do Google Cloud:
- Cloud Run: https://console.cloud.google.com/run
- App Engine: https://console.cloud.google.com/appengine

## Domínio Customizado

Para usar um domínio customizado no Cloud Run:

1. Vá para Cloud Run no console
2. Selecione seu serviço
3. Clique em "Manage Custom Domains"
4. Adicione seu domínio

## Troubleshooting

- **Erro de build:** Verifique se todas as dependências estão no package.json
- **Erro 404 nas rotas:** Verifique se o nginx.conf está configurado corretamente
- **Imagem não encontrada:** Verifique se fez o push da imagem corretamente

