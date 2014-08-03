class CorporationsController < ApplicationController
  before_action :set_corporation, only: [:show]

  # GET /corporations
  # GET /corporations.json
  def index
    @corporations = Corporation.text_search(params[:query])
    @corporations = @corporations.paginate(:page => params[:page])
  end

  # GET /corporations/1
  # GET /corporations/1.json
  def show
    @personas = Persona.joins(:asociations).select('distinct personas.id,personas.nombre').where(asociaciones: { sociedad_id: @corporation.id }).includes(:asociations)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_corporation
      @corporation = Corporation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def corporation_params
      params.require(:corporation).permit(:nombre, :ficha, :representante_text, :capital_text, :capital, :moneda, :agente, :notaria, :fecha_registro, :status, :duracion, :provincia)
    end
end
