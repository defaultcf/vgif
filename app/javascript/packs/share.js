const main = async () => {
  const direct_url = document.querySelector('#direct_url');
  if (!direct_url) return;

  const share_button = document.querySelector('#share-button');
  share_button.setAttribute('disabled', true);
  if (!navigator.share) {
    share_button.style.display = 'none';
    return;
  }

  const title = document.querySelector('.title').innerText;
  const res = await fetch(direct_url.value, { mode: 'cors' });
  const blob = await res.blob();
  const file = new File([blob], 'file.gif', { type: 'image/gif' });
  share_button.removeAttribute('disabled');

  share_button.addEventListener('click', () => {
    try {
      navigator.share({
        text: `${title} ${location.href}`,
        files: [file],
      });
    } catch (e) {
      console.warn('Your device does not support navigator.share :(');
    }
  });
};

main();
