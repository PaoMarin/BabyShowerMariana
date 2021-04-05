class FixScortGuestsTable < ActiveRecord::Migration[6.1]
  def change
    rename_column :scort_guests, :id_number, :id_scort
  end
end
