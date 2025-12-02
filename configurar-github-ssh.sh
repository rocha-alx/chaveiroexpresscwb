#!/bin/bash

# Script para configurar autenticação GitHub com SSH

echo "=========================================="
echo "Configurar GitHub com SSH"
echo "=========================================="
echo ""

# Verificar se já existe chave SSH
if [ -f ~/.ssh/id_ed25519_github ]; then
    echo "⚠️  Chave SSH já existe: ~/.ssh/id_ed25519_github"
    read -p "Deseja gerar uma nova? (s/N): " resposta
    if [[ ! $resposta =~ ^[Ss]$ ]]; then
        echo "Usando chave existente..."
        chave_existente=true
    else
        chave_existente=false
    fi
else
    chave_existente=false
fi

# Gerar chave SSH se necessário
if [ "$chave_existente" = false ]; then
    echo "Gerando chave SSH..."
    ssh-keygen -t ed25519 -C "rocha.alx@gmail.com" -f ~/.ssh/id_ed25519_github -N ""
    
    if [ $? -ne 0 ]; then
        echo "❌ Erro ao gerar chave SSH"
        exit 1
    fi
    
    echo "✅ Chave SSH gerada com sucesso!"
fi

# Configurar SSH config
echo "Configurando SSH..."
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# Adicionar configuração para GitHub
if ! grep -q "Host github.com" ~/.ssh/config 2>/dev/null; then
    cat >> ~/.ssh/config <<EOF

Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_github
    IdentitiesOnly yes
EOF
    chmod 600 ~/.ssh/config
    echo "✅ Configuração SSH adicionada"
else
    echo "ℹ️  Configuração SSH já existe"
fi

# Iniciar SSH agent e adicionar chave
echo "Adicionando chave ao SSH agent..."
eval "$(ssh-agent -s)" > /dev/null 2>&1
ssh-add ~/.ssh/id_ed25519_github 2>/dev/null

# Mostrar chave pública
echo ""
echo "=========================================="
echo "Sua chave pública SSH:"
echo "=========================================="
echo ""
cat ~/.ssh/id_ed25519_github.pub
echo ""
echo "=========================================="
echo "Próximos passos:"
echo "=========================================="
echo ""
echo "1. Copie a chave pública acima"
echo ""
echo "2. Acesse: https://github.com/settings/keys"
echo ""
echo "3. Clique em 'New SSH key'"
echo ""
echo "4. Cole a chave e salve"
echo ""
echo "5. Teste a conexão:"
echo "   ssh -T git@github.com"
echo ""
echo "6. Depois, altere o remote:"
echo "   git remote set-url origin git@github.com:rocha-alx/chaveiroexpresscwb.git"
echo ""
echo "7. Faça push:"
echo "   git push -u origin main"
echo ""
echo "=========================================="


