class AddAdminIdToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :admin_id, :integer
  end
end
