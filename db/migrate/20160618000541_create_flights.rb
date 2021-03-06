class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.datetime    :departure_date, index: true
      t.datetime    :arrival_date
      t.references  :airport
      t.references  :airline
      t.integer     :flight_number, unique: true
      t.string      :departure_location, index: true
      t.string      :arrival_location, index: true
      t.decimal     :price, precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
