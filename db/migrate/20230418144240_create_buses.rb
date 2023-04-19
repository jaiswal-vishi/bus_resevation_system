class CreateBuses < ActiveRecord::Migration[7.0]
  def change
    create_table :buses do |t|
      t.string :name
      t.string :source_route
      t.string :destination_route
      t.integer :registration_no
      t.integer :no_of_seats
      t.text :booked_seats, default: [].to_yaml
      t.text :available_seats, default: [].to_yaml
      t.integer :fare
      t.integer :status, default: 0
      t.integer :bus_owner_id, null: false, foreign_key: true
      t.timestamps
    end
  end
end
