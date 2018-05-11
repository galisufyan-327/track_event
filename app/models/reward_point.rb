# == Schema Information
#
# Table name: reward_points
#
#  id              :integer          not null, primary key
#  reward_type     :string           not null
#  points          :integer          default("0")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  company_id      :integer
#  company_user_id :integer
#  level           :integer
#
# Indexes
#
#  index_reward_points_on_company_user_id  (company_user_id)
#

class RewardPoint < ApplicationRecord
  belongs_to :company_user
  validates_uniqueness_of :reward_type, scope: [:company_user_id, :points]
end
