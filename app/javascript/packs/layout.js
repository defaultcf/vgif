const main = () => {
  // Navbar burger
  const navbar_burger = document.querySelector('.navbar-burger')
  const navbar_menu = document.querySelector('#navbarMenu');
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
};

main();
document.addEventListener('turbolinks:load', main);
