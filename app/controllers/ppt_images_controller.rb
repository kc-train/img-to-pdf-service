class PptImagesController < ApplicationController
  before_action :find_ppt 
  def index
    @ppt_images = PptImage.all
  end

  def new
    @ppt_image = @ppt.ppt_images.new
  end

  def create
    @ppt_image = @ppt.ppt_images.new(ppt_image_params)
    if @ppt_image.save
      redirect_to "/ppts/#{@ppt.id}"
    end
  end

  private

    def ppt_image_params
      params.require(:ppt_image).permit(:image_ids => [])
    end

    def find_ppt
      @ppt = Ppt.find(params[:ppt_id])
    end
end