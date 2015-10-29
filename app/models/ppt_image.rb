class PptImage
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :images, class_name: 'Image'
  belongs_to :ppt, class_name: 'Ppt'
end
