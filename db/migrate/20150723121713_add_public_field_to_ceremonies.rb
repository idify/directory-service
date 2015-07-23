class AddPublicFieldToCeremonies < ActiveRecord::Migration
  def change
    add_column :ceremonies, :public, :boolean
  end
end
