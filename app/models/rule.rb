class Rule < ActiveRecord::Base
  has_many :users
  has_many :documents
  has_many :menu_items
  has_many :menus

  named_scope :for_current_user, lambda {|current_user| {:conditions => ['id >= ?',current_user]}}

  def readonly?
    false
  end
end
