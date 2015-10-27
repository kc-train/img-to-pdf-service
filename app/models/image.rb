class Image
  include Mongoid::Document
  include Mongoid::Timestamps
 
  field :title, :type => String
  field :name, :type => String
  field :url, :type => String

  belongs_to :ppt_image, class_name: 'PptImage'
end
