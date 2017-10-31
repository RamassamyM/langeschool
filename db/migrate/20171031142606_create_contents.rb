class CreateContents < ActiveRecord::Migration[5.1]
  def change
    create_table :contents do |t|
      t.text :text
      t.string :location

      t.timestamps
    end
  end
end
