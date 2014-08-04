class BrandsController < ApplicationController

  # GET /brands
  # GET /brands.json
  def index
    @brands = Brand.select('id,nombre,registro,abogado,fecha_registro').text_search(params[:query])
    @brands = @brands.paginate(:page => params[:page])
  end

  # GET /brands/1
  # GET /brands/1.json
  def show
    @brand = Brand.select('id,nombre,registro,abogado,fecha_registro,estado,actividad,fecha_vencimiento,capital_text,representante_text').includes(:products,:owners).find(params[:id])
  end

end
