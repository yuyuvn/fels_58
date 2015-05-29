class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :content
      t.string :audio
      
      t.belongs_to :category, index: true

      t.timestamps null: false
    end
  end
end
