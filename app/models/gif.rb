class Gif < ApplicationRecord
  include RemoteImage

  belongs_to :user
  has_one_attached :image
  acts_as_taggable

  validates :title, presence: true
  validates :source_url, format: /\A#{URI::regexp(%w(http https))}\z/
  validates :image,
    attached: true,
    content_type: 'image/gif',
    size: { less_than: Settings.gifs.upload.max_size },
    dimension: {
      width: { max: Settings.gifs.upload.max_width },
      height: { max: Settings.gifs.upload.max_height },
    }
  validate :custom_validator

  def tag_list=(tag_json)
    begin
      arr = JSON.parse(tag_json).pluck('value')
    rescue
      arr = []
    end

    super(arr)
  end

  private

  def custom_validator
    errors.add(:base, 'Must be boolean') if public.nil?
  end
end
