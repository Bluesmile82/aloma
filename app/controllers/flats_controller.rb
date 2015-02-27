class FlatsController < ApplicationController
  before_action :set_flat, only: [:show, :edit, :update, :destroy, :show_owner_flat]

  def index_owner_flats
    @flats = current_user.flats

  end

  def show_owner_flat
    @user = current_user
    @flat = current_user.flats.find(params[:id])
  end

  def index
    if params['search']
      @flats = Flat.all.where("city = ?", params['search']['city'])
      if params['search']['advanced'] == true
        @flats = @flats.select do |flat|
          available?(flat, params)
        end
      end
      redirect_to :root, notice: 'That city has no haunted houses, try again' if @flats.empty?
    else
      @flats = Flat.all
    end
  end

  def search

  end

  def show
  end

  def new
    @flat = Flat.new
  end

  def edit
    @flat.pictures.new
  end

  def create
    @flat = current_user.flats.build(flat_params)


      if @flat.save
       redirect_to owner_flats_path, notice: 'Flat was successfully created.'
      else
       render :new
      end

  end

  def update
    # if  params[:flat][:pictures_attributes].nil?
    # end
      if @flat.update(flat_params)
        redirect_to owner_flat_path, notice: 'Flat was successfully updated.'
      else
        render :edit
      end

  end

  def destroy
    @flat.destroy
      redirect_to owner_flats_path, notice: 'Flat was successfully destroyed.'
  end

  private

    def set_flat
      @flat = Flat.find(params[:id])
    end


    def flat_params
      params.require(:flat).permit(:name, :description, :price, :street, :city, :country, :zipcode, :user_id, pictures_attributes: [:image])
    end

    def available?(flat, params)
        my_start_date = Date.new(params['search']['start_date(1i)'].to_i, params['search']['start_date(2i)'].to_i, params['search']['start_date(3i)'].to_i)
        my_end_date = Date.new(params['search']['start_date(1i)'].to_i, params['search']['start_date(2i)'].to_i, params['search']['start_date(3i)'].to_i)
      flat.availabilities.each do |availability|
          return true if my_start_date >= availability.start_date && my_end_date <= availability.end_date
      end
      return false
    end
end
