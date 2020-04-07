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
preview.addEventListener('click', () => {
  file_field.click();
});

// Tagify
import Tagify from '@yaireo/tagify'
new Tagify(document.querySelector('[name="gif[tag_list]"'));

// Submit
const form = document.querySelector('form');
const submit_button = document.querySelector('#submit_button');
submit_button.addEventListener('click', e => {
  submit_button.setAttribute('disabled', '');
  submit_button.textContent = 'Wait...';
  form.submit();
});
