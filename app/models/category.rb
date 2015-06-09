class Category < ActiveRecord::Base

  #validates_format_of :mobile, :presence => true, with: /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/
  belongs_to :user
  extend FriendlyId
  friendly_id :category_type, use: [:slugged, :history]

  def should_generate_new_friendly_id?
    new_record?
  end

end
