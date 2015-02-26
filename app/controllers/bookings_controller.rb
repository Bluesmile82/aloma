class BookingsController < ApplicationController
before_action :find_flat

  def new
  end

  def create
    @booking = @flat.bookings.build(booking_params)
    @booking.user = current_user
    if @booking.save
      # notice: 'Flat was successfully created.'
    else
      render :new
    end
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
