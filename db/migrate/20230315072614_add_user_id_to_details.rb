class AddUserIdToDetails < ActiveRecord::Migration[7.0]
  def change
    add_column :details, :user_id, :integer
    add_index :details, :user_id
  end
end
