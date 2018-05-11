class UserRewardsHistoryController < AuthenticatedController

  def index
    render json: reward_history
  end

  private
    def reward_history
      # history for only created event types
      history = []
      event_counts = current_company_user.events.not_deleted.where(event_type: 0).group(:target_type).count
      event_counts.each do |key, value|
        reward_type = "#{key}#created"
        points = current_company_user.reward_points.where(reward_type: reward_type).sum(:points)
        #just passing the events that added points in reward points
        if points > 0
          history << { xp_earned: points,
                       quantity_added: value,
                       type: key.gsub('ManagedAsset', 'asset').gsub('CompanyUser', 'staff member').underscore.split('_').join(' ') }
        end
      end
      history
    end

end
