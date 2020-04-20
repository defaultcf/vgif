// GIF preview
const file_field = document.querySelector('input[name="gif[image]"]');
const preview = document.querySelector('#gif-preview');
file_field.addEventListener('change', input => {
  if (input.target.files && input.target.files[0]) {
    const reader = new FileReader();
    reader.onload = e => {
      preview.setAttribute('src', e.target.result);
    };
    reader.readAsDataURL(input.target.files[0]);
  }
});

const remote_url_field = document.querySelector('input[name="gif[remote_image_url]"]');
const source_url_field = document.querySelector('input[name="gif[source_url]"]');
let timer;
remote_url_field.addEventListener('input', e => {
  window.clearTimeout(timer);
  timer = window.setTimeout(async() => {
    const gifs_id = remote_url_field.value.match(/\/([\w-_]+).gif$/);
    if (!gifs_id) return;
    preview.setAttribute('src', remote_url_field.value);
    const res = await fetch(`/api/gifscom/get_meta.json?gifs_id=${gifs_id[1]}`);
    const json = await res.json();
    source_url_field.value = `https://youtu.be/${json.yid}?t=${Math.trunc(json.start)}`;
  }, 3000);
});

preview.addEventListener('click', () => {
  file_field.click();
});
