class Logo < ActiveRecord::Base
  has_many :documents, :dependent => :nullify

  has_attached_file :logo,
    :path => ':rails_root/public/document_logos/:class/:id/:basename.:extension',
    :url => '/document_logos/:class/:id/:basename.:extension'
  
  validates_attachment_content_type :logo, :content_type => /image/
  validates_attachment_size :logo, :less_than => 100.kilobyte,
    :message => I18n.t(:error_max_image_size_byte, :max => ':max')
  validates_attachment_presence :logo, :message => I18n.t(:must_be_set)

  before_create :rename

  def rename
    # extension = File.extname(logo_file_name).downcase
    # self.logo.instance_write(:file_name, "#{ActiveSupport::SecureRandom.hex(16)}#{extension}")
  end
  
end
