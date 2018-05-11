class AddDeletedByAndDeletedAtColumnsToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :deleted_by, :integer
    add_column :events, :deleted_at, :datetime
  end
end
