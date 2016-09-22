class AddCheckedToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :checked, :boolean, default: false
  end
end
