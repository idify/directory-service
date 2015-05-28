class Guest < ActiveRecord::Base

  validates_format_of :mobile, :presence => true, with: /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/
  belongs_to :user
end
