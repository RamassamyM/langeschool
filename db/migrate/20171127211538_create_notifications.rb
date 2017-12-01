class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.text :notification_message, default: "Nouvelle notification"
      t.references :user, foreign_key: true
      t.boolean :is_seen, default: false, null: false
      t.references :notificable, polymorphic: true, index: true
      t.timestamps
    end
    add_index :notifications,
              %i[user_id notificable_id notificable_type],
              name: 'by_notificable_and_user',
              unique: true
  end
end
