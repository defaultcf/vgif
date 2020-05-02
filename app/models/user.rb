# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
    :omniauthable, omniauth_providers: %i[twitter developer]

  has_many :gifs, dependent: :destroy
  acts_as_taggable

  include TagList

  validates :username, presence: true, uniqueness: true
  validates :displayname, presence: true, length: { in: 1..30 }

  # rubocop:disable Metrics/AbcSize
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = "#{auth.provider}-#{auth.uid}@example.com"
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.info.nickname || auth.info.name
      user.displayname = auth.info.name
    end
  end
  # rubocop:enable Metrics/AbcSize

  def to_param
    username
  end
end
