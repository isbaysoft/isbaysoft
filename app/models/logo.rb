class Logo < ActiveRecord::Base
  has_one :document

  has_attached_file :logo,
    :url => '/system/:attachment/:id/:style/:filename',
    :default_style => :thumb,
    :styles => {:thumb => "128x128#"}
  
  validates_attachment_content_type :logo, :content_type => /image/
  validates_attachment_size :logo, :less_than => 100.kilobyte,
    :message => I18n.t(:error_max_image_size_byte, :max => ':max')
  validates_attachment_presence :logo, :message => I18n.t(:must_be_set)

end
