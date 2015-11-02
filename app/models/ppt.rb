class Ppt
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :pptx, PptxUploader
 
  field :title, :type => String

  has_many :ppt_images , class_name: 'PptImage'
end