import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './home.component.html',
  styleUrl: './home.component.css'
})
export class HomeComponent implements OnInit {
  currentSlide = 0;
  
  servicos = [
    {
      titulo: 'Abertura de Portas',
      descricao: 'Serviço rápido e seguro de abertura de portas residenciais e comerciais',
      imagem: 'https://chaveirorapido24horas.com.br/wp-content/uploads/2022/09/Chaveiro-Rapido-24-horas-1.jpg'
    },
    {
      titulo: 'Cópia de Chaves',
      descricao: 'Cópias de chaves com precisão e qualidade garantida',
      imagem: 'https://casadaschavessantos.com.br/wp-content/uploads/2017/05/Copia-de-Chave-em-Santos.jpg'
    },
    {
      titulo: 'Chaveiro Automotivo',
      descricao: 'Serviços especializados para carros, motos e veículos em geral',
      imagem: 'https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2000&q=80'
    },
    {
      titulo: 'Segurança Residencial',
      descricao: 'Instalação e manutenção de fechaduras e sistemas de segurança',
      imagem: 'https://blog.intelbras.com.br/wp-content/uploads/2020/07/Imagem_conteudo15_1200x628.jpg'
    },
    {
      titulo: 'Cofres e Cadeados',
      descricao: 'Abertura de cofres, cadeados e sistemas de segurança avançados',
      imagem: 'https://chaves.curitibachaveiro.com.br/chaveiro/imagens/abertura-cofre.png'
    }
  ];

  ngOnInit() {
    this.startCarousel();
  }

  startCarousel() {
    setInterval(() => {
      this.nextSlide();
    }, 5000); // Muda slide a cada 5 segundos
  }

  nextSlide() {
    this.currentSlide = (this.currentSlide + 1) % this.servicos.length;
  }

  prevSlide() {
    this.currentSlide = (this.currentSlide - 1 + this.servicos.length) % this.servicos.length;
  }

  goToSlide(index: number) {
    this.currentSlide = index;
  }
}

