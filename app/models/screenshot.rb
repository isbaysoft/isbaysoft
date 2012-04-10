class Screenshot < ActiveRecord::Base
  belongs_to :document

  has_attached_file :screenshot,
    :path => ':rails_root/public/screenshots/:class/:document_id/:basename.:extension',
    :url => '/screenshots/:class/:document_id/:basename.:extension',
    :default_style => :thumb,
    :styles => {:thumb => "128x128#"}

  validates_attachment_content_type :screenshot, :content_type => /image/
  validates_attachment_size :screenshot, :less_than => 2.megabyte,
    :message => I18n.t(:error_max_image_size_byte, :max => ':max')
  validates_attachment_presence :screenshot, :message => I18n.t(:must_be_set)

end
