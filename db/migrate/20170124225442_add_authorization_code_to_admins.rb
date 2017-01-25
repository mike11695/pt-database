class AddAuthorizationCodeToAdmins < ActiveRecord::Migration[5.0]
  def change
    add_column :admins, :authorization, :string
  end
end
