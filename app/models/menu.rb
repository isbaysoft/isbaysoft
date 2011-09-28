class Menu < ActiveRecord::Base
  belongs_to :rule, :foreign_key => 'access_level'

  has_many :menu_items, :dependent => :destroy
  has_many :documents

  attr_accessible :title, :menu_id
  cattr_reader :per_page

  scope :published, {:conditions => 'published = true'}
  scope :permitted, {:conditions => ['access_level <= ?',User.current.access_level]}

  @@per_page=30

  def reordering
    menu_items = MenuItem.items(self.id).order_by_sort_no
    cnt = 1
    menu_items.map do |m|
      mm = MenuItem.find(m.id)
      mm.update_attribute(:sort_no, cnt)
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
