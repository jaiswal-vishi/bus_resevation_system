class ReservationsController < ApplicationController
  before_action :authenticate_bus_owner!, only: [:index, :new, :destroy]
  before_action :authenticate_user!

  def new
  end
  
  def index
    @reservations = Reservation.includes(:bus, :user).all.order(reservation_date: :desc)
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      respond_to do |format|
        format.html # renders index.html.erb
        format.json { render json: { success: true } } # renders JSON format
      end
    else
      render json: { success: false }
    end
  end

  def show
    @reservation = Reservation.find(params[:id]).order(reservation_date: :desc)
  end

  def user_reservations
    reservations = Reservation.where(user_id: params[:id])
    @reservations = reservations.includes(:bus, :user).all
    render 'user_reservations'
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to reservations_path, notice: "Reservation cancelled successfully."
  end

  def cancel_reservation
    @reservation = Reservation.find(params[:reservation_id])
    @reservation.destroy
    redirect_to "/#{params[:id]}/reservations", notice: "Reservation cancelled successfully."
  end

  private

  def reservation_params
    params.require(:reservation).permit(:user_id, :bus_id, :reservation_date, :available_seats => [], :booked_seats => [])
  end
end
