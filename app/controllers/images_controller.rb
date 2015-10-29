require 'open-uri'
require 'net/http'

class ImagesController < ApplicationController
  def index
    @images = Image.all
  end

  def new
    @image = Image.new
  end

  def create
    image = Image.create(image_params)
    if image.save
      image_title = params[:image][:title]
      uri = params[:image][:url]
      img = MiniMagick::Image.open(uri)
      img.resize "360x270"
      img.write(Rails.root + 'app/assets/images/' + image_title)
      # open(uri) do |http|
      #   resp = http.read
      #   File.open(Rails.root + 'app/assets/images/' + image_name,'wb'){ |f| f.write(resp)}
      # end
      redirect_to "/images"
    end
  end

  def choice
    
  end

  private

      def image_params
        params.require(:image).permit(:title, :url)
      end
end