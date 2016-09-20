class CreateBoards < ActiveRecord::Migration[5.0]
  def change
    create_table :boards do |t|
      t.string :name
      t.string :color, default: "teal"
      t.integer :user_id
      t.boolean :private,  default: true
      t.boolean :starred,  default: false

      t.timestamps
    end
  end
end
