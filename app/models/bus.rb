class Bus < ApplicationRecord
  serialize :booked_seats, Array
  serialize :available_seats, Array
  SOURCE = ['New Delhi', 'Lucknow', 'Kanpur', 'Haridwar', 'Varanasi', 'Prayagraj', 'Indore', 'Ayodhya']
  DESTINATION = ['New Delhi', 'Lucknow', 'Kanpur', 'Haridwar', 'Varanasi', 'Prayagraj', 'Indore', 'Ayodhya']

  attr_accessor :source, :destination
  enum status: [:pending, :approved, :rejected]

  before_save :strip_name_whitespace
  before_create :generate_available_seats

  has_many :reservations

  validates :name, presence: true
  validates :registration_no, presence: true
  validates :source_route, presence: true
  validates :destination_route, presence: true
  validates :no_of_seats, presence: true
  validates :status, presence: true

  scope :approved, -> { where(status: 'approved') }

  def self.search(source, destination, bus_name)
    if source&.present? && destination&.present? && bus_name.present? 
      where("source_route LIKE ? AND destination_route LIKE ? AND name LIKE?", "#{source}", "#{destination}", "#{bus_name}")
    elsif source.present? && destination.present?
      where("source_route LIKE ? AND destination_route LIKE ?", "#{source}", "#{destination}")
    else
      where("name LIKE?", "#{bus_name}")
    end
  end

  private

  def generate_available_seats
    seats = self.no_of_seats
    @available_seats = Array.new(seats) { |i| i + 1 }
    self.available_seats = @available_seats
  end

  def strip_name_whitespace
    self.name = name.strip
  end
end