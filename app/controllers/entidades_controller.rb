class EntidadesController < ApplicationController
  def index
      @entidades = Entidad.text_search(params[:query])
  end

  def show
      @entidad = Entidad.find(params[:id])
      @top_proveedores = Provider.select('proveedores.id,proveedores.nombre,count(*),sum(compras.precio)').joins(:licitations).group('proveedores.id,proveedores.nombre').where('compras.fecha > ? and compras.entidad_id = ?', 1.months.ago, @entidad.id).order('sum DESC').limit(10)
      @licitations = @entidad.licitations.select('acto,description,entidad,proponente,proveedor_id,precio,fecha').order('FECHA DESC').paginate(:page => params[:page])
  end
end
