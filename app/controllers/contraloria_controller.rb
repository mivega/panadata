class ContraloriaController < ApplicationController

  def stats
    @total = @docs.length
    @sum = @docs.sum(:monto)
  end

  def index
    @docs = ContraloriaDoc.text_search(params[:query])
    stats if params[:query]
    @docs = @docs.paginate(:page => params[:page])
  end

  def show
    @doc= ContraloriaDoc.find(params[:id].downcase)
  end
end
