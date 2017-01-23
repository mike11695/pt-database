class AddUftUfaFieldsToPets < ActiveRecord::Migration[5.0]
  def change
    add_column :pets, :uft, :boolean
    add_column :pets, :ufa, :boolean
  end
end
