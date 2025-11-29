#!/bin/bash

# Script para corrigir permissões do diretório .config
# Execute: chmod +x fix-gcloud-permissions.sh && ./fix-gcloud-permissions.sh

echo "🔧 Corrigindo permissões do diretório .config..."

# Corrigir propriedade do diretório .config
sudo chown -R $USER:$(id -gn) ~/.config

# Verificar se foi corrigido
if [ -w ~/.config ]; then
    echo "✅ Permissões corrigidas com sucesso!"
    echo ""
    echo "📦 Agora você pode instalar o gcloud novamente:"
    echo "   brew install --cask google-cloud-sdk"
else
    echo "❌ Erro ao corrigir permissões. Tente executar manualmente:"
    echo "   sudo chown -R $USER:$(id -gn) ~/.config"
fi

