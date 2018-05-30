class NurseriesController < ApplicationController
  before_action :set_garden, only: [:show]
  before_action :set_nursery, only: [:show]
  
  def show
    
  end

  def set_garden
    @garden = Garden.find(params[:garden_id])
  end
  
  def set_nursery
    @nursery = @garden.nursery
  end
end