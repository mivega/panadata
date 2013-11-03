class LicitationsController < ApplicationController
  before_action :set_licitation, only: [:show, :edit, :update, :destroy]

  # GET /licitations
  # GET /licitations.json
  def index
    @licitations = Licitation.text_search(params[:query]).order('FECHA DESC')
    @licitations = @licitations.paginate(:page => params[:page])

    @entidades = Rails.cache.fetch("entidades", :expires_in => 1.day ) {Licitation.select("DISTINCT(ENTIDAD)").map{|x| x.entidad}.sort}
    @compra_type = Rails.cache.fetch("compra_type", :expires_in => 1.day ) {Licitation.select("DISTINCT(COMPRA_TYPE)").select{|x| x.compra_type != 'Licitaciуn Pъblica'}.map{|x| x.compra_type }.sort}
    @categories = Category.all
  end

  # GET /licitations/1
  # GET /licitations/1.json
  def show
  end

  # GET /licitations/new
  def new
    @licitation = Licitation.new
  end

  # GET /licitations/1/edit
  def edit
  end

  # POST /licitations
  # POST /licitations.json
  def create
    @licitation = Licitation.new(licitation_params)

    respond_to do |format|
      if @licitation.save
        format.html { redirect_to @licitation, notice: 'Licitation was successfully created.' }
        format.json { render action: 'show', status: :created, location: @licitation }
      else
        format.html { render action: 'new' }
        format.json { render json: @licitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /licitations/1
  # PATCH/PUT /licitations/1.json
  def update
    respond_to do |format|
      if @licitation.update(licitation_params)
        format.html { redirect_to @licitation, notice: 'Licitation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @licitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /licitations/1
  # DELETE /licitations/1.json
  def destroy
    @licitation.destroy
    respond_to do |format|
      format.html { redirect_to licitations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_licitation
      @licitation = Licitation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def licitation_params
      params.require(:licitation).permit(:url, :visited, :parsed, :category_id, :compra_type, :entidad, :dependencia, :nombre_contacto, :telefono_contacto, :correo_contacto, :objeto, :modalidad, :unidad, :provincia, :precio, :proponente, :description, :acto, :fecha)
    end
end
