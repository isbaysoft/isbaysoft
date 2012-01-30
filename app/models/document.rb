class Document < ActiveRecord::Base
  belongs_to :category, :dependent => :destroy
  belongs_to :section, :dependent => :destroy
  belongs_to :rule, :foreign_key => 'access_level'
  belongs_to :logo, :dependent => :destroy
  belongs_to :menu

  has_many :document_files
  has_many :filelists, :through => :document_files
  has_many :screenshots

  validates :description, :presence => true
  validates :name, :presence => true

  scope :get, lambda { |id| { :conditions => ['documents.id = ?', id] } }
  scope :set_of, lambda { |ids| { :conditions => ['documents.id in (?)', ids] } }
  scope :getlist,  :include => [:section, :category, :rule, :document_files]
  scope :section, lambda { |section_id| { :conditions => ['section_id = ?',section_id] }}
  scope :category, lambda { |category_id| {:conditions => ['categories.id=?',category_id]} unless category_id.nil? }
  scope :published, where('documents.published = ?',true)
  scope :approved, where('documents.approved = ?',true)
  scope :popular, lambda {|top| { :include => [:document_files], :limit => top, :order => 'document_files.hits desc' }}

  cattr_reader :per_page

  @@per_page=30

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
    @@per_page = options[:per_page] || @@per_page
    filter = ['name like ?',"%#{options[:filter]}%"] if options[:filter]
    Document.where(filter).getlist.paginate :page => page
  end

  def path_name
    self.category && self.category.section ? "#{self.category.section.name} / #{self.category.name}" : "choose the category"
  end
end
