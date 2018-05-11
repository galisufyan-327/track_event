class CreateRewardPoints < ActiveRecord::Migration[5.0]
  def change
    create_table :reward_points do |t|
      t.string :reward_type, null: false
      t.integer :points, default: 0
      t.belongs_to :user, index: true, null: false
      t.timestamps
    end
  end
end
