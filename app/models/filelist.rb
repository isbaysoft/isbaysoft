class Filelist < ActiveRecord::Base
  has_many :document_files, :dependent => :destroy
  has_attached_file :f,
    :path => ':rails_root/downloads/:class/:id_partition/:basename.:extension'
  validates_attachment_presence :f, :message => I18n.t(:must_be_set)

  cattr_reader :per_page

  scope :files_without_document,
    :include => [:document_files], :conditions => 'filelists.id is null'
  scope :order, lambda { |order| {:order => order } }
  scope :get, lambda { |id| {:conditions => ['filelists.id = ?', id] } }
  scope :except, lambda { |ids| {:conditions => ['filelists.id not in (?)', ids] } if ids.present? }

  
  @@per_page=30


  def file_exist?
    File.exist?(self.f.path)
  end

  def downloadable?(user)
    true
  end

  def self.getrows(options)
    @@per_page = options[:per_page] || @@per_page
    page = options[:page]
    filter = ['f_file_name like ?',"%#{options[:filter]}%"] if options[:filter]
    Filelist.paginate :page => page,
      :conditions => filter,
      :order => options[:order]
  end
  
end
