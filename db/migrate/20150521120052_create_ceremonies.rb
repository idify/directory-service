class CreateCeremonies < ActiveRecord::Migration
  def change
    create_table :ceremonies do |t|
      t.string :program
      t.date :date
      t.time :time
      t.string :venue
      t.references :user
      t.timestamps null: false
    end
  end
end
