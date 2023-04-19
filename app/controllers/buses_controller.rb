class BusesController < ApplicationController
  before_action :authenticate_bus_owner!, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :set_bus, only: [:edit, :update, :destroy]

  def index
    @home_show_link = true
    @buses = current_user.buses
  end

  def new
    @home_show_link = true
    @bus = Bus.new
  end

  def create
    debugger
    @bus = Bus.new(bus_params)
    @bus.bus_owner_id = current_user.id

    if @bus.save
      redirect_to buses_path
    else
      render :new
    end
  end

  # def create
  #   @bus = current_user.buses.build(bus_params)

  #   if @bus.save
  #     redirect_to @bus
  #   else
  #     render :new
  #   end
  # end



  def show
    @bus = Bus.find(params[:id])
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

  def authenticate_bus_owner!
    unless current_user && current_user.bus_owner?
      redirect_to root_path, alert: "You don't have permission to access this page"
    end
  end

  def set_bus
    @bus = current_user.buses.find(params[:id])
  end


  def bus_params
    params.require(:bus).permit(:name, :registration_no, :source_route, :destination_route, :fare, :status, :no_of_seats, :bus_owner_id, { booked_seats: [] }, {available_seats: []})
  end
end