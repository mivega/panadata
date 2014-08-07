class LicitationsController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_filter :load_meta

  def stats
    @sum = @licitations.sum(:precio)
	  @count = @licitations.count('*')
    @chart_data = licitation_chart_data
  end

  def stats_global
	  @count = Rails.cache.fetch("compras_count", :expires_in => 10.minutes ) { Licitation.count }
    @sum = Rails.cache.fetch("compras_sum", :expires_in => 10.minutes ) {Licitation.sum(:precio)}
    @chart_data = Rails.cache.fetch("global_chart_data", :expires_in => 10.minutes ) {licitation_chart_data}
  end

  # GET /licitations
  # GET /licitations.json
  def index
    @licitations = Licitation.text_search(params[:query])
    if params.length > 2 then 
        filter_licitations
        stats
    else
        @licitations = @licitations.where('fecha is not null')
        stats_global
    end
    @licitations = @licitations.order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], total_entries: @count)
  end

  # GET /licitations/1
  # GET /licitations/1.json
  def show
    @licitation = Licitation.select('acto,description,entidad,provincia,dependencia,unidad,compra_type,url,modalidad,objeto,category_id,nombre_contacto,correo_contacto,telefono_contacto,proponente,proveedor_id,precio,fecha').find_by_acto(params[:id].downcase)
  end


  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def licitation_params
      params.require(:licitation).permit(:url, :category_id, :compra_type, :entidad, :dependencia, :objeto, :modalidad, :unidad, :provincia, :precio, :proveedor, :description, :acto, :fecha)
    end

  def order_and_paginate
    if not params[:page] or params[:page] == 1 or params[:page] = '' then
      @licitations = @licitations.where('fecha is not null')
    end
    @licitations = @licitation.order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], total_entries: @count)
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
    if params[:proveedor] and params[:proveedor] != '' then
      @proveedores = Provider.text_search(params[:proveedor])
	    @licitations = @licitations.where(proveedor_id: @proveedores.collect{ |p| p.id })
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

  def filter_entidad
    if (params[:entidad] and params[:entidad] != '') then
      @entidades = Entidad.text_search(params[:entidad])
      @licitations = @licitations.where(entidad_id: @entidades.collect{ |e| e.id })
    end
  end

  def filter_licitations
    filter_entidad
    filter_proponente
    filter_fecha
    filter_price
    filter_acto
    filter_modalidad
    filter_objeto
    filter_compra_type
    @licitations = @licitations.where('category_id = ?', params[:category]) if (params[:category] and params[:category] != '')
  end

  def sort_column
    column_names = ['precio','entidad','proponente','fecha']
    column_names.include?(params[:sort]) ? params[:sort] : "FECHA"  
  end 

  def licitation_chart_data(compras = @licitations)
      require 'date'
      (compras.only(:where).select('extract(mon from fecha) as mon, extract(year from fecha) as year, sum(precio) as precio').where('fecha is not null').group('year, mon').order('year, mon')).map do |l|
        [ "new Date(" + l.year.to_i.to_s + "," + l.mon.to_i.to_s + ", 1)" , "{v: " + l.precio.to_s + ", f: '$" + l.precio.to_s + "'}" ]
      end
  end

  def load_meta
    @compra_type = Rails.cache.fetch("compra_type", :expires_in => 1.day ) {Licitation.select("DISTINCT(COMPRA_TYPE)").map{|x| x.compra_type }.sort}
    @categories = Rails.cache.fetch("categories", :expires_in => 1.day ) {Category.all}
  end

end
