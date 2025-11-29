#!/bin/bash

# Script para deploy no Cloud Storage (Opção mais econômica)
# Pré-requisitos: gcloud CLI instalado e autenticado

PROJECT_ID="SEU_PROJECT_ID"
BUCKET_NAME="chaveiro-express-website"
REGION="us-central1"

echo "🚀 Fazendo deploy no Cloud Storage (Opção mais econômica)..."

# 1. Build da aplicação
echo "📦 Building aplicação..."
npm install
npm run build:prod

# 2. Criar bucket (se não existir)
echo "🪣 Criando bucket..."
gsutil mb -p $PROJECT_ID -c STANDARD -l $REGION gs://$BUCKET_NAME 2>/dev/null || echo "Bucket já existe"

# 3. Configurar bucket para website estático
echo "⚙️ Configurando bucket como website..."
gsutil web set -m index.html -e index.html gs://$BUCKET_NAME

# 4. Configurar CORS (se necessário)
echo "🌐 Configurando CORS..."
cat > cors.json << EOF
[
  {
    "origin": ["*"],
    "method": ["GET", "HEAD"],
    "responseHeader": ["Content-Type"],
    "maxAgeSeconds": 3600
  }
]
EOF
gsutil cors set cors.json gs://$BUCKET_NAME
rm cors.json

# 5. Fazer upload dos arquivos
echo "📤 Fazendo upload dos arquivos..."
gsutil -m rsync -r -d dist/chaveiro-express/browser gs://$BUCKET_NAME

# 6. Configurar permissões públicas
echo "🔓 Configurando permissões públicas..."
gsutil iam ch allUsers:objectViewer gs://$BUCKET_NAME

# 7. Obter URL do website
echo "✅ Deploy concluído!"
echo "🌐 URL do website: https://storage.googleapis.com/$BUCKET_NAME/index.html"
echo ""
echo "💡 Para usar um domínio customizado:"
echo "   1. Configure um bucket com o nome do seu domínio"
echo "   2. Configure DNS apontando para c.storage.googleapis.com"
echo "   3. Use Cloud Load Balancer para HTTPS customizado"

