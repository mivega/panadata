class OwnersController < ApplicationController
  before_action :set_owner, only: [:show]

  # GET /owners
  # GET /owners.json
  def index
    @owners = Owner.text_search(params[:query]).order("RANDOM()")
    @owners = @owners.paginate(:page => params[:page])
  end

  # GET /owners/1
  # GET /owners/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_owner
      @owner = Owner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def owner_params
      params[:owner]
    end
end
