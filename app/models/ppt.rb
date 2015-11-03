class Ppt
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :pptx, PptxUploader
 
  field :title, :type => String

  has_and_belongs_to_many :images, class_name: 'Image'
end