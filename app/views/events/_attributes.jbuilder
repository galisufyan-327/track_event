json.id event.id
json.type event.display_event_type
json.target_uuid event.target_uuid
json.triggered_at event.trigered_at
json.orignal_company_user_id event.company_user.try(:orignal_id)
json.company_user_id event.company_user_id
json.company_id event.company_id
