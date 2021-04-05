class CreateGuestTable < ActiveRecord::Migration[6.1]
  def change
    create_table :guests do |t|
      t.string :fullname, null: true
      t.string :id_number, null: true
      t.string :email, null: true
      t.decimal :quantitypeople, null: true
      t.timestamps
    end
  end
end
