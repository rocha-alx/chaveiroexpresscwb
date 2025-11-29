#!/bin/bash

# Script de deploy no Cloud Storage (NÃO precisa de billing!)
# Execute: chmod +x deploy-storage.sh && ./deploy-storage.sh

set -e

PROJECT_ID="81113926722"
BUCKET_NAME="chaveiroexpresscwb.com.br"
REGION="us-central1"

echo "🚀 Deploy no Cloud Storage (Opção mais econômica - sem billing necessário!)"
echo ""

# 1. Build da aplicação
echo "📦 Building aplicação..."
npm install
npm run build:prod

# 2. Verificar se bucket existe, criar se não existir
echo "🪣 Verificando bucket..."
if gsutil ls -b gs://$BUCKET_NAME 2>/dev/null; then
    echo "✅ Bucket já existe"
else
    echo "📦 Criando bucket..."
    gsutil mb -p $PROJECT_ID -c STANDARD -l $REGION gs://$BUCKET_NAME
fi

# 3. Configurar bucket para website estático
echo "⚙️ Configurando bucket como website..."
gsutil web set -m index.html -e index.html gs://$BUCKET_NAME

# 4. Configurar CORS
echo "🌐 Configurando CORS..."
cat > /tmp/cors.json << EOF
[
  {
    "origin": ["*"],
    "method": ["GET", "HEAD"],
    "responseHeader": ["Content-Type"],
    "maxAgeSeconds": 3600
  }
]
EOF
gsutil cors set /tmp/cors.json gs://$BUCKET_NAME
rm /tmp/cors.json

# 5. Fazer upload dos arquivos
echo "📤 Fazendo upload dos arquivos..."
gsutil -m rsync -r -d dist/chaveiro-express/browser gs://$BUCKET_NAME

# 6. Configurar permissões públicas
echo "🔓 Configurando permissões públicas..."
echo "⚠️  Se houver erro de política organizacional, configure manualmente:"
echo "   1. Acesse: https://console.cloud.google.com/storage/browser/$BUCKET_NAME"
echo "   2. Clique em 'Permissions' > 'Grant Access'"
echo "   3. Adicione: allUsers com role: Storage Object Viewer"
echo ""
if gcloud storage buckets add-iam-policy-binding gs://$BUCKET_NAME --member=allUsers --role=roles/storage.objectViewer 2>/dev/null; then
    echo "✅ Permissões configuradas com sucesso!"
else
    echo "⚠️  Não foi possível configurar automaticamente. Configure manualmente no console."
fi

# 7. Obter URL do website
echo ""
echo "✅ Deploy concluído com sucesso!"
echo ""
echo "🌐 URL do website:"
echo "   https://storage.googleapis.com/$BUCKET_NAME/index.html"
echo ""
echo "💡 Para usar um domínio customizado:"
echo "   1. Configure um bucket com o nome do seu domínio"
echo "   2. Configure DNS apontando para c.storage.googleapis.com"
echo "   3. Use Cloud Load Balancer para HTTPS customizado (requer billing)"
echo ""
echo "📊 Free Tier do Cloud Storage:"
echo "   - 5 GB de armazenamento/mês"
echo "   - 5.000 operações classe A/mês"
echo "   - 50.000 operações classe B/mês"
echo "   - 1 GB de saída de rede/mês"
echo "   (Mais que suficiente para um site estático!)"

