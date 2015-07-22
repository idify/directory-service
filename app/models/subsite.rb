class Subsite < ActiveRecord::Base
  belongs_to :user

  validates_uniqueness_of :domain_name
end
