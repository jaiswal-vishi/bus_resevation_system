class Reservation < ApplicationRecord
	serialize :booked_seats, Array
  serialize :available_seats, Array

  enum status: [:cash, :upi]
	belongs_to :user
	belongs_to :bus

	# validates :reservation_date, presence: true
  # validates :no_of_seats, presence: true, numericality: { greater_than: 0 }

  # validate :available_seats

  # def available_seats
  #   if bus.reservations.where(reservation_date: reservation_date).sum(:no_of_seats) + no_of_seats > bus.no_of_seats
  #     errors.add(:no_of_seats, "is not available")
  #   end
  # end
end
