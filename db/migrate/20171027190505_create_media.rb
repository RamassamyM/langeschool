class CreateMedia < ActiveRecord::Migration[5.1]
  def change
    create_table :media do |t|
      t.string :url
      t.string :type
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
