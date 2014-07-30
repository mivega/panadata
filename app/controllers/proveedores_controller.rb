class ProveedoresController < ApplicationController

  def index
    @proveedores = Provider.text_search(params[:query]).paginate(:page => params[:page])
  end

  def show
    @proveedor = Provider.find(params[:id])
    @licitations = @proveedor.licitations.order('FECHA DESC').paginate(:page => params[:page])
  end

end
