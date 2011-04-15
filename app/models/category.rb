class Category < ActiveRecord::Base

  belongs_to :section

  has_many :documents

  validates_presence_of :name, :description, :section

  cattr_reader :per_page

  named_scope :getlist, :joins => [:section]
  named_scope :order, lambda { |order| {:order => order } }
  named_scope :section, lambda { |section_id| {:conditions => ['section_id=?',section_id]} }
  
  @@per_page=30

  def wrong?
    section_name.nil?
  end

  def self.getrows(options)
    @@per_page = options[:per_page] || @@per_page
    page = options[:page]
    filter = ['categories.name like ?',"%#{options[:filter]}%"] if options[:filter]
    paginate :page =>page,
      :select => 'categories.*, sections.name as section_name',
      :joins => 'left join sections on sections.id=categories.section_id',
      :conditions => filter,
      :order => options[:order]
  end

end
