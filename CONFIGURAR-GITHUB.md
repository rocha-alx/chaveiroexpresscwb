# Como Configurar Autenticação do GitHub

Você está tendo problemas de autenticação ao fazer push. Siga um dos métodos abaixo:

## Método 1: Personal Access Token (PAT) - Mais Simples

### Passo 1: Criar um Personal Access Token no GitHub

1. Acesse: https://github.com/settings/tokens
2. Clique em **"Generate new token"** → **"Generate new token (classic)"**
3. Dê um nome: `Chaveiro Express - ProjetoExpress`
4. Selecione os escopos (permissões):
   - ✅ `repo` (acesso completo aos repositórios)
5. Clique em **"Generate token"**
6. **COPIE O TOKEN** (você só verá ele uma vez!)

### Passo 2: Usar o Token

Quando fizer `git push`, use o token como senha:
- **Usuário**: `rocha-alx`
- **Senha**: `[cole o token aqui]`

Ou execute o script:
```bash
./configurar-github-pat.sh
```

## Método 2: SSH (Mais Seguro a Longo Prazo)

### Passo 1: Gerar Chave SSH

```bash
ssh-keygen -t ed25519 -C "rocha.alx@gmail.com" -f ~/.ssh/id_ed25519_github
```

### Passo 2: Adicionar Chave ao SSH Agent

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519_github
```

### Passo 3: Copiar Chave Pública

```bash
cat ~/.ssh/id_ed25519_github.pub
```

### Passo 4: Adicionar no GitHub

1. Acesse: https://github.com/settings/keys
2. Clique em **"New SSH key"**
3. Cole a chave pública
4. Salve

### Passo 5: Alterar Remote para SSH

```bash
git remote set-url origin git@github.com:rocha-alx/chaveiroexpresscwb.git
```

Ou execute o script:
```bash
./configurar-github-ssh.sh
```

## Verificar Configuração

```bash
git remote -v
```

## Testar Push

```bash
git push -u origin main
```


