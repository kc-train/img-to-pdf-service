class HomeController < ApplicationController
  def index
    
  end

  def create_ppt
    @deck = Powerpoint::Presentation.new
    redirect_to "/"
  end

  def add_image
    @deck = Powerpoint::Presentation.new
    title = params[:title]
    image_path = params[:image_path]
    @deck.add_pictorial_slide title, image_path
    @deck.save('app/assets/images/test.pptx')
    redirect_to "/"
  end
end