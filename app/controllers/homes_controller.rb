class HomesController < ApplicationController
  def index
    @show_link = true
    @buses = Bus.approved

    session[:name] = params[:name]
    session[:source_route] = params[:source_route]
    session[:destination_route] = params[:destination_route]

    if @buses.present?
      @buses = @buses.search(params[:source_route], params[:destination_route], params[:name])if params[:source_route].present? && params[:destination_route].present? || params[:name].present?
    elsif params[:source_route].present? && params[:destination_route].present? || params[:name].present?
      flash[:alert] = "Bus are not available in this route or this name"
    end
  end
end
