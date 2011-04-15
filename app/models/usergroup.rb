class Usergroup < ActiveRecord::Base
  has_many :users, :include => [:usergroups]
  cattr_reader :per_page

  validates_presence_of :name

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
