class Gif < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  acts_as_taggable

  include RemoteImage
  include TagList

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

  def editable?(check_user)
    user == check_user
  end

  private

  def custom_validator
    errors.add(:base, 'Must be boolean') if public.nil?
  end
end
