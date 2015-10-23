class HomeController < ApplicationController
  def index
    @images = Image.all
    @file_names = FileName.all
  end
end