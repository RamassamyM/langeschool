class AddColumnToNotification < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :picture_url, :string
  end
end
