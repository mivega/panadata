class LicitationsController < ApplicationController
  before_action :set_licitation, only: [:edit, :update, :destroy]

  def stats
    @total = @licitations.count
    @proponentes = @licitations.group_by{|x| x.proponente}.sort_by{|k, v| -v.size}.map(&:first)
    @entidades_stat = @licitations.group_by{|x| x.entidad}.sort_by{|k, v| -v.size}.map(&:first)
  end

  # GET /licitations
  # GET /licitations.json
  def index
    @licitations = Licitation.text_search(params[:query]).order('FECHA DESC')
    filter_licitations
    stats if params.size > 2
    @licitations = @licitations.paginate(:page => params[:page])
    @entidades = Rails.cache.fetch("entidades", :expires_in => 1.day ) {Licitation.select("DISTINCT(ENTIDAD)").map{|x| x.entidad}.sort}
    @compra_type = Rails.cache.fetch("compra_type", :expires_in => 1.day ) {Licitation.select("DISTINCT(COMPRA_TYPE)").map{|x| x.compra_type }.sort}
    @categories = Category.all
  end

  # GET /licitations/1
  # GET /licitations/1.json
  def show
    @licitation = Licitation.find(:first, conditions: ["lower(acto) = ?", params[:id].downcase])
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


  def filter_fecha
    if params[:fecha_min] and params[:fecha_max] and (params[:fecha_max] != '' or params[:fecha_min] != '') then
      @licitations = @licitations.where('DATE(fecha) >= ?', DateTime.strptime(params[:fecha_min], '%d/%m/%Y')) if params[:fecha_min] != ''
      @licitations = @licitations.where('DATE(fecha) <= ?', DateTime.strptime(params[:fecha_max], '%d/%m/%Y')) if params[:fecha_max] != ''
    end
  end

  def filter_price
    if params[:price_min] and params[:price_max] and (params[:price_max] != '' or params[:price_min] != '') then
      @licitations = @licitations.where('precio >= ?', params[:price_min]) if params[:price_min] != ''
      @licitations = @licitations.where('precio <= ?', params[:price_max]) if params[:price_max] != ''
    end
  end

  def filter_proponente
    if params[:proponente] and params[:proponente] != '' then
      @licitations = @licitations.where("to_tsvector('simple',proponente) @@ plainto_tsquery('simple',?)", params[:proponente])
    end
  end

  def filter_acto
    if params[:acto] and params[:acto] != '' then
      @licitations = @licitations.where("lower(acto) like ?", "%#{params[:acto].downcase}%")
    end
  end

  def filter_modalidad
    if params[:modalidad] and params[:modalidad] != '' then
      @licitations = @licitations.where("modalidad = ?", params[:modalidad])
    end
  end

  def filter_objeto
    if params[:objeto] and params[:objeto] != '' then
      @licitations = @licitations.where("objeto = ?", params[:objeto])
    end
  end

  def filter_compra_type
    if params[:compra_type] and params[:compra_type] != '' then
      @licitations = @licitations.where("compra_type = ?", params[:compra_type])
    end
  end

  def filter_licitations
    filter_fecha
    filter_price
    filter_proponente
    filter_acto
    filter_modalidad
    filter_objeto
    filter_compra_type
    @licitations = @licitations.where('entidad = ?', params[:entidad]) if (params[:entidad] and params[:entidad] != '')
    @licitations = @licitations.where('category_id = ?', params[:category]) if (params[:category] and params[:category] != '')
    @licitations = @licitations.where('proponente = ?', 'empty') if (params[:empty] and params[:empty] != '')
  end



end
