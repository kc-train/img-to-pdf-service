class ImagesController < ApplicationController
  def create
    image = Image.create(image_params)
    if image.save
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