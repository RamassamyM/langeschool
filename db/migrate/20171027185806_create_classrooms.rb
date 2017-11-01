class CreateClassrooms < ActiveRecord::Migration[5.1]
  def change
    create_table :classrooms do |t|
      t.string :name
      t.string :teacher
      t.string :teacher_gender
      t.string :signin_code
      t.boolean :opened, default: true, null: false

      t.timestamps
    end
  end
end
