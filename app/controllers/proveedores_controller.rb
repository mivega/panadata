class ProveedoresController < ApplicationController

  def index
    if params[:query] then
      @proveedores = Provider.text_search(params[:query]).paginate(:page => params[:page])
    else
      @proveedores = Rails.cache.fetch("top_proveedores", :expires_in => 1.hour ) {Provider.select('proveedores.id,proveedores.nombre,count(*),sum(compras.precio)').joins(:licitations).group('proveedores.id,proveedores.nombre').where('compras.fecha > ?', "2014-07-01").order('sum DESC').limit(30)}
    end
  end

  def show
    @proveedor = Provider.find(params[:id])
    @corporations = Rails.cache.fetch("/proveedores/#{@proveedor_id}/sociedad", :expires_in => 1.hour ) {Corporation.text_search(@proveedor.nombre)}
    @proveedor_sum = Rails.cache.fetch("/proveedores/#{@proveedor_id}/sum", :expires_in => 1.hour ) {@proveedor.licitations.sum(:precio)}
    @licitations = Licitation.text_search('').where('fecha is not null').where(proveedor_id: @proveedor)
    @chart_data = Rails.cache.fetch("/proveedores/#{@proveedor_id}/chart", :expires_in => 1.hour ) {licitation_chart_data}
    @licitations = @licitations.order('FECHA DESC').paginate(:page => params[:page], total_entries: @proveedor.licitations.count)
  end

end
