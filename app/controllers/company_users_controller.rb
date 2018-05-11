class CompanyUsersController < ApplicationController
  skip_before_action :authenticate_company_user, only: [:create]

  before_action :set_company_user, only: [:show, :update, :destroy]

  # GET /company_users
  def index
    @company_users = CompanyUser.all
    json_response(@company_users)
  end

  # POST /company_users
  def create
    @company_user = CompanyUser.create!(user_params)
    render :create
  end

  # GET /company_users/:id
  def show
    json_response(@company_user)
  end

  # PUT /company_users/:id
  def update
    @company_user.update(user_params)
    head :no_content
  end

  # DELETE /company_users/:id
  def destroy
    @company_user.destroy
    head :no_content
  end

  private

  def user_params
    # whitelist params
    params.permit(:orignal_id, :company_id, :guid, :email)
  end

  def set_company_user
    @company_user = CompanyUser.find_by(orignal_id: params[:id])
  end
end
