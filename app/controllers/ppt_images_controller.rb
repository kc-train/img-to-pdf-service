class PptImagesController < ApplicationController
  before_action :find_ppt 
  def index
    @ppt_images = PptImage.all
  end

  def new
    @ppt_image = @ppt.ppt_images.new
  end

  def create
    @deck = Powerpoint::Presentation.new
    @ppt_image = @ppt.ppt_images.new(ppt_image_params)

    if @ppt_image.save
      @ppt.ppt_images.each do |ppt_image|
        ppt_image.images.each do |image|
          coords = {x: 0, y: 0, cx: 720 * 12700, cy: 540 * 12700}
          @deck.add_pictorial_slide image.title, Rails.root + "app/assets/images/" + image.title, coords
        end
      end

      @deck.save("public/" + @ppt.pptx.url)
      
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