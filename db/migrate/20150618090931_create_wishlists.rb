class CreateWishlists < ActiveRecord::Migration
  def change
    create_table :wishlists do |t|
      t.string :name
      t.references :user
      t.integer :city_id
      t.string :category
      t.string :mobile_number, :email
      t.date :program_date
      t.text :wish_list
      t.timestamps null: false
    end
  end
end
