class RenameUserToCompanyUser < ActiveRecord::Migration[5.0]
  def change
    rename_table :users, :company_users
  end 
end
