import Tagify from '@yaireo/tagify'

const main = () => {
  // Navbar burger
  const navbar_burger = document.querySelector('.navbar-burger')
  const navbar_menu = document.querySelector('#navbarMenu');
  if (navbar_burger.getAttribute('setevent') === 'true') return;

  navbar_burger.setAttribute('setevent', 'true');
  navbar_burger.addEventListener('click', () => {
    navbar_burger.classList.toggle('is-active');
    navbar_menu.classList.toggle('is-active');
  });

  // Notification delete button
  document.querySelectorAll('.notification .delete').forEach(delete_button => {
    const notification = delete_button.parentNode;
    delete_button.addEventListener('click', () => {
      notification.remove();
    });
  });

  // Modal
  document.querySelectorAll('button.open-modal').forEach(open_button => {
    const modal = open_button.nextElementSibling;
    open_button.addEventListener('click', () => {
      modal.classList.add('is-active')
      document.body.classList.add('is-clipped');
    });
  });
  document.querySelectorAll('button.modal-close').forEach(close_button => {
    const modal = close_button.parentNode;
    const background = modal.querySelector('.modal-background');
    const closeModal = () => {
      modal.classList.remove('is-active');
      document.body.classList.remove('is-clipped');
    };
    close_button.addEventListener('click', closeModal);
    background.addEventListener('click', closeModal);
  });

  if (document.querySelector('.copy-button')) {
    // Copy button
    document.querySelectorAll('.copy-button').forEach(area => {
      const input = area.querySelector('input');
      const button = area.querySelector('button');
      button.addEventListener('click', () => {
        input.select();
        document.execCommand('copy');
        button.setAttribute('data-tooltip', button.getAttribute('data-tooltip-tmp'));
      });
    });

    // Ready thumbnail image
    fetch(window.location.href + '.thumb_gif', { method: 'HEAD' })
  }

  // Tagify
  const tagify_field = document.querySelector('input.tagify');
  if (tagify_field) {
    new Tagify(tagify_field);
  }

  // Submit
  const form = document.querySelector('form');
  const submit_button = document.querySelector('#submit_button');
  if (form && submit_button) {
    submit_button.removeAttribute('disabled');
    submit_button.addEventListener('click', e => {
      submit_button.setAttribute('disabled', '');
      submit_button.textContent = 'Wait...';
      form.submit();
    });
  }
};

document.addEventListener('DOMContentLoaded', main);
document.addEventListener('turbolinks:load', main);
