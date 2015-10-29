class PptsController < ApplicationController
  def index
    @ppts = Ppt.all
  end

  def new
    @ppt = Ppt.new
  end

  def create
    # @deck = Powerpoint::Presentation.new
    # @ppt_images = PptImage.all
    # @word_contents = WordContent.all
    ppt = Ppt.create(ppt_params)
    # coords = {x: 0, y: 0, cx: 720 * 12700, cy: 540 * 12700}

    # @word_contents.each do |word_content|
    #   @deck.add_intro word_content.title, word_content.content
    # end

    # @ppt_images.each do |ppt_image|
    #   ppt_image.image.each do |image|
    #     @deck.add_pictorial_slide image.title, Rails.root + "app/assets/images/" + image.title,coords
    #   end
    # end
    
    # @deck.save(file.name + '.pptx')

    if ppt.save     
      redirect_to "/ppts"
    end
  end

  def show
    @ppt = Ppt.find(params[:id])
  end

  def download
    ppt = Ppt.find(params[:id])
    # send_file("#{Rails.root}/" + ppt.title + ".pptx", :filename => ppt.title + ".pptx")
    send_file("#{Rails.root}/app/assets/pptxs/#{ppt.title}.pptx", :filename => ppt.title + ".pptx")
  end

  def destroy
    ppt = Ppt.find(params[:id])
    ppt.destroy
    redirect_to "/ppts"
  end

  private

    def ppt_params
      params.require(:ppt).permit(:title)
    end
end
