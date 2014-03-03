class OwnerBrandsController < ApplicationController
  before_action :set_owner_brand, only: [:show, :edit, :update, :destroy]

  # GET /owner_brands
  # GET /owner_brands.json
  def index
    @owner_brands = OwnerBrand.all
  end

  # GET /owner_brands/1
  # GET /owner_brands/1.json
  def show
  end

  # GET /owner_brands/new
  def new
    @owner_brand = OwnerBrand.new
  end

  # GET /owner_brands/1/edit
  def edit
  end

  # POST /owner_brands
  # POST /owner_brands.json
  def create
    @owner_brand = OwnerBrand.new(owner_brand_params)

    respond_to do |format|
      if @owner_brand.save
        format.html { redirect_to @owner_brand, notice: 'Owner brand was successfully created.' }
        format.json { render action: 'show', status: :created, location: @owner_brand }
      else
        format.html { render action: 'new' }
        format.json { render json: @owner_brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /owner_brands/1
  # PATCH/PUT /owner_brands/1.json
  def update
    respond_to do |format|
      if @owner_brand.update(owner_brand_params)
        format.html { redirect_to @owner_brand, notice: 'Owner brand was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @owner_brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /owner_brands/1
  # DELETE /owner_brands/1.json
  def destroy
    @owner_brand.destroy
    respond_to do |format|
      format.html { redirect_to owner_brands_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_owner_brand
      @owner_brand = OwnerBrand.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def owner_brand_params
      params[:owner_brand]
    end
end
