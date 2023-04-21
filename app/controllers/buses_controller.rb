class BusesController < ApplicationController
  before_action :authenticate_bus_owner!, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :authenticate_user!, only:[:show]
  before_action :set_bus, only: [:edit, :update, :destroy]

  def index
    @buses = current_user.buses
  end

  def new
    @bus = Bus.new
  end

  def create
    @bus = Bus.new(bus_params)
    @bus.bus_owner_id = current_user.id

    if @bus.save
      redirect_to buses_path
    else
      render :new
    end
  end


  def show
    @bus = Bus.find(params[:id])
  end

  def update_show
    @bus = Bus.find(params[:id])
    # Get the selected date from the form
    selected_date = params[:reservation_date]
    bus_id = params[:id]

    # Update the data for the selected date
    @booked_seats = @bus.reservations.where(reservation_date: selected_date, bus_id: bus_id).pluck(:booked_seats).flatten.map(&:to_i)
    @available_seats = @bus.available_seats - @booked_seats
  end


  def edit
  end

  def update
    if @bus.update(bus_params)
      redirect_to buses_path
    else
      render :edit
    end
  end

  def destroy
    @bus.destroy
    redirect_to buses_path
  end

  private

  def set_bus
    @bus = current_user.buses.find(params[:id])
  end


  def bus_params
    params.require(:bus).permit(:name, :registration_no, :source_route, :destination_route, :fare, :status, :no_of_seats, :bus_owner_id, { booked_seats: [] }, {available_seats: []})
  end
end