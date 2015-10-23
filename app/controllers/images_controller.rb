require 'open-uri'
require 'net/http'

class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    image = Image.create(image_params)
    if image.save
      file_name = params[:image][:title]
      uri = params[:image][:url]
      open(uri) do |http|
        resp = http.read
        File.open(Rails.root + 'app/assets/images/' + file_name,'wb'){ |f| f.write(resp)}
      end
      redirect_to "/home/index"
      # html = render_to_string :partial => "/images/image_li", :locals => {:image => image}
      # return render :text => html
    end
  end

  private

      def image_params
        params.require(:image).permit(:title, :url)
      end
end