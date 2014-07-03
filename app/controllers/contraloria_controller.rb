class ContraloriaController < ApplicationController
  def index
    @docs = ContraloriaDoc.text_search(params[:query])
    @docs = @docs.paginate(:page => params[:page])
  end

  def show
    @doc= ContraloriaDoc.find(:first, conditions: ["lower(control) = ?", params[:id].downcase])
  end
end
