class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :duration
      t.float :fee

      t.timestamps
    end
  end
end
