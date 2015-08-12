class AddIsFacebookEmailVerifiedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_facebook_email_verified, :boolean, default: false, null: false
  end
end

