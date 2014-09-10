class ImportacionesController < ApplicationController

  def index
    @importaciones = Importacion.text_search(params[:query]).paginate(:page => params[:page])
  end

end
