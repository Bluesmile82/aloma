class AvailabilitiesController < ApplicationController
before_action :set_flat

  def index
    @availabilities = @flat.availabilities
  end

  def new
    @availability = Availability.new

  end

  def create
    @availability = @flat.availabilities.build(availability_params)


    respond_to do |format|
      if @availability.save
        update_availabilities
        format.html { redirect_to flat_availabilities_path(@flat), notice: 'Availability was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  private
    def set_flat
      @flat = Flat.find(params[:flat_id])
    end

    def availability_params
      params.require(:availability).permit(:start_date, :end_date, :flat_id)
    end

    def update_availabilities
      @availability = Availability.last
      @flat.availabilities.each do |a|
      unless a == @availability
            if a.start_date > @availability.start_date && a.end_date < @availability.end_date
              a.destroy
            elsif a.start_date < @availability.start_date && a.end_date > @availability.start_date && a.end_date > @availability.end_date
              @availability.start_date = a.start_date
              @availability.end_date = a.end_date
              @availability.save
              a.destroy
            elsif a.start_date < @availability.start_date && a.end_date > @availability.start_date && a.end_date < @availability.end_date
              @availability.start_date = a.start_date
              @availability.save
              a.destroy
            elsif a.start_date > @availability.start_date && a.start_date < @availability.end_date && a.end_date > @availability.end_date
              @availability.end_date = a.end_date
              @availability.save
              a.destroy
            end
          end
        end
    end

end
