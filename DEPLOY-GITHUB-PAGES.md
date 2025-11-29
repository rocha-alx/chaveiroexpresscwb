# Deploy no GitHub Pages

Guia completo para fazer deploy do site no GitHub Pages.

## Pré-requisitos

1. Conta no GitHub
2. Repositório criado no GitHub
3. Git instalado localmente

## Passo a Passo

### 1. Criar Repositório no GitHub

1. Acesse: https://github.com/new
2. Crie um novo repositório (ex: `chaveiroexpresscwb`)
3. **NÃO** inicialize com README, .gitignore ou licença

### 2. Inicializar Git no Projeto (se ainda não tiver)

```bash
# Inicializar git
git init

# Adicionar arquivos
git add .

# Primeiro commit
git commit -m "Initial commit"

# Adicionar remote do GitHub
git remote add origin https://github.com/SEU_USUARIO/chaveiroexpresscwb.git

# Renomear branch para main (se necessário)
git branch -M main

# Fazer push
git push -u origin main
```

### 3. Configurar GitHub Pages

#### Opção A: Usando GitHub Actions (Recomendado - Automático)

O arquivo `.github/workflows/deploy.yml` já está configurado. Basta:

1. **Habilitar GitHub Pages no repositório:**
   - Vá em Settings > Pages
   - Em "Source", selecione "GitHub Actions"

2. **Fazer push do código:**
   ```bash
   git add .
   git commit -m "Configure GitHub Pages"
   git push
   ```

3. **Aguardar o deploy:**
   - Vá em Actions no GitHub
   - O workflow será executado automaticamente
   - Após concluir, o site estará disponível em:
     `https://SEU_USUARIO.github.io/ProjetoExpress/`

#### Opção B: Deploy Manual

```bash
# Build da aplicação
npm run build:prod

# Entrar na pasta de build
cd dist/chaveiro-express/browser

# Inicializar git (se necessário)
git init
git add .
git commit -m "Deploy"

# Adicionar remote (crie uma branch gh-pages no seu repo)
git remote add origin https://github.com/SEU_USUARIO/chaveiroexpresscwb.git

# Fazer push para branch gh-pages
git push -f origin main:gh-pages
```

Depois, em Settings > Pages, selecione a branch `gh-pages` como source.

### 4. Configurar Base Href

O `base-href` já está configurado no `package.json` como `/ProjetoExpress/`.

**Se seu repositório tiver nome diferente**, atualize:

```json
"build:prod": "ng build --configuration production --base-href /NOME_DO_REPO/"
```

**Se for usar domínio customizado**, use:

```json
"build:prod": "ng build --configuration production --base-href /"
```

### 5. Domínio Customizado (Opcional)

1. Crie um arquivo `CNAME` na pasta `src/`:
   ```
   chaveiroexpresscwb.com.br
   ```

2. Configure DNS no seu provedor:
   - Tipo: CNAME
   - Nome: @ ou www
   - Valor: SEU_USUARIO.github.io

3. Em Settings > Pages do GitHub, adicione o domínio customizado

## Estrutura de Arquivos

```
ProjetoExpress/
├── .github/
│   └── workflows/
│       └── deploy.yml          # Workflow de deploy automático
├── src/
│   └── CNAME                   # (Opcional) Domínio customizado
└── package.json                # Scripts de build
```

## Atualizações Futuras

Para atualizar o site:

```bash
# Fazer alterações no código
# ...

# Commit e push
git add .
git commit -m "Atualização do site"
git push
```

O GitHub Actions fará o deploy automaticamente!

## Troubleshooting

### Erro 404 nas rotas
- Verifique se o `base-href` está correto
- Certifique-se de que o `nginx.conf` está configurado para SPA

### Site não aparece
- Verifique se GitHub Pages está habilitado em Settings > Pages
- Verifique os logs em Actions
- Aguarde alguns minutos para propagação

### Build falha
- Verifique se todas as dependências estão no `package.json`
- Verifique os logs em Actions para detalhes do erro

## Vantagens do GitHub Pages

✅ Grátis
✅ HTTPS incluído
✅ Deploy automático via GitHub Actions
✅ Sem restrições de política organizacional
✅ Fácil de atualizar
✅ Suporta domínio customizado

## URL Final

Após o deploy, seu site estará disponível em:
- `https://SEU_USUARIO.github.io/ProjetoExpress/`
- Ou no domínio customizado configurado

