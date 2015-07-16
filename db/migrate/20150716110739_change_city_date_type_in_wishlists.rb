class ChangeCityDateTypeInWishlists < ActiveRecord::Migration
  def change
    change_column :wishlists, :city, :string
  end
end