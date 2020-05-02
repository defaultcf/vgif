# frozen_string_literal: true

module RemoteImage
  extend ActiveSupport::Concern

  def remote_image_url=(url)
    header = get_header(url)
    return unless header.present? && image_valid?(header)

    image.attach(io: open(url), filename: 'from_other_site.gif') # rubocop:disable all
  end

  private

  def get_header(url)
    uri = URI.parse(url)
    return nil if Settings.gifs.upload.allow_hosts.none?(uri.host)

    http = Net::HTTP.new(uri.host, 443)
    http.use_ssl = true
    http.read_timeout = 5
    http.head(uri.path)
  rescue StandardError
    nil
  end

  def image_valid?(header)
    header.content_type == 'image/gif' && \
      header.content_length.to_i.bytes < 20.megabytes
  end
end
