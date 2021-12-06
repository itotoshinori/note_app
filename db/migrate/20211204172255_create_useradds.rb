class CreateUseradds < ActiveRecord::Migration[6.0]
  def change
    create_table :useradds do |t|
      t.string :twitter_tag
      t.integer :user_id

      t.timestamps
    end
  end
end
