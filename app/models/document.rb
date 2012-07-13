class Document < ActiveRecord::Base
  cattr_reader :per_page

  belongs_to :category, :dependent => :destroy
  belongs_to :section, :dependent => :destroy
  belongs_to :logo
  belongs_to :menu
  belongs_to :rule, :foreign_key => 'access_level'  

  has_many :document_files
  has_many :filelists, :through => :document_files
  has_many :screenshots, :dependent => :destroy

  validates :short_description, :name, :category_id, :section_id, :presence => true

  scope :get, lambda { |id| { :conditions => ['documents.id = ?', id] } }
  scope :set_of, lambda { |ids| { :conditions => ['documents.id in (?)', ids] } }
  scope :getlist,  :include => [:section, :category, :rule, :document_files]
  scope :section, lambda { |section_id| { :conditions => ['section_id = ?',section_id] }}
  scope :category, lambda { |category_id| {:conditions => ['categories.id=?',category_id]} unless category_id.nil? }
  scope :published, where('documents.published = ?',true)
  scope :approved, where('documents.approved = ?',true)
  scope :popular, lambda {|top| { :include => [:document_files], :limit => top, :order => 'document_files.hits desc' }}


  def hits
    self.document_files.sum('hits')
  end

  def logo_url
    self.logo.nil? ? 'main/empty_logo.png ' : self.logo.logo.url
  end

  def section_name
    self.section.present? ? self.section['name'] : I18n::t(:text_no_data)
  end

  def downloadable?(user)
     user.access_level >= self.access_level
  end

  def self.getrows(options = {})
    page = options[:page] || 1
    filter = ['name like ?',"%#{options[:s]}%"] if options[:s]
    Document.where(filter).getlist.paginate :page => page,
      :per_page => options[:per_page] || WillPaginate.per_page
  end

  def path_name
    self.category && self.category.section ? "#{self.category.section.name} / #{self.category.name}" : I18n.t(:text_not_selected)
  end

end
