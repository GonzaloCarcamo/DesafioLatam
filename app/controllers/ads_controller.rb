class AdsController < ApplicationController
  before_action :set_ad, only: [:show, :edit, :update, :destroy, :delete_image]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /ads
  # GET /ads.json
  def index
    @ads = Ad.all
    @tags = Tag.all
    
  end

  # GET /ads/1
  # GET /ads/1.json
  def show
  end

  # GET /ads/new
  def new
    @ad = Ad.new
    @categories = Category.pluck(:title)
    @tags = Tag.all
  end

  # GET /ads/1/edit
  def edit

  end

  # POST /ads
  # POST /ads.json
  def create
    @ad = Ad.new(ad_params)
    @ad.user = current_user
  
    params[:ad][:ads_tags].each do |id, value|
      @ad.tags.push Tag.find(id) if value == '1'
  
    end
  
    respond_to do |format|
      if @ad.save
        format.html { redirect_to @ad, notice: 'Ad was successfully created.' }
        format.json { render :show, status: :created, location: @ad }
      else
        @categories = Category.pluck(:title)
        @tags = Tag.all
        format.html { render :new }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ads/1
  # PATCH/PUT /ads/1.json
  def update
    respond_to do |format|
      if @ad.update(ad_params)
        format.html { redirect_to @ad, notice: 'Ad was successfully updated.' }
        format.json { render :show, status: :ok, location: @ad }
      else
        format.html { render :edit }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ads/1
  # DELETE /ads/1.json
  def destroy
    @ad.destroy
    respond_to do |format|
      format.html { redirect_to ads_url, notice: 'Ad was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delete_image
    begin
      @image = ActiveStorage::Attachment.find(params[:image_id])
      @image.purge
        redirect_to ad_path(@ad), notice: 'Imagen eliminada con éxito'
        rescue ActiveRecord::RecordNotFound
      redirect_to ad_path(@ad), alert: 'Error al eliminar la imagen'
    end
  end
   

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad
      @ad = Ad.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ad_params
      params.require(:ad).permit(:title, :category, :tag, :image, :instruction)
    end
end
