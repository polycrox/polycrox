class NurseryItemsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  before_action :set_garden, only: [:create, :index]
  before_action :set_nursery, only: [:create, :index]
  
  def index
    render json: @nursery.items.to_json(include: :item)
  end
  
  def new
    render json: NurseryItem.new
  end

  def create
    item = @nursery.items.new(nursery_item_params)
    if item.save
      render json: item.to_json(include: :item)
    end
  end

  def set_garden
    @garden = Garden.find(params[:garden_id])
  end
  
  def set_nursery
    @nursery = @garden.nursery
  end

  def nursery_item_params
    params.require(:nursery_item).permit(:type, :item_id, :cultivar, :quantity, :birthdate, :happiness, :state)
  end
end