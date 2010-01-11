class AddIndexToCreatedAtOnArticles < ActiveRecord::Migration
  def self.up
    add_index :articles, :created_at
  end

  def self.down
    remove_index :articles, :created_at
  end
end
