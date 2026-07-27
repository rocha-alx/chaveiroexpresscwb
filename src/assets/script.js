const PHONE = '5541984202450';
const GOOGLE_ADS_CONVERSION_ID = 'AW-18268662536/LpInCKbRrNAcEIjWlodE';
const baseMessage = 'Olá! Vim pelo site da Chaveiro Express CWB e preciso de atendimento.';
const wa = (message = baseMessage) => `https://wa.me/${PHONE}?text=${encodeURIComponent(message)}`;

const contactLinks = document.querySelectorAll('[data-whatsapp], [data-service]');

contactLinks.forEach((link) => {
  const message = link.dataset.service
    ? `Olá! Vim pelo site e preciso de atendimento para ${link.dataset.service}. Minha localização é: `
    : baseMessage;

  link.href = wa(message);
  link.target = '_blank';
  link.rel = 'noopener';

  link.addEventListener('click', (event) => {
    const destination = link.href;

    // Mantém a abertura em nova aba e aguarda brevemente o envio da conversão.
    event.preventDefault();
    const newTab = window.open('about:blank', '_blank');
    let redirected = false;

    const openDestination = () => {
      if (redirected) return;
      redirected = true;

      if (newTab && !newTab.closed) {
        newTab.opener = null;
        newTab.location.href = destination;
      } else {
        window.location.href = destination;
      }
    };

    const fallback = window.setTimeout(openDestination, 1000);

    if (typeof window.gtag === 'function') {
      window.gtag('event', 'conversion', {
        send_to: GOOGLE_ADS_CONVERSION_ID,
        event_callback: () => {
          window.clearTimeout(fallback);
          openDestination();
        },
        event_timeout: 900
      });
    } else {
      window.clearTimeout(fallback);
      openDestination();
    }
  });
});

const header = document.querySelector('.header');
const back = document.querySelector('.backtop');

addEventListener('scroll', () => {
  if (header) header.classList.toggle('scrolled', scrollY > 30);
  if (back) back.classList.toggle('show', scrollY > 500);
});

if (back) back.addEventListener('click', () => scrollTo({ top: 0, behavior: 'smooth' }));

const btn = document.querySelector('.menu-btn');
const menu = document.querySelector('.menu');

if (btn && menu) {
  btn.addEventListener('click', () => {
    const open = menu.classList.toggle('open');
    btn.setAttribute('aria-expanded', open);
  });
  menu.querySelectorAll('a').forEach((link) => link.addEventListener('click', () => menu.classList.remove('open')));
}

const io = new IntersectionObserver(
  (entries) => entries.forEach((entry) => entry.isIntersecting && entry.target.classList.add('visible')),
  { threshold: 0.12 }
);

document.querySelectorAll('.reveal').forEach((element) => io.observe(element));
