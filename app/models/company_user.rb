# == Schema Information
#
# Table name: company_users
#
#  id         :integer          not null, primary key
#  orignal_id :integer          not null
#  company_id :integer
#  guid       :string           not null
#  email      :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  level      :integer          default("0")
#
# Indexes
#
#  index_company_users_on_guid  (guid) UNIQUE
#

class CompanyUser < ApplicationRecord
  # Dependencies

  # ActiveRecord Associations
  has_many :events
  has_many :reward_points

  # Constants
  COMPANY_USER_LEVEL_SCORE_COUNTER = [
          {level: 0, points: 0, discount: 0, name: "Intern"},
          {level: 1, points: 1000, discount: 5, name: "Tech Nerd"},
          {level: 2, points: 3000, discount: 10, name: "Computer Wizard"},
          {level: 3, points: 8000, discount: 15, name: "Super Geek"},
          {level: 4, points: 17500, discount: 20, name: "IT Hero"}
        ]

  def award_points(type:, points:)
    reward_point = self.reward_points.find_or_initialize_by(reward_type: type)
    reward_point.points = points
    reward_point.save!
    check_level
  end

  def total_reward_points
    reward_points.sum(:points)
  end

  private
    def check_level
      company_user = self
      CompanyUser::COMPANY_USER_LEVEL_SCORE_COUNTER.each do |lvl|
        if company_user.total_reward_points >= lvl[:points]
          company_user.level = lvl[:level]
        end
      end
      company_user.save!
    end
end
