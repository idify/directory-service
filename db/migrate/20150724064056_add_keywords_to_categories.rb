class AddKeywordsToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :keywords, :string
  end
end
