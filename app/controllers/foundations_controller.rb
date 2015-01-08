class FoundationsController < ApplicationController
	before_action :set_foundation, only: [:show]

  # GET /foundations
  # GET /foundations.json
  def index
    @foundations = Corporation.text_search(params[:query])
    @foundations = @foundations.paginate(:page => params[:page])
  end

  # GET /foundations/1
  # GET /foundations/1.json
  def show
    @personas = Persona.joins(:asociations).select('distinct personas.id,personas.nombre').where(asociaciones: { sociedad_id: @corporation.ficha }).includes(:asociations)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_foundation
      @foundation = Foundation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def foundation_params
      params.require(:foundation).permit(:nombre, :ficha, :firmante_text, :patrimonio_text, :patrimonio, :moneda, :agente, :notaria, :fecha_registro, :status, :duracion, :provincia)
    end
end
