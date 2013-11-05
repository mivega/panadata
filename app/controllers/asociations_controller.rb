class AsociationsController < ApplicationController
  before_action :set_asociation, only: [:show, :edit, :update, :destroy]

  # GET /asociations
  # GET /asociations.json
  def index
    @asociations = Asociation.paginate(:page => params[:page])
  end

  # GET /asociations/1
  # GET /asociations/1.json
  def show
  end

  # GET /asociations/new
  def new
    @asociation = Asociation.new
  end

  # GET /asociations/1/edit
  def edit
  end

  # POST /asociations
  # POST /asociations.json
  def create
    @asociation = Asociation.new(asociation_params)

    respond_to do |format|
      if @asociation.save
        format.html { redirect_to @asociation, notice: 'Asociation was successfully created.' }
        format.json { render action: 'show', status: :created, location: @asociation }
      else
        format.html { render action: 'new' }
        format.json { render json: @asociation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asociations/1
  # PATCH/PUT /asociations/1.json
  def update
    respond_to do |format|
      if @asociation.update(asociation_params)
        format.html { redirect_to @asociation, notice: 'Asociation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @asociation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asociations/1
  # DELETE /asociations/1.json
  def destroy
    @asociation.destroy
    respond_to do |format|
      format.html { redirect_to asociations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asociation
      @asociation = Asociation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def asociation_params
      params.require(:asociation).permit(:persona_id, :sociedad_id, :rol)
    end
end
