class ChangeDateFormatInLists < ActiveRecord::Migration[5.0]
  def change
    change_column :lists, :duedate, :datetime
  end
end
