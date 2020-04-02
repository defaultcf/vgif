const main = () => {
  const navbar_burger = document.querySelector('.navbar-burger')
  const navbar_menu = document.querySelector('#navbarMenu');
  navbar_burger.addEventListener('click', () => {
    navbar_burger.classList.toggle('is-active');
    navbar_menu.classList.toggle('is-active');
  })
};

main();
document.addEventListener('turbolinks:load', main);
