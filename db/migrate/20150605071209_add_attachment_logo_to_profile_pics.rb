class AddAttachmentLogoToProfilePics < ActiveRecord::Migration
  def self.up
    change_table :profile_pics do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :profile_pics, :logo
  end
end
