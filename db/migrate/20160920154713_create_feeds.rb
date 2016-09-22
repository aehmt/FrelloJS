class CreateFeeds < ActiveRecord::Migration[5.0]
  def change
    create_table :feeds do |t|
      t.string :action
      t.integer :card_id
      t.integer :list_id
      t.integer :user_id

      t.timestamps
    end
  end
end
