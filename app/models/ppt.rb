class Ppt
  include Mongoid::Document
  include Mongoid::Timestamps
 
  field :title, :type => String

  has_many :ppt_images , class_name: 'PptImage'
end