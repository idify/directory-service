class ProfilePic < ActiveRecord::Base

  belongs_to :user

  has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/
  validates_attachment :logo, :presence => true, :size => { :in => 1..100.megabytes }

  has_attached_file :header_image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :header_image, :content_type => /\Aimage\/.*\Z/
  validates_attachment :header_image, :presence => true, :size => { :in => 1..100.megabytes }
end
