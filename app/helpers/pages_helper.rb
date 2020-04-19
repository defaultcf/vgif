module PagesHelper
  def ogp_image(resource)
    resource.variant(resize: '600x315^').processed
  end

  def thumbnail_image(resource)
    # convert input.gif -coalesce -scale 50% -deconstruct +dither -layers Optimize output.gif
    resource.variant(
      loader: { page: nil },
      #resize: "600x315^", # FIXME: 何故か縦横を小さくしたはずなのにファイルサイズが大きくなる
      scale: '50%',
      coalesce: true,
      deconstruct: true,
      dither: true, '+': true,
      layers: "Optimize",
    ).processed
  end

  def error_message(obj, attr)
    attr = attr.to_sym
    if obj.errors[attr.to_sym]
      tag.p obj.errors.full_messages_for(attr.to_sym).join('、'), class: 'help is-danger'
    end
  end
end
