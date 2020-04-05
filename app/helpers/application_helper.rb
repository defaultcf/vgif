module ApplicationHelper
  def default_meta_tags
    {
      site: 'vGIF',
      description: 'VTuberのGIFが集まる場所',
      keywords: 'VTuber,GIF',
      charset: 'UTF-8',
      og: {
        site_name: :site,
        type: 'website',
        url: request.original_url,
        title: :title,
        description: 'VTuberのGIFが集まる場所',
      },
    }
  end
end
