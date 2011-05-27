class Menu < ActiveRecord::Base
  has_many :menu_items, :dependent => :destroy
  belongs_to :rule, :foreign_key => 'access_level'

  attr_accessible :title, :menu_id
  cattr_reader :per_page

  @@per_page=30

  def reordering
    menu_items = MenuItem.items(self.menu_id)
    cnt = 1
    menu_items.map do |m|
      mm = MenuItem.find(m.id)
      mm.update_attribute(:sort_no, cnt)
#      MenuItem.update_ (m.id, :sort_no => cnt )
      cnt += 1
    end
  end

  def self.getrows(options)
    page = options[:page] || 1
    @@per_page = options[:per_page] || @@per_page
    filter = ['title like ?',"%#{options[:filter]}%"] if options[:filter]
    paginate :page =>page,
      :conditions => filter,
      :order => options[:order]
  end

end
