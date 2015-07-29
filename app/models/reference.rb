class Reference < ActiveRecord::Base

  belongs_to :category

  ratyrate_rateable "comment"
end
