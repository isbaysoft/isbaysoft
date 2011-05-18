class Document < ActiveRecord::Base
  belongs_to :category, :dependent => :destroy
  belongs_to :section, :dependent => :destroy
  belongs_to :rule, :foreign_key => 'access_level'
  belongs_to :logo, :dependent => :destroy

  has_many :document_files
  has_many :filelists, :through => :document_files

  validates_presence_of :description, :name

  named_scope :get, lambda { |id| { :conditions => ['documents.id = ?', id] } }
  named_scope :set_of, lambda { |ids| { :conditions => ['documents.id in (?)', ids] } }
  named_scope :getlist,  :include => [:section, :category, :rule, :document_files]
  named_scope :section, lambda { |section_id| { :conditions => ['section_id = ?',section_id] }}
  named_scope :category, lambda { |category_id| {:conditions => ['categories.id=?',category_id]} unless category_id.nil? }
  named_scope :published, :conditions => 'documents.published=1'
  named_scope :approved, :conditions => 'documents.approved=1'
  named_scope :popular, lambda {|top| { :include => [:document_files], :limit => top, :order => 'document_files.hits desc' }}

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
     user.rule_id <= self.access_level
  end

  def self.getrows(options = {})
    page = options[:page] || 1
    @@per_page = options[:per_page] || @@per_page
    filter = ['documents.name like ?',"%#{options[:filter]}%"] if options[:filter]
    Document.getlist.paginate :page => page
  end

  def path_name
    self.category && self.category.section ? "#{self.category.section.name} / #{self.category.name}" : "выберите категорию"
  end
end
