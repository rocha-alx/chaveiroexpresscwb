#!/bin/bash

# Script para fazer deploy manual no GitHub Pages
# Execute: chmod +x deploy-github.sh && ./deploy-github.sh

set -e

echo "🚀 Deploy no GitHub Pages"
echo ""

# Verificar se git está inicializado
if [ ! -d .git ]; then
    echo "❌ Git não inicializado. Execute:"
    echo "   git init"
    echo "   git remote add origin https://github.com/SEU_USUARIO/SEU_REPO.git"
    exit 1
fi

# Build da aplicação
echo "📦 Building aplicação..."
npm install
npm run build:prod

# Verificar se build foi bem-sucedido
if [ ! -d "dist/chaveiro-express/browser" ]; then
    echo "❌ Erro no build"
    exit 1
fi

echo ""
echo "✅ Build concluído!"
echo ""
echo "📋 Próximos passos:"
echo ""
echo "1. Configure GitHub Pages no repositório:"
echo "   - Vá em Settings > Pages"
echo "   - Source: GitHub Actions"
echo ""
echo "2. Faça commit e push:"
echo "   git add ."
echo "   git commit -m 'Deploy GitHub Pages'"
echo "   git push"
echo ""
echo "3. O GitHub Actions fará o deploy automaticamente!"
echo ""
echo "🌐 Após o deploy, o site estará em:"
echo "   https://SEU_USUARIO.github.io/SEU_REPO/"
echo "   ou"
echo "   https://chaveiroexpresscwb.com.br (se configurar DNS)"

