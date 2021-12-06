class CreateInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :infos do |t|
      t.string :twitter_tag
      t.integer :user_id

      t.timestamps
    end
  end
end
