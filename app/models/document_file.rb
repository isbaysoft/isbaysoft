class DocumentFile < ActiveRecord::Base
  belongs_to :document
  belongs_to :filelist  
end
