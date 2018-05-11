class ChangeUserReferenceToCompanyUserInModels < ActiveRecord::Migration[5.0]
  def change
    remove_reference :events, :user
    remove_reference :reward_points, :user

    add_reference :events, :company_user, index: true
    add_reference :reward_points, :company_user, index: true
  end
end
