class NurseryItemsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  before_action :set_garden, only: [:create]
  before_action :set_nursery, only: [:create]
  
  def new
    render json: NurseryItem.new
  end

  def create
    binding.pry
  end

  def set_garden
    @garden = Garden.find(params[:garden_id])
  end
  
  def set_nursery
    @nursery = @garden.nursery
  end
end