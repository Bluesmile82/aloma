class PicturesController < ApplicationController

  before_action :find_flat, only: [ :new, :create, :destroy ]

  def new
    @picture = @flat.pictures.new
  end

  def create

    @picture = @flat.pictures.last.build(picture_params)
    @picture.save
    redirect_to owner_flat_path
  end

  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    redirect_to owner_flat_path(@flat)
  end

  private

  def picture_params
    params.require(:picture).permit(:image)
  end

  def find_flat
    @flat = Flat.find(params[:flat_id])
  end

end