class AddAttachmentHeaderImageToProfilePics < ActiveRecord::Migration
  def self.up
    change_table :profile_pics do |t|
      t.attachment :header_image
    end
  end

  def self.down
    remove_attachment :profile_pics, :header_image
  end
end
