#!/bin/bash

# Script para configurar autenticação GitHub com Personal Access Token

echo "=========================================="
echo "Configurar GitHub com Personal Access Token"
echo "=========================================="
echo ""
echo "Este script vai:"
echo "1. Limpar credenciais antigas"
echo "2. Configurar o remote para usar HTTPS"
echo "3. Preparar para usar PAT no próximo push"
echo ""

# Limpar credenciais antigas
echo "Limpando credenciais antigas..."
git credential-osxkeychain erase <<EOF
host=github.com
protocol=https
EOF

# Garantir que o remote está usando HTTPS
echo "Configurando remote para HTTPS..."
git remote set-url origin https://github.com/rocha-alx/chaveiroexpresscwb.git

echo ""
echo "=========================================="
echo "Próximos passos:"
echo "=========================================="
echo ""
echo "1. Crie um Personal Access Token:"
echo "   https://github.com/settings/tokens"
echo ""
echo "2. Permissões necessárias:"
echo "   ✅ repo (acesso completo aos repositórios)"
echo ""
echo "3. Quando fizer 'git push', use:"
echo "   Usuário: rocha-alx"
echo "   Senha: [cole o token aqui]"
echo ""
echo "4. O macOS vai salvar o token no keychain"
echo ""
echo "=========================================="
echo "Para fazer push agora, execute:"
echo "  git push -u origin main"
echo "=========================================="


