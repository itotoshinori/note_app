class AddTwitterTagToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :twitter_tag, :string
  end
end
