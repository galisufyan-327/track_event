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

class Event < ApplicationRecord
  # Dependencies
  include RewardConstants
  # ActiveRecord Associations
  belongs_to :company_user
  # ActiveRecord Callbacks
  after_commit  :check_for_reward, on: :create
  # Enums
  enum event_type: {created: 0, updated: 1, deleted: 2}
  # ActiveRecord::Validations
  validates :target_type, :event_type, :target_uuid, :company_user_id, presence: true
  validates_uniqueness_of :event_type, scope: [:target_type, :target_uuid]

  # scopes
  scope :not_deleted, -> {where(event_type: 0, deleted_at: nil)}

  def check_for_reward
    event = self
    event = Event.unscoped.where(target_type: target_type, target_uuid: target_uuid, event_type: 0).first if deleted?
    company_user = event.company_user
    record_count = company_user.try(:events).not_deleted.where(target_type: event.target_type, event_type: event.event_type, company_user_id: event.company_user_id).length
    reward_points = 0
    "Event::#{event.callback_constant}".constantize.try(:each) do |reward|
      if record_count > reward[:count] || record_count == reward[:count]
        reward_points += reward[:points]
      end
    end if event.class.const_defined?(event.callback_constant)
    company_user.award_points(type: event.display_event_type, points: reward_points )
  end

  def display_event_type
    "#{self.target_type}##{self.event_type}"
  end

  def callback_constant
    "#{self.target_type}_#{self.event_type.upcase}_REWARDS".upcase
  end
end
