class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :name, :email, :mobile, :city
      t.references :user
      t.timestamps null: false
    end
  end
end
