class Image
  include Mongoid::Document
  include Mongoid::Timestamps
 
  default_scope ->{ order(created_at: :desc) }

  field :title, :type => String
  field :url, :type => String

  has_and_belongs_to_many :ppts, class_name: 'Ppt'
end
