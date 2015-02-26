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
        format.html { redirect_to owner_flat_path(@flat), notice: 'Availability was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def self.remove_booked(startdate, enddate, flat)
    flat.availabilities.each do |a|
      if startdate >= a.start_date && enddate <= a.end_date
        if startdate != a.start_date
          Availability.create(flat_id: a.flat_id, start_date: a.start_date, end_date: startdate -1)
        end
        if enddate != a.end_date
          a.start_date = enddate + 1
          a.save
        else
          a.destroy
        end
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
        # if the db availability is contained in the new date
            if a.start_date >= @availability.start_date && a.end_date <= @availability.end_date
              a.destroy
              # the new date is contained in the DB
            elsif a.start_date <= @availability.start_date && a.end_date > @availability.start_date && a.end_date >= @availability.end_date
              @availability.start_date = a.start_date
              @availability.end_date = a.end_date
              @availability.save
              a.destroy
              # "décalé" the new one is "overlapping" later than the DB with some dates in common
            elsif a.start_date < @availability.start_date && a.end_date >= @availability.start_date && a.end_date < @availability.end_date
              @availability.start_date = a.start_date
              @availability.save
              a.destroy
              # "décalé" but new one is before the Db with dates in common
            elsif a.start_date > @availability.start_date && a.start_date <= @availability.end_date && a.end_date > @availability.end_date
              @availability.end_date = a.end_date
              @availability.save
              a.destroy
            end
          end
        end
    end

end
