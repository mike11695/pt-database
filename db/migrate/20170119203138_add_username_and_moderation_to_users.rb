class AddUsernameAndModerationToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :username, :string
    add_index :users, :username, unique: true
    add_column :users, :moderator, :boolean, default: false
  end
end
