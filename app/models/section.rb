class Section < ActiveRecord::Base

  validates :name, :presence => true

  has_many :categories, :dependent => :destroy
  has_many :documents, :dependent => :destroy
  
  cattr_reader :per_page

  def self.getrows(options)
    page = options[:page] || 1
    filter = ['name like ?',"%#{options[:s]}%"] if options[:s]
    paginate :page =>page,
      :per_page => options[:per_page] || WillPaginate.per_page,
      :conditions => filter,
      :order => options[:order]
  end

end
