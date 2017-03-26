class AddNeoUsernameToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :neoname, :string
  end
end
