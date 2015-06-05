class CreateProfilePics < ActiveRecord::Migration
  def change
    create_table :profile_pics do |t|
      t.references :user
      t.timestamps null: false
    end
  end
end
