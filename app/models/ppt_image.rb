class PptImage
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :image, class_name: 'Image'
end
