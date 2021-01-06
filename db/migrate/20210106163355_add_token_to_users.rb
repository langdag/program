class AddTokenToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :token, :string
    add_column :users, :password, :string
    add_column :users, :password_digest, :string
  end
end