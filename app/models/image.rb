class Image < ActiveRecord::Base
  has_attachet_file :image
  validates_attachment_content_type :image, :content_type => /image/
  validates_attachment_size :image, :less_than => 25.kilobyte
  
end
