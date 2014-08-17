class PersonasController < ApplicationController

  # GET /personas
  # GET /personas.json
  def index
    @personas = Persona.text_search(params[:query]).paginate(:page => params[:page])
  end

  # GET /personas/1
  # GET /personas/1.json
  def show
    @persona = Persona.find(params[:id])
    @corporations = Corporation.select('distinct sociedades.ficha,sociedades.nombre').where(asociaciones: { persona_id: @persona.id }).includes(:asociations).paginate(:page => params[:page], :per_page => 50)
    @ccount = @corporations.count('*')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_persona
      @persona = Persona.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def persona_params
      params.require(:persona).permit(:nombre)
    end
end
