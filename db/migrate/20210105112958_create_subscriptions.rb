class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.references :user, foreign_key: true
      t.references :partnership, foreign_key: true

      t.timestamps
    end
  end
end
