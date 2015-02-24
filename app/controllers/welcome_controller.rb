class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @flats = Flat.all
  end
end
