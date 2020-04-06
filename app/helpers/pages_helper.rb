module PagesHelper
  def ogp_image(resource)
    resource.variant(resize: '600x315^').processed
  end
end
