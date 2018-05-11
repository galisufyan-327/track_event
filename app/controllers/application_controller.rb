class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  # include JsonWebToken

  before_action :authenticate_company_user

  helper_method :current_company_user

  def authenticate_company_user
    begin
      @company_user_id ||= JsonWebToken.decode(params[:token])
    rescue => e
      raise 'Access Denied ActionController::InvalidAuthenticityToken'
    end
  end

  def current_company_user
    @current_company_user ||= CompanyUser.find_by(orignal_id: authenticate_company_user)
  end
end
