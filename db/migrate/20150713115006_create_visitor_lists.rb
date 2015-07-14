class CreateVisitorLists < ActiveRecord::Migration
  def change
    create_table :visitor_lists do |t|
      t.string :mobile_number
      t.boolean :is_otp_confirmed, default: false
      t.timestamps null: false
    end
  end
end
