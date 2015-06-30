class AddTargetTypeToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :target_type, :string
  end
end
