# Guia de Instalação do Google Cloud CLI no macOS

## Opção 1: Instalação via Homebrew (Recomendado)

### 1. Instalar Homebrew (se ainda não tiver)
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Instalar Google Cloud SDK
```bash
brew install --cask google-cloud-sdk
```

### 3. Inicializar o gcloud
```bash
gcloud init
```

## Opção 2: Instalação Manual

### 1. Baixar o instalador
```bash
curl https://sdk.cloud.google.com | bash
```

### 2. Executar o instalador
```bash
exec -l $SHELL
```

### 3. Inicializar o gcloud
```bash
gcloud init
```

## Opção 3: Instalação via pip (Python)

### 1. Instalar via pip
```bash
pip install google-cloud-sdk
```

## Configuração Inicial

### 1. Autenticar no Google Cloud
```bash
gcloud auth login
```
Isso abrirá o navegador para você fazer login na sua conta Google.

### 2. Criar ou selecionar um projeto
```bash
# Listar projetos disponíveis
gcloud projects list

# Criar um novo projeto (se necessário)
gcloud projects create SEU_PROJECT_ID --name="Chaveiro Express"

# Selecionar o projeto
gcloud config set project SEU_PROJECT_ID
```

### 3. Habilitar APIs necessárias
```bash
# Para Cloud Run
gcloud services enable run.googleapis.com
gcloud services enable cloudbuild.googleapis.com

# Para Cloud Storage
gcloud services enable storage-component.googleapis.com

# Para App Engine
gcloud services enable appengine.googleapis.com
```

### 4. Configurar Docker (para Cloud Run)
```bash
gcloud auth configure-docker
```

### 5. Verificar instalação
```bash
gcloud version
gcloud config list
```

## Configurações Úteis

### Definir região padrão
```bash
gcloud config set compute/region us-central1
gcloud config set compute/zone us-central1-a
```

### Configurar billing account (necessário para serviços pagos)
```bash
# Listar contas de billing
gcloud billing accounts list

# Associar billing ao projeto
gcloud billing projects link SEU_PROJECT_ID --billing-account=BILLING_ACCOUNT_ID
```

## Verificar se está tudo funcionando

```bash
# Testar autenticação
gcloud auth list

# Testar projeto atual
gcloud config get-value project

# Testar APIs habilitadas
gcloud services list --enabled
```

## Próximos Passos

Após a instalação, você pode fazer deploy usando:

1. **Cloud Run**: `docker build` + `gcloud run deploy`
2. **Cloud Storage**: Script `deploy-cloud-storage.sh`
3. **App Engine**: `gcloud app deploy`

## Troubleshooting

### Erro: "command not found: gcloud"
- Adicione ao seu `~/.zshrc` ou `~/.bash_profile`:
```bash
export PATH="$PATH:/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin"
```

### Erro de permissões
```bash
chmod +x /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin/gcloud
```

### Atualizar o gcloud
```bash
gcloud components update
```

