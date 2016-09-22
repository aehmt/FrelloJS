class AddBoardIdToFeeds < ActiveRecord::Migration[5.0]
  def change
    add_column :feeds, :board_id, :integer
  end
end
