class CreateReportForm < ActiveRecord::Migration[5.0]
  def change
    create_table :report_forms do |t|
      t.string :name
      t.string :issue
      t.text :body
      t.references :user, index: true
      t.timestamps
    end
  end
end
