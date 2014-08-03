class ProveedoresController < ApplicationController

  def index
    if params[:query] then
      @proveedores = Provider.text_search(params[:query]).paginate(:page => params[:page])
    else
      @proveedores = Provider.select('proveedores.id,proveedores.nombre,count(*),sum(compras.precio)').joins(:licitations).group('proveedores.id,proveedores.nombre').where('compras.fecha > ?', 1.month.ago).order('count DESC').limit(10)
    end
  end

  def show
    @proveedor = Provider.find(params[:id])
    @corporations = Corporation.text_search(@proveedor.nombre)
    @licitations = @proveedor.licitations.select('acto,description,entidad,proponente,proveedor_id,precio,fecha').order('FECHA DESC').paginate(:page => params[:page])
  end

end
