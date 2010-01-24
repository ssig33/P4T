class ChangeCommentToText < ActiveRecord::Migration
  def self.up
    change_column :articles, :comments, :text
  end

  def self.down
    change_column :articles, :comments, :string
  end
end
