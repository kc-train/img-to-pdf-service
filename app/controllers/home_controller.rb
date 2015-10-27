class HomeController < ApplicationController
  def index
    @images = Image.all
    @file_names = FileName.all
    @ppt_images = PptImage.all
    @word_contents = WordContent.all
  end
end