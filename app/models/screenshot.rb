class Screenshot < ActiveRecord::Base
  has_attachet_file :screenshot,
    :path => ':rails_root/public/screenshots/:class/:id/:basename.:extension',
    :url => '/screenshots/:class/:id/:basename.:extension'

  validates_attachment_content_type :screenshot, :content_type => /image/
  validates_attachment_size :screenshot, :less_than => 2.megobite,
    :message => I18n.t(:error_max_image_size_byte, :max => ':max')
  validates_attachment_presence :screenshot, :message => I18n.t(:must_be_set)

end
