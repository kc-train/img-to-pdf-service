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
    ppt = Ppt.create(ppt_params)

    if ppt.save
      ImgToPptTranscodeWorker.perform_async(ppt.id.to_s)

      redirect_to "/ppts"
    end
  end

  def edit
    @ppt = Ppt.find(params[:id])
  end

  def update
    ppt = Ppt.find(params[:id])
    ppt.update(ppt_params)

    if ppt.save
      ImgToPptTranscodeWorker.perform_async(ppt.id.to_s)

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
