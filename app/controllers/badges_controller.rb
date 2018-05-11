class BadgesController < ApplicationController

  def index
    render json: set_badges_data
  end


  private
    def set_badges_data
      badges_data = {}
      Event::TARGET_TYPES.each do |target|
        single_target_badges = []
        callback_constant = "#{target}_CREATED_REWARDS".upcase
        "Event::#{callback_constant}".constantize.try(:each) do |reward|
          single_target_badges << reward[:count] 
        end
        badges_data[target.gsub('ManagedAsset', 'asset').gsub('CompanyUser', 'staff member').underscore.split('_').join(' ') ] = single_target_badges
      end
      badges_data.as_json
    end

end
