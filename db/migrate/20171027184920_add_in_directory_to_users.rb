class AddInDirectoryToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :in_directory, :boolean, default: true, null: false
  end
end
