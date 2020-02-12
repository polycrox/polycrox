class PlotsController < ApplicationController
  before_action :set_plot, only: [:show, :edit, :update, :destroy]
  before_action :set_garden, only: [:index, :new, :show, :edit, :update, :destroy]

  # GET /plots
  # GET /plots.json
  def index
    @plots = Plot.all
  end

  # GET /plots/1
  # GET /plots/1.json
  def show
    @boxes = @plot.boxes
  end

  # GET /plots/new
  def new
    @plot = Plot.new
  end

  # GET /plots/1/edit
  def edit
  end

  # POST /plots
  # POST /plots.json
  def create
    @plot = Plot.new(plot_params)
    @plot.geometry = JSON.parse(plot_params[:geometry])

    respond_to do |format|
      if @plot.save
        format.html { redirect_to edit_garden_plot_url(id: @plot.id), notice: 'Plot was successfully created.' }
        format.json { render :show, status: :created, location: @plot }
      else
        format.html { render :new }
        format.json { render json: @plot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plots/1
  # PATCH/PUT /plots/1.json
  def update
    respond_to do |format|
      if @plot.update(plot_params)
        format.html { redirect_to @plot, notice: 'Plot was successfully updated.' }
        format.json { render :show, status: :ok, location: @plot }
      else
        format.html { render :edit }
        format.json { render json: @plot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plots/1
  # DELETE /plots/1.json
  def destroy
    @plot.destroy
    respond_to do |format|
      format.html { redirect_to garden_plots_url, notice: 'Plot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plot
      @plot = Plot.find(params[:id])
    end

    def set_garden
      @garden = Garden.find(params[:garden_id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def plot_params
      params.require(:plot).permit(:name, :geometry, :garden_id)
    end
end
