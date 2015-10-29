class Image
  include Mongoid::Document
  include Mongoid::Timestamps
 
  field :title, :type => String
  field :url, :type => String

  has_and_belongs_to_many :ppt_images, class_name: 'PptImage'
end
