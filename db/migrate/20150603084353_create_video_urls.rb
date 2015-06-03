class CreateVideoUrls < ActiveRecord::Migration
  def change
    create_table :video_urls do |t|
      t.string :url
      t.references :user
      t.timestamps null: false
    end
  end
end
