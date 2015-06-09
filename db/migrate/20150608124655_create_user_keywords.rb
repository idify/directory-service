class CreateUserKeywords < ActiveRecord::Migration
  def change
    create_table :user_keywords do |t|
      t.references :user
      t.string :keyword
      t.timestamps null: false
    end
  end
end
