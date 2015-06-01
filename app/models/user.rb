class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :guests
  has_many :ceremonies

  acts_as_messageable

  def mailboxer_email(object)
    email
  end
end
