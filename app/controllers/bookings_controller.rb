class BookingsController < ApplicationController
before_action :find_flat

  def new
  end

  def create
    @booking = Booking.create(booking_params)
  end

  def index
  end

  def show
  end

  private

  def find_flat
    @flat = Flat.find(params[:flat_id])
  end

  def booking_params
    params.require(:booking).permit(:flat_id, :user_id, :start_date, :end_date )
  end
end
