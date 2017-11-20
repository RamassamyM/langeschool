class CreateConversations < ActiveRecord::Migration[5.1]
  def change
    create_table :conversations do |t|
      t.references :user1, references: :users, index: true
      t.references :user2, references: :users, index: true
      t.datetime :last_update
      t.timestamps
    end
    add_index :conversations, [:user1_id, :user2_id], unique: true
  end
end
