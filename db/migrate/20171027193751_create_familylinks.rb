class CreateFamilylinks < ActiveRecord::Migration[5.1]
  def change
    create_table :familylinks do |t|
      t.references :user, foreign_key: true
      t.references :child, foreign_key: true
      t.integer :parental_link
      t.timestamps
    end
  end
end
