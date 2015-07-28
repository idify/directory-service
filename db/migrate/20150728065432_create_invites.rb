class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :full_name
      t.string :email
      t.string :invite_source
      t.references :user
      t.timestamps null: false
    end
  end
end