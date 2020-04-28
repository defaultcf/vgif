# frozen_string_literal: true

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

  def tweet_url(text, url = '')
    "https://twitter.com/intent/tweet?#{URI.encode_www_form(text: text, url: url)}"
  end
end
