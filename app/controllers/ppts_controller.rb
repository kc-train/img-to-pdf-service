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
      redirect_to "/ppts"
    end
  end

  def show
    @ppt = Ppt.find(params[:id])
  end


  def download
    ppt = Ppt.find(params[:id])
    send_file("public/" + ppt.pptx.url, :filename => ppt.title + ".pptx")
  end

  def destroy
    ppt = Ppt.find(params[:id])
    ppt.destroy
    redirect_to "/ppts"
  end

  private

    def ppt_params
      params.require(:ppt).permit(:title, :pptx)
    end
end
