class AddApiKeyToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :api_key, :string
    add_index :users, :mail, :unique => true
    add_index :users, :api_key, :unique => true
  end

  def self.down
    remove_index :users, :mail
    remove_index :users, :api_key
    remove_column :users, :api_key
  end
end
