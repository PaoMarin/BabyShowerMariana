class CreateScortGuestsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :scort_guests do |t|
      t.string :fullname, null: true
      t.string :id_number, null: true
      t.belongs_to :guest, index: true
      t.timestamps
    end
  end
end
