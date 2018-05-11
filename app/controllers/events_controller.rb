class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]
  before_action :update_effected_user_event, only: [:create]
  # GET /events
  def index
    @events = current_company_user.events
    render :index
  end

  # POST /events
  def create
    @event = current_company_user.events.where(target_type: params[:target_type], target_uuid: params[:target_uuid], event_type: params[:event_type], company_user_id: current_company_user.id)
    if @event.any?
      data = {error: true, message: "#{params[:target_type]} with type #{params[:event_type]} already exists"}
      render json: data
    else
      @event = current_company_user.events.create_with(event_params).find_or_create_by(
                                                    target_type: params[:target_type],
                                                    target_uuid: params[:target_uuid],
                                                    event_type: params[:event_type],
                                                    company_user_id: current_company_user.id)
      
      @event_count = current_company_user.events.where( target_type: params[:target_type],
                                                        event_type: params[:event_type],
                                                        company_user_id: current_company_user.id).count
      if @event.event_type === "deleted"
        @event_deleted = Event.where(target_type: params[:target_type], target_uuid: params[:target_uuid], event_type: 0).first
        @creator = @event_deleted.company_user
      end        
      render :create
    end
  end

  # GET /events/:id
  def show
    json_response(@event)
  end

  # PUT or PATCH /events/:id
  def update
    @event.update(event_params)
    head :no_content
  end

  # DELETE /events/:id
  def destroy
    @event.destroy
    head :no_content
  end

  private

  def event_params
    # whitelist params
    params.permit(:title, :target_type, :target_uuid, :event_type, :trigered_at, :company_id, :company_user_id)
  end

  def set_event
    @event = current_company_user.events.find(params[:id])
  end

  def update_effected_user_event
    if params[:event_type] === "deleted"
      event = Event.where(target_type: params[:target_type], target_uuid: params[:target_uuid], event_type: 0).first
      event.update(deleted_by: params[:company_user_id], deleted_at: Time.now)
    end
  end
end
