class Wishlist < ActiveRecord::Base

  belongs_to :user

  validates_format_of :mobile_number, :presence => true, with: /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/
end