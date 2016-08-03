class CreateAirlines < ActiveRecord::Migration
  def change
    create_table :airlines do |t|
      t.string :name
      t.string :icao
      t.string :iata
      t.references :airport
      t.timestamps null: false
    end
  end
end
