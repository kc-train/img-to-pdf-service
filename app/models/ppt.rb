class Ppt
  extend Enumerize
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :pptx, PptxUploader

  field :title, :type => String

  validates :title, :presence => true
  # edit  converting  convert_success convert_fail
  enumerize :status, in: [:edit, :converting, :convert_success, :convert_fail], default: :edit

  has_and_belongs_to_many :images, class_name: 'Image'
end
