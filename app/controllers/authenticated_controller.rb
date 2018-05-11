class AuthenticatedController < ApplicationController
  before_action :check_current_company_user_presence

  protected

  def check_current_company_user_presence
    return ActiveRecord::RecordNotFound unless current_company_user.present?
  end

end