class LicitationsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def stats
    @total = @licitations.count('*')
    @sum = @licitations.sum(:precio)
    #@proponentes = @licitations.reject{ |l| l.proponente.nil? }.group_by{|x| x.proponente}.sort_by{|k, v| -v.size}.map(&:first)
    #@entidades_stat = @licitations.group_by{|x| x.entidad}.sort_by{|k, v| -v.size}.map(&:first)
  end

  def stats_global
    @total = Licitation.count 
    @sum = Licitation.sum(:precio)
    @chart_data = licitation_chart_data(Licitation)
    @top_proveedores = Rails.cache.fetch("top_proveedores", :expires_in => 1.hour ) {Provider.select('proveedores.id,proveedores.nombre,count(*),sum(compras.precio)').joins(:licitations).group('proveedores.id,proveedores.nombre').where('compras.fecha > ?', 1.month.ago).order('sum DESC').limit(10)}
  end

  # GET /licitations
  # GET /licitations.json
  def index
    if params.length > 2 then 
        filter_licitations
    	@chart_data = licitation_chart_data(@licitations)
        @licitations = @licitations.select('acto,description,entidad,proponente,proveedor_id,precio,fecha')
        stats 
	@licitations = @licitations.order(sort_column + ' ' + sort_direction).paginate(:page => params[:page])	
    else
        stats_global
        @licitations = Licitation.select('acto,description,entidad,proponente,proveedor_id,precio,fecha').order(sort_column + ' ' + sort_direction).paginate(:page => params[:page])
    end
    @entidades = Rails.cache.fetch("entidades", :expires_in => 1.day ) {Licitation.select("DISTINCT(ENTIDAD)").map{|x| x.entidad}.sort}
    @compra_type = Rails.cache.fetch("compra_type", :expires_in => 1.day ) {Licitation.select("DISTINCT(COMPRA_TYPE)").map{|x| x.compra_type }.sort}
    @categories = Category.all
  end

  # GET /licitations/1
  # GET /licitations/1.json
  def show
    @licitation = Licitation.select('acto,description,entidad,provincia,dependencia,unidad,compra_type,url,modalidad,objeto,category_id,nombre_contacto,correo_contacto,telefono_contacto,proponente,proveedor_id,precio,fecha').find(params[:id].downcase)
    @entidades = Rails.cache.fetch("entidades", :expires_in => 1.day ) {Licitation.select("DISTINCT(ENTIDAD)").map{|x| x.entidad}.sort}
    @compra_type = Rails.cache.fetch("compra_type", :expires_in => 1.day ) {Licitation.select("DISTINCT(COMPRA_TYPE)").map{|x| x.compra_type }.sort}
    @categories = Category.all
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
      @licitations = @licitations.where("lower(acto) like lower(?)", "%#{params[:acto].downcase}%")
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
    @licitations = Licitation.text_search(params[:query])
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

  def sort_column
    column_names = ['precio','Entidad','Proponente','Description','Fecha']
    column_names.include?(params[:sort]) ? params[:sort] : "FECHA"  
  end 

  def licitation_chart_data(compras)
      require 'date'
      (compras.select('extract(mon from fecha) as mon, extract(year from fecha) as year, sum(precio) as precio').group('year, mon').order('year, mon')).map do |l|
        [ "new Date(" + l.year.to_i.to_s + "," + l.mon.to_i.to_s + ", 1)" , "{v: " + l.precio.to_s + ", f: '$" + l.precio.to_s + "'}" ]
      end
  end

end
