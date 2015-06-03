class Image < ActiveRecord::Base

  belongs_to :user

  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  validates_attachment :photo, :presence => true, :size => { :in => 1..100.megabytes }

end
