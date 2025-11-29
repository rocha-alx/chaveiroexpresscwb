#!/bin/bash

# Script de deploy no Cloud Run (Alternativa quando há restrições de política)
# Execute: chmod +x deploy-cloudrun.sh && ./deploy-cloudrun.sh

set -e

PROJECT_ID="81113926722"
SERVICE_NAME="chaveiroexpresscwb"
REGION="us-central1"
REPOSITORY_NAME="chaveiroexpresscwb-repo"
IMAGE_NAME="$REGION-docker.pkg.dev/$PROJECT_ID/$REPOSITORY_NAME/$SERVICE_NAME"

echo "🚀 Deploy no Cloud Run (Alternativa para políticas restritivas)"
echo ""

# 1. Build da aplicação
echo "📦 Building aplicação..."
npm install
npm run build:prod

# 2. Verificar se Docker está instalado
if ! command -v docker &> /dev/null; then
    echo "❌ Docker não encontrado. Instalando..."
    echo "   Instale Docker Desktop: https://www.docker.com/products/docker-desktop"
    exit 1
fi

# 3. Criar repositório Artifact Registry (se não existir)
echo "📦 Verificando repositório Artifact Registry..."
if ! gcloud artifacts repositories describe $REPOSITORY_NAME --location=$REGION &>/dev/null; then
    echo "📦 Criando repositório Artifact Registry..."
    gcloud artifacts repositories create $REPOSITORY_NAME \
        --repository-format=docker \
        --location=$REGION \
        --description="Repositório para chaveiroexpresscwb.com.br"
else
    echo "✅ Repositório já existe"
fi

# 4. Configurar Docker para usar gcloud e Artifact Registry
echo "🔐 Configurando Docker..."
gcloud auth configure-docker $REGION-docker.pkg.dev

# 4. Build da imagem Docker
echo "🐳 Building imagem Docker..."
docker build -t $IMAGE_NAME .

# 5. Push da imagem
echo "📤 Fazendo push da imagem..."
docker push $IMAGE_NAME

# 6. Deploy no Cloud Run
echo "🚀 Fazendo deploy no Cloud Run..."
gcloud run deploy $SERVICE_NAME \
  --image $IMAGE_NAME \
  --platform managed \
  --region $REGION \
  --allow-unauthenticated \
  --port 80 \
  --memory 256Mi \
  --cpu 1 \
  --min-instances 0 \
  --max-instances 10

# 7. Obter URL do serviço
echo ""
echo "✅ Deploy concluído com sucesso!"
echo ""
SERVICE_URL=$(gcloud run services describe $SERVICE_NAME --region $REGION --format 'value(status.url)')
echo "🌐 URL do website:"
echo "   $SERVICE_URL"
echo ""
echo "💡 Informações:"
echo "   - Free tier: 2 milhões de requisições/mês"
echo "   - Escala automaticamente"
echo "   - HTTPS incluído"
echo "   - Sem restrições de política organizacional"

