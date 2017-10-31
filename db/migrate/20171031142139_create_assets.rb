class CreateAssets < ActiveRecord::Migration[5.1]
  def change
    create_table :assets do |t|
      t.string :url
      t.string :asset_type
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
