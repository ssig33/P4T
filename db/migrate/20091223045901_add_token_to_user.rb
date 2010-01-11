class AddTokenToUser < ActiveRecord::Migration
  def self.up
    add_index :users, :screen_name, :unique => true
    add_column :users, :access_token, :string
    add_column :users, :access_token_secret, :string
    add_column :users, :password, :string
  end

  def self.down
    remove_index :users, :screen_name
    remove_column :users, :access_token
    remove_column :users, :access_token_secret
    remove_column :users, :password
  end
end
