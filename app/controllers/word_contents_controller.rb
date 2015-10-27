class WordContentsController < ApplicationController
  def new
    @word_content = WordContent.new
  end

  def create
    word_content = WordContent.create(word_content_params)
    if word_content.save
      redirect_to "/"
    end
  end

  private

    def word_content_params
      params.require(:word_content).permit(:title, :content)
    end
end
