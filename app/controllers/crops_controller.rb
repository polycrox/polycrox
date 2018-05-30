class CropsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :set_plot, only: [:index, :create, :update]
  before_action :check_params, only: [:create]
  
  before_action :set_crop, only: [:update]

  before_action :set_item, only: [:add_item]

  def index
    render json: @plot.crops.to_json(include: :item)
  end

  
  def create
    qty = params[:qty].to_i
    
    begin
      qty.times do
        crop = @plot.crops.create(crop_params)
        crop.set_date = params[:crop][:date]
        unless crop.save
          raise ArgumentError.new("failed to save crop!")
        end
      end
    rescue ArgumentError => e  
      render_fail and return
    end
    
    render json: @plot.crops.last(qty).to_json(include: :item), status: :ok

  end

  def update
    # update state, present_in_plot, position
    
    if @crop.update(crop_params)
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

  def crop_params
    params.require(:crop).permit(:item_id, :date, :present_in_plot)
  end


  def render_fail
    render json: {}, status: :unprocessable_entity
  end
end