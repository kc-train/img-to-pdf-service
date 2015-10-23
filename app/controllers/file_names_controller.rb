class FileNamesController < ApplicationController
  def new
    @file_name = FileName.new
  end

  def create
    file = FileName.create(file_name_params)
    if file.save
      redirect_to "/home/index"
    end
  end

  private

    def file_name_params
      params.require(:file_name).permit(:name)
    end
end
