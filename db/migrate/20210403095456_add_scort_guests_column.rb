class AddScortGuestsColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :scort_guests, :confirmation, :boolean, default: false
  end
end
