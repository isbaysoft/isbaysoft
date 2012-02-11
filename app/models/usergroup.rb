class Usergroup < ActiveRecord::Base
  has_many :users, :include => [:usergroups]
  cattr_reader :per_page

  validates_presence_of :name
 
  def self.getrows(options)
    page = options[:page] || 1
    filter = ['name like ?',"%#{options[:s]}%"] if options[:s]
    paginate :page =>page,
      :per_page => options[:per_page] || WillPaginate.per_page,
      :conditions => filter,
      :order => options[:order]
  end

end
