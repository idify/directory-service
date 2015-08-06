class AddContactAddressToSubsites < ActiveRecord::Migration
  def change
    add_column :subsites,  :contact_address, :string
  end
end
