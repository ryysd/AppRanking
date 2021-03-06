class User < ActiveRecord::Base
  validates :provider, presence: :true
  validates :uid, presence: :true
  validates :name, presence: :true

  validates_uniqueness_of :uid, scope: :provider

  has_many :reservations

  def self.create_with_omniauth(auth)
    create! do |user|
      pp auth
      user.provider = auth[:provider]
      user.uid = auth[:uid]
      user.email = auth[:info][:email]

      if user.provider != 'twitter'
	user.name = auth[:info][:name]
      else
	user.name = auth[:info][:nickname]
      end
    end
  end
end
