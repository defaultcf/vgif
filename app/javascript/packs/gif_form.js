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

// Tagify
import Tagify from '@yaireo/tagify'
new Tagify(document.querySelector('[name="gif[tag_list]"'));
