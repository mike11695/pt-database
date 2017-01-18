class AddModeratorToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :moderator, :boolean
  end
end
