class Category < ActiveRecord::Base

  belongs_to :section

  has_many :documents

  validates_presence_of :name, :description, :section

  cattr_reader :per_page

  scope :getlist, :joins => [:section]
  scope :order, lambda { |order| {:order => order } }
  scope :section, lambda { |section_id| {:conditions => ['section_id=?',section_id]} }
  
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
