import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-servicos',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './servicos.component.html',
  styleUrl: './servicos.component.css'
})
export class ServicosComponent {
  servicos = [
    {
      icone: 'fas fa-door-open',
      titulo: 'Abertura de Portas',
      descricao: 'Serviço profissional de abertura de portas residenciais e comerciais, sem danificar a fechadura. Atendimento rápido e seguro.',
      detalhes: [
        'Abertura sem danos',
        'Serviço residencial e comercial',
        'Técnicas modernas e seguras',
        'Garantia de qualidade'
      ]
    },
    {
      icone: 'fas fa-key',
      titulo: 'Cópia de Chaves',
      descricao: 'Cópias de chaves com precisão absoluta. Trabalhamos com todos os tipos de chaves: comum, codificada, automotiva e mais.',
      detalhes: [
        'Todos os tipos de chaves',
        'Chaves codificadas',
        'Chaves automotivas',
        'Precisão garantida'
      ]
    },
    {
      icone: 'fas fa-car',
      titulo: 'Chaveiro Automotivo',
      descricao: 'Serviços especializados para veículos: abertura de portas, cópia de chaves de carro, programação de chaves e muito mais.',
      detalhes: [
        'Abertura de portas de carros',
        'Cópia de chaves automotivas',
        'Programação de chaves',
        'Emergências 24h'
      ]
    },
    {
      icone: 'fas fa-lock',
      titulo: 'Instalação de Fechaduras',
      descricao: 'Instalação e manutenção de fechaduras residenciais e comerciais. Sistemas de segurança de última geração.',
      detalhes: [
        'Instalação profissional',
        'Manutenção preventiva',
        'Fechaduras de segurança',
        'Sistemas eletrônicos'
      ]
    },
    {
      icone: 'fas fa-shield-alt',
      titulo: 'Segurança Residencial',
      descricao: 'Soluções completas de segurança para sua residência: fechaduras, trancas, portões automáticos e muito mais.',
      detalhes: [
        'Consultoria em segurança',
        'Instalação de sistemas',
        'Manutenção de portões',
        'Trancas especiais'
      ]
    },
    {
      icone: 'fas fa-vault',
      titulo: 'Cofres e Cadeados',
      descricao: 'Abertura especializada de cofres, cadeados de alta segurança e sistemas de proteção avançados.',
      detalhes: [
        'Abertura de cofres',
        'Cadeados de alta segurança',
        'Sistemas avançados',
        'Técnicas especializadas'
      ]
    }
  ];
}

