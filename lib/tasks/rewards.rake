namespace :rewards do
  desc "Update rewards for all company users"
  task update: :environment do

    # We're going to create hash with count to points for easy lookup
    scorecard = {}
    Event::TARGET_TYPES.each do |target_type|
      callback_constant = "#{target_type}_created_rewards".upcase
      scorecard[target_type] = {}
      "Event::#{callback_constant}".constantize.try(:each) do |reward|
        scorecard[target_type][reward[:count]] = reward[:points]
      end
    end

    CompanyUser.where.not(company_users: {granted_access_at: nil}).each do |company_user|
      company_user.reward_points.destroy_all
      counts = {}
      company_user.events.order(:created_at).where(event_type: Event.event_types[:created]).find_each do |event|
        counts[event.target_type] ||= 0
        counts[event.target_type] += 1
        count = counts[event.target_type]
        if scorecard[event.target_type][count]
          reward_point = company_user.reward_points.create!(company_user: company_user, company_id: company_user.company_id, points: scorecard[event.target_type][count], reward_type: "#{event.target_type}#created")
          reward_point.update_attribute(:created_at, event.created_at)
        end
      end
    end
  end
end
