class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.integer :orignal_id,              null: false
      t.integer :company_id
      t.string :guid,                     null: false
      t.string :email,                    null: false, default: ""

      t.timestamps
    end
    add_index :users, :guid,              unique: true
  end
end
