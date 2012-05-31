class Logo < ActiveRecord::Base
  has_many :document_logos

  has_attached_file :logo,
    :path => ':rails_root/public/sysimages/document_logos/:logo_document_id/:basename.:extension',
    :url => '/sysimages/document_logos/:logo_document_id/:basename.:extension',
    :default_style => :thumb,
    :styles => {:thumb => "128x128#"}
  
  validates_attachment_content_type :logo, :content_type => /image/
  validates_attachment_size :logo, :less_than => 100.kilobyte,
    :message => I18n.t(:error_max_image_size_byte, :max => ':max')
  validates_attachment_presence :logo, :message => I18n.t(:must_be_set)

  #  Interpolate custom path
  Paperclip.interpolates :logo_document_id do |logo, style|
    p logo.instance
    # logo.instance.document_logos.first.document.id
    210
  end

  сделать папки для паперклипа

end
