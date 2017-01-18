class AddUsernameToUsers < ActiveRecord::Migration[5.0]
  
  attr_accessor :username
  
  def change
    add_column :users, :username, :string
    add_index :users, :username, unique: true
  end
  
end
