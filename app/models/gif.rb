class Gif < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :title, presence: true
  validates :source_url, format: /\A#{URI::regexp(%w(http https))}\z/
end
