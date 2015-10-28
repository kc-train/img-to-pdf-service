class FileNamesController < ApplicationController
  def new
    @file_name = FileName.new
  end

  def create
    @deck = Powerpoint::Presentation.new
    @ppt_images = PptImage.all
    @word_contents = WordContent.all
    file = FileName.create(file_name_params)
    coords = {x:0, y: 0, cx: 720 * 12700, cy: 540 * 12700}

    @word_contents.each do |word_content|
      @deck.add_intro word_content.title, word_content.content
    end

    @ppt_images.each do |ppt_image|
      ppt_image.image.each do |image|
        @deck.add_pictorial_slide image.title, Rails.root + "app/assets/images/" + image.name,coords
      end
    end
    
    @deck.save(file.name + '.pptx')

    if file.save
      WordContent.destroy_all
      PptImage.destroy_all     
      redirect_to "/"
    end
  end

  def download
    file = FileName.find(params[:id])
    send_file("#{Rails.root}/" + file.name + ".pptx", :filename => file.name + ".pptx")
  end

  def destroy
    file = FileName.find(params[:id])
    file.destroy
    redirect_to "/"
  end

  private

    def file_name_params
      params.require(:file_name).permit(:name)
    end
end
