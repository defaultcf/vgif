const main = async () => {
  const gif_dom = document.querySelector('#gif');
  if (!gif_dom) return;

  const share_button = document.querySelector('#share-button');
  if (!navigator.share) {
    share_button.style.display = 'none';
    return;
  }

  const title = document.querySelector('.title').innerText;
  const res = await fetch(gif_dom.src);
  const blob = await res.blob();
  const file = new File([blob], 'file.gif', { type: 'image/gif' });

  share_button.addEventListener('click', () => {
    try {
      navigator.share({
        text: title,
        url: location.href,
        files: [file],
      });
    } catch (e) {
      console.warn('Your device does not support navigator.share :(');
    }
  });
};

main();
