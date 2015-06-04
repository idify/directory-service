class AddMapLocationFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :categories, :latitude, :string
    add_column :categories, :longitude, :string
  end
end
