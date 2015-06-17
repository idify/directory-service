class CreateSubsites < ActiveRecord::Migration
  def change
    create_table :subsites do |t|
      t.references :user
      t.string :domain_name
      t.string :template_type
      t.string :contact_email
      t.string :invitees
      t.timestamps null: false
    end
  end
end
