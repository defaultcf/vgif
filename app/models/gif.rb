class Gif < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :title, presence: true
  validates :source_url, format: /\A#{URI::regexp(%w(http https))}\z/
  validate :custom_validator

  private

  def custom_validator
    errors.add(:base, 'Must be boolean') if public.nil?
  end
end
