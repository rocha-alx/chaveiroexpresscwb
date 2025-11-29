#!/bin/bash

# Script de instalação do Google Cloud CLI no macOS
# Execute: chmod +x install-gcloud.sh && ./install-gcloud.sh

set -e

echo "🚀 Instalando Google Cloud CLI..."

# Verificar se Homebrew está instalado
if ! command -v brew &> /dev/null; then
    echo "❌ Homebrew não encontrado. Instalando Homebrew primeiro..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Adicionar Homebrew ao PATH (para Macs com chip Apple Silicon)
    if [[ $(uname -m) == 'arm64' ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
fi

# Instalar Google Cloud SDK via Homebrew
echo "📦 Instalando Google Cloud SDK..."
brew install --cask google-cloud-sdk

# Adicionar gcloud ao PATH
echo "🔧 Configurando PATH..."
if [[ -f ~/.zshrc ]]; then
    if ! grep -q "google-cloud-sdk" ~/.zshrc; then
        echo '' >> ~/.zshrc
        echo '# Google Cloud SDK' >> ~/.zshrc
        echo 'source "$(brew --prefix)/share/google-cloud-sdk/path.bash.inc"' >> ~/.zshrc
        echo 'source "$(brew --prefix)/share/google-cloud-sdk/completion.bash.inc"' >> ~/.zshrc
    fi
fi

# Recarregar shell
if [[ -f ~/.zshrc ]]; then
    source ~/.zshrc
fi

# Verificar instalação
echo "✅ Verificando instalação..."
if command -v gcloud &> /dev/null; then
    echo "✅ Google Cloud CLI instalado com sucesso!"
    echo ""
    echo "📋 Próximos passos:"
    echo "   1. Execute: gcloud init"
    echo "   2. Execute: gcloud auth login"
    echo "   3. Execute: gcloud config set project SEU_PROJECT_ID"
    echo ""
    echo "💡 Para mais informações, consulte SETUP-GCLOUD.md"
else
    echo "❌ Erro na instalação. Tente executar manualmente:"
    echo "   brew install --cask google-cloud-sdk"
fi

