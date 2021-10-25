class AddDetailsToMemos < ActiveRecord::Migration[6.0]
  def change
    add_column :memos, :important, :boolean, default: false
    add_column :memos, :complete, :boolean, default: false
    add_column :memos, :twitter, :boolean, default: false
    add_column :memos, :public, :boolean, default: false
    add_column :memos, :user_id, :integer
    add_column :memos, :link, :string
  end
end
