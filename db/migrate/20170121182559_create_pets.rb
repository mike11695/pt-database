class CreatePets < ActiveRecord::Migration[5.0]
  def change
    create_table :pets do |t|
      t.integer :user_id
      t.string :name
      t.string :color
      t.string :species
      t.integer :level
      t.integer :hp
      t.integer :strength
      t.integer :defence
      t.integer :movement
      t.integer :hsd
      t.boolean :uc
      t.boolean :rw
      t.boolean :rn
      t.boolean :verified
      t.string :description
      t.timestamps
    end
  end
end
