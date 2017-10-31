class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :content
      t.references :author, references: :users, index: true
      t.references :recipient, references: :users, index: true

      t.timestamps
    end
  end
end
