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
    size: { less_than: 20.megabytes },
    dimension: { width: { max: 1500 }, height: { max: 1500 } }
  validate :custom_validator

  private

  def custom_validator
    errors.add(:base, 'Must be boolean') if public.nil?
  end
end
