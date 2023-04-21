class Reservation < ApplicationRecord
  serialize :booked_seats, Array
  serialize :available_seats, Array

  enum status: [:cash, :upi]
	belongs_to :user
	belongs_to :bus

  before_save :update_available_seats
  before_destroy :update_new_available_seats

  private

  def update_available_seats

    # Get the selected seats from the booked_seats attribute
    selected_seats = self.booked_seats.map(&:to_i)

    # Get the current available seats of the bus
    available_seats = self.bus.available_seats

    # Remove the selected seats from the available seats
    available_seats = available_seats - selected_seats

    # Update the available seats of the bus
    (self.bus.booked_seats += selected_seats.flatten).sort
    # self.bus.update(booked_seats: selected_seats)

    # Update the available seats of the bus
    self.bus.update(available_seats: available_seats)
  end

  def update_new_available_seats

    # Get the selected seats from the booked_seats attribute
    selected_seats = self.booked_seats.map(&:to_i)

    # Get the current available seats of the bus
    available_seats = self.bus.available_seats

    # Remove the selected seats from the available seats
    available_seats = available_seats + selected_seats
    available_seats = available_seats.sort!

    # Remove the selected seats from the booked seats
    (self.bus.booked_seats -= selected_seats.flatten).sort

    # Update the available seats of the bus
    self.bus.update(available_seats: available_seats)
  end

	# validates :reservation_date, presence: true
  # validates :no_of_seats, presence: true, numericality: { greater_than: 0 }

  # validate :available_seats

  # def available_seats
  #   if bus.reservations.where(reservation_date: reservation_date).sum(:no_of_seats) + no_of_seats > bus.no_of_seats
  #     errors.add(:no_of_seats, "is not available")
  #   end
  # end
end
