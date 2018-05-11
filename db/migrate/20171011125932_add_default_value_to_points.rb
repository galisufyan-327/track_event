class AddDefaultValueToPoints < ActiveRecord::Migration[5.0]
  def change
    change_column :reward_points, :points, :integer, default: 0
  end
end
