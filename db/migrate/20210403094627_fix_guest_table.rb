class FixGuestTable < ActiveRecord::Migration[6.1]
  def change
    rename_column :guests, :id_number, :id_guest
    add_column :guests, :confirmation, :boolean, default: false
  end
end
