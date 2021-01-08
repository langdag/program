class AddBlockedToSubscriptions < ActiveRecord::Migration[6.1]
  def change
    add_column :subscriptions, :blocked, :boolean, default: false
  end
end