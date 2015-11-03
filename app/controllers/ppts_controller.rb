require 'tempfile'
require 'open-uri'
require 'net/http'

class PptsController < ApplicationController
  def index
    @ppts = Ppt.all
  end

  def new
    @ppt = Ppt.new
  end

  def create
    @deck = Powerpoint::Presentation.new
    ppt = Ppt.create(ppt_params)

    if ppt.save
      ppt.images.each do |image|
        file = Tempfile.new('ppt_image')
        open(image.url) do |http|
          resp = http.read
          File.open(file.path,'wb'){ |f| f.write(resp)}
        end
        file.close
        coords = {x: 0, y: 0, cx: 720 * 12700, cy: 540 * 12700}
        @deck.add_pictorial_slide image.title, file.path, coords
      end

      @deck.save("public/"+ ppt.pptx.url + ".pptx")

      redirect_to "/ppts"
    end
  end

  def edit
    @ppt = Ppt.find(params[:id])
  end

  def update
    @deck = Powerpoint::Presentation.new
    ppt = Ppt.find(params[:id])
    ppt.update(ppt_params)

    if ppt.save
      ppt.images.each do |image|
        file = Tempfile.new('ppt_image')
        open(image.url) do |http|
          resp = http.read
          File.open(file.path,'wb'){ |f| f.write(resp)}
        end
        file.close
        coords = {x: 0, y: 0, cx: 720 * 12700, cy: 540 * 12700}
        @deck.add_pictorial_slide image.title, file.path, coords
      end

      @deck.save("public/"+ ppt.pptx.url + ".pptx")

      redirect_to "/ppts"
    end
  end

  def show
    @ppt = Ppt.find(params[:id])
  end


  def download
    ppt = Ppt.find(params[:id])
    send_file("public/"+ ppt.pptx.url + ".pptx", :filename => ppt.title + ".pptx")
  end

  def destroy
    ppt = Ppt.find(params[:id])
    ppt.destroy
    redirect_to "/ppts"
  end

  private

    def ppt_params
      params.require(:ppt).permit(:title, :pptx, :image_ids => [])
    end
end
