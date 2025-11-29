import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-contato',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './contato.component.html',
  styleUrl: './contato.component.css'
})
export class ContatoComponent {
  whatsappNumber = '5541984202450';
  
  endereco = {
    rua: 'R. Waldemar Loureiro Campos, 3615 LJ05',
    bairro: 'Xaxim',
    cidade: 'Curitiba - PR',
    cep: '81720-180'
  };
  
  telefone = '(41) 99999-9999';
  email = 'contato@chaveiroexpress.com.br';
  horarioAtendimento = 'Segunda a Sexta: 09:00 às 20:00\nSábado: 09:00 às 15:00';
  
  contatoForm = {
    nome: '',
    telefone: '',
    email: '',
    servico: '',
    mensagem: ''
  };

  enviarMensagem(event: Event) {
    event.preventDefault(); // Previne o comportamento padrão do formulário
    
    // Valida se os campos obrigatórios estão preenchidos
    if (!this.contatoForm.nome || !this.contatoForm.telefone || !this.contatoForm.mensagem) {
      alert('Por favor, preencha todos os campos obrigatórios.');
      return;
    }
    
    // Constrói a mensagem com os dados do formulário
    let mensagemTexto = `Olá! Meu nome é ${this.contatoForm.nome}.\n\n`;
    mensagemTexto += `📞 Telefone: ${this.contatoForm.telefone}\n`;
    
    if (this.contatoForm.email) {
      mensagemTexto += `📧 Email: ${this.contatoForm.email}\n`;
    }
    
    if (this.contatoForm.servico) {
      mensagemTexto += `🔧 Serviço de interesse: ${this.contatoForm.servico}\n`;
    }
    
    mensagemTexto += `\n💬 Mensagem:\n${this.contatoForm.mensagem}`;
    
    // Codifica a mensagem para URL
    const mensagem = encodeURIComponent(mensagemTexto);
    
    // Cria a URL do WhatsApp
    const url = `https://wa.me/${this.whatsappNumber}?text=${mensagem}`;
    
    // Detecta se é dispositivo móvel
    const isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
    
    if (isMobile) {
      // Em mobile, tenta abrir o app do WhatsApp diretamente
      // Se o app não estiver instalado, abre no navegador
      window.location.href = url;
    } else {
      // Em desktop, abre o WhatsApp Web em nova aba
      window.open(url, '_blank');
    }
    
    // Limpa o formulário após o envio (com pequeno delay para garantir que abriu)
    setTimeout(() => {
      this.contatoForm = { nome: '', telefone: '', email: '', servico: '', mensagem: '' };
    }, 1000);
  }

  abrirWhatsApp() {
    const url = `https://wa.me/${this.whatsappNumber}`;
    window.open(url, '_blank');
  }

  enviarTelefone() {
    // Remove formatação do telefone para o link tel:
    const telefoneLimpo = this.telefone.replace(/\D/g, '');
    const url = `tel:+55${telefoneLimpo}`;
    window.open(url);
  }

  abrirMapa() {
    const enderecoCompleto = encodeURIComponent(
      `${this.endereco.rua}, ${this.endereco.bairro}, ${this.endereco.cidade}`
    );
    const url = `https://www.google.com/maps/search/?api=1&query=${enderecoCompleto}`;
    window.open(url, '_blank');
  }

  enviarEmail() {
    const url = `mailto:${this.email}?subject=Contato%20-%20Chaveiro%20Express`;
    window.open(url);
  }
}

