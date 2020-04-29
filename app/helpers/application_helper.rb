# frozen_string_literal: true

module ApplicationHelper
  def default_meta_tags
    {
      site: 'vGIF',
      description: 'VTuberのGIFが集まる場所、vGIF',
      keywords: 'VTuber,GIF',
      charset: 'UTF-8',
      og: {
        site_name: :site,
        type: 'website',
        url: request.original_url,
        title: :full_title,
        description: :description,
      },
    }
  end
end
