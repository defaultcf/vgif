module GifsHelper
  def image_public_url(resource)
    if Rails.env.production?
      url = URI.parse(resource.service_url)
      url.query = ''
      url.to_s.delete_suffix('?')
    else
      full_url_for(resource)
    end
  end

  def error_message(obj, attr)
    attr = attr.to_sym
    if obj.errors[attr.to_sym]
      tag.p obj.errors.full_messages_for(attr.to_sym).join('、'), class: 'help is-danger'
    end
  end

  def tweet_url(text, url = '')
    "https://twitter.com/intent/tweet?#{URI.encode_www_form(text: text, url: url)}"
  end
end
