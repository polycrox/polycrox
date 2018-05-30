class SpacingsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :set_item, only: [:index, :create, :update]
  before_action :set_spacing, only: [:update]
  def index
    render json: @item.spacings.map {|i| i.parsed_options }
  end

  def create
    @item.spacings.create(options: params[:options])    
    render json: @item.spacings.last.parsed_options
  end

  def update
    @spacing.options = params[:options]
    @spacing.save
    render json: @spacing.parsed_options
  end
  
  def new_square    
    render json: Spacing.default_square.parsed_options
  end

  def new_corner
    render json: Spacing.default_corner.parsed_options
  end
  
  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_spacing
    @spacing = Spacing.find(params[:spacing_id])
  end
end