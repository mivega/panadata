class EntidadesController < ApplicationController
  def index
      @entidades = Entidad.text_search(params[:query])
  end

  def show
  end
end
