class Reservation < ApplicationRecord
  serialize :booked_seats, Array
  serialize :available_seats, Array

  enum status: [:cash, :upi]
	belongs_to :user
	belongs_to :bus

	validates :reservation_date, presence: true
  validates :booked_seats, presence: true
end
