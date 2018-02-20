class AddNotifyUsersToChannels < ActiveRecord::Migration[5.0]
  def change
    add_column :channels, :notify_users, :json, default: []
  end
end
