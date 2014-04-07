class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :reservations

  def self.create_unique_string
    SecureRandom.uuid
  end
 
  # twitterではemailを取得できないので、適当に一意のemailを生成
  def self.create_unique_email
    "#{User.create_unique_string}@example.com"
  end
 
  def self.find_for_google_oauth(auth, signed_in_resource=nil)
    (User.find_by_provider_and_uid auth.provider, auth.uid) ||
    create do |new_user|
      new_user.name     = auth.extra.raw_info.name,
      new_user.provider = auth.provider,
      new_user.uid      = auth.uid,
      new_user.email    = auth.info.email,
      new_user.password = Devise.friendly_token[0,20]
    end
  end
 
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    find_for_google_oauth auth, signed_in_resource
  end
 
  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    (User.find_by_provider_and_uid auth.provider, auth.uid) ||
    create do |new_user|
      new_user.name     = auth.info.nickname,
      new_user.provider = auth.provider,
      new_user.uid      = auth.uid,
      new_user.email    = User.create_unique_email,
      new_user.password = Devise.friendly_token[0,20]
    end
  end
end
