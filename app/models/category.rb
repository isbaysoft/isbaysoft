class Category < ActiveRecord::Base

  belongs_to :section

  has_many :documents

  validates :name, :section_id, :presence => true

  cattr_reader :per_page

  scope :getlist, :joins => [:section]
  
  def wrong?
    section_name.nil?
  end

  def self.getrows(options)
    page = options[:page] || 1
    filter = ['categories.name like ?',"%#{options[:s]}%"] if options[:s]
    paginate :page =>page,
      :per_page => options[:per_page] || WillPaginate.per_page,
      :select => 'categories.*, sections.name as section_name',
      :joins => 'left join sections on sections.id=categories.section_id',
      :conditions => filter,
      :order => options[:order]
  end

end
