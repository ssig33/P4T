class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :comments
      t.string :url
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
