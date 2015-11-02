module PptxUploaderMethods
  def filename
    if original_filename.present?
      ext = file.extension.blank? ? '' : ".#{file.extension}"
      "#{secure_token}#{ext}"
    end
  end

  def url
    _file_name = model[mounted_as]
    return default_url if _file_name.blank?

    prefix = version_name.blank? ? '' : "#{version_name}_"

    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}/#{prefix}#{_file_name}" 
  end

  def extension_white_list
    %w(pptx)
  end

  private
    def secure_token
      var = :"@#{mounted_as}_secure_token"
      model.instance_variable_get(var) || model.instance_variable_set(var, randstr)
    end

    def randstr(length=8)
      base = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
      size = base.size
      re = '' << base[rand(size-10)]
      (length - 1).times {
        re << base[rand(size)]
      }
      re
    end
end