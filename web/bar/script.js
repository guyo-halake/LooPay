// Mobile nav toggle
const hamburgerButton = document.getElementById('hamburger');
const nav = document.getElementById('nav');
if (hamburgerButton) {
  hamburgerButton.addEventListener('click', () => {
    const willOpen = !nav.classList.contains('open');
    nav.classList.toggle('open', willOpen);
    hamburgerButton.classList.toggle('active', willOpen);
    hamburgerButton.setAttribute('aria-expanded', String(willOpen));
  });
}

// Smooth scroll for same-page links
document.querySelectorAll('a[href^="#"]').forEach(link => {
  link.addEventListener('click', e => {
    const targetId = link.getAttribute('href');
    if (!targetId || targetId === '#') return;
    const el = document.querySelector(targetId);
    if (!el) return;
    e.preventDefault();
    el.scrollIntoView({ behavior: 'smooth', block: 'start' });
    nav.classList.remove('open');
    hamburgerButton?.classList.remove('active');
    hamburgerButton?.setAttribute('aria-expanded', 'false');
  });
});

// Footer year
document.getElementById('year').textContent = new Date().getFullYear();

// Simple form validation and success message
const form = document.getElementById('reserveForm');
const success = document.getElementById('formSuccess');
if (form) {
  form.addEventListener('submit', e => {
    e.preventDefault();

    const fields = ['name', 'email', 'date', 'time', 'guests'];
    let valid = true;

    fields.forEach(id => {
      const input = document.getElementById(id);
      const errorEl = document.querySelector(`.error[data-for="${id}"]`);
      if (!input) return;

      let message = '';
      if (!input.value) {
        message = 'Required';
        valid = false;
      } else if (id === 'email' && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(input.value)) {
        message = 'Enter a valid email';
        valid = false;
      }
      if (errorEl) errorEl.textContent = message;
    });

    if (!valid) return;

    success.textContent = 'Thanks! Your booking request has been received.';
    form.reset();
  });
}


