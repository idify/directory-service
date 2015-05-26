class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, :category_type, :service_area, :email, :address, :mobile
      t.integer :no_of_employees, :min_price, :max_price
      t.text :description
      t.timestamps null: false
    end
  end
end
