class AddDuedateToLists < ActiveRecord::Migration[5.0]
  def change
    add_column :lists, :duedate, :date
  end
end
