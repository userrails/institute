class RemoveColumnsFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :confirmation_token
    remove_column :users, :confirmed_at
    remove_column :users, :confirmation_sent_at
    remove_column :users, :unconfirmed_email
    remove_index :users, :confirmation_token
  end

  def down
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email , :string
    add_index :users, :confirmation_token, :unique => true
  end
end
