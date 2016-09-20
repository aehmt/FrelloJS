class CreateCollaborations < ActiveRecord::Migration[5.0]
  def change
    create_table :collaborations do |t|
      t.integer :card_id
      t.integer :user_id

      t.timestamps
    end
  end
end
