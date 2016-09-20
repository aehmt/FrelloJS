class AddBoardIdToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :board_id, :integer
  end
end
