class ContraloriaController < ApplicationController
  helper_method :sort_column, :sort_direction

  def stats
    @total = @docs.length
    @sum = @docs.sum(:monto)
  end

  def global_stats
    @total = Rails.cache.fetch("contraloria_count", :expires_in => 1.day ) {ContraloriaDoc.count}
    @sum = Rails.cache.fetch("contraloria_sum", :expires_in => 1.day ) {ContraloriaDoc.sum(:monto)}
  end

  def index
    @docs = ContraloriaDoc.text_search(params[:query])
    params[:query] ? stats : global_stats
    @docs = @docs.order(sort_column + ' ' + sort_direction).paginate(:page => params[:page])
  end

  def show
    @doc= ContraloriaDoc.find(params[:id].downcase)
  end

  private


  def sort_column
    column_names = ['Numero','Documento','Institucion','Favor','Monto','Fecha']
    column_names.include?(params[:sort]) ? params[:sort] : "FECHA"  
  end 

end
