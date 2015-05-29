class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :target_id
      t.string :state
      
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
