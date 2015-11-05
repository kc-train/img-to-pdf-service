class ImgToPptTranscodeWorker
  include Sidekiq::Worker

  sidekiq_options queue: "正在将图片转码为ppt", retry: false

  def perform(ppt_id)
    @deck = Powerpoint::Presentation.new
    @ppt = Ppt.find(ppt_id)

    @ppt.status = "converting"
    @ppt.save

    @ppt.images.each do |image|
      file = Tempfile.new('ppt_image')
      open(image.url) do |http|
        resp = http.read
        File.open(file.path,'wb'){ |f| f.write(resp)}
      end
      file.close
      img = MiniMagick::Image.new(file.path)
      img.contrast
      img.resize "960x420"
      # coords = {x: 0, y: 0, cx: 720 * 12700, cy: 540 * 12700}
      @deck.add_pictorial_slide image.title, file.path
      # @deck.add_pictorial_slide image.title, file.path, coords
    end

    @ppt.status = "convert_fail"
    @ppt.save

    @deck.save("public/"+ @ppt.pptx.url + ".pptx")

    @ppt.status = "convert_success"
    @ppt.save
  end
end
