class EntidadesController < ApplicationController
  def index
      @entidades = Entidad.text_search(params[:query])
  end

  def show
      @entidad = Entidad.find(params[:id])
      @top_proveedores = Provider.select('proveedores.id,proveedores.nombre,count(*),sum(compras.precio)').joins(:licitations).group('proveedores.id,proveedores.nombre').where('compras.fecha > ? and compras.entidad_id = ?', "2014-07-01", @entidad.id).order('sum DESC').limit(10)
      @licitations = Licitation.text_search('').where('fecha is not null').where(entidad_id: @entidad.id)
      @chart_data = licitation_chart_data
      @licitations = @licitations.order('FECHA DESC').paginate(:page => params[:page],total_entries:  @entidad.licitations.size)
  end
end
