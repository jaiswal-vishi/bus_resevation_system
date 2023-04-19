class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @bus = Bus.find(params[:bus_id])
  end

  # def create
  # 	debugger
  #   @user = current_user
  #   @bus = Bus.find(params[:bus_id])
  #   @reservation = @user.reservations.create!(bus: @bus, reservation_date: Date.today)
  #   redirect_to reservation_path(@reservation)
  # end

  # def destroy
  #   reservation = current_user.reservations.find(params[:id])
  #   reservation.destroy

  #   flash[:notice] = "Reservation cancelled successfully."
  #   redirect_to reservations_path
  # end

  

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

  private

  def reservation_params
    params.require(:reservation).permit(:user_id, :bus_id)
  end
end
