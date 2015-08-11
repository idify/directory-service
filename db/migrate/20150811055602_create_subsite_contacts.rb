class CreateSubsiteContacts < ActiveRecord::Migration
  def change
    create_table :subsite_contacts do |t|
      t.string :name, :email, :subject
      t.text :message
      t.timestamps null: false
    end
  end
end
