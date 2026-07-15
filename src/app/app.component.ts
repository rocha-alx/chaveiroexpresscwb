import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, NavigationEnd, Router, RouterOutlet } from '@angular/router';
import { Title, Meta } from '@angular/platform-browser';
import { filter, map, mergeMap } from 'rxjs/operators';
import { HeaderComponent } from './components/header/header.component';
import { WhatsappFloatComponent } from './components/whatsapp-float/whatsapp-float.component';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, HeaderComponent, WhatsappFloatComponent],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent implements OnInit {
  title = 'Chaveiro Express';

  constructor(
    private router: Router,
    private activatedRoute: ActivatedRoute,
    private titleService: Title,
    private metaService: Meta
  ) {}

  ngOnInit(): void {
    this.router.events.pipe(
      filter((event) => event instanceof NavigationEnd),
      map(() => this.activatedRoute),
      map((route) => {
        while (route.firstChild) {
          route = route.firstChild;
        }
        return route;
      }),
      mergeMap((route) => route.data)
    ).subscribe((data) => {
      const pageData = {
        title: 'Chaveiro Express | Chaveiro em Curitiba no Xaxim',
        description: 'Chaveiro Express em Curitiba, bairro Xaxim. Atendimento em raio de 10km para abertura de portas, cópia de chaves, chaveiro automotivo e instalação de fechaduras.',
        canonical: 'https://chaveiroexpresscwb.com.br/',
        image: 'https://chaveiroexpresscwb.com.br/assets/Logo.png',
        ...data
      };

      this.titleService.setTitle(pageData.title);
      this.metaService.updateTag({ name: 'description', content: pageData.description });
      this.metaService.updateTag({ name: 'robots', content: 'index, follow, max-image-preview:large, max-snippet:-1, max-video-preview:-1' });
      this.metaService.updateTag({ property: 'og:title', content: pageData.title });
      this.metaService.updateTag({ property: 'og:description', content: pageData.description });
      this.metaService.updateTag({ property: 'og:url', content: pageData.canonical });
      this.metaService.updateTag({ property: 'og:image', content: pageData.image });
      this.metaService.updateTag({ name: 'twitter:title', content: pageData.title });
      this.metaService.updateTag({ name: 'twitter:description', content: pageData.description });
      this.metaService.updateTag({ name: 'twitter:url', content: pageData.canonical });
      this.metaService.updateTag({ name: 'twitter:image', content: pageData.image });
      this.setCanonical(pageData.canonical);
    });
  }

  private setCanonical(url: string): void {
    let link = document.querySelector("link[rel='canonical']") as HTMLLinkElement | null;
    if (!link) {
      link = document.createElement('link');
      link.setAttribute('rel', 'canonical');
      document.head.appendChild(link);
    }
    link.setAttribute('href', url);
  }
}

