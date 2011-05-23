class Menu < ActiveRecord::Base
  has_many :menu_items, :dependent => :destroy
  belongs_to :rule, :foreign_key => 'access_level'

  attr_accessible :title, :menu_id
  cattr_reader :per_page

  @@per_page=30

  def self.getrows(options)
    page = options[:page] || 1
    @@per_page = options[:per_page] || @@per_page
    filter = ['title like ?',"%#{options[:filter]}%"] if options[:filter]
    paginate :page =>page,
      :conditions => filter,
      :order => options[:order]
  end

end
