class AddLevelToRewardPoints < ActiveRecord::Migration[5.0]
  def change
    add_column :reward_points, :level, :integer
  end
end
