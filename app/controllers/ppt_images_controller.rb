class PptImagesController < ApplicationController
  def index
    @ppt_images = PptImage.all
  end

  def new
    @ppt_image = PptImage.new
  end

  def create
    ppt_image = PptImage.create(ppt_image_params)
    if ppt_image.save
      redirect_to '/'
    end
  end

  private

    def ppt_image_params
      params.require(:ppt_image).permit(:image_ids => [])
    end
end