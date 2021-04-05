class ChangeColumnScortGuests < ActiveRecord::Migration[6.1]
  def change
    #change_column :scort_guests, :confirmation, 'integer USING CAST(confirmation AS integer)', null: false, default: 0
    remove_column :scort_guests, :confirmation, :boolean
    add_column :scort_guests, :confirmation, :integer
  end
end
