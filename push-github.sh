#!/bin/bash

# Script para fazer push no GitHub via HTTPS
# Execute: chmod +x push-github.sh && ./push-github.sh

echo "🚀 Fazendo push para GitHub..."
echo ""
echo "⚠️  Você precisará inserir suas credenciais do GitHub"
echo ""
echo "📝 Para autenticar, você pode:"
echo "   1. Usar seu username: rocha-alx"
echo "   2. Usar um Personal Access Token como senha"
echo ""
echo "🔑 Para criar um token:"
echo "   https://github.com/settings/tokens"
echo "   - Clique em 'Generate new token (classic)'"
echo "   - Dê um nome (ex: chaveiroexpresscwb)"
echo "   - Selecione escopo: repo"
echo "   - Clique em 'Generate token'"
echo "   - Copie o token e use como senha"
echo ""

# Configurar remote para HTTPS
git remote set-url origin https://github.com/rocha-alx/chaveiroexpresscwb.git

# Tentar push (vai pedir credenciais)
git push -u origin main

echo ""
if [ $? -eq 0 ]; then
    echo "✅ Push realizado com sucesso!"
    echo ""
    echo "📋 Próximos passos:"
    echo "   1. Acesse: https://github.com/rocha-alx/chaveiroexpresscwb"
    echo "   2. Vá em Settings > Pages"
    echo "   3. Em 'Source', selecione 'GitHub Actions'"
    echo "   4. Aguarde o deploy automático!"
    echo ""
    echo "🌐 Após o deploy, o site estará em:"
    echo "   https://rocha-alx.github.io/chaveiroexpresscwb/"
else
    echo "❌ Erro no push. Verifique suas credenciais."
fi
