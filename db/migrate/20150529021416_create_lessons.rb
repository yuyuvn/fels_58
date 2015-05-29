class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.integer :correct_number
      
      t.belongs_to :user, index: true
      t.belongs_to :category, index: true

      t.timestamps null: false
    end
  end
end
