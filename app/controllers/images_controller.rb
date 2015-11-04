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
      redirect_to "/images"
    end
  end

  def destroy
    image = Image.find(params[:id])
    image.destroy
    redirect_to "/images"
  end

  private

      def image_params
        params.require(:image).permit(:title, :url)
      end
end