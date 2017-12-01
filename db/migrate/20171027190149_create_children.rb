class CreateChildren < ActiveRecord::Migration[5.1]
  def change
    create_table :children do |t|
      t.string :first_name
      t.string :last_name
      t.references :classroom, foreign_key: true

      t.timestamps
    end
    add_index :children, %i[first_name last_name], unique: true
  end
end
