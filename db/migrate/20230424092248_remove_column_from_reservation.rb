class RemoveColumnFromReservation < ActiveRecord::Migration[7.0]
  def change
    remove_column :reservations, :total_no_of_seats_booked, :integer
    remove_column :reservations, :available_seats, :text
  end
end
