class MenuItem < ActiveRecord::Base
  belongs_to :menu
  belongs_to :rule, :foreign_key => 'access_level'

  attr_accessible :title, :alias, :url, :note, :target, :order
  cattr_reader :per_page, :TARGET_TYPES
  
  before_validation_on_create :auto_ordering

  validates_uniqueness_of :order, :scope => :menu_id

#  before_save :auto_ordering

  named_scope :items, lambda { |menu_id| {:conditions => ["menu_id = ?", menu_id]} }
  
  @@per_page=30

#  link_to target type
  TARGET_TYPES = {
    0 => 'self',
    1 => 'blank'
  }
  
  TARGET_TYPES_NAMES = {
    0 => I18n.t(:text_target_self),
    1 => I18n.t(:text_target_blank)
  }

  def target_type
    TARGET_TYPES[self.target]
  end
  
  def target_name
    TARGET_TYPES_NAMES[self.target] unless self.target.nil?
  end

  def self.getrows(options)
    page = options[:page] || 1
    @@per_page = options[:per_page] || @@per_page
    filter = ['title like ?',"%#{options[:filter]}%"] if options[:filter]
    self.paginate :page =>page,
      :conditions => filter,
      :order => options[:order]
  end

  def reordering
    items = MenuItem.items(self.menu_id)
    item_position = 1
    items.map do |m|
      m.order = item_position
      item_position += 1
    end
    items.save
  end

  def auto_ordering
    self.order = MenuItem.items(self.menu_id).maximum('order')+1
  end

end
