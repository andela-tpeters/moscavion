class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
    	t.datetime 'departure_date', index: true
    	t.string 'from', index: true
    	t.string 'to', index: true
    	
      t.timestamps null: false
    end
    add_reference :flights, :airports, index: true
  end
end
