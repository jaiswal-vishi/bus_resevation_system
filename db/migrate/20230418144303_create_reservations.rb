class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.integer :total_no_of_seats_booked
      t.integer :payment_status, default: 0
      t.datetime :reservation_date
      t.text :booked_seats, default: [].to_yaml
      t.text :available_seats, default: [].to_yaml
      t.references :bus, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
