class AddBoardIdToLists < ActiveRecord::Migration[5.0]
  def change
    add_column :lists, :board_id, :integer
  end
end
