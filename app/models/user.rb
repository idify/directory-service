class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :twitter, :google_oauth2]

  has_many :guests
  has_many :ceremonies
  has_many :categories
  has_many :images
  has_many :videos
  has_many :video_urls
  has_one :subsite
  has_many :wishlists
  #has_many :user_keywords
  has_one :profile_pic
  has_many :invites

  acts_as_messageable

  enum role: [ :customer, :vendor]

  validates_format_of :mobile, :presence => true, with: /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/

  ##########################################################################
  # User full name
  ##########################################################################
  def full_name
    if self.first_name.present? && self.last_name.present?
      (self.first_name+ ' ' + self.last_name).capitalize
    elsif self.first_name.present?
      self.first_name.capitalize
    else
      self.email
    end
  end

  def mailboxer_email(object)
    email
  end

  def self.from_omniauth(auth, user_role=nil)
    user = self.where(provider: auth.provider, uid: auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        new_user_from_provider = User.new(first_name: auth.info.name, provider: auth.provider,
                                          email: auth.info.email.present? ? auth.info.email : "#{auth.info.name}@idifysolutions.com",
                                          uid: auth.uid, password: Devise.friendly_token[0,20], role: user_role['role']=='customer' ? 0 : 1)
        new_user_from_provider.skip_confirmation!
        new_user_from_provider.save(:validate => false)
        return new_user_from_provider
      end
    end
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil, user_role=nil)
    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
    if user
      return user
    else
      registered_user = User.where(:email => access_token.info.email).first
      if registered_user
        return registered_user
      else
        user = User.new(first_name: data["name"],
                           provider:access_token.provider,
                           email: data["email"],
                           uid: access_token.uid ,
                           password: Devise.friendly_token[0,20],
                           role: user_role['role']=='customer' ? 0 : 1

        )
        user.skip_confirmation!
        user.save(validate:false)
        return user
      end
    end
  end

  def self.get_users_not_logged_in_from_last_five_days
    users_list = self.where("date(last_sign_in_at)=?", Date.today - 5.day)
    if users_list.present?
      users_list
    end
  end
end
