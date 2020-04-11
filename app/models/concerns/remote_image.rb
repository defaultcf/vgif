module RemoteImage
  extend ActiveSupport::Concern

  def remote_image_url=(url)
    return unless is_header_valid?(url)

    image.attach(io: open(url), filename: 'from_other_site')
  end

  private

  def is_header_valid?(url)
    return false if url.empty?

    begin
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host)
      http.read_timeout = 5
      header = http.head(uri.path)
    rescue
      return false
    end

    header.content_type == 'image/gif' && header.content_length.to_i.bytes < 20971520.gigabytes
  end
end
