class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.integer :company_id
      t.string :target_type
      t.string :target_uuid
      t.integer :event_type
      t.belongs_to :user, index: true
      t.datetime :trigered_at
      t.timestamps
    end
  end
end
