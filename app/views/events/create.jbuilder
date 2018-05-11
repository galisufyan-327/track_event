json.partial! 'company_users/member', company_user: current_company_user
json.partial! 'events/member', event: @event
json.event_count  @event_count
if @event_deleted
  json.effected_user do
    json.partial! 'company_users/member', company_user: @creator
    json.partial! 'events/member', event: @event
  end
end