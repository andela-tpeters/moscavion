class CreateAirports < ActiveRecord::Migration
  def change
    create_table :airports do |t|
      t.string :name
      t.string :city
      t.string :country
      t.string :iata, null: true
      t.string :icao, null: true
      t.decimal :latitude
      t.decimal :longitude
      t.string :tz_db
      t.timestamps null: false
    end
  end
end
