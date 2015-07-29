class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.string :name
      t.string :email
      t.text :comment
      t.float :score
      t.references :category
      t.timestamps null: false
    end
  end
end