class Screenshot < ActiveRecord::Base
  belongs_to :document

  has_attached_file :screenshot,
    :path => ":rails_root/public/sysimages/:class/:document_id/:id-:basename.:extension",
    :url => "/sysimages/:class/:document_id/:id-:basename.:extension",
    :default_style => :thumb,
    :styles => {:thumb => "160x120#"}

  validates_attachment_content_type :screenshot, :content_type => /image/
  validates_attachment_size :screenshot, :less_than => 2.megabyte,
    :message => I18n.t(:error_max_image_size_byte, :max => ':max')
  validates_attachment_presence :screenshot, :message => I18n.t(:must_be_set)


  #  Interpolate custom path
  Paperclip.interpolates :document_id do |attachment, style|
    attachment.instance.document_id
  end

end
