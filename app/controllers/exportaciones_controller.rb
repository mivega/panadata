class ExportacionesController < ApplicationController
  def index
    @exportaciones = Exportacion.text_search(params[:query]).paginate(:page => params[:page])
  end
end
