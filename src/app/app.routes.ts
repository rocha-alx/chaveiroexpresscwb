import { Routes } from '@angular/router';
import { HomeComponent } from './pages/home/home.component';
import { ServicosComponent } from './pages/servicos/servicos.component';
import { ContatoComponent } from './pages/contato/contato.component';

export const routes: Routes = [
  {
    path: '',
    component: HomeComponent,
    data: {
      title: 'Chaveiro Express 24h em Curitiba | Xaxim',
      description: 'Chaveiro Express no Xaxim, Curitiba. Atendimento rápido em raio de 10km para abertura de portas, cópia de chaves, chaveiro automotivo e instalação de fechaduras.',
      canonical: 'https://chaveiroexpresscwb.com.br/'
    }
  },
  {
    path: 'inicio',
    redirectTo: ''
  },
  {
    path: 'servicos',
    component: ServicosComponent,
    data: {
      title: 'Serviços de Chaveiro em Curitiba | Chaveiro Express',
      description: 'Conheça os serviços do Chaveiro Express em Curitiba: abertura de portas, cópia de chaves, chaveiro automotivo, instalação de fechaduras e segurança.',
      canonical: 'https://chaveiroexpresscwb.com.br/servicos'
    }
  },
  {
    path: 'contato',
    component: ContatoComponent,
    data: {
      title: 'Contato | Chaveiro Express Curitiba',
      description: 'Entre em contato com o Chaveiro Express em Curitiba para atendimento rápido, WhatsApp e localização no Xaxim e região.',
      canonical: 'https://chaveiroexpresscwb.com.br/contato'
    }
  },
  { path: '**', redirectTo: '' }
];

