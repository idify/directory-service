class Video < ActiveRecord::Base

  belongs_to :user

  has_attached_file :video,styles: {:thumb => { :geometry => "100x100#", :format => 'jpg', :time => 10}, :medium => { :geometry => "300x300#", :format => 'jpg', :time => 10}}
  validates_attachment_content_type :video, content_type: /\Avideo\/.*\Z/
end
