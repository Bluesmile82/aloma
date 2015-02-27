class FlatsController < ApplicationController
  before_action :set_flat, only: [:show, :edit, :update, :destroy, :show_owner_flat]

  def index_owner_flats
    @flats = current_user.flats

  end

  def show_owner_flat
    @flat = current_user.flats.find(params[:id])
  end

  def index
    @flats = Flat.all
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


    respond_to do |format|
      if @flat.save
        format.html { redirect_to owner_flat_path(user_id:current_user.id, id:@flat.id), notice: 'Space was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @flat.update(flat_params)
        format.html { redirect_to @flat, notice: 'Space was successfully updated.' }
        format.json { render :show, status: :ok, location: @flat }
      else
        format.html { render :edit }
        format.json { render json: @flat.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @flat.destroy
    respond_to do |format|
      format.html { redirect_to flats_url, notice: 'Flat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_flat
      @flat = Flat.find(params[:id])
    end


    def flat_params
      params.require(:flat).permit(:name, :description, :price, :street, :city, :country, :zipcode, :user_id, pictures_attributes: [:image])
    end
end
