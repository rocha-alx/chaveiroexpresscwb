# Chaveiro Express

Site institucional do Chaveiro Express desenvolvido em Angular com TypeScript.

## 🚀 Características

- Design moderno com cores Amarelo e Preto
- Header com logo e navegação responsiva
- Página inicial com carrossel de banners dos serviços
- Componente flutuante de WhatsApp com popup
- Páginas de Serviços e Contato completas
- Layout totalmente responsivo

## 📋 Pré-requisitos

- Node.js (versão 18 ou superior)
- npm ou yarn

## 🛠️ Instalação

1. Instale as dependências:
```bash
npm install
```

2. Execute o servidor de desenvolvimento:
```bash
npm start
```

3. Acesse o site em `http://localhost:4200`

## 📝 Configuração do WhatsApp

Para configurar o número do WhatsApp da loja, edite os seguintes arquivos:

1. `src/app/components/whatsapp-float/whatsapp-float.component.ts`
   - Altere a variável `whatsappNumber` com o número no formato: `5511999999999` (código do país + DDD + número)

2. `src/app/pages/contato/contato.component.ts`
   - Altere a variável `whatsappNumber` com o mesmo formato

## 🎨 Estrutura do Projeto

```
src/
├── app/
│   ├── components/
│   │   ├── header/          # Header com logo e menu
│   │   └── whatsapp-float/   # Componente flutuante do WhatsApp
│   ├── pages/
│   │   ├── home/             # Página inicial com carrossel
│   │   ├── servicos/         # Página de serviços
│   │   └── contato/          # Página de contato
│   ├── app.component.ts
│   └── app.routes.ts
├── styles.css                 # Estilos globais
└── index.html
```

## 🌐 Rotas

- `/` ou `/inicio` - Página inicial
- `/servicos` - Página de serviços
- `/contato` - Página de contato

## 📱 Funcionalidades

- **Carrossel de Serviços**: Banner rotativo na página inicial mostrando os principais serviços
- **WhatsApp Flutuante**: Ícone fixo no canto inferior direito com popup para contato rápido
- **Navegação Responsiva**: Menu hambúrguer para dispositivos móveis
- **Formulário de Contato**: Formulário que envia mensagem diretamente pelo WhatsApp

## 🎯 Personalização

Para personalizar imagens do carrossel, edite o array `servicos` em `src/app/pages/home/home.component.ts` e altere as URLs das imagens.

