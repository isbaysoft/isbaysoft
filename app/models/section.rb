class Section < ActiveRecord::Base
  validates_presence_of :name, :description

  has_many :categories, :dependent => :destroy
  has_many :documents, :dependent => :destroy
  
  cattr_reader :per_page

  scope :order, lambda { |order| {:order => order } }

  @@per_page=30

  def self.getrows(options)
    page = options[:page] || 1
    @@per_page = options[:per_page] || @@per_page
    filter = ['name like ?',"%#{options[:filter]}%"] if options[:filter]
    paginate :page =>page,
      :conditions => filter,
      :order => options[:order]
  end

end
