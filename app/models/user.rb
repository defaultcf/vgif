class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :omniauthable, omniauth_providers: %i[twitter]

  has_many :gifs, dependent: :destroy

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = "#{auth.provider}-#{auth.uid}@example.com"
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
