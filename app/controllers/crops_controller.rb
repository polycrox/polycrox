class CropsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :set_plot, only: [:index, :create, :update, :add_item, :index_items]
  before_action :check_params, only: [:create]
  
  before_action :set_crop, only: [:update, :add_item, :index_items]
  before_action :check_active_crop, only: [:update]

  before_action :set_item, only: [:add_item]

  def index
    
    # render json: {
    #   active: @plot.garden.crops.find {|crop| crop.active }.to_json,
    #   past: @plot.garden.crops.find_all {|crop| !crop.active }.to_json
    # }

    render json: @plot.garden.crops
  end

  def create
    crop = Crop.new(garden_id: @plot.garden.id)
    crop.set_date = params[:crop][:date]
    if crop.save
      render json: crop.to_json, status: :ok
    else
      render_fail
    end
  end

  def add_item
    cip = CropItemPlot.new(crop_id: @crop.id, item_id: @item.id, plot_id: @plot.id)
    cip.save
    render json: @item.to_json, status: :ok
  end

  def index_items
  
    render json: CropItemPlot.find_items_for_plot_and_crop(@plot.id, @crop.id)
  end

  def update
    
    @crop.active = crop_params[:active]
    if @crop.save
      render json: @crop.to_json, status: :ok
    else
      render_fail
    end
  end

  def set_plot
    @plot = Plot.find(params[:plot_id])
  end

  def set_crop
    @crop = Crop.find(params[:id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def check_params
    if params[:crop][:date].empty?
      render_fail
    end
  end

  def check_active_crop
    if crop_params[:active]
      return render_fail if @plot.crops.find do |crop|
        crop.active
      end
    end
  end

  def crop_params
    params.require(:crop).permit(:active)
  end

  def render_fail
    render json: {}, status: :unprocessable_entity
  end
end