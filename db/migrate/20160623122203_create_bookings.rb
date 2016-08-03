class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.references :flight
      t.references :user
      t.decimal :price, precision: 8, scale: 2
      t.string :booking_code

      t.timestamps null: false
    end
  end
end
