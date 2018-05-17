class HomeController < ApplicationController
  def index
    @gardens = Garden.all
    @fidjis = Fidji.all
  end
end
