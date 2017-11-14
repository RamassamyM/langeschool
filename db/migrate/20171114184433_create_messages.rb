class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :content
      t.references :conversation, foreign_key: true
      t.references :author, references: :users, index: true
      t.boolean :is_read, default: false, null: false

      t.timestamps
    end
  end
end
