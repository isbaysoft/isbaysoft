class MenuItem < ActiveRecord::Base
  belongs_to :menu
  belongs_to :rule, :foreign_key => 'access_level'

  cattr_reader :per_page

  @@per_page=30

#  link_to target type
  TARGET_TYPES = {
    0 => { :target => 'self', :description => 'В этом окне'},
    1 => { :target => 'blank', :description => 'В новом окне'}
  }

  def target_type
    TARGET_TYPES[0][:target]
  end

  def target_type_name
    TARGET_TYPES[0][:description]
  end


  def self.getrows(options)
    page = options[:page] || 1
    @@per_page = options[:per_page] || @@per_page
    filter = ['title like ?',"%#{options[:filter]}%"] if options[:filter]
    paginate :page =>page,
      :conditions => filter,
      :order => options[:order]
  end

end
