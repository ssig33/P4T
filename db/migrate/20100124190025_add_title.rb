class AddTitle < ActiveRecord::Migration
  def self.up
    rename_column :articles, :comments, :title
    add_column :articles, :comments, :string
  end

  def self.down
    remove_column :articles, :comments
    rename_column :articles, :title, :comments
  end
end
