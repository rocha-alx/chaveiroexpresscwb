const PHONE='5541984202450';
const baseMessage='Olá! Vim pelo site da Chaveiro Express CWB e preciso de atendimento.';
const wa=(message=baseMessage)=>`https://wa.me/${PHONE}?text=${encodeURIComponent(message)}`;
document.querySelectorAll('[data-whatsapp]').forEach(a=>{a.href=wa();a.target='_blank';a.rel='noopener'});
document.querySelectorAll('[data-service]').forEach(a=>{a.href=wa(`Olá! Vim pelo site e preciso de atendimento para ${a.dataset.service}. Minha localização é: `);a.target='_blank';a.rel='noopener'});
const header=document.querySelector('.header'), back=document.querySelector('.backtop');
addEventListener('scroll',()=>{if(header)header.classList.toggle('scrolled',scrollY>30);if(back)back.classList.toggle('show',scrollY>500)});
if(back)back.addEventListener('click',()=>scrollTo({top:0,behavior:'smooth'}));
const btn=document.querySelector('.menu-btn'),menu=document.querySelector('.menu');
if(btn&&menu){btn.addEventListener('click',()=>{const open=menu.classList.toggle('open');btn.setAttribute('aria-expanded',open)});menu.querySelectorAll('a').forEach(a=>a.addEventListener('click',()=>menu.classList.remove('open')));}
const io=new IntersectionObserver(entries=>entries.forEach(e=>e.isIntersecting&&e.target.classList.add('visible')),{threshold:.12});
document.querySelectorAll('.reveal').forEach(el=>io.observe(el));
