class AddGenderToPets < ActiveRecord::Migration[5.0]
  def change
    add_column :pets, :gender, :string
  end
end
