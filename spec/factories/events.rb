# == Schema Information
#
# Table name: events
#
#  id              :integer          not null, primary key
#  company_id      :integer
#  target_type     :string
#  target_uuid     :string
#  event_type      :integer
#  trigered_at     :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  company_user_id :integer
#  deleted_by      :integer
#  deleted_at      :datetime
#
# Indexes
#
#  index_events_on_company_user_id  (company_user_id)
#

FactoryGirl.define do
  factory :event do
    target_type "contract"
    target_uuid "3"
    event_type "created"
    trigered_at ""
    company_id ""
    user_id "1"
  end
end
