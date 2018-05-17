class FidjisController < ApplicationController
  before_action :set_fidji, only: [:show, :edit, :update, :destroy]

  # GET /fidjis
  # GET /fidjis.json
  def index
    @fidjis = Fidji.all
  end

  # GET /fidjis/1
  # GET /fidjis/1.json
  def show
  end

  # GET /fidjis/1/edit
  def edit
  end

  # POST /fidjis
  # POST /fidjis.json
  def create
    @fidji = Fidji.new(fidji_params)

    respond_to do |format|
      if @fidji.save
        format.html { redirect_to fidjis_path, notice: 'Fidji was successfully created.' }
        format.json { render :show, status: :created, location: @fidji }
      else
        @fidjis = Fidji.all
        format.html { render :index }
        format.json { render json: @fidji.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fidjis/1
  # PATCH/PUT /fidjis/1.json
  def update
    respond_to do |format|
      if @fidji.update(fidji_params)
        format.html { redirect_to @fidji, notice: 'Fidji was successfully updated.' }
        format.json { render :show, status: :ok, location: @fidji }
      else
        format.html { render :edit }
        format.json { render json: @fidji.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fidjis/1
  # DELETE /fidjis/1.json
  def destroy
    @fidji.destroy
    respond_to do |format|
      format.html { redirect_to fidjis_url, notice: 'Fidji was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fidji
      @fidji = Fidji.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fidji_params
      params.require(:fidji).permit(:name, :family)
    end
end
