# Solução para Política Organizacional Restritiva

## Problema
A política organizacional "Compartilhamento restrito de domínio" impede tornar buckets do Cloud Storage públicos (`allUsers`).

## Soluções Disponíveis

### Opção 1: Cloud Run (Recomendado) ✅

Cloud Run não tem restrições de política organizacional e é perfeito para sites estáticos:

**Vantagens:**
- ✅ Não precisa tornar público (já é acessível publicamente)
- ✅ HTTPS incluído automaticamente
- ✅ Escala automaticamente
- ✅ Free tier: 2 milhões de requisições/mês
- ✅ Muito econômico

**Como fazer:**
```bash
./deploy-cloudrun.sh
```

### Opção 2: Solicitar Exceção na Política

Se você tem acesso de administrador ou pode solicitar:

1. Acesse: https://console.cloud.google.com/iam-admin/org-policy
2. Procure pela política: `constraints/iam.allowedPolicyMemberDomains`
3. Solicite exceção ou ajuste a política para permitir `allUsers` em buckets específicos

### Opção 3: Usar Domínio Específico

Se a política permite domínios específicos, você pode:
- Criar um grupo no Google Workspace
- Adicionar usuários ao grupo
- Dar permissão ao grupo (não a `allUsers`)

### Opção 4: Firebase Hosting

Firebase Hosting também é uma ótima alternativa:
- ✅ Grátis para sites estáticos
- ✅ HTTPS incluído
- ✅ CDN global
- ✅ Deploy simples

```bash
npm install -g firebase-tools
firebase login
firebase init hosting
firebase deploy
```

## Recomendação

**Use Cloud Run** - É a solução mais simples e não tem restrições de política. Execute:

```bash
./deploy-cloudrun.sh
```

O script fará tudo automaticamente e você terá uma URL pública funcionando em minutos!

