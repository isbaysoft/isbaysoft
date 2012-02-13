class MenuItem < ActiveRecord::Base
  belongs_to :menu
  belongs_to :rule, :foreign_key => 'access_level'

  attr_accessible :title, :alias, :url, :note, :target, :sort_no
  cattr_reader :per_page, :TARGET_TYPES
  
  before_validation :auto_ordering

  validates_uniqueness_of :sort_no, :scope => :menu_id

  before_create :auto_ordering

  scope :items, lambda { |menu_id| {:conditions => ["menu_id = ?", menu_id]} }
  scope :order_by_sort_no, {:order => 'sort_no'}
  scope :published, {:conditions => 'published = true'}
  scope :permitted, {:conditions => ['access_level <= ?',User.current.access_level]}

#  link_to target type
  TARGET_TYPES = {
    0 => '_self',
    1 => '_blank'
  }
  
  def target_type
    TARGET_TYPES[self.target]
  end
  
  def self.getrows(options)
    page = options[:page] || 1
    filter = ['title like ?',"%#{options[:s]}%"] if options[:s]    
    options[:order] = nil unless options[:order] && MenuItem.column_names.include?(options[:sort_column])
    self.paginate :page =>page,
      :per_page => options[:per_page] || WillPaginate.per_page,
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
    self.sort_no = MenuItem.items(self.menu_id).maximum('sort_no').to_i+1
  end

end
