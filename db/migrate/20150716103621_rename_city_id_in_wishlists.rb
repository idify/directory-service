class RenameCityIdInWishlists < ActiveRecord::Migration
  def change
    rename_column :wishlists, :city_id, :city
  end
end
