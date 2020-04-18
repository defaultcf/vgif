class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :omniauthable, omniauth_providers: %i[twitter developer]

  has_many :gifs, dependent: :destroy
  acts_as_taggable

  validates :username, uniqueness: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = "#{auth.provider}-#{auth.uid}@example.com"
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.info.nickname
      user.displayname = auth.info.name
    end
  end
end
