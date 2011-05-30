class StaticContent < ActiveRecord::Base
  belongs_to :user
  cattr_reader :per_page

  @@per_page=30

  def to_param
    name
  end

  def self.getrows(options = {})
    page = options[:page] || 1
    @@per_page = options[:per_page] || @@per_page
    filter = ['name like ?',"%#{options[:filter]}%"] if options[:filter]
    StaticContent.paginate :page =>page,
      :select => 'users.email as user_login,static_contents.*',
      :joins => 'join users on users.id=static_contents.user_id',
      :conditions => filter,
      :order => options[:order]
  end

  def self.static_content_position_names
    @f = Dir.glob("app/views/**/*.{rhtml,erb}")
    @p = []
    @f.map do |f|
      file = File.open(f,'r')
      @pa = file.read
      links_array = @pa.scan(/static_content_for\(([\"|\'])(.*)\1\)/)
      links_array.map { |m| @p << m[1]}
    end
    @p.uniq
  end
  
end
