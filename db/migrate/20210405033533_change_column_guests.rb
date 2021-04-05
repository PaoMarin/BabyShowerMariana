class ChangeColumnGuests < ActiveRecord::Migration[6.1]
  def change
    remove_column :guests, :confirmation, :boolean
   add_column :guests, :confirmation, :integer
   #change_column :guests, :confirmation, 'integer USING CAST(confirmation AS integer)', null: false, default: 0

  end
end
