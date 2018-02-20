class AddNotifyUserIdToTalks < ActiveRecord::Migration[5.0]
  def change
    add_column :talks, :notify_user_id, :integer
  end
end
