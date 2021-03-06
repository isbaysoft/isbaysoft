class Screenshot < ActiveRecord::Base
  belongs_to :document

  has_attached_file :screenshot,
    :url => '/system/:attachment/:id/:style/:filename',
    :default_style => :thumb,
    :styles => {:thumb => "160x120#"}

  validates_attachment_content_type :screenshot, :content_type => /image/
  validates_attachment_size :screenshot, :less_than => 2.megabyte,
    :message => I18n.t(:error_max_image_size_byte, :max => ':max')
  validates_attachment_presence :screenshot, :message => I18n.t(:must_be_set)

end
