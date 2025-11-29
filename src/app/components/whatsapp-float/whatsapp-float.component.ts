import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-whatsapp-float',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './whatsapp-float.component.html',
  styleUrl: './whatsapp-float.component.css'
})
export class WhatsappFloatComponent {
  // Substitua pelo número real do WhatsApp da loja
  // Formato: 5511999999999 (código do país + DDD + número)
  whatsappNumber = '5541984202450';
  
  isExpanded = false;

  togglePopup() {
    this.isExpanded = !this.isExpanded;
  }

  openWhatsApp() {
    const message = encodeURIComponent('Olá! Preciso de ajuda com serviços de chaveiro.');
    const url = `https://wa.me/${this.whatsappNumber}?text=${message}`;
    window.open(url, '_blank');
    this.isExpanded = false;
  }
}

