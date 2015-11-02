class PptxUploader < CarrierWave::Uploader::Base
  include PptxUploaderMethods
  storage :file 

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    version__name = self.version_name.blank? ? "空白": self.version_name
    ActionController::Base.helpers.asset_path "uploads/pptx/#{version__name}.pptx"
  end
end
