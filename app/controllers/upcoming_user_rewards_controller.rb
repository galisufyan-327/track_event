class UpcomingUserRewardsController < AuthenticatedController

  def index
    render json: upcoming_rewards
  end

  private

  def upcoming_rewards
    upcoming_rewards = []
    Event::TEMP_REWARD_COUNTS.each do |target_type|
      target_type[:count] = current_company_user.try(:events).not_deleted.where(event_type: 0, target_type: target_type[:key]).count
      callback_constant = "#{target_type[:key]}_created_rewards".upcase
      added_reward = false
      "Event::#{callback_constant}".constantize.try(:each) do |reward|
        if target_type[:count] < reward[:count]
          added_reward = true
          upcoming_rewards << { xp_can_get: reward[:points],
                                amount_needed: reward[:count] - target_type[:count],
                                type: target_type[:key].gsub('ManagedAsset', 'asset').gsub('CompanyUser', 'staff member').underscore.split('_').join(' ') }
          break
        end
      end
      if !added_reward
        upcoming_rewards << { xp_can_get: 0,
                              amount_needed: 0,
                              type: target_type[:key].gsub('ManagedAsset', 'asset').gsub('CompanyUser', 'staff member').underscore.split('_').join(' ') }
      end
    end
    upcoming_rewards
  end

end
