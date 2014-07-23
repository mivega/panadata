class PersonasController < ApplicationController

  # GET /personas
  # GET /personas.json
  def index
    @personas = Persona.text_search(params[:query])
    @personas = @personas.paginate(:page => params[:page])
  end

  # GET /personas/1
  # GET /personas/1.json
  def show
    @persona = Persona.find(params[:id])
    @asociations = Asociation.where('persona_id = ?', @persona.id)
    @corporations = Corporation.where(id: @asociations.map{|a| a.sociedad_id})
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
