class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :twitter]

  has_many :guests
  has_many :ceremonies

  has_many :images
  has_many :videos
  has_many :video_urls

  acts_as_messageable

  def mailboxer_email(object)
    email
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email.present? ? auth.info.email : auth.info.name
      user.password = Devise.friendly_token[0,20]
    end
  end

  # def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
  #   data = access_token.info
  #   user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
  #   if user
  #     return user
  #   else
  #     registered_user = User.where(:email => access_token.info.email).first
  #     if registered_user
  #       return registered_user
  #     else
  #       user = User.create(name: data["name"],
  #                          provider:access_token.provider,
  #                          email: data["email"],
  #                          uid: access_token.uid ,
  #                          password: Devise.friendly_token[0,20],
  #       )
  #     end
  #   end
  # end
end
