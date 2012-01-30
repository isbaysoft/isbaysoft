class Rule < ActiveRecord::Base
	self.primary_key = "access_level"
  
  has_many :users
  has_many :documents
  has_many :menu_items
  has_many :menus

  scope :for_current_user, lambda {|current_user| {:conditions => ['access_level <= ?',current_user]}}

  def readonly?
    false
  end
end
