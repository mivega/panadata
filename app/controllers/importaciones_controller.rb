class ImportacionesController < ApplicationController
  before_action :authenticate_user!


  def index
    @importaciones = Importacion.text_search(params[:query]).paginate(:page => params[:page])
  end

end
