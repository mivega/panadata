class ExportacionesController < ApplicationController
  before_action :authenticate_user!

  def index
    @exportaciones = Exportacion.text_search(params[:query]).paginate(:page => params[:page])
  end
end
