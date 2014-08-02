class ProveedoresController < ApplicationController

  def index
    @proveedores = Provider.text_search(params[:query]).paginate(:page => params[:page])
  end

  def show
    @proveedor = Provider.find(params[:id])
    @corporations = Corporation.text_search(@proveedor.nombre)
    @licitations = @proveedor.licitations.select('acto,description,entidad,proponente,proveedor_id,precio,fecha').order('FECHA DESC').paginate(:page => params[:page])
  end

end
