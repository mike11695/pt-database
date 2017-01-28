class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.string :name
      t.string :issue
      t.text :body
      t.references :user, index: true
      t.timestamps
    end
  end
end
