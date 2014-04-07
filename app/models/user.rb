class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :reservations

  def self.create_with_omniauth(auth)
    create! do |user|
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
 
  def self.create_unique_string
    SecureRandom.uuid
  end
 
  # twitterではemailを取得できないので、適当に一意のemailを生成
  def self.create_unique_email
    User.create_unique_string + "@example.com"
  end
 
  def self.find_for_google_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:     auth.extra.raw_info.name,
 			provider: auth.provider,
 			uid:      auth.uid,
 			email:    auth.info.email,
 			password: Devise.friendly_token[0,20]
 		       )
    end
    user
  end
 
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:     auth.extra.raw_info.name,
 			provider: auth.provider,
 			uid:      auth.uid,
 			email:    auth.info.email,
 			password: Devise.friendly_token[0,20]
 		       )
    end
    user
  end
 
  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:     auth.info.nickname,
 			provider: auth.provider,
 			uid:      auth.uid,
 			email:    User.create_unique_email,
 			password: Devise.friendly_token[0,20]
 		       )
    end
    user
  end
end
