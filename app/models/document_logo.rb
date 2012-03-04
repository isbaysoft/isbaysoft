class DocumentLogo < ActiveRecord::Base
	belongs_to :document
  belongs_to :logo
end